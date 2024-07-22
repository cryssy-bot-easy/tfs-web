package com.ucpb.tfsweb.main

import grails.converters.JSON
import net.ipc.utils.DateUtils

class MtService {

    def queryService
    def commandService
    def commandBusService

    def coreAPIService

    def tradeServiceFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class
    def mtMessageFinder = com.ucpb.tfs.application.query.mtmessage.IMtMessageFinder.class

    Map<String, Object> getMtMessage(id) {

        List<Map<String, Object>> queryResult = queryService.executeQuery(mtMessageFinder, "findMtMessage", [id: id])
        println "getMtMessage  queryResult:"+queryResult
        Map<String, Object> mtMessage = new HashMap<String, Object>()

        mtMessage.put("id", queryResult[0].ID)
        mtMessage.put("tradeServiceReferenceNumber", queryResult[0].TRADESERVICEREFERENCENUMBER)
        mtMessage.put("documentNumber", queryResult[0].DOCUMENTNUMBER)
        mtMessage.put("mtStatus", queryResult[0].MTSTATUS)
        mtMessage.put("dateReceived", queryResult[0].DATERECEIVED ? DateUtils.shortDateFormat(queryResult[0].DATERECEIVED) : "")
        mtMessage.put("mtType", queryResult[0].MTTYPE)
        mtMessage.put("message", queryResult[0].MESSAGE)
        mtMessage.put("instruction", queryResult[0].INSTRUCTION)
        mtMessage.put("userActiveDirectoryId", queryResult[0].USERACTIVEDIRECTORYID)
        mtMessage.put("modifiedDate", queryResult[0].MODIFIEDDATE ? DateUtils.shortDateFormat(queryResult[0].MODIFIEDDATE) : "")
        mtMessage.put("mtDirection", queryResult[0].MTDIRECTION)
        mtMessage.put("messageClass", queryResult[0].MESSAGECLASS)
        mtMessage.put("tradeServiceId", queryResult[0].TRADESERVICEID)

        return mtMessage
    }
    
    Map<String, Object> updateMtMessage(params) {
        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")

        Map<String, String> parameterMap = new HashMap<String, String>()

        params.each {
            parameterMap.put(it.key, it.value)
        }

        commandService.updateCommand("mtMessage", parameterMap, params.statusAction)

        Map<String, Object> mtMessage = null;
        try {
            mtMessage = getMtMessage(params.id)
        } catch(Exception e) {
            e.printStackTrace()

        }
        return mtMessage
    }
	
	boolean transmitAllMts(Map<String,String> parameterMap) {
		try {
			commandService.updateCommand("mtMessage", parameterMap, parameterMap.get("statusAction"))
		} catch(Exception e) {
			e.printStackTrace()
			return false
		}
		return true
	}

    Map<String, Object> getTradeServiceByReferenceNumber(tradeServiceReferenceNumber) {
        // sets method name and parameters
        String methodName = "findTradeServiceByReferenceNumber"
        Map<String, Object> param = [tradeserviceReferenceNumber: tradeServiceReferenceNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceFinder, methodName, param)

        if(queryResult == null) {
            return null
        }

        return queryResult[0]
    }

    def generateTradeServiceFromMt(id) {
        return coreAPIService.dummySendCommand([id: id], "generateTradeService", "mtMessage")
    }

}
