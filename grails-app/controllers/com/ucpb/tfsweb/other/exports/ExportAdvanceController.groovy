package com.ucpb.tfsweb.other.exports

import grails.converters.JSON
import net.ipc.utils.NumberUtils

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class ExportAdvanceController {

    def coreAPIService
    def ratesService
    def etsService
    def chargesPaymentService
    def routingInformationService
    def dataEntryService
	def chargesService
	def tabUtilityService
	def documentUploadingService

    private static ETS_PAYMENT_TABS = ["basicDetails", "attachedDocuments", "charges", "chargesPayment", "settlementToBeneficiary", "instructionsAndRouting"]
    private static DATAENTRY_PAYMENT_TABS = ["basicDetails", "attachedDocuments", "charges", "chargesPayment", "settlementToBeneficiary", "pddts", "mt103", "instructionsAndRouting"]

    private static DEFAULT_TABS = ["basicDetails", "attachedDocuments", "productPayment", "charges", "chargesPayment", "instructionsAndRouting"]
    private static PAYMENT_DE_TABS = ["basicDetails", "attachedDocuments", "mtDetails", "productPayment", "charges", "chargesPayment", "instructionsAndRouting"]

    def viewPaymentEts() {
		println "EXPORT ADVANCE PAYMENT"
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
				
				List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(session.etsModel.tradeServiceId)
				
				println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + charges
				
				session.etsModel << [charges:charges]
            }
			session.etsModel << [formName: chainModel.formName]
        }

        def exchange = []

        ratesService.getRates(session.etsModel.currency).response.details.each {
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

        session.etsModel << [title: "Export Advance Payment - eTS",
                tabs: ETS_PAYMENT_TABS,
                serviceType: "PAYMENT",
                documentClass: "EXPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]

        session.etsModel << [basicDetailsTab: "../product/other/exports/export_advance/payment/ets/basic_details_tab"]
        session.etsModel << [proceedsDetailsTab: "../product/other/exports/export_advance/payment/ets/settlement_to_ben_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.etsModel << [basicDetailsAction: "savePaymentEts"]
        session.etsModel << [settlementToBeneficiaryAction: "updatePaymentEts"]
        session.etsModel << [chargesAction: "updatePaymentEts"]
        session.etsModel << [chargesPaymentAction: "updatePaymentEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        def documentServiceRoute = routingInformationService.getNextBranchApprover("EXPORT_ADVANCE", null, null, null, "ETS", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("EXPORT_ADVANCE", null, null, null, "PAYMENT", session.etsModel.approvers)

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

    def savePaymentEts() {
        //println"savePaymentEts"
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
        sessionModel << ["serviceInstructionId": etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvance", action: "viewPaymentEts", model: sessionModel)
    }

    def updatePaymentEts() {
        //println"updatePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportAdvance", action: "viewPaymentEts", model: map)
    }

    def viewPaymentDataEntry() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel?.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel << tradeService?.documentNumber
                session.dataEntryModel.serviceInstructionId = tradeService?.serviceInstructionId?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 : session.dataEntryModel.approvers.split(",").size() + 1

                def negoPayments = chargesPaymentService.findNegotiationPayments(session.dataEntryModel?.tradeServiceId)

                session.dataEntryModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
                session.dataEntryModel << [mt103Flag: negoPayments.mt103.mt103Flag]
            }
			session.dataEntryModel << [formName: chainModel.formName]
        }

        session.dataEntryModel << [title: "Export Advance Payment - Data Entry",
                tabs: DATAENTRY_PAYMENT_TABS,
                serviceType: "PAYMENT",
                documentClass: "EXPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

		List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(session.dataEntryModel.tradeServiceId)
		
		println ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + charges
		
		session.dataEntryModel << [charges:charges]
		
        def exchange = []

        ratesService.getRates(session.dataEntryModel.currency).response.details.each {
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

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advance/payment/dataentry/basic_details_tab"]
        session.dataEntryModel << [proceedsDetailsTab: "../product/other/exports/export_advance/payment/dataentry/settlement_to_ben_tab"]

        session.dataEntryModel << [pddtsTab: "../product/other/exports/export_advance/payment/dataentry/pddts_tab"]
        session.dataEntryModel << [mt103Tab: "../product/other/exports/export_advance/payment/dataentry/mt103_details_tab"]

        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVANCE", null, null, null, "DATA_ENTRY", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVANCE", null, null, null, "PAYMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("EXPORT_ADVANCE", null, null, null, "PAYMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "savePaymentDataEntry"]
        session.dataEntryModel << [pddtsAction: "savePaymentDataEntry"]
        session.dataEntryModel << [mt103Action: "savePaymentDataEntry"]
        session.dataEntryModel << [chargesAction: "savePaymentDataEntry"]
        session.dataEntryModel << [chargesPaymentAction: "savePaymentDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def savePaymentDataEntry() {
        //println"savePaymentDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvance", action: "viewPaymentDataEntry", model: sessionModel)
    }

    def updatePaymentDataEntry() {
        //println"updatePaymentDataEntry"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportAdvance", action: "viewPaymentDataEntry", model: map)
    }

    def viewRefundEts() {
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS: ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
            } else if (chainModel?.documentNumber) {
                def exportAdvancePayment = coreAPIService.dummySendQuery([documentNumber : chainModel.documentNumber], "details", "exportadvance/payment/")?.details

                session.etsModel << exportAdvancePayment
                session.etsModel << exportAdvancePayment.documentNumber
                session.etsModel << [currency: exportAdvancePayment.currency.currencyCode]
                session.etsModel << [sendersChargesCurrency: exportAdvancePayment.sendersChargesCurrency?.currencyCode]
                session.etsModel << [receiversChargesCurrency: exportAdvancePayment.receiversChargesCurrency?.currencyCode]
                session.etsModel << [reimbursingBankCurrency: exportAdvancePayment.reimbursingBankCurrency?.currencyCode]

            }
			session.etsModel << [formName: chainModel.formName]
        }

        session.etsModel << [title: "Export Advance Refund - eTS",
                tabs: DEFAULT_TABS,
                serviceType: "REFUND",
                documentClass: "EXPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "ETS"
        ]

		List<Map<String, Object>> charges = chargesService.findAllCharges(session.etsModel.serviceInstructionId)
		
		session.etsModel << [charges:charges]
		
        def exchange = []

        ratesService.getRates(session.etsModel.currency).response.details.each {
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

        def documentServiceRoute = routingInformationService.getNextBranchApprover("EXPORT_ADVANCE", null, null, null, "ETS", "REFUND", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("EXPORT_ADVANCE", null, null, null, "REFUND", session.etsModel.approvers)

        session.etsModel << [basicDetailsTab: "../product/other/exports/export_advance/refund/ets/basic_details_tab"]
        session.etsModel << [productPaymentTabLabel: "Export Advance <br /> Refund Details"]
        session.etsModel << [productPaymentTab: "../product/other/exports/export_advance/refund/ets/product_payment_tab"]
        session.etsModel << [chargesTab: "../product/commons/tabs/charges_tab"]
        session.etsModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        session.etsModel << [basicDetailsAction: "saveRefundEts"]
        session.etsModel << [productPaymentAction: "updateRefundEts"]
        session.etsModel << [chargesAction: "updateRefundEts"]
        session.etsModel << [chargesPaymentAction: "updateRefundEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

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

    def saveRefundEts() {
        //println"saveRefundEts"
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
        sessionModel << ["serviceInstructionId": etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvance", action: "viewRefundEts", model: sessionModel)
    }

    def updateRefundEts() {
        //println"updateRefundEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportAdvance", action: "viewRefundEts", model: map)
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

        session.dataEntryModel << [title: "Export Advance Refund - Data Entry",
                tabs: PAYMENT_DE_TABS,
                serviceType: "REFUND",
                documentClass: "EXPORT_ADVANCE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

		List<Map<String, Object>> charges = chargesService.findAllCharges(session.dataEntryModel.serviceInstructionId)
		
		session.dataEntryModel << [charges:charges]
		
        def exchange = []

        ratesService.getRates(session.dataEntryModel.currency).response.details.each {
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

        session.dataEntryModel << [basicDetailsTab: "../product/other/exports/export_advance/refund/dataentry/basic_details_tab"]
        session.dataEntryModel << [productPaymentTabLabel: "Export Advance <br /> Refund Details"]
        session.dataEntryModel << [productPaymentTab: "../product/other/exports/export_advance/refund/dataentry/product_payment_tab"]
        session.dataEntryModel << [mtDetailsTab: "../product/other/exports/export_advance/refund/dataentry/mt103_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/commons/tabs/charges_payment_tab"]

        // START routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("EXPORT_ADVANCE", null, null, null, "DATA_ENTRY", "REFUND", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("EXPORT_ADVANCE", null, null, null, "REFUND", session.dataEntryModel.approvers)

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

        session.dataEntryModel << [basicDetailsAction: "saveRefundDataEntry"]
        session.dataEntryModel << [mtDetailsAction: "saveRefundDataEntry"]
        session.dataEntryModel << [productPaymentAction: "updateRefundDataEntry"]
        session.dataEntryModel << [chargesAction: "updateRefundDataEntry"]
        session.dataEntryModel << [chargesPaymentAction: "updateRefundDataEntry"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

		if(chainModel){
			if("View Data Entry" == chainModel?.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:chainModel?.viewMode]
				session.viewMode=chainModel?.viewMode
			}
		}else if(params.dataEntryButtonCaption){
			if("View Data Entry" == params.dataEntryButtonCaption){
				session.dataEntryModel<<[viewMode:'viewMode']
				session.viewMode='viewMode'
			}else{
				session.dataEntryModel<<[viewMode:params.viewMode]
				session.viewMode=params.viewMode
			}
		}else{
			session.dataEntryModel << [viewMode:session.viewMode]
		}
		
        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveRefundDataEntry() {
        //println"saveRefundDataEntry"
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
        //sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]
        sessionModel << returnedValues["details"]["documentNumber"]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "exportAdvance", action: "viewRefundDataEntry", model: sessionModel)
    }

    def updateRefundDataEntry() {
        //println"updateRefundDataEntry"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "exportAdvance", action: "viewRefundDataEntry", model: map)
    }

    def displaySettlementToBenEtsGrid() {
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

            [id: it.ID,
                    cell: [
                            chargesPaymentService.formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, 'credit'),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
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

    def displaySettlementToBenDataEntryGrid() {
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
            //printlnit.STATUS
            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) ||
                        "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("PDDTS") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("SWIFT")) {
                    status = "Paid"
                    paymentString = ""
                } else if("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)){
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'"+it.ID+"\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'"+it.ID+"\'; payCreditToCasa(id);\"/>";
                }else {
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
                } else {
                    if (it.PAYMENTINSTRUMENTTYPE in ["PDDTS", "SWIFT"]) {
                        paymentString = ""
                    } else {
                        paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    }
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
		redirect(controller:'exportAdvance', action:'invokeUploadCommand',params:params)
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
