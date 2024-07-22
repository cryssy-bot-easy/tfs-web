package com.ucpb.tfsweb.other.imports.refund

import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class RefundController {

    def etsService
    def coreAPIService
    def documentClassService
    def ratesService
    def foreignExchangeService
    def parserService
    def routingInformationService
    def dataEntryService
    def chargesPaymentService

    def refundService
	def tabUtilityService
	def documentUploadingService

    private static DEFAULT_TABS = ["basicDetails", "attachedDocuments", "refundDetailsProduct", "refundDetailsService", "modeOfRefund", "instructionsAndRouting"]

    def viewRefundEts() {
		def documentClass
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS : ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << [tradeServiceId: tradeService?.tradeServiceId?.tradeServiceId]
				documentClass = tradeService?.ets?.details?.documentClass
            }
			session.etsModel << [formName: chainModel.formName]
        } else {
			documentClass = session.etsModel.documentClass 
			if(documentClass == "LC") {
	            Map<String,Object> lc = documentClassService.getLetterOfCredit(session.etsModel.documentNumber, "LC")
	
	            lc.each {
	                session.etsModel << it
	            }
        	}else {
				Map<String,Object> nonlc = documentClassService.getDocumentaryCredit(session.etsModel.documentNumber, documentClass, null)
						
				nonlc.each {
					session.etsModel << it
				}
			}
        }

        session.etsModel << [title: "Refund of Cash LC and/or Charges - eTS",
                tabs: DEFAULT_TABS,
                serviceType: "REFUND",
                documentClass: documentClass,
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referencetype: "ETS"
        ]


        def approvedTradeServices = coreAPIService.dummySendQuery([tradeProductNumber : session.etsModel.documentNumber],
                "getApprovedTradeServiceIdsForLcRefund",
                "tradeservice/")?.response

        session.etsModel << [approvedTradeServices: approvedTradeServices]

        // daily ratesrates
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

        // routing
        def documentServiceRoute = routingInformationService.getNextBranchApprover("LC", null, null, null, "ETS", "REFUND", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("LC", null, null, null, "REFUND", session.etsModel.approvers)

        session.etsModel << [basicDetailsTab: "../product/other/imports/refund/basic_details_tab"]
        session.etsModel << [refundDetailsProductTab: "../product/other/imports/refund/refund_details_lc_amount_tab"]
        session.etsModel << [refundDetailsServiceTab: "../product/other/imports/refund/refund_details_for_charges_tab"]
        session.etsModel << [modeOfRefundTab: "../product/other/imports/refund/settlement_to_ben_tab"]

        session.etsModel << [basicDetailsAction: "saveRefundEts"]
        session.etsModel << [modeOfRefundAction: "updateRefundEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

        render(view: "../product/index", model: session.etsModel)
    }

    def viewRefundDataEntry() {
		def documentClass
        if (chainModel) {
            // sets the value of etsModel to the chained model if there is
            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId, includeETS : ""], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId
                session.dataEntryModel << tradeService?.serviceInstructionId
                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
				documentClass = tradeService?.details?.documentClass
            }

        }
        session.dataEntryModel << [title: "Refund of Cash LC and/or Charges - Data Entry",
                tabs: ["basicDetails", "attachedDocuments", "refundDetailsProduct", "refundDetailsService", "instructionsAndRouting"],
                serviceType: "REFUND",
                documentClass: documentClass,
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]


        def approvedTradeServices = coreAPIService.dummySendQuery([tradeProductNumber : session.dataEntryModel.documentNumber],
                "getApprovedTradeServiceIdsForLcRefund",
                "tradeservice/")?.response

        session.dataEntryModel << [approvedTradeServices: approvedTradeServices]

        // daily ratesrates
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

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("LC", null, null, null, "DATA_ENTRY", "REFUND", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("LC", null, null, null, "REFUND", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("LC", null, null, null, "REFUND", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/refund/basic_details_tab"]
        session.dataEntryModel << [refundDetailsProductTab: "../product/other/imports/refund/refund_details_lc_amount_tab"]
        session.dataEntryModel << [refundDetailsServiceTab: "../product/other/imports/refund/refund_details_for_charges_tab"]
        session.dataEntryModel << [modeOfRefundTab: "../product/other/imports/refund/settlement_to_ben_tab"]

        session.dataEntryModel << [basicDetailsAction: "saveRefundEts"]
        session.dataEntryModel << [modeOfRefundAction: "updateRefundEts"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def viewRefundPayment() {
		def documentClass
        if (chainModel) {
            session.chargesModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId: chainModel.tradeServiceId, includeETS : ""], "details", "tradeservice/")?.details

                session.chargesModel << tradeService?.details
                session.chargesModel << tradeService?.documentNumber
                session.chargesModel << tradeService?.serviceInstructionId
                session.chargesModel << tradeService?.tradeServiceId
				documentClass = tradeService?.details?.documentClass
            }
        }

        def exchange = []

        ratesService.getRatesEB(session.chargesModel.currency).response.details.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash
			def pass_on_rate = it.conversionRate
			def special_rate = it.conversionRate

            session.chargesModel.each { ets ->
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

        session.chargesModel << [exchange: exchange]

        session.chargesModel << [title: "Refund of Cash LC and/or Charges - Payment Processing",
                tabs: ["basicDetails", "modeOfRefund"],
                serviceType: "REFUND",
                documentClass: documentClass,
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "PAYMENT"
        ]

        session.chargesModel << [basicDetailsTab: "../product/other/imports/refund/basic_details_tab"]
        session.chargesModel << [modeOfRefundTab: "../product/other/imports/refund/settlement_to_ben_tab"]

        render(view: "../product/index", model: session.chargesModel)
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
        sessionModel << ["serviceInstructionId" : etsNumber]
		sessionModel << [formName: tabUtilityService.getTabName(params.form)]

        chain(controller: "refund", action: "viewRefundEts", model: sessionModel)
    }

    def saveRefundDataEntry() {

    }

    def updateRefundEts() {
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = etsService.updateEts(params)
		map.put("formName",tabUtilityService.getTabName(params.form))

        chain(controller: "refund", action: "viewRefundEts", model: map)
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

    def viewProductRefundGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = refundService.getRefundableProductPayments(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = mapList.display.collect {
            UUID uuid = UUID.randomUUID()
            String id = String.valueOf(uuid)

            [id: id,
                    cell:[
                            DateUtils.dateTimeFormat(it.PAIDDATE),
                            it.TRANSACTIONTYPE,
                            it.LCCURRENCY,
                            NumberUtils.currencyFormat(it.OUTSTANDINGBALANCE),
                            getSpecialRate(it.LCCURRENCY, it.CURRENCY) ? it.get(getSpecialRate(it.LCCURRENCY, it.CURRENCY)) : "1.000000",
                            it.CURRENCY,
                            NumberUtils.currencyFormat(it.AMOUNT),
                            'NEW AMOUNT',
                            'REFUND AMOUNT'
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def getSpecialRate(baseCurrency, targetCurrency) {
        switch (baseCurrency) {
            case "USD":
                switch (targetCurrency) {
                    case "USD":
                        return null
                    case "PHP":
                        return "SPECIALRATEUSDTOPHP"
                    default:
                        return "SPECIALRATETHIRDTOUSD"
                }
            case "PHP":
                switch (targetCurrency) {
                    case "USD":
                        return "SPECIALRATEUSDTOPHP"
                    case "PHP":
                        return null
                    default:
                        return "SPECIALRATETHIRDTOPHP"
                }
            default:
                switch (targetCurrency) {
                    case "USD":
                        return "SPECIALRATETHIRDTOUSD"
                    case "PHP":
                        return "SPECIALRATETHIRDTOPHP"
                    default:
                        return null
                }
        }
    }

    def onChangeTransaction(String tradeServiceId) {
		println "tradeServiceId:;:;: " + tradeServiceId
        def jsonData = [:]

        if (tradeServiceId) {
            def rates = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                    "getServiceChargeRates",
                    "rates/")?.response

            def ratesList = refundService.constructRatesList(rates)

            def charges = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                    "getServiceChargeBaseAmounts",
                    "charges/")?.response

            def chargesMap = refundService.constructCharges(charges)

            def chargesList = chargesMap.chargesMapList
            def corresChargeList = chargesMap.corresChargeMapList

            jsonData = [rates: ratesList, charges: chargesList, corresCharges: corresChargeList]
        } else {
            jsonData = [rates: [], charges: [], corresCharges: []]
        }


        render(jsonData as JSON)
    }

    def recomputeNewCharges() {
        def rates = [:]

        params.each {
            if ((it.key != null) && ((String)it.key).contains("special_rate") && (it.value != null)) {
                rates.put(it.key, new BigDecimal(it.value))
            }
        }

        def convertedValues = refundService.constructConvertedValues(params, rates)

        render([convertedValues: convertedValues] as JSON)
    }

    def applyUpdatedCharges() {
        def paramList = refundService.constructParameterForWebService(params)

        def jsondata = [newCharges: paramList, tradeServiceId: params.tradeServiceId]

        Map returnedValues = coreAPIService.dummySendCommand(jsondata, "saveChargesRefundDetails", "refund")

        render(returnedValues as JSON)
    }

    def getSavedNewCharges() {
        def maxRows = params.int('rows') ?: 20
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def tradeServiceId = session.etsModel?.tradeServiceId ?: session.dataEntryModel?.tradeServiceId
        def queryResult = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getSavedNewServiceCharges",
                "charges/")?.response

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        def display = queryResult?.subList(rowOffset, toIndex)

        def totalRows = queryResult?.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def totalAmountOfCharges = 0

        def results = display.collect {
            totalAmountOfCharges += it.refundAmount

            [id: it.id,
                    cell:[
                            it.transactionDate,
                            it.transactionType,
                            it.chargeType,
                            it.settlementCurrency.currencyCode,
                            NumberUtils.currencyFormat(it.oldAmount),
                            NumberUtils.currencyFormat(it.newAmount),
                            NumberUtils.currencyFormat(it.refundAmount)
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages,
                userdata: [totalAmountOfCharges: NumberUtils.currencyFormat(totalAmountOfCharges)]]
        render jsonData as JSON
    }

    // product tab
    def recomputeNewProductAmount() {
        def rates = [:]

        params.each {
            if (it.key.contains("special_rate")) {
                rates.put(it.key.replaceAll("_text", "").replaceAll("_charges", ""), new BigDecimal(it.value))
            }
        }

        def newAmountInPhp = refundService.computeNewProductAmount(params, rates)

        render([newAmount: NumberUtils.currencyFormat(newAmountInPhp)] as JSON)
    }

    def getProductPaymentsMade(String tradeServiceId) {
        def paymentDetail = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getSavedProductPayments",
                "payment/")?.response

        def returnPaymentDetails = refundService.constructPaymentDetails(paymentDetail)

        def tradeService = coreAPIService.dummySendQuery([tradeServiceId: tradeServiceId, includeETS : ""], "details", "tradeservice/")?.details

        def currency = tradeService?.details?.currency
        def amount

        if (tradeService.serviceType.equalsIgnoreCase("OPENING")) {
            amount = new BigDecimal(tradeService.details.amount)
        } else if (tradeService.serviceType.equalsIgnoreCase("AMENDMENT")) {
            amount = new BigDecimal(tradeService.details?.amountTo ?: tradeService.details?.outstandingBalance ?: tradeService.details?.amountFrom ?: "0")

            if (tradeService.details.amountSwitch?.equals("off")) {
                amount = new BigDecimal(tradeService.details.outstandingBalance ?: tradeService.details.amountFrom)
            }
        } else if (tradeService.serviceType.equalsIgnoreCase("NEGOTIATION") && tradeService.documentClass.equalsIgnoreCase("LC")) {
            amount = new BigDecimal(tradeService.details.negotiationAmount)
            currency = tradeService.details.negotiationCurrency
        } else if (tradeService.serviceType.equalsIgnoreCase("ISSUANCE")) {
            amount = new BigDecimal(tradeService.details.shipmentAmount)
            currency = tradeService.details.shipmentCurrency
        } else if (tradeService.serviceType.contains("ADVISING")) {
            amount = new BigDecimal(tradeService.details.lcAmount ? tradeService.details.lcAmount?.replaceAll(",","") : 0)
            currency = tradeService.details.lcCurrency
        } else {
            amount = 0
        }

        render([paymentDetail: returnPaymentDetails,
                outstandingLcAmount: NumberUtils.currencyFormat(new Double(amount)),
                outstandingLcCurrency: currency] as JSON)
    }

    def recomputeNewRateProductAmount() {
        def rates = [:]

        params.each {
            if ((it.key != null) && ((String)it.key).contains("special_rate") && (it.value != null)) {
                rates.put(it.key, new BigDecimal(it.value))
            }
        }

         def newAmountList = refundService.computeNewRateProductAmount(params, rates)

        render([newAmountList: newAmountList] as JSON)
    }

    def applyNewRateProductAmount() {
        def parameterList = refundService.constructNewRateProductParameters(params)

        def jsondata = [newProductRefund: parameterList, tradeServiceId: params.tradeServiceId]

        Map returnedValues = coreAPIService.dummySendCommand(jsondata, "saveProductRefundDetails", "refund")

        render(returnedValues as JSON)
    }

    def savedNewRateProductPayment() {
        def maxRows = params.int('rows') ?: 20
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def tradeServiceId = session.etsModel?.tradeServiceId ?: session.dataEntryModel.tradeServiceId

        def queryResult = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getProductRefundDetails",
                "refund/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        def display = queryResult?.subList(rowOffset, toIndex)

        def totalRows = queryResult.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def totalAmountOfCharges = 0

        def results = display.collect {
            totalAmountOfCharges += it.refundAmountInDefaultCurrency

            [id: it.id,
                    cell:[
                            it.transactionDate,
                            it.transactionType,
                            it.currency.currencyCode,
                            NumberUtils.currencyFormat(it.originalAmount),
                            NumberUtils.currencyFormat(it.newRefundAmountInOriginalCurrency),
                            NumberUtils.currencyFormat(it.refundAmountInDefaultCurrency)
                    ]
            ]
        }

        if (session.etsModel) {
            session.etsModel << [totalRefundableProductPayment : totalAmountOfCharges]
        } else {
            session.dataEntryModel << [totalRefundableProductPayment : totalAmountOfCharges]
        }


        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages,
                userdata: [totalAmountOfProductPayment: NumberUtils.currencyFormat(totalAmountOfCharges)]]
        render jsonData as JSON
    }

    def computeTotalRefund() {

        def tradeServiceId = (session.etsModel?.tradeServiceId != null)  ? session.etsModel?.tradeServiceId : session.chargesModel.tradeServiceId

        def productPayment = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getProductRefundDetails",
                "refund/")?.details

        def serviceChargePayment = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getSavedNewServiceCharges",
                "charges/")?.response

        def totalRefundableAmount = 0

        productPayment.each {
            totalRefundableAmount += it.refundAmountInDefaultCurrency ?: 0
        }

        serviceChargePayment.each {
            totalRefundableAmount += it.refundAmount ?: 0
        }

        def payments = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "details",
                "payment/")?.details

        def balance = totalRefundableAmount
        payments.each { pmt ->
            pmt.details.each { pmtDtl ->
                balance = balance - pmtDtl.amount
            }
        }

        render([totalRefundableAmount: NumberUtils.currencyFormat(totalRefundableAmount),
                balance: NumberUtils.currencyFormat((balance > 0) ? balance : 0)] as JSON)
    }

    def applyPartialRefund() {
        def paramList = refundService.constructPartialProductParameters(params)

        def jsondata = [newProductRefund: paramList, tradeServiceId: params.tradeServiceId]

        Map returnedValues = coreAPIService.dummySendCommand(jsondata, "saveProductRefundDetails", "refund")

        render(returnedValues as JSON)
    }

    def clearAllProductRefund() {
        println 'clearAllProductRefund'
        def tradeServiceId = session.etsModel?.tradeServiceId ?: session.dataEntryModel?.tradeServiceId
        Map returnedValues = coreAPIService.dummySendCommand([tradeServiceId: tradeServiceId], "deleteProductRefundDetails", "refund")

        render(returnedValues as JSON)
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
                    if (it.PAYMENTINSTRUMENTTYPE in ["PDDTS", "SWIFT", "MC_ISSUANCE"]) {
                        paymentString = ""
                    } else {
                        paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    }
                }
            }

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            chargesPaymentService.formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, 'credit'),
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
		redirect(controller:'refund', action:'invokeUploadCommand',params:params)
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

		chain(action:"viewRefundDataEntry", model: session.dataEntryModel)
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

		chain(action:"viewRefundEts", model: session.etsModel)
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
