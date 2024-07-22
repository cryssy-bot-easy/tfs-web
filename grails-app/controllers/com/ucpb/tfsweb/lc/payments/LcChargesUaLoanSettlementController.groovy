package com.ucpb.tfsweb.lc.payments

import grails.converters.JSON

class LcChargesUaLoanSettlementController {

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
    def chargesPaymentService

    // sets service type
    protected String REFERENCE_TYPE = "PAYMENT"
    protected String SERVICE_TYPE = "UA Loan Settlement"
    protected String DOCUMENT_CLASS = "LC"

    // render page
    def viewSettlement() {
        // if accessed from create transaction
        if (chainModel) {
            session.chargesModel = chainModel

            String etsNumber = session.chargesModel.serviceInstructionId ?: ""

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.chargesModel << [charges:charges]
            session.chargesModel << [chargesString: parserService.listHashMapToString(charges)]

//            List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.chargesModel.cifNumber ?: "", session.chargesModel.currency ?: "")
//            session.chargesModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//            List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.chargesModel.cifNumber ?: "")
//            session.chargesModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

            String cilexFlag = "false";
            if(session?.chargesModel?.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(session?.chargesModel?.tradeServiceId?:"")
            }
            session.chargesModel << [cilexFlag: cilexFlag]
			
			if(chainModel.currency) {
//				def exchange = ratesService.getRatesByBaseCurrency()
//				exchange = foreignExchangeService.extractRatesByBaseCurrency(exchange.display, chainModel)
//				session.chargesModel << [exchange:exchange]

//                def exchange = []
//
//                ratesService.getRates(chainModel.currency).response.details.each {
//                    def text_pass_on_rate
//                    def text_special_rate
//                    def pass_on_rate_cash
//                    def special_rate_cash
//
//                    session.chargesModel.each { ets ->
//                        if (ets.key.toString().equals(it.rates.toString()+"_text_pass_on_rate")) {
//                            text_pass_on_rate = ets.value
//                        }
//
//                        if (ets.key.toString().equals(it.rates.toString()+"_pass_on_rate_cash")) {
//                            pass_on_rate_cash = ets.value
//                        }
//
//                        if (ets.key.toString().equals(it.rates.toString()+"_text_special_rate")) {
//                            text_special_rate = ets.value
//                        }
//
//                        if (ets.key.toString().equals(it.rates.toString()+"_special_rate_cash")) {
//                            special_rate_cash = ets.value
//                        }
//                    }
//
//                    exchange << [rates: it.rates,
//                            rate_description: it.description,
//                            pass_on_rate: it.conversionRate,
//                            special_rate: it.conversionRate,
//
//                            text_pass_on_rate: text_pass_on_rate,
//                            pass_on_rate_cash: pass_on_rate_cash,
//                            text_special_rate: text_special_rate,
//                            special_rate_cash: special_rate_cash
//                    ]
//                }
//
//                session.chargesModel << [exchange: exchange]
                def exchange = []

                def ratesResult

                //println"hello i am a documentSubType1 : " + session.chargesModel.documentSubType1
                //println"hello i am a type : " + session.chargesModel.type

//            if (session.chargesModel.documentSubType1.equals("REGULAR") || session.chargesModel.documentSubType1.equals("STANDBY")) {
//                ratesResult = ratesService.getRegularSellRates(chainModel.currency)?.response?.details
//            } else if (session.chargesModel.documentSubType1.equals("CASH")) {
//                ratesResult = ratesService.getCashSellRates(chainModel.currency)?.response?.details
//            }
                println " angulo angulo angulo angulo:"+session.chargesModel.documentType
                println " angulo angulo angulo angulo documentSubType1:"+session.chargesModel.documentSubType1
                if (session.chargesModel.documentType.equals("DOMESTIC")){
                    println "angulo angulo angulo in"
                    if (session.chargesModel.documentSubType1.equals("REGULAR") || session.chargesModel.documentSubType1.equals("STANDBY")) {
                        ratesResult = ratesService.getRegularSellRatesDM(chainModel.currency).response.details
                    } else if (session.chargesModel.documentSubType1.equals("CASH")) {
                        ratesResult = ratesService.getCashSellRatesDM(chainModel.currency).response.details
                    }
                } else {
                    if (session.chargesModel.documentSubType1.equals("REGULAR") || session.chargesModel.documentSubType1.equals("STANDBY")) {
                        ratesResult = ratesService.getRegularSellRates(chainModel.currency).response.details
                    } else if (session.chargesModel.documentSubType1.equals("CASH")) {
                        ratesResult = ratesService.getCashSellRates(chainModel.currency).response.details
                    }
                }



                ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

                if(!it.description.toString().contains("BUYING")){
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
                }

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

                session.chargesModel << [exchange: exchange]
			}
        }

        if (session.chargesModel) {
            String tradeServiceId = session.chargesModel.tradeServiceId
            Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
            session.chargesModel << [paymentsMade: paymentsMade.payments]
            session.chargesModel << [loanCount: paymentsMade.loanCount]


            // passes chain model if existing else passes session model
            render(view: "/lc/payment/opening/index", model: chainModel ? chainModel : session.chargesModel)
        } else {
            render(view: "/main/unauthorized")
        }
    }

    // trigger viewing of page
    def viewSettlementCharges() {
        // get lc class and type
        String documentType = params.documentType
        println "params.documentSubType1 > " + params.documentSubType1
        String documentSubType1 = params.documentSubType1?.toUpperCase()
        String documentSubType2 = params.documentSubType2

        // construct header title
        String headerTitle = headerService.getChargesTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.chargesModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.chargesModel << it
                }
            }


            String cilexFlag = "false";
            if(params.tradeServiceId){
                cilexFlag = chargesPaymentService.getCilexFlag(params.tradeServiceId)
            }
            session.chargesModel << [cilexFlag: cilexFlag]
        }
		session.chargesModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
        // chain to render page
        chain(action: "viewSettlement", model: session.chargesModel)
    }

    def updateSettlementCharges() {
        //construct header title
        String headerTitle = headerService.getChargesTitle(params.documentType, DOCUMENT_CLASS, params.documentSubType1, SERVICE_TYPE, params.documentSubType2)

        // keep session model
        session.chargesModel = [documentType: params.documentType, documentClass: DOCUMENT_CLASS, documentSubType1: params.documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
        session.chargesModel << [formName: tabUtilityService.getTabName(params.form)]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command

        println 'hahahah'
        Map<String, Object> dataEntryMap = chargesService.updateCharges(params)

        dataEntryMap.each {
            session.chargesModel << it
        }

        println "i am a dope"
        // chain to render page
        chain(action: "viewSettlement", model: session.chargesModel)
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

    def computeBalance() {
        def computeBalanceResult = recomputeService.computeBalance(params.totalAmountDue, params.totalAmount)


        def jsonData = [balance: computeBalanceResult.balance, excess: computeBalanceResult.excess]

        render jsonData as JSON
    }
}
