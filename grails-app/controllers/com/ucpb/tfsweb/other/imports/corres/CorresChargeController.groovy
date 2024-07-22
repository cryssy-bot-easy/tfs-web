package com.ucpb.tfsweb.other.imports.corres

import grails.converters.JSON

class CorresChargeController {

    def routingInformationService
    def coreAPIService
    def foreignExchangeService
    def parserService
    def etsService
    def dataEntryService
    def ratesService
	def tabUtilityService

    def viewCorresChargeEts() {
        if (chainModel) {
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
            }

            if (chainModel.documentNumber) {
                def corresCharge = coreAPIService.dummySendQuery([documentNumber: chainModel.documentNumber], "advance/search", "corresCharge/")?.details

                session.etsModel << corresCharge[0]
                session.etsModel << [outstandingCorresCharge: (corresCharge[0]?.totalAdvancedAmount - corresCharge[0]?.totalCoveredAmount)]
            }
			session.etsModel << [formName: chainModel.formName]
        }

        session.etsModel << [title: "Settlement of Actual Corres Charges - eTS",
                tabs: ["basicDetails", "productPayment", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "CORRES_CHARGE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]

        // used to display rates - start
//        def paramz = parserService.sessionModelToHashMap(session.etsModel)
//
//        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, session.etsModel)
//        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//        session.etsModel << [exchange:[]]
        def exchange = []

        def ratesResult = ratesService.getCorresChargeRates(session.etsModel.currency, session.etsModel.settlementCurrency).response.details

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
        println "session.etsModel.exchange " + session.etsModel.exchange
        // setup gsp to display in tabs
        session.etsModel << [basicDetailsTab: "../product/other/imports/corres_charge/ets/basic_details_tab"]
        session.etsModel << [productPaymentTabLabel: "Charges <br /> &#160;"]
        session.etsModel << [productPaymentTab: "../product/other/imports/corres_charge/ets/product_payment_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("CORRES_CHARGE", null, null, null, "ETS", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.etsModel.approvers)

        session.etsModel << [basicDetailsAction: "saveCorresChargeEts"]
        session.etsModel << [productPaymentAction: "updateCorresChargeEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        render(view: "../product/index", model: session.etsModel)
    }

    def viewCorresChargeDataEntry() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                // if tsd initiated, chain to the other viewing of corres charge data entry
                if (!tradeService.serviceInstructionId) {
                    chain(action: "viewCorresChargeDataEntry2", model: [tradeServiceId: tradeService?.tradeServiceId, viewMode: chainModel.viewMode, hasRoute: chainModel.hasRoute])
                }

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId

                session.dataEntryModel << tradeService?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel?.documentNumber) {
                def corresCharge = coreAPIService.dummySendQuery([documentNumber: chainModel.documentNumber], "advance/search", "corresCharge/")?.details

                session.dataEntryModel << corresCharge[0]
                session.dataEntryModel << [outstandingCorresCharge: (corresCharge[0]?.totalAdvancedAmount - corresCharge[0]?.totalCoveredAmount)]
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Settlement of Actual Corres Charges - Data Entry",
                tabs: ["basicDetails", "productPayment", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "CORRES_CHARGE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]
		if (session.dataEntryModel?.remitCorresCharges == 'Y'){
			session.dataEntryModel.tabs << "mt202"
		}

        // used to display rates - start
//        def paramz = parserService.sessionModelToHashMap(session.dataEntryModel)
//
//        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, session.etsModel)
//        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)
//
//        session.dataEntryModel << [exchange:exchange]

        def exchange = []

        def ratesResult = ratesService.getCorresChargeRates(session.dataEntryModel.currency, session.dataEntryModel.settlementCurrency).response.details

        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

	            println "DATA ENTRY 1" + it.description.toString()
				
	            if(it.description.toString().contains("BANK NOTE SELL") || it.description.toString().contains("URR - BOOKING RATE")){
                    session.dataEntryModel.each { ets ->
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

        // setup product labels
        session.dataEntryModel << [totalAmountDueCurrencyLabel: "Import Advance Currency",
                totalAmountDueAmountLabel: "Import Advance Amount",
                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
        ]
        // used to display rates - end


        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/corres_charge/dataentry/basic_details_tab"]
//        session.dataEntryModel << [mt202Tab: "../product/other/imports/corres_charge/dataentry/mt202"]
		session.dataEntryModel << [mt202Tab: "../commons/tabs/mt_202_tab"]
        session.dataEntryModel << [productPaymentTabLabel: "Charges <br /> &#160;"]
        session.dataEntryModel << [productPaymentTab: "../product/other/imports/corres_charge/dataentry/product_payment_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("CORRES_CHARGE", null, null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveCorresChargeDataEntry"]
        session.dataEntryModel << [mt202Action: "saveCorresChargeDataEntry"]
        session.dataEntryModel << [productPaymentAction: "updateCorresChargeDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]
		
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
				if(chainModel?.hasRoute){
					session.hasRoute=chainModel?.hasRoute
				}
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
				if(params.hasRoute){
					session.hasRoute=params.hasRoute
				}
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		 session.dataEntryModel << [hasRoute:session.hasRoute]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewCorresChargeDataEntry2() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                if (!tradeService?.serviceInstructionId && tradeService?.details?.withoutReference) {
                    chain(action: "viewCorresChargeDataEntry3", model: [tradeServiceId: tradeService?.tradeServiceId, viewMode: chainModel.viewMode, hasRoute: chainModel.hasRoute])
                }

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }

            if (chainModel?.documentNumber) {
                def corresCharge = coreAPIService.dummySendQuery([documentNumber: chainModel.documentNumber], "advance/search", "corresCharge/")?.details
				def tradeServiceDetails = coreAPIService.dummySendQuery([documentNumber: chainModel.documentNumber], "getDetails" , "corresCharge/")?.details

				session.dataEntryModel << [countryCode: tradeServiceDetails.get("countryCode")]
                session.dataEntryModel << corresCharge[0]
                session.dataEntryModel << [outstandingCorresCharge: (corresCharge[0]?.totalAdvancedAmount - corresCharge[0]?.totalCoveredAmount)]
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Settlement of Actual Corres Charges - Data Entry",
                tabs: ["basicDetails", "mt202", "actualCorres", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "CORRES_CHARGE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                tsdInitiated: "true"
        ]

        def exchange = []

        def ratesResult = ratesService.getCorresChargeRates(session.dataEntryModel.currency, session.dataEntryModel.settlementCurrency).response.details

        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

	            println "DATA ENTRY 2" + it.description.toString()
				
	            if(it.description.toString().contains("BANK NOTE SELL") || it.description.toString().contains("URR - BOOKING RATE")){
                    session.dataEntryModel.each { ets ->
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
            }

        session.dataEntryModel << [exchange: exchange]

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/corres_charge/dataentry/basic_details_tab2"]
		session.dataEntryModel << [mt202Tab: "../commons/tabs/mt_202_tab"]
        session.dataEntryModel << [actualCorresTab: "../product/other/imports/corres_charge/dataentry/actual_corres_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("CORRES_CHARGE", null, null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveCorresChargeDataEntry2"]
		session.dataEntryModel << [mt202Action: "saveCorresChargeDataEntry2"]
        session.dataEntryModel << [actualCorresAction: "saveCorresChargeDataEntry2"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]
		
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
				if(chainModel?.hasRoute){
					session.hasRoute=chainModel?.hasRoute
				}
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
				if(params.hasRoute){
					session.hasRoute=params.hasRoute
				}
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		 session.dataEntryModel << [hasRoute:session.hasRoute]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewCorresChargeDataEntry3() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Settlement of Actual Corres Charges - Data Entry",
//                tabs: ["basicDetails", "productPayment", "mt202", "instructionsAndRouting"],
                tabs: ["basicDetails", "actualCorres", "mt202", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "CORRES_CHARGE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
                withoutReference: true,
                tsdInitiated: "true"
        ]

        // used to display rates - start
        def exchange = []

        def ratesResult = ratesService.getCorresChargeRates(session.dataEntryModel.currency, session.dataEntryModel.settlementCurrency).response.details

        ratesResult.each {
                def text_pass_on_rate
                def text_special_rate
                def pass_on_rate_cash
                def special_rate_cash
				def pass_on_rate = it.conversionRate
				def special_rate = it.conversionRate

	            println "DATA ENTRY 3" + it.description.toString()
				
	            if(it.description.toString().contains("BANK NOTE SELL") || it.description.toString().contains("URR - BOOKING RATE")){
                    session.dataEntryModel.each { ets ->
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
            }

        session.dataEntryModel << [exchange: exchange]

        // setup product labels
//        session.dataEntryModel << [totalAmountDueCurrencyLabel: "Import Advance Currency",
//                totalAmountDueAmountLabel: "Import Advance Amount",
//                amountInPaymentInCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> in Settlement Currency",
//                amountInPaymentInDocumentCurrencyLabel: "Amount of Payment - Import Advance Amount <br/> (in Import Advance Currency)",
//                totalAmountInCurrencyLabel: "Total Amount of Payment - Import Advance Amount (in Import Advance Currency)",
//                excessAmountInCurrencyLabel: "Excess Amount - Import Advance Amount (in Import Advance Currency)"
//        ]
        // used to display rates - end


        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/corres_charge/dataentry/basic_details_tab3"]
//        session.dataEntryModel << [mt202Tab: "../product/other/imports/corres_charge/dataentry/mt202"]
        session.dataEntryModel << [mt202Tab: "../commons/tabs/mt_202_tab"]
//        session.dataEntryModel << [productPaymentTabLabel: "Charges <br /> &#160;"]
//        session.dataEntryModel << [productPaymentTab: "../product/other/imports/corres_charge/dataentry/product_payment_tab"]
        session.dataEntryModel << [actualCorresTab: "../product/other/imports/corres_charge/dataentry/actual_corres_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("CORRES_CHARGE", null, null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("CORRES_CHARGE", null, null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveCorresChargeDataEntry3"]
        session.dataEntryModel << [mt202Action: "saveCorresChargeDataEntry3"]
//        session.dataEntryModel << [productPaymentAction: "updateCorresChargeDataEntry3"]
        session.dataEntryModel << [actualCorresAction: "saveCorresChargeDataEntry3"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]
		
		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
				if(chainModel?.hasRoute){
					session.hasRoute=chainModel?.hasRoute
				}
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
				if(params.hasRoute){
					session.hasRoute=params.hasRoute
				}
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
         session.dataEntryModel << [hasRoute:session.hasRoute]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveCorresChargeEts() {
        println "xxxxxxxx saveImportAdvancePaymentEts"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
        def urr = foreignExchangeService.getUrrRate(ratesService.getRatesUrr().display, chainModel)
        params.put("USD-PHP_urr", urr)
		params.put("allTabSaved", "N")
        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "ets")

        String etsNumber = returnedValues["details"]["serviceInstructionId"]["serviceInstructionId"]

        // we get the eTS number from
        def sessionModel = [:]

        // copy the details returned from the Save call
        sessionModel << returnedValues["details"]["details"]

        // override etsNumber with the one we got from the Save
        sessionModel << ["serviceInstructionId" : etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "corresCharge", action: "viewCorresChargeEts", model: sessionModel)
    }

    def saveCorresChargeDataEntry() {
        println"saveCorresChargeDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username
        def urr = foreignExchangeService.getUrrRate(ratesService.getRatesUrr().display, chainModel)
        params.put("USD-PHP_urr", urr)

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "corresCharge", action: "viewCorresChargeDataEntry", model: sessionModel)
    }

    def saveCorresChargeDataEntry2() {
        println"saveCorresChargeDataEntry2"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
        def urr = foreignExchangeService.getUrrRate(ratesService.getRatesUrr().display, chainModel)
        params.put("USD-PHP_urr", urr)

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")
        println returnedValues.details.tradeServiceId
        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "corresCharge", action: "viewCorresChargeDataEntry2", model: sessionModel)
    }

    def saveCorresChargeDataEntry3() {
        println"saveCorresChargeDataEntry3"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        def urr = foreignExchangeService.getUrrRate(ratesService.getRatesUrr().display, chainModel)
        params.put("USD-PHP_urr", urr)

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

//        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "corresCharge", action: "viewCorresChargeDataEntry3", model: sessionModel)
    }

    def updateCorresChargeEts() {
        //println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "corresCharge", action: "viewCorresChargeEts", model: map)
    }

    def updateCorresChargeDataEntry() {
        //println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "corresCharge", action: "viewCorresChargeDataEntry", model: map)
    }

    def updateCorresChargeDataEntry3() {
        //println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "corresCharge", action: "viewCorresChargeDataEntry3", model: map)
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

        //Map<String, Object> map = new HashMap<>()
        def map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def validateCorresChargeTSDInit(String documentClass, String tradeServiceId, String netBillingAmount) {
        def jsonData = [success: "true"]

        if (documentClass.equals("CORRES_CHARGE") &&
                (!session.dataEntryModel?.serviceInstructionId &&
                !session.dataEntryModel?.etsNumber) &&
                !session.etsModel) {

            def tradeService = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId], "details", "tradeservice/")?.details

            if (netBillingAmount) {
                BigDecimal paramsNetBillingAmount = new BigDecimal(netBillingAmount.replaceAll(",", ""))
                BigDecimal tradeServiceNetBillingAmount = new BigDecimal(tradeService?.details?.netBillingAmount?.replaceAll(",", ""))

                if (tradeServiceNetBillingAmount.compareTo(paramsNetBillingAmount) != 0) {
                    jsonData = [success: "false"]
                }
            }
        }

        render(jsonData as JSON)
    }
}
