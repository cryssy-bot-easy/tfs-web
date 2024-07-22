package com.ucpb.tfsweb.admin

import com.ucpb.tfsweb.main.RequiredDocumentsService;
import grails.converters.JSON

class RefRequiredDocumentsAdminController {
	
	def coreAPIService
	
	def view(){
		println "Required Documents Maintenance Page"
			
		def parameter = [:]
		
		def returnValues = coreAPIService.dummySendQuery(parameter, "getAllRequiredDocument", "refRequiredDocument/").details
		
		List refRequiredDocuments = []
		
		int i = 0
		
		returnValues.each { details ->
			i++
			refRequiredDocuments.add([id: details?.id, documentCode: details?.documentCode, description: details?.description, documentType: details?.documentType, i: i])
		}
		
		render(view:"/admin/refRequiredDocument/search", model:[requiredDocuments: refRequiredDocuments])
	}
	
	def addOrEditDocument(){
		println "Add or Edit Document" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "refRequiredDocument/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
	
	def deleteDocument(){
		println "Delete Document" + params  
		
		def returnValues = coreAPIService.dummySendCommand(params, "delete", "refRequiredDocument/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
	
}
