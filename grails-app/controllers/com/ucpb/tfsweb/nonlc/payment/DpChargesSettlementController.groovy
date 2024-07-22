package com.ucpb.tfsweb.nonlc.payment

import grails.converters.JSON

class DpChargesSettlementController {

    def chargesPaymentService

    def headerService
    def dataEntryService
    def recomputeService
    def chargesService
    def parserService
    def ratesService
	def foreignExchangeService
    def apService
    def arService
    def tabUtilityService

    // sets service type
    protected String REFERENCE_TYPE = "PAYMENT"
    protected String SERVICE_TYPE = "Settlement"
    protected String DOCUMENT_CLASS = "DP"

    // render page
    def viewSettlement() {
        // if accessed from create transaction
        if (chainModel) {
            session.chargesModel = chainModel
            String etsNumber = session.chargesModel.serviceInstructionId ?: ""

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.chargesModel << [charges:charges]
            session.chargesModel << [chargesString: parserService.listHashMapToString(charges)]
			
//			String tradeServiceId = session.chargesModel.tradeServiceId
//			Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
//			session.chargesModel << [paymentsMade: paymentsMade.payments]
			
            if(!chainModel.currency) {
                //println'walang currency'
                chainModel.currency = "PHP"
            }

            def negoPayments = chargesPaymentService.findNegotiationPayments(session.chargesModel?.tradeServiceId)

            session.chargesModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
            session.chargesModel << [mt103Flag: negoPayments.mt103.mt103Flag]

            session.chargesModel << [pddtsAmount: negoPayments.pddts.pddtsAmount]
            session.chargesModel << [mt103Amount: negoPayments.pddts.mt103Amount]
			
			if(chainModel.currency) {
                def exchange = []

                ratesService.getBankNotSellRates(chainModel.currency).response.details.each {
                    def text_pass_on_rate
		            def text_special_rate
		            def pass_on_rate_cash
		            def special_rate_cash
					def pass_on_rate = it.conversionRate
					def special_rate = it.conversionRate
		
		            session.chargesModel.each { ets ->

                        if (it.description.toString().contains("URR")) {
                            if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate_urr")) {
                                text_pass_on_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash_urr")) {
                                pass_on_rate_cash = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate_urr")) {
                                text_special_rate = ets.value
                            }

                            if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash_urr")) {
                                special_rate_cash = ets.value
                            }
                        } else {
    		                if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
    		                    text_pass_on_rate = ets.value
    		                }
    		
    		                if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
    		                    pass_on_rate_cash = ets.value
    		                }
    		
    		                if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
    		                    text_special_rate = ets.value
    		                }
    		
    		                if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
    		                    special_rate_cash = ets.value
    		                }
                        }
		            }
		
		            if ("PHP".equals(chainModel.currency)) {
		                println it.description
		                if (it.description.contains("URR")) {
		                    exchange << [rates: it.rates,
		                            rate_description: it.description,
                                    rate_description_lbp: it.descriptionLbp,
		                            pass_on_rate: pass_on_rate,
		                            special_rate: special_rate,
		
		                            text_pass_on_rate: text_pass_on_rate,
		                            pass_on_rate_cash: pass_on_rate_cash,
		                            text_special_rate: text_special_rate,
		                            special_rate_cash: special_rate_cash
		                    ]
		                }
		            } else {
		                exchange << [rates: it.rates,
		                        rate_description: it.description,
                                rate_description_lbp: it.descriptionLbp,
		                        pass_on_rate: pass_on_rate,
		                        special_rate: special_rate,
		
		                        text_pass_on_rate: text_pass_on_rate,
		                        pass_on_rate_cash: pass_on_rate_cash,
		                        text_special_rate: text_special_rate,
		                        special_rate_cash: special_rate_cash
		                ]
		            }
		        }

                session.chargesModel << [exchange: exchange]

			}
        }

        if(session.chargesModel) {
            String tradeServiceId = session.chargesModel.tradeServiceId
            Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
            session.chargesModel << [paymentsMade: paymentsMade.payments]


            render(view: "/nonlc/dp/index", model:chainModel ? chainModel : session.chargesModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

    def viewSettlementCharges() {

        Boolean reverseDE

        if((params.serviceType == null) || (params.serviceType.toString().equalsIgnoreCase("SETTLEMENT"))) {
            reverseDE = false
        } else {
            reverseDE = true
        }

		String documentType = params.documentType
		String headerTitle = headerService.getChargesTitle(documentType, DOCUMENT_CLASS, "", SERVICE_TYPE + (reverseDE ? " Reversal" : ""), "")

        String reversalDENumber = ""
        String reversedDENumber = ""
        String reversalEtsNumber = ""
        String approvers=""

        session.chargesModel = [documentType: documentType,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        // keep session model
        session.chargesModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (reverseDE) {
            reversalDENumber = params.tradeServiceId
            Map<String, Object> reversalDEMap = dataEntryService.getDataEntry(reversalDENumber)
            approvers = reversalDEMap.approvers
            reversedDENumber = reversalDEMap.originalTradeServiceId
            reversalEtsNumber = reversalDEMap.serviceInstructionId
        }

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap
            dataEntryMap = reverseDE ? dataEntryService.getDataEntry(reversedDENumber) : dataEntryService.getDataEntry(params.tradeServiceId)

            if (reverseDE) {
                dataEntryMap.approvers = approvers
                dataEntryMap.put("reversalDENumber", reversalDENumber)
                dataEntryMap.put("reversalEtsNumber", reversalEtsNumber)
                dataEntryMap.put("reverseDE", true)

                session.chargesModel << [reversalPaymentProcessing: true]
            }

            dataEntryMap.each {
                if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.chargesModel << it
                }
            }

            String cilexFlag = "false";
            cilexFlag = chargesPaymentService.getCilexFlag(params.tradeServiceId)
            session.chargesModel << [cilexFlag: cilexFlag]

            if(reverseDE){
                cilexFlag = chargesPaymentService.getCilexFlag(reversedDENumber)
                session.chargesModel << [cilexFlag: cilexFlag]
//                session.chargesModel << [cilexFlag: "true"]
            }

        }

		session.chargesModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
		// chain to render page
        chain(action: "viewSettlement", model: session.chargesModel)
    }

    def updateSettlementCharges() {
        //println"updateSettlementCharges"
        String documentType = params.documentType
		String headerTitle = headerService.getChargesTitle(documentType, DOCUMENT_CLASS, "", SERVICE_TYPE, "")
		
		session.chargesModel = [documentType: documentType,  documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
		session.chargesModel << [formName: tabUtilityService.getTabName(params.form)]
		
		// trigger command
		params.put("username", session.username)
		params.put("unitcode", session.unitcode)

		// trigger command
		Map<String, Object> dataEntryMap = chargesService.updateCharges(params)

		dataEntryMap.each {
			session.chargesModel << it
		}

		// chain to render page
		chain(action: "viewSettlement", model: session.chargesModel)
		
    }

    // compute total amount
    def computeTotal() {
        def jsonData = [totalAmount: recomputeService.computeTotal(params.amounts)]

        render jsonData as JSON
    }

    // compute balance
    def computeBalance() {
        def computeBalanceResult = recomputeService.computeBalance(params.totalAmountDue, params.totalAmount)

        def jsonData = [balance: computeBalanceResult.balance, excess: computeBalanceResult.excess]

        render jsonData as JSON
    }

    // pay charges (create Debit accounting entry)
    def payItem() {
        def jsonData = [:]

        try {
            chargesService.payCharges(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

    def reversePayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

    def errorCorrectPayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success: true]

            render jsonData as JSON
        } catch (Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

}
