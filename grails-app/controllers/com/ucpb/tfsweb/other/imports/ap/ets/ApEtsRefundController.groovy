package com.ucpb.tfsweb.other.imports.ap.ets

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

class ApEtsRefundController {

    def headerService
    def etsService
    def commandService
    def tabUtilityService

    def parserService
    def routingInformationService
    def servletContext
	
	def documentUploadingService
	def dataEntryService
	def coreAPIService

    protected String REFERENCE_TYPE = "ETS"
    protected String SERVICE_TYPE = "REFUND"
    protected String DOCUMENT_CLASS = "AP"

    def viewRefund() {
        // if accessed from create transaction
        if(chainModel) {
            session.etsModel = chainModel
        }

        if(session.etsModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/ap/index", model: chainModel ?: session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }

    def viewRefundEts() {
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        // sets default value of documentSubType2 if cash or standby
        if ((documentSubType1.equalsIgnoreCase("CASH") || documentSubType1.equalsIgnoreCase("STANDBY")) && documentSubType2 == null) {
            documentSubType2 = "SIGHT"
        }

        // construct header title
        String headerTitle = headerService.getEtsTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.etsModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, documentSubType2: documentSubType2, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.etsNumber) {
            Map<String, Object> etsMap = etsService.getEts(params.etsNumber)

            etsMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
        }
		def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
		session.nextRoute = documentServiceRoute
		session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        // chain to render page
        chain(action:"viewRefund", model: session.etsModel)
    }

    def saveRefundEts() {
        //construct header title
        String headerTitle = "AP Monitoring Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

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
		def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
		session.nextRoute = documentServiceRoute
		session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        // chain to render page
        chain(action:"viewRefund", model: session.etsModel)
    }

    def updateRefundEts() {
        //construct header title
        String headerTitle = "AP Monitoring Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

		session.etsModel << [formName: tabUtilityService.getTabName(params.form)]
		
		params.saveAs = ""
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> etsMap = etsService.updateEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }
		def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
		session.nextRoute = documentServiceRoute
		session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, null, null, null, SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        // chain to render page
        chain(action:"viewRefund", model:session.etsModel)
    }

    def updateEtsStatus() {
        //construct header title
        String headerTitle = "AP Monitoring Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

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
		redirect(controller:'apEtsRefund', action:'invokeUploadCommand',params:params)
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
			chain(action:"viewRefund", model: session.etsModel)
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
