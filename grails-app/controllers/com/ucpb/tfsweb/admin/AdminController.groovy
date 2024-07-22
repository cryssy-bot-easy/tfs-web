package com.ucpb.tfsweb.admin

import grails.converters.JSON

class AdminController {

	def coreAPIService
	
    def index() {

		def parameter = [:]
		
		def returnValues = coreAPIService.dummySendQuery(parameter, "getCutOff", "cutOff/").details

        render (view: "/admin/index", model:[hour: returnValues?.cutOffTime?.substring(0, 2), minute:returnValues?.cutOffTime?.substring(3, 5), period: returnValues?.cutOffTime?.substring(6, 8)])

    }
	
	def changeCutOff(){
		println "Change Cut Off" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "cutOff/").details
		
		println "Return Values :" + returnValues
		
		//TODO
		def jsonData = [success: "true"]
		render(jsonData as JSON)
		
	}

}
