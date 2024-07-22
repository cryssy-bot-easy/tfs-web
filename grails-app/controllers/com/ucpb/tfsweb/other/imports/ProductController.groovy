package com.ucpb.tfsweb.other.imports

import grails.converters.JSON



/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number: SCR# IBD-16-1206-01
	SCR/ER Description: To comply with the requirement for CIF archiving/purging of inactive accounts in TFS.
	[Created by:] Allan Comboy and Lymuel Saul
	[Date Deployed:] 12/20/2016
	Program [Revision] Details: Add CDT Remittance and CDT Refund module.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: ProductController
	
	(revision)
	SCR/ER Number: 
	SCR/ER Description: Redmine #4118 - If with outstanding EBC is tagged as Yes, the drop down lists of EBC document numbers 
	are not complete. Example: Document number 909-11-307-17-00004-2 is not included in the list but it should be part of the 
	drop down list since this is an approved EBC Nego and it is still outstanding.
	[Revised by:] John Patrick C. Bautista
	[Date Deployed:] 06/16/2017
	Program [Revision] Details: Added new method to query from Export Bills without the BP Currency restriction.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
	Project Name: ProductController
 */

/**
 * (revision)
 *	SCR/ER Number:
 *	SCR/ER Description: EBP Negotiation - Data Entry Inquiry (Redmine# 4152)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date revised:] 02/14/2017 (tfs-web Rev# 7284)
 *	[Date deployed:] 06/16/2017
 *	Program [Revision] Details: Created a new parameter that retrieves all the values in retrieveCollectionAmount function.
 *	Member Type: Groovy
 *	Project: WEB
 *	Project Name: ProductController.groovy
 */

class ProductController {

    def etsService
    def dataEntryService
    def coreAPIService

    def chargesService
    def chargesPaymentService

    def productService

    // import advance payment
    def viewImportAdvancePayment(String referenceType) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "importAdvance", action: "viewPaymentEts")
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "importAdvance", action: "viewPaymentDataEntry")
        }
    }

    // import advance refund
    def viewImportAdvanceRefund(String referenceType, String documentNumber) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "importAdvance", action: "viewRefundEts", model: [documentNumber: documentNumber])
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "importAdvance", action: "viewRefundDataEntry")
        }
    }

    // payment of other import charges
    def viewImportChargesPayment(String referenceType) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "importCharges", action: "viewPaymentChargesEts")
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "importCharges", action: "viewPaymentChargesDataEntry")
        }
    }

    // payment of other import charges others
    def viewImportChargesPaymentOthers(String referenceType) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "importCharges", action: "viewPaymentOtherChargesEts")
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "importCharges", action: "viewPaymentOtherChargesDataEntry")
        }
    }

	
		// cdt remittance
		def viewReportcdt() {
			session.model = [referenceType: "DATAENTRY"]
			chain(controller: "cdt", action: "viewRemittancereport")
		}
    // cdt payment
    def viewCdtPayment() {
        println 'productController viewCdtPayment'
        def chainModel = [iedieirdNumber: params.iedieirdNumber, username: session.username, userrole: session.userrole.id]
        session.model = [:]
        chain(controller: "cdt", action: "viewCdtPayment", model: chainModel)
    }

    // cdt refund
    def viewCdtRefund() {
        def chainModel = [iedieirdNumber: params.iedieirdNumber, username: session.username, userrole: session.userrole.id]

		if(params.forViewing.equalsIgnoreCase("true")){
			session.dataEntryModel = null
			chainModel = params
		}
		
		if(session.userrole.id.contains('BR')){
			chain(controller: "cdt", action: "viewCdtBranchRefund", model: chainModel)
		} else {
		session.model = [tsdInitiated: "true"]

        chain(controller: "cdt", action: "viewCdtRefund", model: chainModel)
		}
    }

    // cdt remittance
    def viewCdtRemittance() {
        session.model = [referenceType: "DATAENTRY"]
        chain(controller: "cdt", action: "viewRemittance")
    }

    // cdt client
    def viewCdtClient(String agentBankCode) {
        session.model = [agentBankCode: agentBankCode]

        chain(controller: "cdt", action: "viewCdtClient")
    }

    // upload todays transaction
    def viewCdtUploadTransactions() {
        chain(controller: "cdt", action: "viewCdtUploadTransactions")
    }

    // upload client file
    def viewCdtUploadClients() {
        chain(controller: "cdt", action: "viewCdtUploadClients")
    }

    // upload payment history
    def viewCdtUploadPaymentHistory() {
        chain(controller: "cdt", action: "viewCdtUploadPaymentHistory")
    }

    // pay charges (create Debit accounting entry)
    def payItem() {
        def jsonData = [:]
        params.each {
            //printlnit
        }
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

    // route ets
    def updateEtsStatus() {
        //println"updateEtsStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = etsService.updateEts(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")

    }

    // route data entry
    def updateDataEntryStatus() {
        //println"updateDataEntryStatus"
        params.unitcode = session.unitcode
        params.username = session.username

        Map<String, Object> map = new HashMap<>()
        map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    // charges payment grid
    def displayServiceChargePaymentsGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = chargesPaymentService.findServiceChargesPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

        if (params.referenceType == "PAYMENT" || (params.referenceType == "DATA_ENTRY")) {
            results = chargesPaymentService.constructChargesPaymentGrid(mapList.display)
        } else if (params.referenceType == "ETS") {
            results = chargesPaymentService.constructServiceChargesGrid(mapList.display)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    // product payment grid
    def displayProductPaymentsGrid() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList

        mapList = chargesPaymentService.findProductChargesPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        println totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

		println params.referenceType + ", " + params.form + ", " + params.serviceType
        if (params.referenceType == "PAYMENT" || params.referenceType == "DATA_ENTRY") {
            if (params.form?.equalsIgnoreCase("basicDetails")) {
                results = chargesPaymentService.constructApPayment(mapList.display)
            } else if (params.form?.equalsIgnoreCase("product") && !(params.documentClass in ['DA', 'DP', 'OA', 'DR'])) {
                results = chargesPaymentService.constructProductChargesPaymentMdGrid(mapList.display)
            } else {
                results = chargesPaymentService.constructProductChargesPaymentGrid(mapList.display)
            }
        } else if (params.referenceType == "ETS") {
            if (params.form?.equalsIgnoreCase("basicDetails")) {
                results = chargesPaymentService.constructApPayment(mapList.display)
            } else {
                if (params.serviceType?.equalsIgnoreCase("Settlement")) {
                    if (params.documentClass in ['DA', 'DP', 'OA', 'DR']) {
                        results = chargesPaymentService.constructProductChargesGridNonLc(mapList.display)
                    } else {
                        results = chargesPaymentService.constructProductChargesGridSettlement(mapList.display)
                    }
                } else {
                    if ((params.serviceType?.equalsIgnoreCase("Negotiation") && params.documentType?.equalsIgnoreCase("DOMESTIC") && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY"))) || ((params.serviceType.equalsIgnoreCase("UA Loan Settlement") || params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && params.documentType.equalsIgnoreCase("DOMESTIC") && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY")))) {
                        results = chargesPaymentService.constructProductChargesGridDomestic(mapList.display)
                    } else {
                        results = chargesPaymentService.constructProductChargesGrid(mapList.display, null, null)
                    }
                }
            }
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def viewRefundProductServiceCharge(String referenceType, String documentNumber, String documentClass) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS", documentNumber: documentNumber, documentClass: documentClass]
            chain(controller: "refund", action: "viewRefundEts")
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "refund", action: "viewRefundDataEntry")
        }
    }

    // EXPORTS
    def viewExportAdvancePayment(String referenceType) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "exportAdvance", action: "viewPaymentEts")
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "exportAdvance", action: "viewPaymentDataEntry")
        }
    }

    def viewExportAdvanceRefund(String referenceType, String documentNumber) {
        if (referenceType?.equals("ets")) {
            session.etsModel = [referenceType: "ETS"]
            chain(controller: "exportAdvance", action: "viewRefundEts", model: [documentNumber: documentNumber])
        } else if (referenceType?.equals("dataEntry")) {
            session.dataEntryModel = [referenceType: "DATAENTRY"]
            chain(controller: "exportAdvance", action: "viewPaymentDataEntry")
        }
    }

    def viewExportAdvisingOpeningSecond(String referenceType) {
        session.dataEntryModel = [referenceType: "DATAENTRY"]
        chain(controller: "exportAdvising", action: "viewOpeningSecond")
    }

    def viewExportAdvisingOpeningFirst(String referenceType) {
        session.dataEntryModel = [referenceType: "DATAENTRY"]
        chain(controller: "exportAdvising", action: "viewOpeningFirst", model: session.dataEntryModel)
    }

    def createExportAdvising(String documentNumber, String serviceType, String advisingBankType) {
        session.dataEntryModel = [referenceType: "DATAENTRY", documentNumber: documentNumber, advisingBankType: advisingBankType]
        if (serviceType.equals("amendment")) {
            if (advisingBankType.equals("FIRST")) {
                chain(controller: "exportAdvising", action: "viewAmendmentFirst", model: session.dataEntryModel)
            } else if (advisingBankType.equals("SECOND")) {
                chain(controller: "exportAdvising", action: "viewAmendmentSecond", model: session.dataEntryModel)
            }
        } else if (serviceType.equals("cancellation")) {
            if (advisingBankType.equals("FIRST")) {
                chain(controller: "exportAdvising", action: "viewCancellationFirst", model: session.dataEntryModel)
            } else {
                chain(controller: "exportAdvising", action: "viewCancellationSecond", model: session.dataEntryModel)
            }
        }
    }

    def createBillsForPurchase(String documentType) {
        def etsModel = [referenceType:  "ETS", documentType: documentType]

        if ("FOREIGN".equals(documentType)) {
            chain(controller: "exportBillsPurchase", action: "viewNegotiationEts", model: etsModel)
        } else {
            chain(controller: "domesticBillsPurchase", action: "viewNegotiationEts", model: etsModel)
        }
    }

    def createBillsForCollection(String documentType) {
        def dataEntryModel = [referenceType:  "DATA_ENTRY", documentType: documentType]

        if ("FOREIGN".equals(documentType)) {
            chain(controller: "exportBillsCollection", action: "viewNegotiationDataEntry", model: dataEntryModel)
        } else {
            chain(controller: "domesticBillsCollection", action: "viewNegotiationDataEntry", model: dataEntryModel)
        }
    }

    def settleBillsForCollection(String documentNumber, String documentType) {
        def etsModel = [referenceType:  "ETS", documentNumber: documentNumber]

        if ("FOREIGN".equals(documentType)) {
            chain(controller: "exportBillsCollection", action: "viewSettlementEts", model: etsModel)
        } else {
            chain(controller: "domesticBillsCollection", action: "viewSettlementEts", model: etsModel)
        }
    }

    def cancelBillsForCollection(String documentNumber, String documentType, String documentClass) {
        def dataEntryModel = [referenceType: "DATA_ENTRY", 
			    documentNumber: documentNumber,
				documentType: documentType,
				documentClass: documentClass,
				serviceType: "CANCELLATION"
		]
		//added by Henry alabin
		println documentClass + ">>>>>>>>>>>>>>>>documentClass"
		println documentType + ">>>>>>>>>>>>>>>>documentType"
		println documentNumber + ">>>>>>>>>>>>>>>>documentNumber"
		if ("DOMESTIC".equals(documentType)) {
			chain(controller: "domesticBillsCollection", action: "viewCancellationDataEntry", model: dataEntryModel)//max DBC       
		}else{
		   chain(controller: "exportBillsCollection", action: "viewCancellationDataEntry", model: dataEntryModel)
		}
    }

    def transactBillsForPurchase(String documentNumber, String documentType, String documentClass) {

        def dataEntryModel = [referenceType:  "DATA_ENTRY",
                documentNumber: documentNumber,
                documentType: documentType,
                documentClass: documentClass,
                serviceType: "SETTLEMENT"
        ]

        if ("FOREIGN".equals(
documentType)) {
            chain(controller: "exportBillsPurchase", action: "viewSettlementDataEntry", model: dataEntryModel)
        } else if ("DOMESTIC".equals(documentType)) {
            chain(controller: "domesticBillsPurchase", action: "viewSettlementDataEntry", model: dataEntryModel)
        }
    }


    def retrieveAllCollections() {
        def documentNumbers = productService.searchExportBillsByCifNumber(params.cifNumber, params.exportBillType)

        render([documentNumbers: documentNumbers] as JSON)
    }
	
	//	12092016 EBP Extraction - Case 2
	def retrieveAllExportBills() {
		def documentNumbers = productService.getAllExportBills(params.cifNumber, params.exportBillType) //error

		render([documentNumbers: documentNumbers] as JSON)
	}
	
	// 01242017 - Redmine 4118: Remove restriction on BP Currency
	def retrieveAllExportBillsNoBPCurrencyRestriction() {
		def documentNumbers = productService.getAllExportBillsNoBPCurrencyRestriction(params.cifNumber, params.exportBillType) //error

		render([documentNumbers: documentNumbers] as JSON)
	}

    def retrieveCollectionAmount() {
        def exportBills = coreAPIService.dummySendQuery([:], "details/"+params.documentNumber, "product/exportBills/").details
		def allExportBills = coreAPIService.dummySendQuery([:], "details/"+params.documentNumber, "product/exportBills/").exportDetails

        render([amount: exportBills.amount, currency: exportBills.currency.currencyCode, paymentMode: exportBills.paymentMode, buyerName: exportBills.buyerName, buyerAddress:exportBills.buyerAddress, countryCode:exportBills.countryCode, exportBills: allExportBills] as JSON)
    }

    def gotoRebate() {
        def dataEntryModel = [referenceType: "DATA_ENTRY"]

        chain(controller: "rebate", action: "viewRebate", model: dataEntryModel)
    }

    def gotoImportChargesOthers() {
        def model = [referenceType: "DATA_ENTRY", documentClass: "IMPORT_CHARGES"]

        chain(controller: "otherCharges", action: "viewOtherChargesDataEntry", model: model)
    }

    def gotoExportChargesOthers() {
        def model = [referenceType: "DATA_ENTRY", documentClass: "EXPORT_CHARGES"]

        chain(controller: "otherCharges", action: "viewOtherChargesDataEntry", model: model)
    }

    def gotoCorresCharge(String documentNumber, String referenceType) {
        String actionName = ""
        def model = [documentNumber: documentNumber]

        if ("ets".equals(referenceType)) {
            model << [referenceType: "ETS"]

            actionName = "viewCorresChargeEts"
        } else if ("dataentry".equals(referenceType)) {
            model << [referenceType: "DATA_ENTRY"]

            actionName = "viewCorresChargeDataEntry2"

            if ("true".equals(params.withoutReference)) {
                actionName = "viewCorresChargeDataEntry3"
            }
        }

        chain(controller: "corresCharge", action: actionName, model: model)
    }

    def getHasReversal() {
        def hasReversal = etsService.getReversal(params.serviceInstructionId, params.serviceType)
        println "hasReversal ? " + hasReversal
        render([hasReversal: hasReversal.hasReversal.toString()] as JSON)
    }

    def gotoOtherImportCharges() {
        def model = [referenceType: "ETS", documentClass: "IMPORT_CHARGES", documentNumber: params.documentNumber]

        chain(controller: "importCharges", action: "viewPaymentChargesEts", model: model)
    }

    def gotoOtherExportCharges() {
        def model = [referenceType: "ETS", documentClass: "EXPORT_CHARGES", documentNumber: params.documentNumber]

        chain(controller: "exportCharges", action: "viewPaymentChargesEts", model: model)
    }

    def gotoRefundExportCharges() {
        def model = [referenceType: "ETS", documentClass: "EXPORT_CHARGES", documentNumber: params.documentNumber]

        chain(controller: "exportsRefund", action: "viewRefundEts", model: model)
    }

    def getPaymentStatus() {
        Map<String, Object> result = chargesService.findPaymentStatus(params.tradeServiceId)
        println "payment status is " + result.PAYMENTSTATUS

        session.dataEntryModel << [paymentStatus: result.PAYMENTSTATUS]

        def jsonData = [paymentStatus: result.PAYMENTSTATUS]

        render jsonData as JSON
    }
}
