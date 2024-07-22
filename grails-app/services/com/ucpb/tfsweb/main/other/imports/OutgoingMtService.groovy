package com.ucpb.tfsweb.main.other.imports

class OutgoingMtService {

	def coreAPIService
	def routingInformationService

	def loadMtDetails(tradeServiceId,messageType){
		def parameters = [tradeServiceId : tradeServiceId?:"", messageType : messageType];
		def model = coreAPIService.httpGetCommand(parameters, "details","tradeservice/").details;
		return model
	}

	def getNextApprovers(userName,userId,userLevel,unitCode,documentData){
		return routingInformationService.getNextMainApproverTsdInitiated("MT", "OUTGOING", null, null, "OUTGOING_MT", "CREATE", userName, userId, unitCode, documentData, userLevel)
	}
	
	def getApprovalMode(approvers){
		return routingInformationService.getMainApprovalMode("MT", "OUTGOING", null, null,"CREATE", approvers)
	}
	
	def getExistingTransaction(String documentNumber,String messageType){
		def parameters = [documentNumber : documentNumber,messageType : messageType];
		def result = coreAPIService.dummySendCommand(parameters, "getExistingTransaction","outgoingMT/")?.details;
		result = normalizeDocumentNumber(result,messageType)
		return result
	}
	
	def normalizeDocumentNumber(model,messageType){
		if(model?.tradeProductNumber?.tradeProductNumber != null &&
			!model?.tradeProductNumber?.tradeProductNumber.toString().isEmpty()){
			model.documentNumber << ["documentNumber": model?.tradeProductNumber?.tradeProductNumber]
			switch(messageType.toString()){
				case "103":
				case "202":
				case "742":
					model.details << ["documentNumber": model?.tradeProductNumber?.tradeProductNumber]
					break
				case "752":
					model.details << ["lcNumber": model?.tradeProductNumber?.tradeProductNumber]
					break
				case "799":
					model.details << ["documentNumberMt799": model?.tradeProductNumber?.tradeProductNumber]
					break
				case "199":
				case "299":
				case "499":
				case "999":
					model.details << ["transactionReferenceNumber": model?.tradeProductNumber?.tradeProductNumber]
					break
				default:
					break
			}
		}
		return model
	}
	
	def loadExistingDataToParams(model,params){
		if(model.details){
			model.details.remove("tradeServiceId")
			model.details.remove("outgoingTradeServiceId")
			params.remove("tradeServiceId")
			params.remove("outgoingTradeServiceId")
			model.details.each{
				params.put(it.key, it.value)
			}
		}
		return params
	}
}