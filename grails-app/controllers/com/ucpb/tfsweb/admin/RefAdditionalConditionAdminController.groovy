package com.ucpb.tfsweb.admin

import grails.converters.JSON

class RefAdditionalConditionAdminController {

	def coreAPIService
	
	def view(){
		println "Additional Condition Maintenance Page"
			
		def parameter = [:]
		
		def returnValues = coreAPIService.dummySendQuery(parameter, "getAllAdditionalCondition", "refAdditionalCondition/").details
		
		List refAdditionalCondition = []
		
		int i = 0
		
		returnValues.each { details ->
			i++;
			refAdditionalCondition.add([id: details?.id, conditionType: details?.conditionType, conditionCode: details?.conditionCode, condition: details?.condition, i:i])
		}
		
		render(view:"/admin/refAdditionalCondition/search", model:[additionalCondition: refAdditionalCondition])
	}
	
	def addOrEdit(){
		println "Add or Edit Additional Condition" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "refAdditionalCondition/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
	
	def delete(){
		println "Delete Additional Condition" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "delete", "refAdditionalCondition/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
	}
}
