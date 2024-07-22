package com.ucpb.tfsweb.admin

import grails.converters.JSON

class RefFirmLibAdminController {
	
	def coreAPIService
	
	def index() {
		redirect(action: "search")
	}
	
	def search() {
		Map searchParams = [:]
		
		if(params.searchFirmCode != null && !params.searchFirmCode.trim().isEmpty()) {
			searchParams.put("firmCode", params.searchFirmCode)
		}
		if(params.searchFirmDescription != null && !params.searchFirmDescription.trim().isEmpty()) {
			searchParams.put("firmDescription", params.searchFirmDescription)
		}
		
		List firmLib = []
		int idCount = 0
		def returnValues = coreAPIService.dummySendQuery(searchParams, "searchFirmLib", "refFirmLib/").details		
		
		if(returnValues != "not found") {
			returnValues.each {details ->
				idCount++
				firmLib.add([firmCode: details?.firmCode, firmDescription: details?.firmDescription, idCount: idCount])
			}
			render (view: "/admin/refFirmLib/search", model: [refFirmLib: firmLib])
		} else {
			render (view: "/admin/refFirmLib/search")
		}
	}
	
	def addOrEdit() {		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "refFirmLib/")
		
		//TODO
		def jsonData = [success: returnValues.checkRecord == "notExisting" ? "true" : "false"]		
		render(jsonData as JSON)
	}
	
	def delete() {
		def returnValues = coreAPIService.dummySendCommand(params, "delete", "refFirmLib/")
		
		//TODO
		def jsonData = [success: returnValues.status == "ok" ? "true" : "false"]
		render(jsonData as JSON)
	}
}
