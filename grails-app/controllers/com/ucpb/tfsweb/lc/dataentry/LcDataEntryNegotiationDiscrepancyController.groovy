package com.ucpb.tfsweb.lc.dataentry

import grails.converters.JSON
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class LcDataEntryNegotiationDiscrepancyController {

	def headerService

	def parserService

    def chargesPaymentService

    def dataEntryService

    def routingInformationService

    def tabUtilityService

    def foreignExchangeService

    def ratesService

    def documentUploadingService
	
	def coreAPIService
	def documentClassService
	
	// sets service type
	protected String SERVICE_TYPE = "Negotiation Discrepancy"
	protected String SERVICE_TYPE_ACTUAL = "Negotiation_Discrepancy"
	protected String DOCUMENT_CLASS = "LC"
	protected String REFERENCE_TYPE="DATA_ENTRY"

    def viewNegotiationDiscrepancy() {
        //println"viewNegotiationDiscrepancy" + params
        if(chainModel) {
            session.dataEntryModel = chainModel							
        }
		
		//go to unacted if cancelled from basic details tab
		if(session.cancelBd){
			 session.removeAttribute("cancelBd")
			 render(view:"/main/unacted_transaction")
		}
        else if(session.dataEntryModel) {
			String lcNumber = session.dataEntryModel?.lcNumber ?: session.dataEntryModel?.documentNumber
			println "lcNumber : " + lcNumber
			
			println "LcDataEntryNegotiationDiscrepancyController.viewNegotiationDiscrepancy (line 51)"
			
			println "Before totalRegularAmount : " + session?.dataEntryModel?.totalRegularAmount
			println "Before totalCashAmount : " + session?.dataEntryModel?.totalCashAmount
			
			Map<String, Object> resultMap = documentClassService.findRegualarAndCashIcAmount(lcNumber)
			
			if (session?.dataEntryModel?.totalRegularAmount == null) {
				session.dataEntryModel << [totalRegularAmount: resultMap.get("TOTALREGULARAMOUNT")]
			}
			if (session?.dataEntryModel?.totalCashAmount == null) {
				session.dataEntryModel << [totalCashAmount: resultMap.get("TOTALCASHAMOUNT")]
			}
			
			println "After totalRegularAmount : " + session?.dataEntryModel?.totalRegularAmount
			println "After totalCashAmount : " + session?.dataEntryModel?.totalCashAmount
			
            String tradeServiceId = session.dataEntryModel.tradeServiceId
            Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
            session.dataEntryModel << [paymentsMade: paymentsMade.payments]
            session.dataEntryModel << [loanCount: paymentsMade.loanCount]

            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
            session.dataEntryModel << [exchange:exchange]

            render(view: "/lc/dataentry/opening/index", model:chainModel ? chainModel : session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

    def viewNegotiationDiscrepancyDataEntry() {
        // get lc class and type
        //println"viewNegotiationDiscrepancyDataEntry:"+params
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2
        session.etsPopup = "false"

        // construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE_ACTUAL, documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE_ACTUAL, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }

                ////printlnit
            }
        }

        // todo: refactor, this should be in a service or something
        // todo: we are still using etsModel so we don't have to do an if in the instructions and routing tab
        def documentServiceRoute = routingInformationService.getNextMainApproverTsdInitiated(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE_ACTUAL?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE_ACTUAL?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, SERVICE_TYPE_ACTUAL?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
        // chain to render page
        chain(action:"viewNegotiationDiscrepancy", model: session.dataEntryModel)
    }

    def saveNegotiationDiscrepancyDataEntry() {
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE_ACTUAL, documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE_ACTUAL, referenceType: REFERENCE_TYPE]

        params.saveAs = "PENDING"

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> dataEntryMap = dataEntryService.saveDataEntry(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.dataEntryModel << it
            }
        }

        def documentServiceRoute = routingInformationService.getNextMainApproverTsdInitiated(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE_ACTUAL?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE_ACTUAL?.toUpperCase(), session.dataEntryModel.approvers)
		session.cancelBd=params.cancelBd

        // chain to render page
        chain(action:"viewNegotiationDiscrepancy", model:session.dataEntryModel)
    }

    def updateNegotiationDiscrepancyDataEntry() {
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE_ACTUAL, documentSubType2)

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE_ACTUAL, referenceType: REFERENCE_TYPE]
        session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.dataEntryModel << it
            }
        }
		session.cancelBd=params.cancelBd

        // chain to render page
        chain(action:"viewNegotiationDiscrepancy", model:session.dataEntryModel)
    }

    def updateDataEntryStatus() {
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        //construct header title
        String headerTitle = headerService.getDataEntryTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE_ACTUAL, documentSubType2)

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        // keep session model
        session.dataEntryModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE_ACTUAL, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def viewAttachments() {

        def tradeServiceIdHolder =  params.tradeServiceIdHolder
        ////println"tradeServiceIdHolder:" + tradeServiceIdHolder

        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = dataEntryService.getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = dataEntryService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON

    }

    def uploadDocument() {
        def jsonData
        try{
            ////printlnrequest
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
            MultipartFile uploadedFile = multiRequest.getFile("fileLocation")
            params.serviceType=="NEGOTIATION_DISCREPANCY"
			
            String tradeServiceId = params?.tradeServiceId
            println "tradeServiceId = ${tradeServiceId}"

            params.filename = documentUploadingService.saveFile(uploadedFile, tradeServiceId)

        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
        }
        //NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
        //redirect(controller:'lcDataEntryNegotiationDiscrepancy', action:'invokeUploadCommand',params:params)
        redirect(controller:'lcDataEntryNegotiationDiscrepancy', action:'invokeUploadCommand',params:params)
    }

    def invokeUploadCommand(){
        def jsonData

        try{

            session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            params.put("serviceType", "NEGOTIATION_DISCREPANCY")
            // trigger command
            String temp =  dataEntryService.uploadAttachedToTradeService(params)
            jsonData = [success: true]
        } catch(Exception e){
            e.printStackTrace()
            ////printlne.message
            jsonData = [success: false]
        }
        chain(action:"viewNegotiationDiscrepancy", model: session.dataEntryModel)
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

}
