package com.ucpb.tfsweb.other.exports.exportbills

import net.ipc.utils.JsonUtil

class DomesticBillsCollectionController {

    def routingInformationService
    def ratesService
    def coreAPIService
    def chargesPaymentService
    def documentEnclosedService
    def dataEntryService
    def etsService
    def exportBillsService
    def chargesService
    def parserService
    def foreignExchangeService
	def tabUtilityService

    def viewNegotiationDataEntry() {
        println "viewNegotiationDataEntry"
        if (chainModel) {

            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1

                def negoPayments = chargesPaymentService.findNegotiationPayments(session.dataEntryModel?.tradeServiceId)

                session.dataEntryModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
                session.dataEntryModel << [mt103Flag: negoPayments.mt103.mt103Flag]

                if (tradeService?.details.documentsEnclosed) {
                    def listMap = documentEnclosedService.stringToListMap(tradeService?.details.documentsEnclosed.toString())
                    session.dataEntryModel.documentsEnclosed = listMap
                    session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
                } else {
                    session.dataEntryModel.documentsEnclosed = []
                }

                if (tradeService?.details.enclosedInstruction) {
                    def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.enclosedInstruction.toString())
                    session.dataEntryModel.enclosedInstruction = listMap
                    session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
                } else {
                    session.dataEntryModel.enclosedInstruction = []
                }

                if (tradeService?.details.additionalInstruction) {
                    def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.additionalInstruction.toString())
                    session.dataEntryModel.additionalInstruction = listMap
                } else {
                    session.dataEntryModel.additionalInstruction = []
                }


                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "DBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]

            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [tsdInitiated:"true"]

        session.dataEntryModel << [title: "Domestic Bills for Collection - Negotiation (Data Entry)",
                tabs: ["basicDetails",
                        "setupLcDetails",
                        "docEnclosedInstructions",
                        "instructionsAndRouting"],

                serviceType: "NEGOTIATION",
                documentClass: "BC",
                documentType: "DOMESTIC", //session.dataEntryModel.documentType,
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

        def exchange = []

        ratesService.getRatesEB(session.dataEntryModel.currency).response.details.each {
            exchange << [rates: it.rates,
                    rate_description: it.description,
                    pass_on_rate: it.conversionRate,
                    special_rate: it.conversionRate
            ]
        }

        session.dataEntryModel << [exchange: exchange]
        // used to display rates - end

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/negotiation/basic_details_tab"]

        session.dataEntryModel << [setupLcDetailsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/negotiation/setup_lc_details_foreign_tab"]

        session.dataEntryModel << [docEnclosedInstructionsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/negotiation/documents_enclosed_instructions_tab"]


        session.dataEntryModel << [basicDetailsAction: "saveNegotiationDataEntry"]

        session.dataEntryModel << [setupLcDetailsAction: "saveNegotiationDataEntry"]

        session.dataEntryModel << [docEnclosedInstructionsAction: "saveNegotiationDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "DOMESTIC", null, null, "DATA_ENTRY", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "DOMESTIC", null, null, "NEGOTIATION", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BC", "DOMESTIC", null, null, "NEGOTIATION", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

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

    def saveNegotiationDataEntry() {
        println"saveNegotiationDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		
        // enclosed document
        def paramDocEnclosed = []
        if (params.documentsEnclosedList) {
            params.documentsEnclosedList.split("\\|").each {
                paramDocEnclosed << JsonUtil.parseToMap(it)
            }
        }
		if (!paramDocEnclosed.isEmpty()) {
			params.documentsEnclosed = paramDocEnclosed.toString()
		}

        // enclosed instruction
        def paramEnclosedInstr = []
        if (params.enclosedInstructionList) {
            params.enclosedInstructionList.split("\\|").each {
                paramEnclosedInstr << JsonUtil.parseToMap(it)
            }
        }
		if(!paramEnclosedInstr.isEmpty()) {
			params.enclosedInstruction = paramEnclosedInstr.toString()
		}

        def paramAdditionalInstr = []
        session.dataEntryModel.additionalInstruction?.each {
            paramAdditionalInstr << [id: it.id, instruction: it.instruction]
        }
		if(!paramAdditionalInstr.isEmpty()) {
			params.additionalInstruction = paramAdditionalInstr.toString()
		}
		
		if(params.currency) {
			println "has currency"
			ratesService.getRatesEB(params.currency).response.details.each {
				if(it.description.contains('BOOKING')){
					params["USD-PHP_urr"] = it.conversionRate
				} else {
					params[it.rates] = it.conversionRate
				}
			}
		}

        params.each {
            if (it.key.toString().toLowerCase().contains("amount")) {
                it.value = it.value.replaceAll(",", "")
            }
        }

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "domesticBillsCollection", action: "viewNegotiationDataEntry", model: sessionModel)
    }

    def updateDataEntryStatus() {
        println"updateDataEntryStatus"
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

    // settlement
    def viewSettlementEts() {
        println "angulo angulo angulo viewSettlementEts DBC"
        println "viewSettlementEts"
        if (chainModel) {

            session.etsModel = chainModel

            if (chainModel.documentNumber) {
                def exportBills = coreAPIService.dummySendQuery(null, chainModel.documentNumber, "product/", "exportBills/", "details/").details

                session.etsModel << exportBills
                session.etsModel << [documentNumber : exportBills.documentNumber.documentNumber]

                session.etsModel.currency = exportBills.currency?.currencyCode

                session.etsModel.bpCurrency = exportBills.bpCurrency?.currencyCode
                session.etsModel.bpAmount = exportBills.bpAmount

            }

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]

                String etsNumber = chainModel.serviceInstructionId ?: ""
                List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)
                println "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA CHARGES:" +charges
                session.etsModel << [charges:charges]

            }
			session.etsModel << [formName: chainModel.formName]
        }

        session.etsModel << [title: "Domestic Bills for Collection - Settlement (e-TS)",
                tabs: ["basicDetails", "charges", "chargesPayment", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "BC",
                documentType: "DOMESTIC",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]
		
		if(session.etsModel?.amountForCredit){
			if (new BigDecimal(session.etsModel.amountForCredit) > BigDecimal.ZERO){
				session.etsModel.tabs << "settlementToBeneficiary"
			}
		}
		
		if (session.etsModel.bpAmount && session.etsModel.amountForCredit && new BigDecimal(session.etsModel.bpAmount) > new BigDecimal(session.etsModel.proceedsAmount) && new BigDecimal(session.etsModel.amountForCredit) == BigDecimal.ZERO){
			session.etsModel.tabs << "productPayment"

        // setup product labels
        session.etsModel << [totalAmountDueCurrencyLabel: "Amount Due (in DB Currency)",
                totalAmountDueAmountLabel: "Remaining Balance",
                amountInPaymentInCurrencyLabel: "Amount of Settlement Payment <br/> (in Settlement Currency)",
				amountInPaymentInDocumentCurrencyLabel: "Amount of Settlement Payment <br/> (in DB Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Settlement Currency)",
                excessAmountInCurrencyLabel: "Excess Amount <br/> (in Settlement Currency)",
				bpLoanLabel: "DBP Loan",
				proceedsReceivedlabel: "Proceeds Received"
        ]
		}

        def exchange = []

        ratesService.getRatesEB(session.etsModel.currency).response.details.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

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

        // setup gsp to display in tabs
        session.etsModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/domestic/ets/settlement/basic_details_tab"]
		
		if (session.etsModel.tabs.contains("productPayment")){
		session.etsModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.etsModel << [productPaymentTab: "../product/other/exports/export_bills/collection/domestic/ets/settlement/product_payment_tab"]
		session.etsModel << [productPaymentAction: "updateSettlementEts"]
		}

        session.etsModel << [proceedsDetailsTab: "../product/other/exports/export_bills/collection/domestic/ets/settlement/settlement_to_ben_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.etsModel << [basicDetailsAction: "saveSettlementEts"]
        session.etsModel << [loanSetupAction: "saveSettlementEts"]
        session.etsModel << [settlementToBeneficiaryAction: "updateSettlementEts"]
        session.etsModel << [chargesAction: "updateSettlementEts"]
        session.etsModel << [chargesPaymentAction: "updateSettlementEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("BC", "DOMESTIC", null, null, "ETS", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("BC", "DOMESTIC", null, null, "SETTLEMENT", session.etsModel.approvers)

		if(chainModel){
			session.etsModel << [viewMode:chainModel?.viewMode,onViewMode:chainModel?.onViewMode]
			session.viewMode=chainModel?.viewMode
			session.onViewMode=chainModel?.onViewMode
		}else if(params.viewMode){
			session.etsModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
			session.viewMode=params.viewMode
			session.onViewMode=params.onViewMode
		}else{
			session.etsModel << [viewMode:session.viewMode,onViewMode:session.onViewMode]
		}
		
        render(view: "../product/index", model: session.etsModel)
    }

    def saveSettlementEts() {
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        params.each {
            if (it.key.toString().toLowerCase().contains("amount")) {
                it.value = it.value.replaceAll(",", "")
            }
        }

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "ets")

        String etsNumber = returnedValues["details"]["serviceInstructionId"]["serviceInstructionId"]

        // we get the eTS number from
        def sessionModel = [:]

        // copy the details returned from the Save call
        sessionModel << returnedValues["details"]["details"]

        // override etsNumber with the one we got from the Save
        sessionModel << ["serviceInstructionId": etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "domesticBillsCollection", action: "viewSettlementEts", model: sessionModel)
    }

    def updateSettlementEts() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "domesticBillsCollection", action: "viewSettlementEts", model: map)
    }

    def updateEtsStatus() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = etsService.updateEts(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def viewSettlementDataEntry() {

        if (chainModel) {

            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel << tradeService?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1

                def negoPayments = chargesPaymentService.findNegotiationPayments(session.dataEntryModel?.tradeServiceId)

                session.dataEntryModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
                session.dataEntryModel << [mt103Flag: negoPayments.mt103.mt103Flag]
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Domestic Bills for Collection - Settlement (Data Entry)",
                tabs: ["basicDetails", "charges", "chargesPayment", "pddts", "mt103", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "BC",
                documentType: "DOMESTIC", //session.dataEntryModel.documentType,
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]
		
		if(session.dataEntryModel?.amountForCredit){
			if (new BigDecimal(session.dataEntryModel.amountForCredit) > BigDecimal.ZERO){
				session.dataEntryModel.tabs << "settlementToBeneficiary"
			}
		}
		
		if (session.dataEntryModel.bpAmount && new BigDecimal(session.dataEntryModel.bpAmount) > new BigDecimal(session.dataEntryModel.proceedsAmount) && new BigDecimal(session.dataEntryModel.amountForCredit) == BigDecimal.ZERO){
		session.dataEntryModel.tabs << "productPayment"
		
		session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in DB Currency)",
                totalAmountDueAmountLabel: "Remaining Balance",
                amountInPaymentInCurrencyLabel: "Amount of Settlement Payment <br/> (in Settlement Currency)",
				amountInPaymentInDocumentCurrencyLabel: "Amount of Settlement Payment <br/> (in DB Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Settlement Currency)",
                excessAmountInCurrencyLabel: "Excess Amount <br/> (in Settlement Currency)",
				bpLoanLabel: "DBP Loan",
				proceedsReceivedlabel: "Proceeds Received"
        ]
		}

        def exchange = []

        ratesService.getRatesEB(session.dataEntryModel.currency).response.details.each {
        	def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

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

        session.dataEntryModel << [exchange: exchange]
        // used to display rates - end

		println "chainModel?.tradeserviceID" + chainModel.tradeServiceId
		List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(session.dataEntryModel.tradeServiceId)
		
		println "DBC >>>>>>>>>>>>>>>>>>> charges = ${charges}"
		
		session.dataEntryModel << [charges:charges]
		session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]
		
		
        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/settlement/basic_details_tab"]
        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]
        session.dataEntryModel << [proceedsDetailsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/settlement/settlement_to_ben_tab"]
        session.dataEntryModel << [pddtsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/settlement/pddts_tab"]
        session.dataEntryModel << [mt103Tab: "../product/other/exports/export_bills/collection/domestic/dataentry/settlement/mt103_details_tab"]

		if (session.dataEntryModel.tabs.contains("productPayment")){
		session.dataEntryModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/other/exports/export_bills/collection/domestic/dataentry/settlement/product_payment_tab"]
		session.dataEntryModel << [productPaymentAction: "updateSettlementDataEntry"]
		}

        session.dataEntryModel << [basicDetailsAction: "saveSettlementDataEntry"]
        session.dataEntryModel << [settlementToBeneficiaryAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [pddtsAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [mt103Action: "updateSettlementDataEntry"]
		session.dataEntryModel << [chargesAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "DOMESTIC", null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "DOMESTIC", null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BC", "DOMESTIC", null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

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
	
	def viewCancellationDataEntry() {//MAX START
		if (chainModel) {

			session.dataEntryModel = chainModel

			if (chainModel.tradeServiceId) {
				def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

				session.dataEntryModel << tradeService?.details
				session.dataEntryModel << tradeService?.tradeServiceId
				session.dataEntryModel.approvers = tradeService?.approvers
				session.dataEntryModel << tradeService?.documentNumber

				session.dataEntryModel << [status: tradeService?.status]

				session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1

				List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

				println "EBC >>>>>>>>>>>>>>>>>>> charges = ${charges}"

				session.dataEntryModel << [charges:charges]
				session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]
			} else if (chainModel.documentNumber) {
				def exportBills = coreAPIService.dummySendQuery(null, chainModel.documentNumber, "product/", "exportBills/", "details/").details
				println 'exportBills ' + exportBills
				session.dataEntryModel << exportBills
				session.dataEntryModel << [documentNumber : exportBills.documentNumber.documentNumber]

				println exportBills.processDate
				session.dataEntryModel << [processDate: DateUtils.shortDateFormat(DateUtils.parse(exportBills.processDate.toString()))]

				session.dataEntryModel.currency = exportBills?.currency?.currencyCode

				session.dataEntryModel.exporterName = exportBills?.sellerName
				session.dataEntryModel.importerName = exportBills?.buyerName
				session.dataEntryModel.importerAddress = exportBills?.buyerAddress
			}
			session.dataEntryModel << [formName: chainModel.formName]
		}

		if(params.tradeServiceId){
			List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(params.tradeServiceId)

			println "EBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

			session.dataEntryModel << [charges:charges]
			session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]
		}

		session.dataEntryModel << [title: "Domestic Bills for Collection - Cancellation (Data Entry)",
				tabs: ["basicDetails", "instructionsAndRouting"],
				serviceType: "CANCELLATION",
				documentClass: "BC",
				documentType: "DOMESTIC",
				documentSubType1: "",
				documentSubType2: "",
				referenceType: "DATA_ENTRY"
		]


		// setup gsp to display in tabs
		session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/domestic/dataentry/cancellation/basic_details_tab"]

		session.dataEntryModel << [basicDetailsAction: "saveCancellationDataEntry"]
		session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

		// routing
		def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "DOMESTIC", null, null, "DATA_ENTRY", "CANCELLATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
		session.nextRoute = documentServiceRoute
		session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "DOMESTIC", null, null, "CANCELLATION", session.dataEntryModel.approvers)

		session.removeAttribute("financial")
		session.removeAttribute("postApprovalRequirement")
		session.removeAttribute("amountToCheck")
		session.removeAttribute("signingLimit")
		session.removeAttribute("postingAuthority")

		def productReference = routingInformationService.getProductReferences("BC", "DOMESTIC", null, null, "CANCELLATION", session.dataEntryModel, session.unitcode, session.username)

		session.financial = productReference.financial
		session.postApprovalRequirement = productReference.postApprovalRequirement
		session.amountToCheck = productReference.amountToCheck
		session.signingLimit = productReference.signingLimit
		session.postingAuthority = productReference.postingAuthority

		
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

		session.dataEntryModel << [tsdInitiated:"true"]

		render(view: "../product/index", model: session.dataEntryModel)
	}// END MAX

    def saveSettlementDataEntry() {
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username
		params.userrole = session.userrole.id
		
        params.each {
            if (it.key.toString().toLowerCase().contains("amount")) {
                it.value = it.value.replaceAll(",", "")
            }
        }



        def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
        def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
        def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
        def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
        if(baseCurrency.toString().equalsIgnoreCase("USD")){
            params.put("creationExchangeRate",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
        } else {
            params.put("creationExchangeRate",exchangeRate.setScale(8,BigDecimal.ROUND_HALF_UP))
        }
        params.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(8,BigDecimal.ROUND_HALF_UP))
        params.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
        params.put("urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
        params.put("USD-PHP_urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))


        println "baseCurrency:"+baseCurrency
        if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD")){
            def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
            println "thirdToUsd:"+thirdToUsd
            params.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
        }


        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "domesticBillsCollection", action: "viewSettlementDataEntry", model: sessionModel)
    }

    def updateSettlementDataEntry() {
        params.unitcode = session.unitcode
        params.username = session.username
		
        Map<String, Object> map = new HashMap<>()

        if ("charges".equals(params.form) && "DATA_ENTRY".equals(params.referenceType)) {
            map = exportBillsService.updateExportBillsDataEntry(params)
        } else {
            map = dataEntryService.updateDataEntry(params)
        }
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "domesticBillsCollection", action: "viewSettlementDataEntry", model: map)
    }

}
