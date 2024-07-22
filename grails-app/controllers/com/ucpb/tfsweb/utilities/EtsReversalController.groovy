package com.ucpb.tfsweb.utilities

import grails.converters.JSON

/*
	 (revision)
	 SCR/ER Number: ER# 20170109-040
	 SCR/ER Description: Transaction allowed to be created even the facility is expired
	 [Revised by:] Jesse James Joson
	 [Date revised:] 1/17/2017
	 Program [Revision] Details: Check the expiry date of the facility before allowing to amend LC
	 Member Type: Groovy
	 Project: WEB
	 Project Name: EtsReversalController.groovy
*/

class EtsReversalController {

    def etsService
    def coreAPIService

    def requestReverse() {

        if (params.etsNumber != null && params.unitcode !=null && params.username != null) {

            Map paramz = [
                etsNumber : params.etsNumber,
                unitcode : params.unitcode,
                username : params.username
            ]

            def returnValue = coreAPIService.dummySendCommand(paramz, "reverse", "ets/").details

            Map redirectParams = [
                    action: 'viewEts',
                    controller: 'unactedTransactions',
                    params: [
                        reversal : true,
                        documentSubType1: returnValue.details.documentSubType1,
                        documentSubType2: returnValue.details.documentSubType2,
                        etsNumber: returnValue.serviceInstructionId.serviceInstructionId,
                        reversalEtsNumber: returnValue.serviceInstructionId.serviceInstructionId,
                        documentType: returnValue.details.documentType,
                        serviceType: params.serviceType, //returnValue.details.serviceType + "_REVERSAL",
                        documentClass: returnValue.details.documentClass,
                    ]
            ]
			
            forward(redirectParams)
        }
    }

    def validateMultipleServiceInstruction() {
        println "validating multiple service instruction"
        println params
        def validationResult = etsService.validateMultipleServiceInstruction(params.tradeProductNumber, params.serviceType?.toLowerCase() ?: null, params.serviceInstructionId, params.docType?.toLowerCase() ?: null)

        def jsonData = validationResult
        render(jsonData as JSON)
    }

    def validateMultipleTradeService() {
        println "validating multiple trade service"
        println params
        def validationResult = etsService.validateMultipleTradeService(params.tradeServiceId,
                params.tradeProductNumber,
                params.serviceType ?: null,
                params.isNotPrepared ?: null)
        println "validationResult > " + validationResult
        def jsonData = validationResult
        render(jsonData as JSON)
    }
}
