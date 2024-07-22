package com.ucpb.tfsweb.lc.ets

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.MultipartFile

/**
 * PROLOGUE
 * SCR/ER Description:
 *	[Revised by:] Cedrick C. Nungay
 *	[Date revised:] 03/20/2018
 *	Program [Revision] Details: Added centavos model on page load.
 *	Date deployment: 3/20/2018
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: LcEtsAmendmentController.groovy
*/
class LcEtsAmendmentController {

    def headerService
    def recomputeService
    def dataEntryService
    def etsService
    def chargesService
    def routingInformationService

    def parserService

    def ratesService
	def foreignExchangeService

    def documentUploadingService

    def apService
    def arService

    def tabUtilityService
    def chargesPaymentService
	
	def coreAPIService

    // sets service type
    protected String REFERENCE_TYPE = "ETS"
    protected String SERVICE_TYPE = "Amendment"
    protected String DOCUMENT_CLASS = "LC"
	
	
	// render page for viewing
    def viewAmendment() {
        // if accessed from create transaction
        if(chainModel) {
            session.etsModel = chainModel

            String etsNumber = session.etsModel.serviceInstructionId ?: ""

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.etsModel << [charges:charges]
            session.etsModel << [chargesString: parserService.listHashMapToString(charges)]

//            List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency ?: "")
//            session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//            List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
//            session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]
			
			if(chainModel.currency) {
//				def exchange = ratesService.getRatesByBaseCurrency()
//				exchange = foreignExchangeService.extractRatesByBaseCurrency(exchange.display, chainModel)
//				session.etsModel << [exchange:exchange]

                def exchange = []

                def ratesResult

                //println"hello i am a documentSubType1 : " + session.etsModel.documentSubType1
                //println"hello i am a type : " + session.etsModel.type

                if (session.etsModel.documentType.equals("DOMESTIC")){
                    if (session.etsModel.documentSubType1.equals("REGULAR") || session.etsModel.documentSubType1.equals("STANDBY")) {
                        ratesResult = ratesService.getRegularSellRatesDM(chainModel.currency).response.details
                    } else if (session.etsModel.documentSubType1.equals("CASH")) {
                        ratesResult = ratesService.getCashSellRatesDM(chainModel.currency).response.details
                    }
                } else {
                    if (session.etsModel.documentSubType1.equals("REGULAR") || session.etsModel.documentSubType1.equals("STANDBY")) {
                        ratesResult = ratesService.getRegularSellRates(chainModel.currency).response.details
                    } else if (session.etsModel.documentSubType1.equals("CASH")) {
                        ratesResult = ratesService.getCashSellRates(chainModel.currency).response.details
                    }
                }


                ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

                if(!it.description.toString().contains("BUYING")){
                    session.etsModel.each { ets ->
                        if (it.description.toString().contains("URR")) {
                            if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate_urr")) {
                                text_pass_on_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash_urr")) {
                                pass_on_rate_cash = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate_urr")) {
                                text_special_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash_urr")) {
                                special_rate_cash = ets.value
                            }
                        } else {
                            if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
                                text_pass_on_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
                                pass_on_rate_cash = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
                                text_special_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
                                special_rate_cash = ets.value
                            }
    						if (ets.key.toString().equals("USD-PHP_urr") && it.description.toString().contains("URR")){
    							pass_on_rate = ets.value
    							special_rate = ets.value
    						}
                        }
                    }
                }



                exchange << [rates: it.rates,
                        rate_description: it.description,
                        rate_description_lbp: it.descriptionLbp,
                        pass_on_rate: pass_on_rate,
                        special_rate: special_rate,

                        text_pass_on_rate: text_pass_on_rate,
                        pass_on_rate_cash: pass_on_rate_cash,
                        text_special_rate: text_special_rate,
                        special_rate_cash: special_rate_cash
                ]
            }
                session.etsModel << [exchange: exchange]
			}	
        }
		if(session.cancelBd){
			session.removeAttribute("cancelBd")
			render(view:"/main/unacted_transaction")
	    }
        else if(session.etsModel) {

            // passes chain model if existing else passes session model
			
            session.etsModel << [centavos: coreAPIService.dummySendQuery(
                [documentType: session.etsModel.documentType, documentClass: session.etsModel.documentClass,
                    documentSubType1: session.etsModel.documentSubType1, documentSubType2: session.etsModel.documentSubType2,
                    serviceType: 'AMENDMENT'], 'getChargesParameter', 'chargesParameter/').result?.RATEAMOUNT]
            render(view: "/lc/ets/opening/index", model: chainModel ? chainModel : session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }
	
	// trigger viewing of page
	def viewAmendmentEts() {
        // get lc class and type
        String documentType // = params.documentType
        String documentSubType1 // = params.documentSubType1.toUpperCase()
        String documentSubType2 // = params.documentSubType2
        String windowed = params.windowed ?: null	//for view approved eTS popup
        ////printlnparams
        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            documentType = dataEntryMap.documentType
            documentSubType1 = dataEntryMap.documentSubType1
            documentSubType2 = dataEntryMap.documentSubType2

            // construct header title
            String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

            // keep session model
            session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }


            String cilexFlag = "false";
            if(params.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(params.tradeServiceId)
            }
            session.etsModel << [cilexFlag: cilexFlag]

        } else if (params.etsNumber) {
            Map<String, Object> etsMap = etsService.getEts(params.etsNumber)

            documentType = params.documentType
            documentSubType1 = params.documentSubType1
            documentSubType2 = params.documentSubType2

            String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

            session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE, windowed: windowed]

            etsMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }


            String cilexFlag = "false";
            if(etsMap.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(etsMap.tradeServiceId)
            }
            session.etsModel << [cilexFlag: cilexFlag]

            // todo: refactor, this should be in a service or something
            def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
            session.nextRoute = documentServiceRoute
            session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        }
		session.etsModel<<[viewMode:params.viewMode]
        // chain to render page
        chain(action:"viewAmendment", model: session.etsModel)
	}
	
	// saves new instance of ets
	def saveAmendmentEts() {

        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.etsModel << [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = ""
        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)

        params.productStatus = session.etsModel.status

        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        // todo: refactor, this should be in a service or something
        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
		session.cancelBd=params.cancelBd

        // chain to render page
        chain(action:"viewAmendment", model: session.etsModel)
	}
	
	// updates instance of ets
	def updateAmendmentEts() {
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.etsModel << [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
        session.etsModel << [formName: tabUtilityService.getTabName(params.form)]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> etsMap = etsService.updateEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
		session.cancelBd=params.cancelBd
		
        // chain to render page
        chain(action:"viewAmendment", model:session.etsModel)
	}
	
	def updateEtsStatus() {
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        etsService.updateEts(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
	}

    def uploadDocument() {

        try{
            //handle uploaded file
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

            String tradeServiceId = params?.tradeServiceId
			println "tradeServiceId = ${tradeServiceId}"

			params.filename = documentUploadingService.saveFile(uploadedFile, tradeServiceId)

        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
        }

        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
        redirect(controller:'lcEtsAmendment', action:'invokeUploadCommand',params:params)
    }

    def invokeUploadCommand(){
        def jsonData

        try{

            session.etsModel << [formName: tabUtilityService.getTabName(params.form)]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            String temp =  etsService.uploadAttachedToEts(params)
            jsonData = [success: true]
        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
            jsonData = [success: false]
        }
        chain(action:"viewAmendment", model: session.etsModel)
    }

	def downloadFile() {

		String id = params?.id
		println "id = ${id}"

		String tradeServiceId = params?.tradeServiceId
		println "tradeServiceId = ${tradeServiceId}"

		def returnValue = coreAPIService.dummySendQuery(params, "getFileDetails", "attachment/")

		def fileName = returnValue?.details?.filename

		if (fileName != null) {

			File file = documentUploadingService.retrieveFile(fileName, tradeServiceId)

			if (file.exists()) {
				if(file.canRead()){
					response.setContentType("application/octet-stream")
					response.setHeader("Content-disposition", "filename=${file.name}")
					response.outputStream << file.bytes
					return
				}
			}

		} else {
			return
		}
	}

    def deleteDocument() {

		// sets statusAction to deleteDocument
        params.statusAction = "deleteDocument"

        // trigger command
        // TODO do delete document

        String id = params?.id
        String tradeServiceId = params?.tradeServiceId

        // println "id = ${id}"
        // println "filename = ${filename}"
        // println "tradeServiceId = ${tradeServiceId}"

        def jsonData = [:]

        try {

            // Delete attachment record first in db, then delete the file. The reverse is dangerous.
            def returnValue = coreAPIService.dummySendCommand(params, "delete", "attachment")

            def deleted = null
            if (returnValue.status == "ok") {
                // If successful, delete the actual file
                deleted = documentUploadingService.deleteFile(returnValue.details.filename, tradeServiceId)
            } else if (returnValue.status == "error") {
                throw new Exception(returnValue.error.code);
            }

            jsonData = [success: true]

        } catch (Exception e) {
            e.printStackTrace()
            jsonData = [success: false, message: e.getMessage()]
        }

        render jsonData as JSON
    }

    def viewAttachments() {

        def tradeServiceIdHolder =  params.tradeServiceIdHolder
        // println "tradeServiceIdHolder = ${tradeServiceIdHolder}"

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
		def results
		if (session.userrole.id.contains("TSD")){
			results = etsService.getGridFormattedAttachmentsReadonly(mapList.display, tradeServiceIdHolder)
		} else {
			results = etsService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)
		}
        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON

    }
	
}
