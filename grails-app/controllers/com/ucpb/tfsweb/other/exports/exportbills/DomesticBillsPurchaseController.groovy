package com.ucpb.tfsweb.other.exports.exportbills

import grails.converters.JSON
import net.ipc.utils.JsonUtil

class DomesticBillsPurchaseController {

    def coreAPIService
    def routingInformationService
    def ratesService
    def etsService
    def documentEnclosedService
    def chargesPaymentService
    def dataEntryService
    def exportBillsService
    def parserService
    def chargesService
    def foreignExchangeService
	def tabUtilityService

    def viewNegotiationEts() {
        if (chainModel) {

            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
        		session.etsModel << tradeService?.details
                session.etsModel << tradeService?.documentNumber
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
				
				// passes chain model if existing else passes session model
				String tradeServiceId = session.etsModel.tradeServiceId
				Map<String, Object> paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
				session.etsModel << [paymentsMade: paymentsMade.payments]
				session.etsModel << [loanCount: paymentsMade.loanCount]

                if(tradeService?.tradeServiceId?.tradeServiceId){
                    List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                    println "DBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                    session.etsModel << [charges:charges]
                    session.etsModel << [chargesString: parserService.listHashMapToString(charges)]
                }
            }
			session.etsModel << [formName: chainModel.formName]
        }



        session.etsModel << [title: "Domestic Bills for Purchase - Negotiation (e-TS)",
                tabs: ["basicDetails", "productPayment", "loanSetup", "charges", "chargesPayment", "settlementToBeneficiary", "instructionsAndRouting"],
                serviceType: "NEGOTIATION",
                documentClass: "BP",
                documentType: "DOMESTIC",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]

        // setup product labels
        session.etsModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
                totalAmountDueAmountLabel: "Remaining Balance",
                amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
                amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
                totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
                excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
        ]
		
//		if ("LC".equals(session.etsModel.paymentMode)) {
			session.etsModel.tabs << "setupLcDetails"
//		} else if (session.etsModel.paymentMode in ["DA", "DP", "OA"]) {
//			session.etsModel.tabs << "setupNonLcDetails"
//		}

        def exchange = []

        ratesService.getRatesEB(session.etsModel.currency).response.details.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

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
        session.etsModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/domestic/ets/negotiation/basic_details_tab"]
		
		session.etsModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.etsModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]
		
        session.etsModel << [loanSetupTab: "../product/other/exports/export_bills/purchase/domestic/ets/loan_setup_ets_tab"]
        session.etsModel << [proceedsDetailsTab: "../product/other/exports/export_bills/purchase/domestic/ets/settlement_to_ben_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

//		if (session.etsModel.tabs.contains("setupLcDetails")) {
			session.etsModel << [setupLcDetailsTab: "../product/other/exports/export_bills/purchase/domestic/ets/negotiation/setup_lc_details_domestic_tab"]
			session.etsModel << [setupLcDetailsAction: "saveNegotiationEts"]
//		}
		
//		if (session.etsModel.tabs.contains("setupNonLcDetails")) {
//			session.etsModel << [setupNonLcDetailsTab: "../product/other/exports/export_bills/purchase/domestic/ets/negotiation/setup_nonlc_details_tab"]
//			session.etsModel << [setupNonLcDetailsAction: "saveNegotiationEts"]
//		}
		
        session.etsModel << [basicDetailsAction: "saveNegotiationEts"]
		session.etsModel << [productPaymentAction: "updateNegotiationEts"]
        session.etsModel << [loanSetupAction: "saveNegotiationEts"]
        session.etsModel << [settlementToBeneficiaryAction: "updateNegotiationEts"]
        session.etsModel << [chargesAction: "updateNegotiationEts"]
        session.etsModel << [chargesPaymentAction: "updateNegotiationEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("BP", "DOMESTIC", null, null, "ETS", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("BP", "DOMESTIC", null, null, "NEGOTIATION", session.etsModel.approvers)

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

    def saveNegotiationEts() {
        //println"saveNegotiationEts"

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

        chain(controller: "domesticBillsPurchase", action: "viewNegotiationEts", model: sessionModel)
    }

    def updateNegotiationEts() {
        //println"updateNegotiationEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "domesticBillsPurchase", action: "viewNegotiationEts", model: map)
    }

    def updateEtsStatus() {
        //println"updateEtsStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def viewNegotiationDataEntry() {
        String tradeServiceId = chainModel?.tradeServiceId ?: session.dataEntryModel?.tradeServiceId
		Map<String, Object> paymentsMade
		if (tradeServiceId){
			paymentsMade = chargesPaymentService.findAllPayments(tradeServiceId)
		}
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
		if(tradeServiceId == session.dataEntryModel?.tradeServiceId){
			session.dataEntryModel << [paymentsMade: paymentsMade?.payments]
			session.dataEntryModel << [loanCount: paymentsMade?.loanCount]
		}

        session.dataEntryModel << [title: "Domestic Bills for Purchase - Negotiation (Data Entry)",
                tabs: ["basicDetails",
						"productPayment",
                        "loanSetup",
                        "setupLcDetails",
                        "docEnclosedInstructions",
                        "charges",
                        "chargesPayment",
                        "settlementToBeneficiary",
                        "mt103",
                        "pddts",
                        "instructionsAndRouting"],

                serviceType: "NEGOTIATION",
                documentClass: "BP",
                documentType: "DOMESTIC", //session.dataEntryModel.documentType,
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]
		
		session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
			totalAmountDueAmountLabel: "Remaining Balance",
			amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
			amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
			totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
			excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
		]

        def exchange = []

        ratesService.getRatesEB(session.dataEntryModel.currency).response.details.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

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
        // used to display rates - end

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/negotiation/basic_details_tab"]
		
		session.dataEntryModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]

        session.dataEntryModel << [setupLcDetailsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/negotiation/setup_lc_details_domestic_tab"]

		// comment below code, the pddts and mt103 tab used was the commons tab in lc and nonlc
        // session.dataEntryModel << [pddtsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/pddts_tab"]
        // session.dataEntryModel << [mt103Tab: "../product/other/exports/export_bills/purchase/domestic/dataentry/mt103_details_tab"]

//		session.dataEntryModel << [pddtsTab: "../commons/tabs/pddts_tab"]
//		session.dataEntryModel << [mt103Tab: "../commons/tabs/mt_103_tab"]
		session.dataEntryModel << [pddtsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/pddts_tab"]
		session.dataEntryModel << [mt103Tab: "../product/other/exports/export_bills/purchase/domestic/dataentry/mt103_details_tab"]

        session.dataEntryModel << [loanSetupTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/loan_setup_dataentry_tab"]

        session.dataEntryModel << [docEnclosedInstructionsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/negotiation/documents_enclosed_instructions_tab"]

        session.dataEntryModel << [proceedsDetailsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/settlement_to_ben_tab"]

        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.dataEntryModel << [basicDetailsAction: "saveNegotiationDataEntry"]

		session.dataEntryModel << [productPaymentAction: "updateNegotiationDataEntry"]
		
        session.dataEntryModel << [setupLcDetailsAction: "saveNegotiationDataEntry"]

        session.dataEntryModel << [docEnclosedInstructionsAction: "saveNegotiationDataEntry"]
        session.dataEntryModel << [loanSetupAction: "saveNegotiationDataEntry"]

        session.dataEntryModel << [settlementToBeneficiaryAction: "updateNegotiationDataEntry"]
        session.dataEntryModel << [pddtsAction: "updateNegotiationDataEntry"]
        session.dataEntryModel << [mt103Action: "updateNegotiationDataEntry"]

        session.dataEntryModel << [chargesAction: "updateNegotiationDataEntry"]
        session.dataEntryModel << [chargesPaymentAction: "updateNegotiationDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BP", "DOMESTIC", null, null, "DATA_ENTRY", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BP", "DOMESTIC", null, null, "NEGOTIATION", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BP", "DOMESTIC", null, null, "NEGOTIATION", session.dataEntryModel, session.unitcode, session.username)

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
        //println"saveNegotiationDataEntry"

        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username
		
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

        params.each {
            if (it.key.toString().toLowerCase().contains("amount")) {
                it.value = it.value.replaceAll(",", "")
            }
        }

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "domesticBillsPurchase", action: "viewNegotiationDataEntry", model: sessionModel)
    }

    def updateNegotiationDataEntry() {
        //println"updateNegotiationDataEntry"
        params.unitcode = session.unitcode
        params.username = session.username
		
        Map<String, Object> map = new HashMap<>()

		println "Form: " + params.form
        if ("charges".equals(params.form) && "DATA_ENTRY".equals(params.referenceType)) {
            map = exportBillsService.updateExportBillsDataEntry(params)
        } else {
            map = dataEntryService.updateDataEntry(params)
        }
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "domesticBillsPurchase", action: "viewNegotiationDataEntry", model: map)
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

    // SETTLEMENT
    def viewSettlementDataEntry() {
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
            }

            if (chainModel.documentNumber) {
                def exportBills = coreAPIService.dummySendQuery([:], "details/"+chainModel.documentNumber, "product/exportBills/").details

                exportBills.each {
                    if (!"processDate".equals(it.key)) {
                        session.dataEntryModel << it
                    }
                }
				session.dataEntryModel << [pnNumber: exportBills?.loanDetails?.pnNumber]
                session.dataEntryModel << exportBills.documentNumber
                session.dataEntryModel << [currency: exportBills?.currency.currencyCode]
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [tsdInitiated:"true"]

        session.dataEntryModel << [title: "Domestic Bills for Purchase - Settlement (Data Entry)",
                tabs: ["basicDetails",
//                        "charges",
//                        "chargesPayment",
                        "instructionsAndRouting"],

                serviceType: "SETTLEMENT",
                documentClass: "BP",
                documentType: "DOMESTIC", //session.dataEntryModel.documentType,
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

		if(session.dataEntryModel.amountDue && session.dataEntryModel.amountDue != '0.00'){
			session.dataEntryModel.tabs << "productPayment"
			
			// setup product labels
			session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in Negotiation Currency)",
					totalAmountDueAmountLabel: "Remaining Balance",
					amountInPaymentInCurrencyLabel: "Amount of Negotiation Payment <br/> (in Settlement Currency)",
					amountInPaymentInDocumentCurrencyLabel: "Amount of Negotiation Payment <br/> (in Negotiation Currency)",
					totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Negotiation Currency)",
					excessAmountInCurrencyLabel: "Excess Amount <br/> (in Negotiation Currency)"
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
        // used to display rates - end

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/purchase/domestic/dataentry/settlement/basic_details_tab"]

//        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
//        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]
		
		session.dataEntryModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/commons/tabs/product_payment_tab"]

        session.dataEntryModel << [basicDetailsAction: "saveSettlementDataEntry"]
//        session.dataEntryModel << [chargesAction: "updateSettlementDataEntry"]
//        session.dataEntryModel << [chargesPaymentAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        session.dataEntryModel << [productPaymentAction: "updateSettlementDataEntry"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BP", "DOMESTIC", null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BP", "DOMESTIC", null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BP", "DOMESTIC", null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

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

    def saveSettlementDataEntry() {
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

        chain(controller: "domesticBillsPurchase", action: "viewSettlementDataEntry", model: sessionModel)
    }

    def updateSettlementDataEntry() {
        //println"updateNegotiationDataEntry"
        params.unitcode = session.unitcode
        params.username = session.username
		
        Map<String, Object> map = new HashMap<>()

        if ("charges".equals(params.form) && "DATA_ENTRY".equals(params.referenceType)) {
            map = exportBillsService.updateExportBillsDataEntry(params)
        } else {
            map = dataEntryService.updateDataEntry(params)
        }
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "domesticBillsPurchase", action: "viewSettlementDataEntry", model: map)
    }
	
	def updatePassOnRates() {
		render coreAPIService.dummySendQuery([passOnRateConfirmedByCash: params.passOnRateConfirmedByCash, tradeServiceId: params.tradeServiceId], "updateTradeServicePost", "tradeservice/") as JSON
	}
}
