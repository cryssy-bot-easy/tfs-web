package com.ucpb.tfsweb.other.imports.ap.dataentry

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

class ApDataEntryRefundController {

    def dataEntryService
    def chargesService
    def routingInformationService
	def documentUploadingService
	def coreAPIService

    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Refund"
    protected String DOCUMENT_CLASS = "AP"
    protected String DOCUMENT_TYPE = ""
	
	def tabUtilityService

    def viewRefund() {
        // if accessed from create transaction
        if (chainModel) {
            session.dataEntryModel = chainModel
        }

        if (session.dataEntryModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/ap/index", model: chainModel ?: session.dataEntryModel)
        } else {
            render(view: "/main/unauthorized")
        }
    }

    def viewRefundDataEntry() {
        // construct header title
        String headerTitle = "AP Monitoring Refund - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        }
		def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, null, null, null,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        ////println"*******view**********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
        // chain to render page

//        def documentServiceRoute = routingInformationService.getDocumentServiceRoute(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.dataEntryModel << [nextRoute: ""]

        chain(action: "viewRefund", model: session.dataEntryModel)
    }

    def saveRefundDataEntry() {
        String headerTitle = "AP Monitoring Refund - Data Entry"

        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = "PENDING"

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> dataEntryMap = dataEntryService.saveDataEntry(params)

        dataEntryMap.each {
            if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                session.dataEntryModel << it
            }
        }
		def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, null, null, null,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        ////println"*******view**********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
        // chain to render page

        chain(action: "viewRefund", model: session.dataEntryModel)
    }

    def updateRefundDataEntry() {
        String headerTitle = "AP Monitoring Refund - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
		session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

        dataEntryMap.each {
            if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                session.dataEntryModel << it
            }
        }
		def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, null, null, null,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        ////println"*******view**********"
        ////println"financial >> " + session.financial
        ////println"postApprovalRequirement >> " + session.postApprovalRequirement
        ////println"amountToCheck >> " + session.amountToCheck
        ////println"signingLimit >> " + session.signingLimit
        ////println"postingAuthority >> " + session.postingAuthority
        ////println"status >> " + session.dataEntryModel?.status
        ////println"***********************"
		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
        // chain to render page

        chain(action: "viewRefund", model: session.dataEntryModel)
    }

    def updateDataEntryStatus() {
        //construct header title
        String headerTitle = "AP Monitoring Refund - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

// pay charges (create Debit accounting entry)
    def payItem() {
        def jsonData = [:]

        try {
            chargesService.payCharges(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

    def reversePayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

    def errorCorrectPayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
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
		redirect(controller:'apDataEntryRefund', action:'invokeUploadCommand',params:params)
	}
	
	def invokeUploadCommand(){
		def jsonData
		
		try{

			session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

			params.put("username", session.username)
			params.put("unitcode", session.unitcode)
			// trigger command
			String temp =  dataEntryService.uploadAttachedToTradeService(params)
				jsonData = [success: true]
			} catch(Exception e){
				e.printStackTrace()
				////printlne.message
				jsonData = [success: false]
			}
			chain(action:"viewRefund", model: session.dataEntryModel)
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
}
