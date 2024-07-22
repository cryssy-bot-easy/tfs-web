package com.ucpb.tfsweb.admin

import java.util.List;
import java.util.Map;


@Deprecated
class UploadRmaService {
	def coreAPIService
	
	def processData(List<Map<String,Object>> resultList){
		boolean result=true;
		if(resultList == null || resultList.isEmpty()){
			return false;
		}
		Map<String,Object> parameters = new HashMap<String,Object>()
		parameters.put("resultList",resultList)
		println "PROCESS REF BANKS"
		def returnValue = coreAPIService.dummySendCommand(parameters, "processRefBanks", "refBank/bankDetails/")
		if(returnValue.error != null){
			result=false;
		}
		return result;
	}
	
	def processData(Map<String,String> resultList){
		boolean result=true;
		if(resultList == null || resultList.isEmpty()){
			return false;
		}
		def parameter=["resultList":resultList]
		def returnValue = coreAPIService.dummySendCommand(parameter, "processRefBank", "refBank/bankDetails/")
		//Skip bank cannot exist exception
		if(returnValue.status == "error"){
			println "ERROR IN REFBANK: "+returnValue.error.description
			println resultList
			result=false
		}
		return result;
	}
	
}
