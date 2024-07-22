package com.ucpb.tfsweb.main

/**
 */
class PaymentService {

    def coreAPIService;


    def payItem(String tradeServiceId,String paymentDetailId,String userId,String supervisorId, referenceId){
        def params = [
                tradeServiceId : tradeServiceId,
                paymentDetailId : paymentDetailId,
                userId : userId,
                supervisorId : supervisorId,
				referenceId : referenceId
        ]

        return coreAPIService.dummySendCommand(params,"payItem","payment");
    }

    def addSettlement(params, userId){
        params["userId"] = userId;
        return coreAPIService.dummySendCommand(params,"addSettlement","payment");
    }

    def reversePayment(String paymentDetailId, String userId, String reversalDENumber, String supervisorId){
        def params = [
                paymentDetailId: paymentDetailId,
                userId : userId,
                reversalDENumber : reversalDENumber,
                supervisorId: supervisorId
        ]
        return coreAPIService.dummySendCommand(params,"reverseItem","payment");
    }
    
	def errorCorrectTfsPayment(String paymentDetailId, String userId, String reversalDENumber){
    	def params = [
              paymentDetailId: paymentDetailId,
              reversalDENumber : reversalDENumber
              ]
		return coreAPIService.dummySendCommand(params,"errorCorrectPayment","payment");
    }

//    def validateCasaTransactionAmount(String allocationUnitCode, String currency, BigDecimal amount){
    def validateCasaTransactionAmount(String userId, String currency, BigDecimal amount){
        def params = [
//                unitCode : allocationUnitCode,
                userId: userId,
                currency : currency,
                amount : amount
        ]
        println "params " + params
        return coreAPIService.dummySendCommand(params,"validateCasaTransactionAmount","payment");
    }


}
