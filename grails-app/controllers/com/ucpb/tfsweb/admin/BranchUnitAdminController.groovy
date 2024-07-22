package com.ucpb.tfsweb.admin

class BranchUnitAdminController {
	
	def coreAPIService
	
	def index(){
		redirect(action:'search')
	}
	
	def search() {		
		Map parameters = [:]
		
		if(params.unitCode != null) {
			parameters.put("unitCode", params.unitCode)
		}

		if(params.unitName != null) {
			parameters.put("unitName", params.unitName)
		}
		
		def returnValues = coreAPIService.dummySendQuery(parameters, "search", "branchUnit/").details
		
		List branchUnitList = []
		
		returnValues.each { details ->
			branchUnitList.add([unitCode: details?.unitCode, unitName: details?.unitName])
		}
		
		render(view:"/admin/branchUnit/search", model: [branchUnit: branchUnitList])
	}
	
	def view(){
		def returnValues = coreAPIService.dummySendQuery(params, "search", "branchUnit/").details
		
		render(view:"/admin/branchUnit/view", model: [branchUnitDetail:returnValues[0]])
	}
	
	def save() {
		println "Saving" + params
		
		def returnValues = coreAPIService.dummySendCommand(params, "save", "branchUnit/").details
		
		redirect(action: "view", params: [unitCode:  params.unitCode])
	}	
	
	def add() {
		render(view:"/admin/branchUnit/view")
	}

}

