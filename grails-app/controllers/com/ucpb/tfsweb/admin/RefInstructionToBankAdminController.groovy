package com.ucpb.tfsweb.admin

import grails.converters.JSON


class RefInstructionToBankAdminController {
	
	def coreAPIService
	
	def view(){
		println "Instruction to Bank Maintenance Page"
			
		def parameter = [:]
		
		def returnValues = coreAPIService.dummySendQuery(parameter, "getAllInstructionToBank", "refInstructionToBank/").details
		
		println returnValues;
		
		List refInstructionToBank = []
		
		int i = 0
		returnValues.each { details ->
			i++
			refInstructionToBank.add([id: details?.id, instructionToBankCode: details?.instructionToBankCode, instruction: details?.instruction, i:i])
		}
		
		render(view:"/admin/refInstructionToBank/search", model:[instructionToBank: refInstructionToBank])
	}
	
	def addOrEdit(){
		println "Add or Edit Instruction to Bank" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "refInstructionToBank/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
	
	def delete(){
		println "Delete Instruction to Bank" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "delete", "refInstructionToBank/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
}
