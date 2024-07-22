package com.ucpb.tfsweb.lc.ets
import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest


/**
 * PROLOGUE
 * SCR/ER Description:
 *	[Revised by:] Cedrick C. Nungay
 *	[Date revised:] 03/20/2018
 *	Program [Revision] Details: Added centavos model on page load.
 *	Date deployment: 3/20/2018
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: LcEtsOpeningController.groovy
*/
class LcEtsOpeningController {

	def headerService
	def recomputeService
    def dataEntryService
	def etsService
	def commandService
    
    def chargesService
	def servletContext

    def parserService
	
	def documentUploadingService
    def routingInformationService

    def ratesService
	def foreignExchangeService

    def apService
    def arService
    def tabUtilityService

    def chargesPaymentService
	def facilityService
	
	def etsApprovedPaymentsService

    def coreAPIService

	// sets service type
    protected String REFERENCE_TYPE = "ETS"
	protected String SERVICE_TYPE = "Opening"
	protected String DOCUMENT_CLASS = "LC"

	// render page for viewing
    def viewOpening() {
		// if accessed from create transaction

        if(chainModel) {
			
			session.etsModel = chainModel

            String etsNumber = session.etsModel.serviceInstructionId ?: ""

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.etsModel << [charges:charges]
            Map<String,Map<String, Object>> rates = ratesService.getDailyRates()
            session.etsModel << [rates:rates]

            session.etsModel << [chargesString: parserService.listHashMapToString(charges)]

//            List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency ?: "")
//            session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//            List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
//            session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

			if(!chainModel.currency) {
                if (session.etsModel?.documentType?.equals("DOMESTIC")) {
                    chainModel.currency = "PHP"
                }
			}

            String cilexFlag = "false";
            if(session?.etsModel?.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(session?.etsModel?.tradeServiceId?:"")
            }
            session.etsModel << [cilexFlag: cilexFlag]

//            def paramz = parserService.sessionModelToHashMap(session.etsModel)
//
//            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
//            exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//            session.etsModel << [exchange:exchange]

            def exchange = []

            def ratesResult

            //println"hello i am a documentSubType1 : " + session.etsModel.documentSubType1
            //println"hello i am a type : " + session.etsModel.type

//            if (session.etsModel.documentSubType1.equals("REGULAR") || session.etsModel.documentSubType1.equals("STANDBY")) {
//                ratesResult = ratesService.getRegularSellRates(chainModel.currency)?.response?.details
//            } else if (session.etsModel.documentSubType1.equals("CASH")) {
//                ratesResult = ratesService.getCashSellRates(chainModel.currency)?.response?.details
//            }
//            println " angulo angulo angulo angulo:"+session.etsModel.documentType
//            println " angulo angulo angulo angulo documentSubType1:"+session.etsModel.documentSubType1
            if (session.etsModel.documentType.equals("DOMESTIC")){
                println "angulo angulo angulo in"
                if (session.etsModel.documentSubType1.equals("REGULAR") || session.etsModel.documentSubType1.equals("STANDBY")) {
                    ratesResult = ratesService.getRegularSellRatesDM(chainModel.currency)?.response?.details
                } else if (session.etsModel.documentSubType1.equals("CASH")) {
                    ratesResult = ratesService.getCashSellRatesDM(chainModel.currency)?.response?.details
                }
            } else {
                if (session.etsModel.documentSubType1.equals("REGULAR") || session.etsModel.documentSubType1.equals("STANDBY")) {
                    ratesResult = ratesService.getRegularSellRates(chainModel.currency)?.response?.details
                } else if (session.etsModel.documentSubType1.equals("CASH")) {
                    ratesResult = ratesService.getCashSellRates(chainModel.currency)?.response?.details
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
			
			/*if(session.etsModel.transactionSequenceNumber){
				def facility = facilityService.getFacilityBalanceRequest(new Long(session.etsModel.transactionSequenceNumber), session.etsModel.serviceInstructionId)
				def count = 0;
				while (facility.status.equals("pending") && (count < 10000)){
					facility = facilityService.getFacilityBalanceRequest(new Long(session.etsModel.transactionSequenceNumber), session.etsModel.serviceInstructionId)
                    count++
				}

                if (facility.status.equals("success")){
					session.etsModel << [isOverAvailed : !facility.isBalanceSufficient]
					if (!facility.isBalanceSufficient){
						def overAvailment
						if(facility.hasCramApproval){
							overAvailment = "There is an over-availment in facility. Facility balance is: PHP " + new DecimalFormat("#,##0.00").format(new BigDecimal(facility.balance)) + "."
						} else {
							overAvailment = "Facility balance is insufficient. Current balance is: PHP " + new DecimalFormat("#,##0.00").format(new BigDecimal(facility.balance)) + "."
						}
						session.etsModel << [overAvailment : overAvailment]
					}
				} else if (count >= 10000){
					session.etsModel << [isOverAvailed : true]
					session.etsModel << [overAvailment : "No response received for Facility check."]
				}
			}*/

		}
		//go to unacted if cancelled from basic details tab
		if(session.cancelBd){
			 session.removeAttribute("cancelBd")
			 render(view:"/main/unacted_transaction")
		}
		else if(session.etsModel) {
            String cilexFlag = "false";
            if(session?.etsModel?.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(session?.etsModel?.tradeServiceId?:"")
            }
            session.etsModel << [cilexFlag: cilexFlag]
			
			session.etsModel << [centavos: coreAPIService.dummySendQuery(
				[documentType: session.etsModel.documentType, documentClass: session.etsModel.documentClass,
					documentSubType1: session.etsModel.documentSubType1, documentSubType2: session.etsModel.documentSubType2,
					serviceType: 'OPENING'], 'getChargesParameter', 'chargesParameter/').result?.RATEAMOUNT]
			// passes chain model if existing else passes session model

			render(view: "/lc/ets/opening/index", model: chainModel ?: session.etsModel)			
		}else {
			render(view: "/main/unauthorized")
		}
    }
	
	// trigger viewing of page
	def viewOpeningEts() {

        // get lc class and type
		String documentType = params.documentType
		String documentSubType1 = params.documentSubType1.toUpperCase()
		String documentSubType2 = params.documentSubType2
        String windowed = params.windowed ?: null	//for view approved eTS popup
		//reverse Ets Flag param from ets_inquiry_utility.js
		//Boolean reverseEts=params.reverseEts?params.reverseEts.toBoolean():false
        Boolean reverseEts
        String reversalEtsNumber = ""
        String reversedEtsNumber = ""
		String approvers=""
		println "ETS PARAMS: "+params
		if("true" == params.reverseEts){
			reverseEts = true
		}else if((params.serviceType == null) || (params.serviceType.toString().equalsIgnoreCase("OPENING"))
			|| "viewMode" == params.viewMode) {
            reverseEts = false
        } else {
            reverseEts = true
        }
		
        // sets default value of documentSubType2 if cash or standby
        if ((documentSubType1.equalsIgnoreCase("CASH") || documentSubType1.equalsIgnoreCase("STANDBY")) && documentSubType2 == null) {
            documentSubType2 = "SIGHT"
        }

        // construct header title
		String headerTitle=null
		if(reverseEts) {
			headerTitle = headerService.getEtsReversalTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)
        }
		else {
			headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)
        }

		// keep session model
		session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE, windowed: windowed,reverseEts:reverseEts]
		def originalServiceInstructionId
        if (reverseEts) {
            reversalEtsNumber = params.etsNumber 
            Map<String, Object> reversalEtsMap = etsService.getEts(reversalEtsNumber)
            reversedEtsNumber = reversalEtsMap.serviceInstructionId
			originalServiceInstructionId = reversalEtsMap.etsNumber
			//approvers=reversalEtsMap.approvers

            // this is for ets reversal - same rules apply to routing (loads the reversal instead of the original ets)
            Map<String, Object> etsReversal = etsService.getEts(params.reversalEtsNumber)
            approvers = etsReversal.approvers
        }
		
        if (params.etsNumber) {
			
            Map<String, Object> etsMap
            etsMap = reverseEts ? etsService.getEts(reversedEtsNumber) : etsService.getEts(params.etsNumber)
			if(reverseEts){
				etsMap.approvers=approvers
                // this is for reversal
                etsMap.put("reversalEtsNumber", params.reversalEtsNumber)
                etsMap.put("serviceInstructionId", originalServiceInstructionId)
			}

			if("viewMode" == params.viewMode){
				etsMap.remove("reverseEts")
			}
			
            String cilexFlag = "false";
            if(etsMap.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(etsMap.tradeServiceId)
            }
            session.etsModel << [cilexFlag: cilexFlag]


            etsMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
			////println"SESSION MODEL"+ session.etsModel
            // todo: refactor, this should be in a service or something
            def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
            session.nextRoute = documentServiceRoute
            session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
        }
		session.etsModel<<[viewMode:params.viewMode]
		
		
        ////println"initializing " + session.etsModel?.approvers
        // chain to render page
		chain(action:"viewOpening", model: session.etsModel)
	}
	
	// saves new instance of ets
	def saveOpeningEts() {
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2
//        ////printlnparams.foreignExchangeRates

		//construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)
		
		// keep session model
        session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

		// trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
		println params
        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
				println "key:value " + it.key+":"+it.value
                session.etsModel << it
            }
        }

        // todo: refactor, this should be in a service or something
        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
		//for cancel button in basic details tab
		session.cancelBd=params.cancelBd
		
        // chain to render page
		chain(action:"viewOpening", model: session.etsModel)
	}
	
	// updates instance of ets
	def updateOpeningEts() {
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1?.toUpperCase()
        String documentSubType2 = params.documentSubType2

		//saves over-availment message if non-existent
		if (!params.overAvailment && session.etsModel.overAvailment){
			params.put("overAvailment",	 session.etsModel.overAvailment)
		}
		
        //construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

		// keep session model
        session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        session.etsModel << [formName: tabUtilityService.getTabName(params.form)]
		// trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
		
		Map<String, Object> etsMap = etsService.updateEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
		//for cancel button in basic details tab
		session.cancelBd=params.cancelBd

		// chain to render page
		chain(action:"viewOpening", model:session.etsModel)
	}
	
	def uploadDocument() {

        try {

            //handle uploaded file
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

            String tradeServiceId = params?.tradeServiceId
            println "tradeServiceId = ${tradeServiceId}"

            params.filename = documentUploadingService.saveFile(uploadedFile, tradeServiceId)

        } catch(Exception e) {
            e.printStackTrace()
            ////printlne.message
        }

		//NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
		redirect(controller:'lcEtsOpening', action:'invokeUploadCommand', params:params)
        // forward controller: "lcEtsOpening", action: "invokeUploadCommand", params:params
	}
	
	def invokeUploadCommand() {

        def jsonData

        try {

            session.etsModel << [formName: tabUtilityService.getTabName(params.form)]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            String temp =  etsService.uploadAttachedToEts(params)
            jsonData = [success: true]

        } catch(Exception e) {

            e.printStackTrace()
            ////printlne.message
            jsonData = [success: false]
        }

        chain(action:"viewOpening", model: session.etsModel)
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

	
	// re-route status of ets
	def updateEtsStatus() {
        ////printlnparams
        String documentType = params.documentType
        String documentSubType1 =  params.documentSubType1?.toUpperCase() 
        String documentSubType2 = params.documentSubType2

		//saves over-availment message if non-existent
		if (!params.overAvailment && session.etsModel.overAvailment){
			params.put("overAvailment",	 session.etsModel.overAvailment)
		}
		
        //construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)

		
        etsService.updateEts(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
	}
}
