package com.ucpb.tfsweb.main

import java.util.Date;

class HolidayService {

//    def holidayfinder = com.ucpb.tfs.interfaces.services.HolidayService.class
	def coreAPIService
//	def queryService
	
	def isHolidayOrIsNotABusinessDay(String loanMaturityDate, String branchUnitCode){
		println "HERE"
		try{
//			Boolean queryResult = queryService.executeQuery(holidayfinder, "isHolidayOrIsNotABusinessDay", [date: loanMaturityDate, branchCode: branchUnitCode])
			def queryResult = coreAPIService.dummySendCommand([date: loanMaturityDate, branchCode: branchUnitCode], "getHoliday", "/payment")
			println queryResult
			Boolean isHoliday = queryResult["result"]
			return isHoliday
		} catch(Exception e){
			e.printStackTrace()
		}
	}
}
