package com.ucpb.tfsweb.other.imports.ar.dataentry

import grails.converters.JSON
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartFile;

class ArDataEntrySetupController {

    def dataEntryService
    def routingInformationService
	
	def tabUtilityService
	def documentUploadingService
	def coreAPIService

    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Setup"
    protected String DOCUMENT_CLASS = "AR"
    protected String DOCUMENT_TYPE = ""

    def viewSetup() {
        // if accessed from create transaction
        if (chainModel) {
            session.dataEntryModel = chainModel
        }
		
		session.dataEntryModel << [basicDetailsAction: "saveSetupDataEntry"]

        if (session.dataEntryModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/ar/index", model: chainModel ?: session.dataEntryModel)
        } else {
            render(view: "/main/unauthorized")
        }
    }

    def viewSetupDataEntry() {
        // construct header title
        String headerTitle = "AR Monitoring Setup - Data Entry"

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

        def documentServiceRoute = routingInformationService.getNextMainApproverTsdInitiated(DOCUMENT_CLASS, null, null, null, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, null, null, null,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        ////println"route set! " + session.dataEntryModel.nextRoute

        chain(action: "viewSetup", model: session.dataEntryModel)
    }

    def saveSetupDataEntry() {
		
        String headerTitle = "AR Monitoring Setup - Data Entry"

        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = "PENDING"

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
		params.cifNumber = params.cifNumberParam
		params.cifName = params.cifNameParam
		params.accountOfficer = params.accountOfficerParam
		params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		params.longName = params.longName
		params.address1 = params.address1
		params.address2 = params.address2
		
        Map<String, Object> dataEntryMap = dataEntryService.saveDataEntry(params)

        dataEntryMap.each {
            if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                session.dataEntryModel << it
            }
        }

        chain(action: "viewSetup", model: session.dataEntryModel)
    }

    def updateSetupDataEntry() {
        String headerTitle = "AR Monitoring Setup - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

        dataEntryMap.each {
            if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                session.dataEntryModel << it
            }
        }

        chain(action: "viewSetup", model: session.dataEntryModel)
    }

    def updateDataEntryStatus() {
        //construct header title
        String headerTitle = "AR Monitoring Setup - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        dataEntryService.updateDataEntry(params)

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
		redirect(controller:'arDataEntrySetup', action:'invokeUploadCommand',params:params)
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
			chain(action:"viewSetup", model: session.dataEntryModel)
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
