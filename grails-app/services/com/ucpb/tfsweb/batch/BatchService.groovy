package com.ucpb.tfsweb.batch

import java.text.SimpleDateFormat
import java.util.GregorianCalendar



/*  PROLOGUE:
 * 	(revision)
	SCR/ER Number:  20160613-044
	SCR/ER Description: Program abnormally terminates during SIBS DB access time-out.
	[Revised by:] Allan Comboy Jr.
	[Date Deployed:]  06/14/2016
	Program [Revision] Details: to reconnect when disconnected to sibs (for 4 additional programs)
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: BatchServices
 */

/*  PROLOGUE:
 * 	(revision)
	SCR/ER Number:  20160623-080
	SCR/ER Description: Program abnormally terminates during SIBS DB access time-out.
	[Revised by:] Allan Comboy Jr.
	[Date Deployed:]  06/14/2016
	Program [Revision] Details: for CREDEX and FORM 4
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: BatchServices
 */

/*  PROLOGUE:
 * 	(revision)
	SCR/ER Number:  ER 20160905-019
	SCR/ER Description: Revert ets to pending cannot connect to SIBS.
	[Revised by:] Jesse James Joson
	[Date Deployed:]  10/13/2016
	Program [Revision] Details: The UI for auto reconnect is not functioning, revise a line to correct it.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: BatchServices
 */

class BatchService {

	def coreAPIService
	
	def executeInterfaceMethods(params,methodNames){
		GregorianCalendar calendar = GregorianCalendar.getInstance()
		SimpleDateFormat formatter = new SimpleDateFormat("MM-dd-yyyy")
		def passedParams
		if(params.onlineReportDate != null){
			passedParams = ['date':formatter.format(new SimpleDateFormat("MM/dd/yyyy").parse(params.onlineReportDate))]
		}else{
			
			if(params.interface2Check!=null){
				
				if(params.interface2Check == "true"){
			
					passedParams = ['dateFrom':formatter.format(new SimpleDateFormat("MM/dd/yyyy").parse(params.dateOfTransactionFrom))]
					passedParams << ['dateTo':formatter.format(new SimpleDateFormat("MM/dd/yyyy").parse(params.dateOfTransactionTo))]
				}
			}else{
				passedParams = ['date':formatter.format(calendar.getTime())]
			}
		}
		

		ArrayList<String> methodNamesTemp = methodNames
		
		if(params.adhoc == "true" && params.methodName != null){
			methodNamesTemp.clear()
			methodNamesTemp.add(params.methodName)
		}
		def returnValue;
		def successList=[]

		for(String method : methodNamesTemp){
			println method + "POWER 2"
			try{
	
				returnValue = coreAPIService.dummySendQuery(passedParams, "batch/${method}")
				if(returnValue.success){
					successList.add(returnValue.name)
				
				}else {
					successList.add(returnValue.name)
					successList.add(returnValue.p_message)
				}
				if(returnValue.sibsretry){
					successList.add("hhreconmm"+returnValue.name+"hhreconmm")
					
				}

				
			}catch(Exception e){
				e.printStackTrace()
			}
		}
		return successList
	}
	
	
	
	def executeReRouteApprover(params,methodNames){
		
		def passedParams = ['docNumber':params.docNumber,'newApprover':params.newApprover]
		

		ArrayList<String> methodNamesTemp = methodNames
		
		if(params.adhoc == "true" && params.methodName != null){
			methodNamesTemp.clear()
			methodNamesTemp.add(params.methodName)
		}
		def returnValue;
		def successList=[]

		for(String method : methodNamesTemp){
			println method + "POWER 3"
			try{
	
				returnValue = coreAPIService.dummySendQuery(passedParams, "batch/${method}")
				
				
				println "returnValue Size: " + returnValue.size();
				returnValue.each { key, val ->
					println "Key: $key  Value: $val"
				}
				
				
				if(returnValue.success){
					successList.add(returnValue.name)
				
				}else {
					successList.add(returnValue.name)
					successList.add(returnValue.p_message)
				}
				if(returnValue.sibsretry){
					successList.add("hhreconmm"+returnValue.name+"hhreconmm")
					
				}
				
				println "successList Size: " + successList.size();
				successList.each { entry , index ->
				    println "${index}. successList: ${entry}"
				}
				
			}catch(Exception e){
				System.err.println("rerouteTradeServiceJob: "+ e.getMessage())
			}
		}
		return successList
	}

	def getInterfaceDirectories(){
		def result = coreAPIService.dummySendQuery([:], "batch/getInterfaceDirectories")
		return result.directories
	}	
	
	
	def testMeth(params,methodNames){
	
		def returnValue;
		def successList=[]
		ArrayList<String> methodNamesTemp = methodNames
		for(String method : methodNamesTemp){
			try{

				returnValue = coreAPIService.dummySendQuery(null, "batch/${method}")
				
				successList.add(returnValue.recon); // ER 20160905-019 - to return if for reconnection or not.

			}catch(Exception e){
				e.printStackTrace()
			}
		}

		return successList
	}
}