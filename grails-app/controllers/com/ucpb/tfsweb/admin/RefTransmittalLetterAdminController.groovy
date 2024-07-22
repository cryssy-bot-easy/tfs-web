package com.ucpb.tfsweb.admin

import grails.converters.JSON

class RefTransmittalLetterAdminController {

	def coreAPIService
	
	def view(){
		println "RefTransmittalLetter Maintenance Page"
	
		def parameter = [:]
		
		def returnValues = coreAPIService.dummySendQuery(parameter, "getAllTransmittalLetter", "refTransmittalLetter/").details
		
		List refTransmittalLetter = []
		
		int i = 0
		
		returnValues.each { details ->
			i++
			refTransmittalLetter.add([id: details?.id, transmittalLetterCode: details?.transmittalLetterCode, letterDescription: details?.letterDescription, i:i])
		}
		
		render(view:"/admin/refTransmittalLetter/search", model:[transmittalLetter: refTransmittalLetter])
	}
	
	def addOrEditTransmittalLetter(){
		println "Add or Edit Transmittal Letter"
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "refTransmittalLetter/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
	
	def deleteTransmittalLetter(){
		println "Delete Transmittal Letter"
		
		def returnValues = coreAPIService.dummySendCommand(params, "delete", "refTransmittalLetter/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
}
