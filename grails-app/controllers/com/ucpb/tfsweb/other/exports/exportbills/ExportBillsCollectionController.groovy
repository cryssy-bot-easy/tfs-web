package com.ucpb.tfsweb.other.exports.exportbills

import net.ipc.utils.DateUtils
import net.ipc.utils.JsonUtil

/**
 * PROLOGUE
 * SCR/ER Description: remove negotiation tab, and add allocation unit code to the parameters
 *	[Revised by:] Jesse James Joson
 *	[Date revised:] 2/9/2016
 *	Program [Revision] Details: Comment out the part that set-up negotiation tab; Add new variable to handle allocation unit code.
 *	Date deployment: 6/16/2016 
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: ExportBillsCollectionController.groovy 
*/
/**
 * PROLOGUE
 * SCR/ER Description:
 *	[Revised by:] Cedrick C. Nungay
 *	[Date revised:] 03/20/2018
 *	Program [Revision] Details: Added centavos model on page load.
 *	Date deployment: 3/20/2018
 *	Member Type: groovy
 *	Project: WEB
 *	Project Name: ExportBillsCollectionController.groovy
*/
class ExportBillsCollectionController {

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

                tradeService?.details?.each {
                    println "it >> " + it
                }

                if (tradeService?.details.documentsEnclosed && tradeService?.details.documentsEnclosed != "[[:]]") {
                    println "tradeService?.details.documentsEnclosed >> " + tradeService?.details.documentsEnclosed
                    def listMap = documentEnclosedService.stringToListMapDocEnclosed(tradeService?.details.documentsEnclosed.toString())
                    session.dataEntryModel.documentsEnclosed = listMap
                    session.dataEntryModel.documentsEnclosedList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
                } else {
                    session.dataEntryModel.documentsEnclosed = []
                }

                if (tradeService?.details.enclosedInstruction && tradeService?.details.enclosedInstruction != "[[:]]") {
                    println "tradeService?.details.enclosedInstruction"
                    println tradeService?.details.enclosedInstruction
                    def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.enclosedInstruction.toString())
                    session.dataEntryModel.enclosedInstruction = listMap
                    session.dataEntryModel.enclosedInstructionList = listMap.id.toString().replaceAll("\\[","").replaceAll("\\]","")
                } else {
                    session.dataEntryModel.enclosedInstruction = []
                }

                if (tradeService?.details.additionalInstruction && tradeService?.details.additionalInstruction != "[[:]]") {
                    println "tradeService?.details.additionalInstruction"
                    def listMap = documentEnclosedService.stringToListMapAdditionalCondition(tradeService?.details.additionalInstruction.toString())
                    session.dataEntryModel.additionalInstruction = listMap
                } else {
                    session.dataEntryModel.additionalInstruction = []
                }
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [tsdInitiated:"true"]

        session.dataEntryModel << [title: "Export Bills for Collection - Negotiation (Data Entry)",
                tabs: ["basicDetails",
                        "docEnclosedInstructions",
                        "instructionsAndRouting"],

                serviceType: "NEGOTIATION",
                documentClass: "BC",
                documentType: "FOREIGN", //session.dataEntryModel.documentType,
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

        if ("LC".equals(session.dataEntryModel.paymentMode)) {
            session.dataEntryModel.tabs << "setupLcDetails"
        } else if (session.dataEntryModel.paymentMode in ["DA", "DP", "OA", "DR"]) {
            session.dataEntryModel.tabs << "setupNonLcDetails"
        }

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
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/negotiation/basic_details_tab"]

        if (session.dataEntryModel.tabs.contains("setupLcDetails")) {
            session.dataEntryModel << [setupLcDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/negotiation/setup_lc_details_foreign_tab"]
        }

        if (session.dataEntryModel.tabs.contains("setupNonLcDetails")) {
            session.dataEntryModel << [setupNonLcDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/negotiation/setup_nonlc_details_tab"]
        }

        session.dataEntryModel << [docEnclosedInstructionsTab: "../product/other/exports/export_bills/collection/export/dataentry/negotiation/documents_enclosed_instructions_tab"]


        session.dataEntryModel << [basicDetailsAction: "saveNegotiationDataEntry"]

        if (session.dataEntryModel.tabs.contains("setupLcDetails")) {
            session.dataEntryModel << [setupLcDetailsAction: "saveNegotiationDataEntry"]
        }

        if (session.dataEntryModel.tabs.contains("setupNonLcDetails")) {
            session.dataEntryModel << [setupNonLcDetailsAction: "saveNegotiationDataEntry"]
        }

        session.dataEntryModel << [docEnclosedInstructionsAction: "saveNegotiationDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "FOREIGN", null, null, "DATA_ENTRY", "NEGOTIATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "FOREIGN", null, null, "NEGOTIATION", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BC", "FOREIGN", null, null, "NEGOTIATION", session.dataEntryModel, session.unitcode, session.username)

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
		
		println "SESSION:"+session.dataEntryModel
		
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveNegotiationDataEntry() {
        println "%%%%%%%%%%%%%%%%%%%%%%%%%"
        params.each {
            println "param >> " + it
        }
        println "%%%%%%%%%%%%%%%%%%%%%%%%%"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username
		
        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		params.allocationUnitCode = params.allocationUnitCodeParam
		
        // enclosed document
        def paramDocEnclosed = []
        if (params.documentsEnclosedList) {
            params.documentsEnclosedList.split("\\|").each {
                println 'doc enclosed it ' + it
                paramDocEnclosed << JsonUtil.parseToMapNewLine(it)
            }
        }
		if (!paramDocEnclosed.isEmpty()) {
            println "paramDocEnclosed not empty"
            params.documentsEnclosed = paramDocEnclosed.toString()
		}

        // enclosed instruction
        def paramEnclosedInstr = []
        if (params.enclosedInstructionList) {
            params.enclosedInstructionList.split("\\|").each {
                paramEnclosedInstr << JsonUtil.parseToMapNewLine(it)
            }
        }

		if(!paramEnclosedInstr.isEmpty()) {
            println "paramEnclosedInstr not empty"
			params.enclosedInstruction = paramEnclosedInstr.toString()
		}

        // additional instruction
        def paramAdditionalInstr = []

        session.dataEntryModel.additionalInstruction?.each {
            paramAdditionalInstr << [id: it.id, instruction: it.instruction]
        }

		if(!paramAdditionalInstr.isEmpty()) {
            println "paramAdditionalInstr not empty"
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

        params.put("donotreset","Y")

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportBillsCollection", action: "viewNegotiationDataEntry", model: sessionModel)
    }

    def viewSettlementEts() {
		println "View Settlement Ets - Export Bills for Collection"
		session.removeAttribute("dataEntryModel")
        if (chainModel) {

            session.etsModel = chainModel

            if (chainModel.documentNumber) {
                def exportBills = coreAPIService.dummySendQuery(null, chainModel.documentNumber, "product/", "exportBills/", "details/").details

                session.etsModel << exportBills
                session.etsModel << [bookingCurrency : exportBills?.loanDetails?.bookingCurrency?.currencyCode]
        		session.etsModel << [loanAmount : exportBills?.loanDetails?.loanAmount]
                session.etsModel << [documentNumber : exportBills.documentNumber.documentNumber]

                session.etsModel.currency = exportBills?.currency?.currencyCode

                session.etsModel.bpCurrency = exportBills?.bpCurrency?.currencyCode
                session.etsModel.bpAmount = exportBills.bpAmount

            }

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                //println "tradeService:"+tradeService

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]


                if(tradeService?.tradeServiceId?.tradeServiceId){
                    List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                    println "EBC >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                    session.etsModel << [charges:charges]
                    session.etsModel << [chargesString: parserService.listHashMapToString(charges)]
                }

            }
			
			session.etsModel << [charges: chargesService.findAllCharges(session.etsModel.etsNumber)]
			session.etsModel << [formName: chainModel.formName]
        }

        println "chainModel?.serviceInstructionId:"+chainModel?.serviceInstructionId
        println "session?.etsModel?.serviceInstructionId:"+session?.etsModel?.serviceInstructionId
        println "session?.etsModel?.etsNumber:"+session?.etsModel?.etsNumber
        println "session?.etsModel?.tradeService:"+session?.etsModel?.tradeService


        if (session?.etsModel?.serviceInstructionId) {
            def tradeService = coreAPIService.dummySendQuery([etsNumber: session?.etsModel?.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

            //println "tradeService:"+tradeService

            session.etsModel << tradeService?.ets?.details
			session.etsModel << [status: tradeService?.ets?.status]
            session.etsModel << tradeService?.documentNumber
            session.etsModel << [approvers: tradeService?.ets?.approvers]
            session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]


            if(tradeService?.tradeServiceId?.tradeServiceId){
                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(tradeService?.tradeServiceId?.tradeServiceId)

                println "EBC >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.etsModel << [charges:charges]
                session.etsModel << [chargesString: parserService.listHashMapToString(charges)]
            }

        }


        session.etsModel << [title: "Export Bills for Collection - Settlement (eTS)",
                tabs: ["basicDetails", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "BC",
                documentType: "FOREIGN",//session.etsModel.documentType, tabs  "charges", "chargesPayment",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]
		if(session.etsModel?.amountForCredit){
			if (new BigDecimal(session.etsModel.amountForCredit) > BigDecimal.ZERO){
				session.etsModel.tabs << "settlementToBeneficiary"
				session.etsModel.tabs << "charges"
				session.etsModel.tabs << "chargesPayment"
			}
		}
		
//		if (session.etsModel.bpAmount && session.etsModel.amountForCredit && new BigDecimal(session.etsModel.bpAmount) > new BigDecimal(session.etsModel.proceedsAmount) && new BigDecimal(session.etsModel.amountForCredit) == BigDecimal.ZERO){
////			session.etsModel.tabs << "productPayment"
//
//        // setup product labels
//        session.etsModel << [totalAmountDueCurrencyLabel: "Amount Due (in EB Currency)",
//                totalAmountDueAmountLabel: "Remaining Balance",
//                amountInPaymentInCurrencyLabel: "Amount of Settlement Payment <br/> (in Settlement Currency)",
//				amountInPaymentInDocumentCurrencyLabel: "Amount of Settlement Payment <br/> (in EB Currency)",
//                totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Settlement Currency)",
//                excessAmountInCurrencyLabel: "Excess Amount <br/> (in Settlement Currency)",
//				bpLoanLabel: "EBP Loan",
//				proceedsReceivedlabel: "Proceeds Received"
//        ]
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
        session.etsModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/export/ets/settlement/basic_details_tab"]
		
		if (session.etsModel.tabs.contains("productPayment")){
		session.etsModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.etsModel << [productPaymentTab: "../product/other/exports/export_bills/collection/export/ets/settlement/product_payment_tab"]
		session.etsModel << [productPaymentAction: "updateSettlementEts"]
		}

        session.etsModel << [proceedsDetailsTab: "../product/other/exports/export_bills/collection/export/ets/settlement/settlement_to_ben_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.etsModel << [basicDetailsAction: "saveSettlementEts"]
        session.etsModel << [loanSetupAction: "saveSettlementEts"]
        session.etsModel << [settlementToBeneficiaryAction: "updateSettlementEts"]
        session.etsModel << [chargesAction: "updateSettlementEts"]
        session.etsModel << [chargesPaymentAction: "updateSettlementEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("BC", "FOREIGN", null, null, "ETS", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("BC", "FOREIGN", null, null, "SETTLEMENT", session.etsModel.approvers)

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
		session.etsModel << [centavos: coreAPIService.dummySendQuery(
			[documentType: session.etsModel.documentType, documentClass: session.etsModel.documentClass,
				documentSubType1: session.etsModel.documentSubType1, documentSubType2: session.etsModel.documentSubType2,
				serviceType: 'SETTLEMENT'], 'getChargesParameter', 'chargesParameter/').result?.RATEAMOUNT]
		
		
        render(view: "../product/index", model: session.etsModel)
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

                // changed pddts to ibt and removed swift
                def negoPayments = chargesPaymentService.findNegotiationPayments(session.dataEntryModel?.tradeServiceId)

                session.dataEntryModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]

                List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(chainModel.tradeServiceId)

                println "EBP >>>>>>>>>>>>>>>>>>> charges = ${charges}"

                session.dataEntryModel << [charges:charges]
                session.dataEntryModel << [chargesString: parserService.listHashMapToString(charges)]
				
				session.dataEntryModel << [formName: chainModel.formName]
            }
			
        }

        session.dataEntryModel << [title: "Export Bills for Collection - Settlement (Data Entry)",
                // changed pddts to ibt and removed swift
                tabs: ["basicDetails", "pddts", "instructionsAndRouting"],
                serviceType: "SETTLEMENT",
                documentClass: "BC",
                documentType: "FOREIGN", //session.dataEntryModel.documentType, tabs "charges", "chargesPayment", 
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]
		
		// added by HENRY
		if(session.dataEntryModel?.amountForCredit){
			if (new BigDecimal(session.dataEntryModel.amountForCredit) > BigDecimal.ZERO){
				session.dataEntryModel.tabs << "settlementToBeneficiary"
				session.dataEntryModel.tabs << "charges"
				session.dataEntryModel.tabs << "chargesPayment"
			}
		}
		
//		if (session.dataEntryModel.bpAmount && new BigDecimal(session.dataEntryModel.bpAmount) > new BigDecimal(session.dataEntryModel.proceedsAmount) && new BigDecimal(session.dataEntryModel.amountForCredit) == BigDecimal.ZERO){
//		session.dataEntryModel.tabs << "productPayment"
//		
//		session.dataEntryModel << [totalAmountDueCurrencyLabel: "Amount Due (in EB Currency)",
//                totalAmountDueAmountLabel: "Remaining Balance",
//                amountInPaymentInCurrencyLabel: "Amount of Settlement Payment <br/> (in Settlement Currency)",
//				amountInPaymentInDocumentCurrencyLabel: "Amount of Settlement Payment <br/> (in EB Currency)",
//                totalAmountInCurrencyLabel: "Total Amount of Payment <br/> (in Settlement Currency)",
//                excessAmountInCurrencyLabel: "Excess Amount <br/> (in Settlement Currency)",
//				bpLoanLabel: "EBP Loan",
//				proceedsReceivedlabel: "Proceeds Received"
//        ]
//		}

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
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/settlement/basic_details_tab"]
        session.dataEntryModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]
        session.dataEntryModel << [proceedsDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/settlement/settlement_to_ben_tab"]
        session.dataEntryModel << [pddtsTab: "../product/other/exports/export_bills/collection/export/dataentry/settlement/pddts_tab"]

		if (session.dataEntryModel.tabs.contains("productPayment")){
		session.dataEntryModel << [productPaymentTabLabel: "Negotiation <br /> Payment"]
		session.dataEntryModel << [productPaymentTab: "../product/other/exports/export_bills/collection/export/dataentry/settlement/product_payment_tab"]
		session.dataEntryModel << [productPaymentAction: "updateSettlementDataEntry"]
		}

		session.dataEntryModel << [basicDetailsAction: "saveSettlementDataEntry"]
        session.dataEntryModel << [chargesAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [settlementToBeneficiaryAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [pddtsAction: "updateSettlementDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "FOREIGN", null, null, "DATA_ENTRY", "SETTLEMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "FOREIGN", null, null, "SETTLEMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BC", "FOREIGN", null, null, "SETTLEMENT", session.dataEntryModel, session.unitcode, session.username)

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
		 //for Amla
		 def paymentsMade = chargesPaymentService.findAllPaymentsForExports(session.dataEntryModel.tradeServiceId)
		 
		 List<Object> paymentList = new ArrayList<Map<String, Object>>();
		 paymentList.addAll(paymentsMade)
		 
		 def count=0;
		
		 if(chainModel) {
		 
			 for(Object listahan:paymentList.listIterator()) {
				 
				 println paymentList.get(count).toString() + " aaaarrrrraaaaayyyyy " + count.toString()
				 
				 
				 def paymentDetail = paymentList.get(count)
				 for(Map.Entry<String, String> laman: paymentDetail.entrySet()) {
					 
					 println laman.getKey() + " : " + laman.getValue()

						 if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
							 && paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")){
							 session.dataEntryModel<<[amlaCasaFlag:"1",
													  amlaCasaFlagLc:"1",
													  amlaCasaFlagPhp:"1",
													  amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString(),
												      amlaCasaFlagAccountNo:paymentDetail.get("REFERENCENUMBER").toString()]
						 }
						 if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
							 && !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")){
							 session.dataEntryModel<<[amlaCasaFlag:"1",
													  amlaCasaFlagLc:"1",
													  amlaCasaFlagFx:"1",
													  amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString(),
													  amlaCasaFlagFxCurrency:paymentDetail.get("CURRENCY").toString(),
													  amlaCasaFlagAccountNo:paymentDetail.get("REFERENCENUMBER").toString()]
						 }
						 if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
							 && paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && !session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")){
							 session.dataEntryModel<<[amlaCasaFlag:"1",
													  amlaCasaFlagNlc:"1",
													  amlaCasaFlagPhp:"1",
													  amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString(),
													  //amlaCasaFlagFxCurrency:paymentDetail.get("CURRENCY").toString(),
													  amlaCasaFlagAccountNo:paymentDetail.get("REFERENCENUMBER").toString()]
						 }
						 if(paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("CASA")
							 && !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && !session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")){
							 session.dataEntryModel<<[amlaCasaFlag:"1",
													  amlaCasaFlagNlc:"1",
													  amlaCasaFlagFx:"1",
													  amlaCasaFlagAmount:paymentDetail.get("AMOUNT").toString(),
													  amlaCasaFlagFxCurrency:paymentDetail.get("CURRENCY").toString(),
													  amlaCasaFlagAccountNo:paymentDetail.get("REFERENCENUMBER").toString()]
						 }
		
						 if((paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("IBT_BRANCH") 
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("MC_ISSUANCE")
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("PDDTS"))
							 && paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")) {
							 session.dataEntryModel<<[amlaIBTFlag:"1",
													  amlaIBTFlagLc:"1",
													  amlaIBTFlagPhp:"1",
													  amlaIBTFlagAmount:paymentDetail.get("AMOUNT").toString()]
						 }
						 if((paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("IBT_BRANCH") 
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("MC_ISSUANCE")
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("PDDTS"))
							 && !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")) {
							 session.dataEntryModel<<[amlaIBTFlag:"1",
													  amlaIBTFlagLc:"1",
													  amlaIBTFlagFx:"1",
													  amlaIBTFlagFxCurrency:paymentDetail.get("CURRENCY").toString(),
													  amlaIBTFlagAmount:paymentDetail.get("AMOUNT").toString()]
						 }
						 if((paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("IBT_BRANCH") 
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("MC_ISSUANCE")
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("PDDTS"))
							 && paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && !session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")) {
							 session.dataEntryModel<<[amlaIBTFlag:"1",
													  amlaIBTFlagNLc:"1",
													  amlaIBTFlagPhp:"1",
													  amlaIBTFlagAmount:paymentDetail.get("AMOUNT").toString()]
						 }
						 if((paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("IBT_BRANCH") 
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("MC_ISSUANCE")
							 || paymentDetail.get("PAYMENTINSTRUMENTTYPE").toString().equalsIgnoreCase("PDDTS"))
							 && !paymentDetail.get("CURRENCY").toString().equalsIgnoreCase("PHP")
							 && !session.dataEntryModel.paymentMode.equalsIgnoreCase("LC")) {
							 session.dataEntryModel<<[amlaIBTFlag:"1",
													  amlaIBTFlagNLc:"1",
													  amlaIBTFlagFx:"1",
													  amlaIBTFlagFxCurrency:paymentDetail.get("CURRENCY").toString(),
													  amlaIBTFlagAmount:paymentDetail.get("AMOUNT").toString()]
						 }
				 }
				 count++
			 }
			 
		 }
		 
		 println ">>> " + session.dataEntryModel
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveSettlementEts() {
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
        params.allocationUnitCode = params.allocationUnitCodeParam
		



        def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
        def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
        def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
        def baseCurrency = params.currency
        if(baseCurrency.toString().equalsIgnoreCase("USD")){
            params.put("creationExchangeRate",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
        } else {
            params.put("creationExchangeRate",exchangeRate.setScale(8,BigDecimal.ROUND_HALF_UP))
        }
        params.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(8,BigDecimal.ROUND_HALF_UP))
        params.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
        params.put("urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))


        println "baseCurrency:"+baseCurrency
        if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD")){
            def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
            println "thirdToUsd:"+thirdToUsd
            params.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
        }



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

        chain(controller: "exportBillsCollection", action: "viewSettlementEts", model: sessionModel)
    }

    def updateSettlementEts() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportBillsCollection", action: "viewSettlementEts", model: map)
    }

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

        params.put("donotreset","Y")



        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]
		
		sessionModel << [amlaCasaFlagAccountNo:params.amlaCasaFlagAccountNo]

        chain(controller: "exportBillsCollection", action: "viewSettlementDataEntry", model: sessionModel)
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

        chain(controller: "exportBillsCollection", action: "viewSettlementDataEntry", model: map)
    }

    def updateEtsStatus() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = etsService.updateEts(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def updateDataEntryStatus() {
        params.unitcode = session.unitcode
        params.username = session.username
		
        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        Map<String, Object> map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def viewCancellationDataEntry() {
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

        session.dataEntryModel << [title: "Export Bills for Collection - Cancellation (Data Entry)",
                tabs: ["basicDetails", "instructionsAndRouting"],
                serviceType: "CANCELLATION",
                documentClass: "BC",
                documentType: "FOREIGN",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]


        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_bills/collection/export/dataentry/cancellation/basic_details_tab"]

        session.dataEntryModel << [basicDetailsAction: "saveCancellationDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("BC", "FOREIGN", null, null, "DATA_ENTRY", "CANCELLATION", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("BC", "FOREIGN", null, null, "CANCELLATION", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("BC", "FOREIGN", null, null, "CANCELLATION", session.dataEntryModel, session.unitcode, session.username)

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
    }

    def saveCancellationDataEntry() {
		
		println "xxxxxxxxxx saveCancellationDataEntry"
		
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username
		params.cifNumber = params.cifNumberParam
		params.cifName = params.cifNameParam
		params.accountOfficer = params.accountOfficerParam
		params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam
		params.allocationUnitCode = params.allocationUnitCodeParam		
		params.longName = params.longName
		params.address1 = params.address1
		params.address2 = params.address2
		
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

        chain(controller: "exportBillsCollection", action: "viewCancellationDataEntry", model: sessionModel)
    }
}
