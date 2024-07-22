package com.ucpb.tfsweb.other.imports.importcharges

import grails.converters.JSON
import net.ipc.utils.NumberUtils

import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

class ImportChargesController {

    def foreignExchangeService
    def ratesService
    def parserService
    def routingInformationService
    def coreAPIService

    def otherChargesService
    def etsService

    def chargesService
    def dataEntryService
	def documentUploadingService
	def tabUtilityService

    private static TABS = ["basicDetails", "attachedDocuments", "paymentDetailsService", "modeOfPayment", "instructionsAndRouting"]

    def viewPaymentChargesEts() {
        if (chainModel) {
            session.etsModel = chainModel

            if (chainModel.serviceInstructionId) {
                def tradeService = coreAPIService.dummySendQuery([etsNumber: chainModel.serviceInstructionId, includeETS : ""], "details", "tradeservice/")?.details

                session.etsModel << tradeService?.ets?.details
				session.etsModel << [status: tradeService?.ets?.status]
                session.etsModel << [approvers: tradeService?.ets?.approvers]
                session.etsModel << tradeService?.documentNumber
                session.etsModel << tradeService?.tradeServiceId
            }

            if (chainModel.documentNumber) {
                def importItem = coreAPIService.dummySendQuery(null, session.etsModel.documentNumber, "product/", "import/", "get/").details

                session.etsModel << [amount: importItem.amount]
                session.etsModel << [documentNumber: importItem.documentNumber]
                session.etsModel << [currency: importItem.currency]

                session.etsModel << [cifNumber: importItem.cifNumber]
                session.etsModel << [cifName: importItem.cifName]
                session.etsModel << [accountOfficer: importItem.accountOfficer]
                session.etsModel << [ccbdBranchUnitCode: importItem.ccbdBranchUnitCode]

                session.etsModel << [longName: importItem.longName]
                session.etsModel << [address1: importItem.address1]
                session.etsModel << [address2: importItem.address2]
            }

        }

        session.etsModel << [title: "Payment of Other Import Charges - eTS",
                tabs: TABS,
                serviceType: "PAYMENT",
                documentClass: "IMPORT_CHARGES",
                documentType: "",
                documentSubType1: "",
                documentSubType2: ""
        ]

        def approvedTradeServices = coreAPIService.dummySendQuery([tradeProductNumber : session.etsModel.documentNumber],
                "getApprovedTradeServiceIdsForImportCharges",
                "tradeservice/")?.response

        session.etsModel << [approvedTradeServices: approvedTradeServices]

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

        // setup gsp to display in tabs
        session.etsModel << [basicDetailsTab: "../product/other/imports/import_charges/basic_details_tab"]
        session.etsModel << [paymentDetailsServiceTab: "../product/other/imports/import_charges/payment_details_for_charges_tab"]
        session.etsModel << [modeOfPaymentTab: "../product/other/imports/import_charges/ets/charges_payment_tab"]

        def documentServiceRoute = routingInformationService.getNextBranchApprover("IMPORT_CHARGES", null, null, null, "ETS", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode("IMPORT_CHARGES", null, null, null, "PAYMENT", session.etsModel.approvers)

        session.etsModel << [basicDetailsAction: "saveImportChargesEts"]
        session.etsModel << [modeOfPaymentAction: "updateImportChargesEts"]
        session.etsModel << [routeAction: "updateEtsStatus"]

//        render(view: "../product/index", model: session.etsModel)
        render(view: "/product/index", model: session.etsModel)
    }

    def updateImportChargesEts() {
        //println"updateImportAdvancePaymentEts"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)

        chain(controller: "importCharges", action: "viewPaymentChargesEts", model: map)
    }

    def saveImportChargesEts() {
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

        chain(controller: "importCharges", action: "viewPaymentChargesEts", model: sessionModel)
    }

    def recomputeNewCharges() {
        println "recomputeNewCharges"
        println "params:" + params

        def rates = [:]

        params.each {
            if ((it.key != null) && ((String)it.key).contains("special_rate") && (it.value != null)) {
                rates.put(it.key, new BigDecimal(it.value))
            }
        }

        def convertedValues = otherChargesService.constructConvertedValues(params, rates)

        render([convertedValues: convertedValues] as JSON)
    }

    def applyUpdatedCharges() {
        println "applyUpdatedCharges"
        def paramList = otherChargesService.constructParameterForWebService(params)

        def jsondata = [newCharges: paramList, tradeServiceId: params.tradeServiceId, transaction:params.transaction]

        Map returnedValues = coreAPIService.dummySendCommand(jsondata, "saveChargesCollectibleDetails", "collectible")

        render(returnedValues as JSON)
    }

    def getSavedNewCharges() {
        println "getSavedNewCharges"
        println params
        def maxRows = params.int('rows') ?: 20
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def tradeServiceId = session.etsModel?.tradeServiceId ?: session.dataEntryModel?.tradeServiceId
        def res = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getSavedNewCollectibleCharges",
                "charges/")?.response

        def queryResult = res.charges

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        def display = queryResult?.subList(rowOffset, toIndex)

        def totalRows = queryResult?.size()  ?: 0
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def totalAmountOfCharges = 0

        def results = display.collect {
            totalAmountOfCharges += it.collectibleAmount

            [id: it.id,
                    cell:[
                            it.transactionDate,
                            it.transactionType,
                            it.chargeType,
                            it.settlementCurrency.currencyCode,
                            NumberUtils.currencyFormat(it.oldAmount),
                            NumberUtils.currencyFormat(it.newAmount),
                            NumberUtils.currencyFormat(it.collectibleAmount)
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages,
                userdata: [totalAmountOfCharges: NumberUtils.currencyFormat(totalAmountOfCharges),
                currency: res?.currency?.currencyCode]]
        render jsonData as JSON
    }

    def onChangeTransaction(String tradeServiceId) {
        println "onChangeTransaction tradeServiceId:" +tradeServiceId

        def jsonData = [:]

        if (tradeServiceId) {

            def settlementCurrency = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                    "getSettlementCurrency",
                    "tradeservice/")?.settlementCurrency

            println "settlementCurrency::::: >> " + settlementCurrency

            def rates = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                    "getServiceChargeRates",
                    "rates/")?.response

            def ratesList = otherChargesService.constructRatesList(rates)

            def charges = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                    "getServiceChargeBaseAmounts",
                    "charges/")?.response

            def chargesMap = otherChargesService.constructCharges(charges)

            def chargesList = chargesMap.chargesMapList
            def corresChargeList = chargesMap.corresChargeMapList

            jsonData = [rates: ratesList, charges: chargesList, corresCharges: corresChargeList, settlementCurrency:settlementCurrency ]
        } else {
            jsonData = [rates: [], charges: [], corresCharges: [], settlementCurrency:'']
        }

        println "jsonData:"+ jsonData
        render(jsonData as JSON)
    }

    def computeTotalCollectible() {

        def tradeServiceId = (session.etsModel?.tradeServiceId != null)  ? session.etsModel?.tradeServiceId : session.dataEntryModel.tradeServiceId

        def serviceChargePayment = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getSavedNewCollectibleCharges",
                "charges/")?.response

        def totalCollectible = 0

        serviceChargePayment.charges.each {
            totalCollectible += it.collectibleAmount ?: 0
        }

        def payments = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "details",
                "payment/")?.details

        def balance = totalCollectible
        payments.each { pmt ->
            pmt.details.each { pmtDtl ->
                balance = balance - pmtDtl.amount
            }
        }

        coreAPIService.dummySendCommand([tradeServiceId: tradeServiceId, totalCollectible: totalCollectible],
                "updatePaymentStatus", "collectible")

        render([totalCollectibleAmount: NumberUtils.currencyFormat(totalCollectible),
                balance: NumberUtils.currencyFormat((balance > 0) ? balance : 0)] as JSON)
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
        println "updateDataEntryStatus"
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

    def viewPaymentChargesDataEntry() {
        if (chainModel) {
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
            }
        }

        session.dataEntryModel << [title: "Payment of Other Import Charges - Data Entry",
                tabs: TABS,
                serviceType: "PAYMENT",
                documentClass: "IMPORT_CHARGES",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY"
        ]

        def approvedTradeServices = coreAPIService.dummySendQuery([tradeProductNumber : session.dataEntryModel.documentNumber],
                "getApprovedTradeServiceIdsForImportCharges",
                "tradeservice/")?.response

        session.dataEntryModel << [approvedTradeServices: approvedTradeServices]

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

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/import_charges/basic_details_tab"]
        session.dataEntryModel << [paymentDetailsServiceTab: "../product/other/imports/import_charges/payment_details_for_charges_tab"]
        session.dataEntryModel << [modeOfPaymentTab: "../product/other/imports/import_charges/dataentry/charges_payment_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("IMPORT_CHARGES", null, null, null, "DATA_ENTRY", "PAYMENT", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("IMPORT_CHARGES", null, null, null, "PAYMENT", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("IMPORT_CHARGES", null, null, null, "PAYMENT", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveImportChargesDataEntry"]
        session.dataEntryModel << [modeOfPaymentAction: "updateImportChargesEts"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.dataEntryModel)
    }
	
	def saveImportChargesDataEntry() {
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

        chain(controller: "importCharges", action: "viewPaymentChargesDataEntry", model: sessionModel)
    }


    def getPaymentStatus() {
        Map<String, Object> result = chargesService.findPaymentStatus(params.tradeServiceId)
        println "payment status is " + result.PAYMENTSTATUS

        session.dataEntryModel << [paymentStatus: result.PAYMENTSTATUS]

        def jsonData = [paymentStatus: result.PAYMENTSTATUS]

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
		redirect(controller:'importCharges', action:'invokeUploadCommand',params:params)
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

		chain(action:"viewPaymentChargesDataEntry", model: session.dataEntryModel)
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

		chain(action:"viewPaymentChargesEts", model: session.etsModel)
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
