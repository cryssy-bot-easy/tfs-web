package com.ucpb.tfsweb.other.imports.importadvance

import grails.converters.JSON
import net.ipc.utils.NumberUtils

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class ImportAdvanceController {

    def foreignExchangeService
    def ratesService
    def parserService
    def routingInformationService

    def etsService
    def dataEntryService
    def chargesPaymentService
    def chargesService
	def tabUtilityService
	
	def documentUploadingService

    private static DEFAULT_TABS = ["basicDetails", "attachedDocuments", "productPayment", "charges", "chargesPayment", "instructionsAndRouting"]
    private static PAYMENT_DE_TABS = ["basicDetails", "attachedDocuments", "mtDetails", "productPayment", "charges", "chargesPayment", "instructionsAndRouting"]

//    private static REFUND_DE_TABS = ["basicDetails", "productPayment", "charges", "chargesPayment", "instructionsAndRouting"]

    def coreAPIService


    // payment
    def viewPaymentEts() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.etsModel = chainModel
            println "chainModel:"+chainModel

            if (chainModel.tradeServiceId) {


                println "chainModel.tradeServiceId:"+chainModel.tradeServiceId
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS : ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
        		session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << tradeService?.tradeServiceId
                println "tradeService?.tradeServiceId:"+tradeService?.tradeServiceId
            } else if (chainModel.serviceInstructionId){
                println "chainModel.serviceInstructionId:"+chainModel.serviceInstructionId
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS : ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << tradeService?.tradeServiceId
                println "tradeService?.tradeServiceId:"+tradeService?.tradeServiceId
            }
			session.etsModel << [formName: chainModel.formName]
        }

        session.etsModel << [title: "Import Advance Payment - eTS",
                tabs: DEFAULT_TABS,
                serviceType: "PAYMENT",
                documentClass: "IMPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: ""
        ]

        // used to display rates - start
        List<Map<String, Object>> charges = chargesService.findAllCharges(session.etsModel.serviceInstructionId)

        session.etsModel << [charges:charges]

        def exchange = []

        def ratesResult = ratesService.getRegularSellRates(session.etsModel.currency).response.details
        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

                if(!it.description.toString().contains("BUYING")){
                    session.etsModel.each { ets ->
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

        session.etsModel << [exchange: exchange]
        // used to display rates - end

        // setup gsp to display in tabs
        session.etsModel << [basicDetailsTab: "../product/other/imports/import_advanced/payment/ets/basic_details_tab"]
		
        session.etsModel << [productPaymentTabLabel: "Import Advance Amount <br /> Payment Details"]
        session.etsModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        // setup product labels
        session.etsModel << [totalAmountDueCurrencyLabel: "Import Advance Currency / Amount",
                totalAmountDueAmountLabel: "Remaining Balance",
                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
        ]

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("IMPORT_ADVANCE", null, null, null, "ETS", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("IMPORT_ADVANCE", null, null, null, "PAYMENT", session.etsModel.approvers)

        session.etsModel << [basicDetailsAction: "saveImportAdvancePaymentEts"]
        session.etsModel << [productPaymentAction: "updateImportAdvancePaymentEts"]
        session.etsModel << [chargesAction: "updateImportAdvancePaymentEts"]
        session.etsModel << [chargesPaymentAction: "updateImportAdvancePaymentEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        render(view: "../product/index", model: session.etsModel)
    }

    def viewPaymentDataEntry() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel << tradeService?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Import Advance Payment - Data Entry",
                tabs: PAYMENT_DE_TABS,
                serviceType: "PAYMENT",
                documentClass: "IMPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

        // used to display rates - start
//        def paramz = parserService.sessionModelToHashMap(session.dataEntryModel)
//
//        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, session.etsModel)
//        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//        session.dataEntryModel << [exchange:exchange]
//        def exchange = []
//        ratesService.getRates(session.dataEntryModel.currency).response.details.each {
//            exchange << [rates: it.rates,
//                    rate_description: it.description,
//                    pass_on_rate: it.conversionRate,
//                    special_rate: it.conversionRate
//            ]
//        }
//
//        session.dataEntryModel << [exchange: exchange]

        List<Map<String, Object>> charges = chargesService.findAllCharges(session.dataEntryModel.serviceInstructionId)

        session.dataEntryModel << [charges:charges]

        def exchange = []

        def ratesResult = ratesService.getRegularSellRates(session.dataEntryModel.currency).response.details
        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

                if(!it.description.toString().contains("BUYING")){
                    session.dataEntryModel.each { ets ->
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

        session.dataEntryModel << [exchange: exchange]

        // setup product labels
        session.dataEntryModel << [totalAmountDueCurrencyLabel: "Import Advance Currency / Amount",
                totalAmountDueAmountLabel: "Remaining Balance",
                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
        ]
        // used to display rates - end

		
        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/import_advanced/payment/dataentry/basic_details_tab"]
        session.dataEntryModel << [mtDetailsTab: "../product/other/imports/import_advanced/payment/dataentry/mt_details_tab"]
//		session.dataEntryModel << [mtDetailsTab: "../nonlc/commons/tabs/mt103_details_tab"]
        session.dataEntryModel << [productPaymentTabLabel: "Import Advance Amount <br /> Payment Details"]
        session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]
        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("IMPORT_ADVANCE", null, null, null, "DATA_ENTRY", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("IMPORT_ADVANCE", null, null, null, "PAYMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("IMPORT_ADVANCE", null, null, null, "PAYMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveImportAdvancePaymentDataEntry"]
        session.dataEntryModel << [mtDetailsAction: "saveImportAdvancePaymentDataEntry"]
        session.dataEntryModel << [productPaymentAction: "updateImportAdvancePaymentDataEntry"]
        session.dataEntryModel << [chargesAction: "updateImportAdvancePaymentDataEntry"]
        session.dataEntryModel << [chargesPaymentAction: "updateImportAdvancePaymentDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    // refund
    def viewRefundEts() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS : ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << tradeService?.tradeServiceId
            } else if (chainModel?.documentNumber) {
                def importAdvancePayment = coreAPIService.dummySendQuery([documentNumber : chainModel.documentNumber], "details", "importadvance/payment/")?.details

                session.etsModel << importAdvancePayment
                session.etsModel << importAdvancePayment.documentNumber
                session.etsModel << [currency: importAdvancePayment.currency.currencyCode]
        		session.etsModel << [amount: NumberUtils.currencyFormat(new Double(importAdvancePayment.amount))]
                session.etsModel << [sendersChargesCurrency: importAdvancePayment.sendersChargesCurrency?.currencyCode]
                session.etsModel << [receiversChargesCurrency: importAdvancePayment.receiversChargesCurrency?.currencyCode]
                session.etsModel << [reimbursingBankCurrency: importAdvancePayment.reimbursingBankCurrency?.currencyCode]
            }
			session.etsModel << [formName: chainModel.formName]
        }

        session.etsModel << [title: "Import Advance Refund - eTS",
                tabs: DEFAULT_TABS,
                serviceType: "REFUND",
                documentClass: "IMPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]

        // used to display rates - start
        List<Map<String, Object>> charges = chargesService.findAllCharges(session.etsModel.serviceInstructionId)

        session.etsModel << [charges:charges]
//
//        // used to display rates - start
//        def paramz = parserService.sessionModelToHashMap(session.etsModel)
//
//        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, session.etsModel)
//        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//        session.etsModel << [exchange:exchange]

        def exchange = []

        def ratesResult = ratesService.getRegularSellRates(session.etsModel.currency).response.details
        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

                if(!it.description.toString().contains("BUYING")){
                    session.etsModel.each { ets ->
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
						if (ets.key.toString().equals("USD-PHP_urr") && it.description.toString().contains("URR")){
							pass_on_rate = ets.value
							special_rate = ets.value
						}
                    }
                }

                exchange << [rates: it.rates,
                        rate_description: it.description,
                        pass_on_rate: pass_on_rate,
                        special_rate: special_rate,

                        text_pass_on_rate: text_pass_on_rate,
                        pass_on_rate_cash: pass_on_rate_cash,
                        text_special_rate: text_special_rate,
                        special_rate_cash: special_rate_cash
                ]
            }

        session.etsModel << [exchange: exchange]
        // used to display rates - end

//        session.etsModel << [totalAmountDueCurrencyLabel: "Import Advance Currency",
//                totalAmountDueAmountLabel: "Import Advance Amount",
//                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
//                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
//                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
//                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
//        ]

        session.etsModel << [basicDetailsTab: "../product/other/imports/import_advanced/refund/ets/basic_details_tab"]
        session.etsModel << [productPaymentTabLabel: "Process <br /> Refund"]
        session.etsModel << [productPaymentTab: "../product/other/imports/import_advanced/refund/ets/product_payment_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        def documentServiceRoute = routingInformationService.getNextBranchApprover("IMPORT_ADVANCE", null, null, null, "ETS", "REFUND", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("IMPORT_ADVANCE", null, null, null, "REFUND", session.etsModel.approvers)

        session.etsModel << [basicDetailsAction: "saveImportAdvanceRefundEts"]
        session.etsModel << [productPaymentAction: "updateImportAdvanceRefundEts"]
        session.etsModel << [chargesAction: "updateImportAdvanceRefundEts"]
        session.etsModel << [chargesPaymentAction: "updateImportAdvanceRefundEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        render(view: "../product/index", model: session.etsModel)
    }

    def viewRefundDataEntry() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel << tradeService?.documentNumber
                session.dataEntryModel.serviceInstructionId = tradeService?.serviceInstructionId?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Import Advance Refund - Data Entry",
                tabs: DEFAULT_TABS,
                serviceType: "REFUND",
                documentClass: "IMPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

//        session.dataEntryModel << [totalAmountDueCurrencyLabel: "Import Advance Currency",
//                totalAmountDueAmountLabel: "Import Advance Amount",
//                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
//                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
//                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
//                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
//        ]
		
		List<Map<String, Object>> charges = chargesService.findAllCharges(session.dataEntryModel.serviceInstructionId)
		
		session.dataEntryModel << [charges:charges]

//        def paramz = parserService.sessionModelToHashMap(session.dataEntryModel)

//        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, session.dataEntryModel)
//        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//        session.dataEntryModel << [exchange:exchange]

        def exchange = []

        def ratesResult = ratesService.getRegularSellRates(session.dataEntryModel.currency).response.details
        ratesResult.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

            if(!it.description.toString().contains("BUYING")){
                session.etsModel.each { ets ->
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
					if (ets.key.toString().equals("USD-PHP_urr") && it.description.toString().contains("URR")){
						pass_on_rate = ets.value
						special_rate = ets.value
					}
                }
            }

            exchange << [rates: it.rates,
                    rate_description: it.description,
                    pass_on_rate: pass_on_rate,
                    special_rate: special_rate,

                    text_pass_on_rate: text_pass_on_rate,
                    pass_on_rate_cash: pass_on_rate_cash,
                    text_special_rate: text_special_rate,
                    special_rate_cash: special_rate_cash
            ]
        }

        session.dataEntryModel << [exchange: exchange]

        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/import_advanced/refund/dataentry/basic_details_tab"]
        session.dataEntryModel << [productPaymentTabLabel: "Process <br /> Refund"]
//        session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]
        session.dataEntryModel << [productPaymentTab: "../product/other/imports/import_advanced/refund/dataentry/product_payment_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        // START routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("IMPORT_ADVANCE", null, null, null, "DATA_ENTRY", "REFUND", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("IMPORT_ADVANCE", null, null, null, "REFUND", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("IMPORT_ADVANCE", null, null, null, "REFUND", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
        // END routing

        session.dataEntryModel << [basicDetailsAction: "saveImportAdvanceRefundDataEntry"]
        session.dataEntryModel << [productPaymentAction: "updateImportAdvanceRefundDataEntry"]
        session.dataEntryModel << [chargesAction: "updateImportAdvanceRefundDataEntry"]
        session.dataEntryModel << [chargesPaymentAction: "updateImportAdvanceRefundDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    //
    def saveImportAdvancePaymentEts() {
        //println"saveImportAdvancePaymentEts"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "ets")

        String etsNumber = returnedValues["details"]["serviceInstructionId"]["serviceInstructionId"]

        // we get the eTS number from
        def sessionModel = [:]

        // copy the details returned from the Save call
        sessionModel << returnedValues["details"]["details"]

        // override etsNumber with the one we got from the Save
        sessionModel << ["serviceInstructionId" : etsNumber]

        chain(controller: "importAdvance", action: "viewPaymentEts", model: sessionModel)
    }

    def saveImportAdvancePaymentDataEntry() {
        //println"saveImportAdvancePaymentDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "importAdvance", action: "viewPaymentDataEntry", model: sessionModel)
    }

    def updateImportAdvancePaymentEts() {
        println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "importAdvance", action: "viewPaymentEts", model: map)
    }

    def updateImportAdvancePaymentDataEntry() {
        //println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "importAdvance", action: "viewPaymentDataEntry", model: map)
    }

    def saveImportAdvanceRefundEts() {
        //println"saveImportAdvanceRefundEts"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "ets")

        String etsNumber = returnedValues["details"]["serviceInstructionId"]["serviceInstructionId"]

        // we get the eTS number from
        def sessionModel = [:]

        // copy the details returned from the Save call
        sessionModel << returnedValues["details"]["details"]

        // override etsNumber with the one we got from the Save
        sessionModel << ["serviceInstructionId" : etsNumber]

        chain(controller: "importAdvance", action: "viewRefundEts", model: sessionModel)
    }

    def saveImportAdvanceRefundDataEntry() {
        //println"saveImportAdvanceRefundDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]

        chain(controller: "importAdvance", action: "viewRefundDataEntry", model: sessionModel)
    }

    def updateImportAdvanceRefundEts() {
        //println"updateImportAdvanceRefundEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "importAdvance", action: "viewRefundEts", model: map)
    }

    def updateImportAdvanceRefundDataEntry() {
        //println"updateImportAdvanceRefundDataEntry"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "importAdvance", action: "viewRefundDataEntry", model: map)
    }

    def updateEtsStatus() {
        //println"updateEtsStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def updateDataEntryStatus() {
        //println"updateDataEntryStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def displayServiceChargeGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = chargesPaymentService.findServiceChargesPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = chargesPaymentService.constructChargesPaymentGrid(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def displayRefundEtsGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = chargesPaymentService.findProceedsPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows ?: 0

        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = mapList.display.collect {
            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""
            //TODO add special rates
            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0,it.PASSONRATETHIRDTOPHP)
            ratesList.add(1,it.PASSONRATETHIRDTOUSD)
            ratesList.add(2,it.PASSONRATEUSDTOPHP)
            ratesList.add(3,it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4,it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5,it.SPECIALRATEUSDTOPHP)
            ratesList.add(6,it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = chargesPaymentService.getRates(map.currency , it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: map.currency,
                    target_ccy: it.CURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            chargesPaymentService.formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            result.equivLc,
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePayment(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : ""
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def displayRefundDataEntryGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = chargesPaymentService.findProceedsPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows ?: 0

        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = mapList.display.collect {
            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""
            //TODO add special rates
            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            String paymentString = ""

            String status = ""

            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) ||
                        "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("PDDTS") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("SWIFT")) {
                    status = "Paid"
                    paymentString = ""
                }else if("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)){
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'"+it.ID+"\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'"+it.ID+"\'; payCreditToCasa(id);\"/>";
				}else if("MC_ISSUANCE".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)){
					paymentString = ""
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }
            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else {
                status = "Paid"

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
//                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
				}else if("MC_ISSUANCE".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)){
					paymentString = ""
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            chargesPaymentService.formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, "credit"),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePayment(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            it.AMOUNT
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
	
	//Upload Documents Related
	def uploadDocument() {

		try{
			//handle uploaded file
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request
			MultipartFile uploadedFile = multiRequest.getFile("fileLocation")

			String tradeServiceId = params?.tradeServiceId
            println "tradeServiceId = ${tradeServiceId}"

            params.filename = documentUploadingService.saveFile(uploadedFile, tradeServiceId)

		} catch(Exception e){
			e.printStackTrace()
			////printlne.message
		}

		//NOTE: We do this because of a conflict between FileUpload and MultipartHttpSevletRequest that is causing an error in the Spring Remoting
		redirect(controller:'importAdvance', action:'invokeUploadCommand',params:params)
	}

	def invokeUploadCommand(){
		def jsonData

		if(params.referenceType == "DATA_ENTRY"){
		try{

			session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

			params.put("username", session.username)
			params.put("unitcode", session.unitcode)
			// trigger command
			String temp =  dataEntryService.uploadAttachedToTradeService(params)
			jsonData = [success: true]
		} catch(Exception e){
			e.printStackTrace()
			////printlne.message
			jsonData = [success: false]
		}
		String action

		if(session.dataEntryModel.serviceType.equals("PAYMENT")){
				action = "viewPaymentDataEntry"
		} else if(session.dataEntryModel.serviceType.equals("REFUND")){
				action = "viewRefundDataEntry"
		}


		chain(action:action, model: session.dataEntryModel)
		} else if(params.referenceType == "ETS"){
		try{

			session.etsModel << [formName: tabUtilityService.getTabName(params.form)]

			params.put("username", session.username)
			params.put("unitcode", session.unitcode)
			// trigger command
			String temp =  etsService.uploadAttachedToEts(params)
			jsonData = [success: true]
		} catch(Exception e){
			e.printStackTrace()
			////printlne.message
			jsonData = [success: false]
		}
		String action

		if(session.etsModel.serviceType.equals("PAYMENT")){
				action = "viewPaymentEts"
		} else if(session.etsModel.serviceType.equals("REFUND")){
				action = "viewRefundEts"
		}

		chain(action:action, model: session.etsModel)
	}
	}

    def downloadFile() {

        String id = params?.id
        println "id = ${id}"

        String tradeServiceId = params?.tradeServiceId
        println "tradeServiceId = ${tradeServiceId}"

        def returnValue = coreAPIService.dummySendQuery(params, "getFileDetails", "attachment/")

        def fileName = returnValue?.details?.filename

        if (fileName != null) {

            File file = documentUploadingService.retrieveFile(fileName, tradeServiceId)

            if (file.exists()) {
                if(file.canRead()){
                    response.setContentType("application/octet-stream")
                    response.setHeader("Content-disposition", "filename=${file.name}")
                    response.outputStream << file.bytes
                    return
                }
            }

        } else {
            return
        }
    }

    def deleteDocument() {

        // sets statusAction to deleteDocument
        params.statusAction = "deleteDocument"

        // trigger command
        // TODO do delete document

        String id = params?.id
        String tradeServiceId = params?.tradeServiceId

        // println "id = ${id}"
        // println "filename = ${filename}"
        // println "tradeServiceId = ${tradeServiceId}"

        def jsonData = [:]

        try {

            // Delete attachment record first in db, then delete the file. The reverse is dangerous.
            def returnValue = coreAPIService.dummySendCommand(params, "delete", "attachment")

            def deleted = null
            if (returnValue.status == "ok") {
                // If successful, delete the actual file
                deleted = documentUploadingService.deleteFile(returnValue.details.filename, tradeServiceId)
            } else if (returnValue.status == "error") {
                throw new Exception(returnValue.error.code);
            }

            jsonData = [success: true]

        } catch (Exception e) {
            e.printStackTrace()
            jsonData = [success: false, message: e.getMessage()]
        }

        render jsonData as JSON
    }
	
	def viewAttachments() {
		
				def tradeServiceIdHolder =  params.tradeServiceIdHolder
				////println"tradeServiceIdHolder:" + tradeServiceIdHolder
		
				def maxRows = params.int('rows') ?: 10
				def currentPage = params.int('page') ?: 1
				def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
				def mapList = dataEntryService.getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder)
		
				def totalRows = mapList.totalRows
				def numberOfPages = Math.ceil(totalRows / maxRows)
				def results
				if(params.referenceType == "ETS"){
					if (session.userrole.id.contains("TSD")){
						results = etsService.getGridFormattedAttachmentsReadonly(mapList.display, tradeServiceIdHolder)
					} else {
						results = etsService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)
					}
				} else {
					results = dataEntryService.getGridFormattedAttachments(mapList.display, tradeServiceIdHolder)
				}
				def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
				render jsonData as JSON		
	}
}
