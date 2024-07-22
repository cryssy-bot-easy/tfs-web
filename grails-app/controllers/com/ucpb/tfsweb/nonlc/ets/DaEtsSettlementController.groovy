package com.ucpb.tfsweb.nonlc.ets

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
 *	Project Name: DaEtsSettlementController.groovy
*/
/**
 * PROLOGUE
 * SCR/ER Description:
 *	[Revised by:] Cedrick C. Nungay
 *	[Date revised:] 04/13/2018
 *	Program [Revision] Details: Added parameters for computation of docstamps on page load.
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: DaEtsSettlementController.groovy
*/
class DaEtsSettlementController {

	def headerService
	def recomputeService
	def dataEntryService
    def etsService
    def chargesService
    def routingInformationService
    def parserService
    def ratesService
    def apService
    def arService
    def tabUtilityService
    def documentClassService
    def documentUploadingService
    def chargesPaymentService
    def foreignExchangeService
    def coreAPIService

    // sets service type
    protected String REFERENCE_TYPE = "ETS"
    protected String SERVICE_TYPE = "Settlement"
    protected String DOCUMENT_CLASS = "DA"
	protected String DOCUMENT_TYPE = "FOREIGN"

    // render page for viewing
    def viewSettlement() {
		session.etsModel << [hasCif : documentClassService.getDocumentaryCredit(session.etsModel.documentNumber, DOCUMENT_CLASS, "NEGOTIATION_ACCEPTANCE").cifNumber]
        // if accessed from create transaction
		/*if(chainModel) {
        session.etsModel = chainModel

        String etsNumber = session.etsModel.serviceInstructionId

        List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

        session.etsModel << [charges:charges]
        session.etsModel << [chargesString: parserService.listHashMapToString(charges)]
    }*/
	if(chainModel) {
		session.etsModel = chainModel

		String etsNumber = session.etsModel.serviceInstructionId ?: ""

		List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

		session.etsModel << [charges:charges]
		Map<String,Map<String, Object>> rates = ratesService.getDailyRates()
		session.etsModel << [rates:rates]

		session.etsModel << [chargesString: parserService.listHashMapToString(charges)]

//        List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency ?: "")
//        session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//        List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
//        session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

//        if (session.etsModel.settlementMode && !(session.etsModel.settlementMode.equals("TR") || session.etsModel.settlementMode.equals("DTR"))) {
        if (session.etsModel.settlementMode && !(session.etsModel.settlementMode.equals("TR"))) {
            session.etsModel << [approvalMode: 'APPROVE']
        } else {
            session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
        }

        String cilexFlag = "false";
        if(session.etsModel.tradeServiceId){
            cilexFlag = chargesPaymentService.getCilexFlag(session.etsModel.tradeServiceId)

            Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(session.etsModel.tradeServiceId)
            session.etsModel << [paymentsMade: paymentsMade.payments]
            session.etsModel << [loanCount: paymentsMade.loanCount]

        }
        session.etsModel << [cilexFlag: cilexFlag]

		if(!chainModel.currency) {
			chainModel.currency = "PHP"
		}

        def exchange = []

        ratesService.getBankNotSellRates(chainModel.currency).response.details.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

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

            if ("PHP".equals(chainModel.currency)) {
                println it.description
                if (it.description.contains("URR")) {
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
            } else {
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
        }

        session.etsModel << [exchange: exchange]

        def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
        session.etsModel << [urrrates:urrrates]
		
	}
		//go to unacted if cancelled from basic details tab
		if(session.cancelBd){
			 session.removeAttribute("cancelBd")
			 render(view:"/main/unacted_transaction")
		}
        else if(session.etsModel) {
            // passes chain model if existing else passes session model

            def cp = coreAPIService.dummySendQuery(
                [documentType: session.etsModel.documentType, documentClass: session.etsModel.documentClass,
                    documentSubType1: session.etsModel.documentSubType1, documentSubType2: session.etsModel.documentSubType2,
                    serviceType: 'SETTLEMENT'], 'getChargesParameter', 'chargesParameter/').result
            session.etsModel << [centavos: cp?.RATENEGOAMOUNT]
            session.etsModel << [documentaryStampForFirst: cp?.BASEAMOUNT]
            session.etsModel << [documentaryStampForFirstAmountPopup: cp?.RATEAMOUNT]
            session.etsModel << [documentaryStampForNext: cp?.SUCCEEDINGBASEAMOUNT]
            session.etsModel << [documentaryStampAmountForNextAmountPopup: cp?.SUCCEEDINGRATEAMOUNT]
            session.etsModel << [negotiationAmount: session.etsModel.outstandingAmount]
            render(view: "/nonlc/da/index", model: chainModel ? chainModel : session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }
    
    def viewSettlementEts() {

        Boolean reverseEts = false
        String reversalEtsNumber = ""
        String reversedEtsNumber = ""
        String approvers=""

        //println"viewSettlementEts servicetype params: " + params
        //println"viewSettlementEts servicetype: " + params.serviceType + " ::: " + params.reversal

        //printlnparams.reversalEtsNumber

        if((params.serviceType == null) || (params.serviceType.toString().equalsIgnoreCase("SETTLEMENT"))
			|| "viewMode" == params.viewMode) {
            reverseEts = false
        } else {
            reverseEts = true
        }

        // special handling if directed right after invoking reversal
        if (params.reversalEtsNumber != null) {
            params.etsNumber = params.reversalEtsNumber
            reverseEts = true
        }

		String documentType = params.documentType
		String windowed = params.windowed ?: null	//for view approved eTS popup
//        String headerTitle = "FX Document Against Acceptance Settlement Non-LC - eTS"
//		String headerTitle = headerService.getEtsTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, null, SERVICE_TYPE + (reverseEts ? " Reversal" : ""))
		String headerTitle = reverseEts ? headerService.getNonLcReversalTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, SERVICE_TYPE, REFERENCE_TYPE) : headerService.getEtsTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        session.etsModel = [documentType: DOCUMENT_TYPE,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE, windowed: windowed]
		def originalServiceInstructionId
        if (reverseEts) {
            reversalEtsNumber = params.etsNumber
            Map<String, Object> reversalEtsMap = etsService.getEts(reversalEtsNumber)
            approvers = reversalEtsMap.approvers
			originalServiceInstructionId = reversalEtsMap.etsNumber

            reversedEtsNumber = reversalEtsMap.etsNumber
        }

        if (params.etsNumber) {

            Map<String, Object> etsMap
            etsMap = reverseEts ? etsService.getEts(reversedEtsNumber) : etsService.getEts(params.etsNumber)

            if (reverseEts) {
                etsMap.approvers = approvers
                etsMap.put("reversalEtsNumber", reversalEtsNumber)
                etsMap.put("serviceInstructionId", originalServiceInstructionId)
                etsMap.put("reverseEts", true)
                etsMap.put("reverseEtsDisplay", true)
            }

			if("viewMode" == params.viewMode){
				etsMap.remove("reverseEts")
			}
			
			etsMap.each {
				if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
					session.etsModel << it
				}
			}


            String cilexFlag = "false";
            if(etsMap.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(etsMap.tradeServiceId)

                Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(etsMap.tradeServiceId)
                session.etsModel << [paymentsMade: paymentsMade.payments]
                session.etsModel << [loanCount: paymentsMade.loanCount]

            }
            session.etsModel << [cilexFlag: cilexFlag]



			//println"SESSION MODEL"+ session.etsModel
			// todo: refactor, this should be in a service or something
			def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
			session.nextRoute = documentServiceRoute

//            if (session.etsModel.settlementMode && !(session.etsModel.settlementMode.equals("TR") || session.etsModel.settlementMode.equals("DTR"))) {
//                session.etsModel << [approvalMode: 'APPROVE']
            if (session.etsModel.settleFlag && "Y".equals(session.etsModel.settleFlag)) {
                session.etsModel << [approvalMode: 'APPROVE']
            } else {
                session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
            }
		}
		session.etsModel << [viewMode:params.viewMode]
        chain(action: "viewSettlement", model: session.etsModel)
    }

    def saveSettlementEts() {
        String headerTitle = headerService.getEtsTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")

        session.etsModel = [documentType: DOCUMENT_TYPE,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = ""
        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        // todo: refactor, this should be in a service or something
        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute

//        if (session.etsModel.settlementMode && !(session.etsModel.settlementMode.equals("TR") || session.etsModel.settlementMode.equals("DTR"))) {
//            session.etsModel << [approvalMode: 'APPROVE']
        if (session.etsModel.settleFlag && "Y".equals(session.etsModel.settleFlag)) {
            session.etsModel << [approvalMode: 'APPROVE']
        } else {
            session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
        }

		session.cancelBd=params.cancelBd
		
        // chain to render page
        chain(action: "viewSettlement", model: session.etsModel)
    }

    def updateSettlementEts() {
		String headerTitle = headerService.getEtsTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")
		
		//keep session model
		session.etsModel << [documentType: DOCUMENT_TYPE,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
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
		
		def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "", REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
		session.nextRoute = documentServiceRoute

//        if (session.etsModel.settlementMode && !(session.etsModel.settlementMode.equals("TR") || session.etsModel.settlementMode.equals("DTR"))) {
//            session.etsModel << [approvalMode: 'APPROVE']
        if (session.etsModel.settleFlag && "Y".equals(session.etsModel.settleFlag)) {
            session.etsModel << [approvalMode: 'APPROVE']
        } else {
            session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, DOCUMENT_TYPE, "", "",SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
        }

		session.cancelBd=params.cancelBd
		
		// chain to render page
		chain(action: "viewSettlement", model: session.etsModel)
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
        }

        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
        redirect(action:'invokeUploadCommand',params:params)
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
            jsonData = [success: false]
        }
        chain(action:"viewSettlement", model: session.etsModel)
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
	
	def updateEtsStatus() {
        String headerTitle = headerService.getEtsTitle(DOCUMENT_TYPE, DOCUMENT_CLASS, "", SERVICE_TYPE, "")
        
        //keep session model
        session.etsModel << [documentType: DOCUMENT_TYPE,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
		params.put("username", session.username)
		
		params.put("unitcode", session.unitcode)
		// trigger command
		etsService.updateEts(params)

		// chain to render page
		redirect(controller: "unactedTransactions", action: "viewUnacted")
    }
	
	// add instruction remarks
	def addRemarks() {
		// trigger command
		def jsonData = [success: true]
		
		render jsonData as JSON
	}
	
	// update instruction remarks
	def updateRemarks() {
		// trigger command
		def jsonData = [success: true]

		render jsonData as JSON
	}
    
}
