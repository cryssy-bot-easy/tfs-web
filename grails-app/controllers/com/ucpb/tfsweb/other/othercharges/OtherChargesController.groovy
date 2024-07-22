package com.ucpb.tfsweb.other.othercharges

import grails.converters.JSON
import net.ipc.utils.NumberUtils

class OtherChargesController {

    def ratesService
    def dataEntryService
    def coreAPIService
    def routingInformationService

    def chargesService

    def viewOtherChargesDataEntry() {
        println "before " + session.dataEntryModel
        if (chainModel) {

            session.dataEntryModel = chainModel

            if (chainModel.tradeServiceId) {
                def tradeService = coreAPIService.dummySendQuery([tradeServiceId : chainModel.tradeServiceId], "details", "tradeservice/")?.details

                session.dataEntryModel << tradeService?.details
                session.dataEntryModel << tradeService?.tradeServiceId

                session.dataEntryModel.approvers = tradeService?.approvers
                session.dataEntryModel << tradeService?.documentNumber
				session.dataEntryModel << tradeService?.tradeServiceReferenceNumber

                session.dataEntryModel << [paymentStatus: tradeService?.paymentStatus]

                session.dataEntryModel << [status: tradeService?.status]

                session.dataEntryModel.approvalLevel = (session.dataEntryModel.approvers.isEmpty()) ? 1 :  session.dataEntryModel.approvers.split(",").size()+1
            }
        }

        String title = ""
        println "after " + session.dataEntryModel
        if ("IMPORT_CHARGES".equals(session.dataEntryModel.documentClass)) {
            title = "Payment of Other Import Charges (Others) - Data Entry"
        } else {
            title = "Payment of Other Export Charges (Others) - Data Entry"
        }

        session.dataEntryModel << [title: title,
                tabs: ["basicDetails", "chargesPayment", "instructionsAndRouting"],
                serviceType: "PAYMENT_OTHER",
                documentClass: session.dataEntryModel.documentClass,
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
				tsdInitiated: "true"
        ]

        // setup gsp to display in tabs
        session.dataEntryModel << [productPaymentTabLabel: "Payment Details for Charges <br /> &#160;"]
        session.dataEntryModel << [basicDetailsTab: "../product/other/othercharges/basic_details_tab"]
        session.dataEntryModel << [chargesPaymentTab: "../product/other/othercharges/charges_payment_tab"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover(session.dataEntryModel.documentClass, null, null, null, "DATA_ENTRY", "PAYMENT_OTHER", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(session.dataEntryModel.documentClass, null, null, null, "PAYMENT_OTHER", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(session.dataEntryModel.documentClass, null, null, null, "PAYMENT_OTHER", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        session.dataEntryModel << [basicDetailsAction: "saveOtherChargesOthers"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveOtherChargesOthers() {
        println params
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]
		sessionModel << returnedValues["details"]["tradeServiceReferenceNumber"]

        chain(controller: "otherCharges", action: "viewOtherChargesDataEntry", model: sessionModel)
    }

    def displaySavedOtherChargesOthersGrid() {
        def maxRows = params.int('rows') ?: 20
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def tradeServiceId = session.dataEntryModel.tradeServiceId
        println "tradeServiceId " + tradeServiceId
        def queryResult = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId],
                "getOtherChargeDetails",
                "otherCharges/")?.details

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        def display = (queryResult != "not found") ? queryResult?.subList(rowOffset, toIndex) : []

        def totalRows = queryResult.size()
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def totalAmountDue = 0

        def results = display.collect {
            totalAmountDue += it.amount

            [id: it.id,
                    cell:[
                            it.transactionType, //'test',
                            it.chargeType,
                            NumberUtils.currencyFormat(it.amount),
                            "<a href=\"javascript:void(0)\"  style=\"color: red\" onclick=\"var id='" + it.id + "'; deleteAddedCharge(id);\">delete</a>",
                    ]
            ]
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages,
                userdata: [totalAmountDue: NumberUtils.currencyFormat(totalAmountDue)]]
        render jsonData as JSON
    }

    def addOtherChargesOthers() {
        println params
        def param = [tradeServiceId: params.tradeServiceId,
                transactionType: params.transactionType,
                chargeType: params.chargeType,
                amount: params.amount,
                currency: "PHP",
				cwtFlag: params.cwtFlag]

        Map returnedValues = coreAPIService.dummySendCommand(param, "saveCharge", "otherCharges")

        render([success:true] as JSON)
    }

    def deleteOtherChargesOthers() {
        println params
        def param = [tradeServiceId: params.tradeServiceId,
                id: params.id]

        Map returnedValues = coreAPIService.dummySendCommand(param, "deleteCharge", "otherCharges")

        render([success:true] as JSON)
    }

    def getPaymentStatus() {
        Map<String, Object> result = chargesService.findPaymentStatus(params.tradeServiceId)
        ////println"payment status is " + result.PAYMENTSTATUS

        session.dataEntryModel << [paymentStatus: result.PAYMENTSTATUS]

        def jsonData = [paymentStatus: result.PAYMENTSTATUS]

        render jsonData as JSON
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
	
	def getCifDetailsFromDocumentNumber() {
		println params
		def param = [documentNumber: params.documentNumber]
		
		Map returnedValues = coreAPIService.dummySendCommand(param, "getCifDetailsFromDocumentNumber", "otherCharges")
		
		render returnedValues.resultMap as JSON
	}
}
