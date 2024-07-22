package com.ucpb.tfsweb.telecoms

import java.util.Map;

import grails.converters.JSON

class TelecomsController {

	def telecomsService
	def mtService
	
    def index() {
		redirect(action:'viewUnactedMt',params:params)
	}
	
	
	def viewUnactedMt(){
		render(view:'/telecoms/index',model:[outputType:'NEW',title:'Main Unacted MTs'])
	}

	def viewTransmittedMt(){
		render(view:'/telecoms/index',model:[outputType:'TRANSMITTED',title:'Transmitted MTs'])
	}
	
	def viewDiscardedMt(){
		render(view:'/telecoms/index',model:[outputType:'DISCARDED',title:'Discarded MTs'])
	}

	def getOutgoingMtGridData(){
		def maxRows = params.int('rows') ?: 10
		def currentPage = params.int('page') ?: 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = telecomsService.findAllOutgoingMt(maxRows, rowOffset, currentPage,params.outputType)

		def totalRows = mapList.totalRows
		def numberOfPages = Math.ceil(totalRows / maxRows)
		def results = telecomsService.constructOutgoingMt(mapList.display)

		def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
		
		render jsonData as JSON
	}
	
	def transmitAllMts(){
		Map<String, String> parameterMap = new HashMap<String, String>()
		List<Map<String, Object>> newMtList = telecomsService.findAllNewMts()
		
		 
		parameterMap.put("statusAction", "transmit")
		parameterMap.put("type", "OUTGOING")
		newMtList.each {
			parameterMap.put("id",it?.ID?.toString())
			if(!mtService.transmitAllMts(parameterMap)){
				System.err.println("Error Transmitting ID Number: $it")
				flash.message = "Some MTs were not transmitted."
			}
		}
		
		redirect (action:'viewUnactedMt')
	}
}