package com.ucpb.tfsweb.other.imports.rebate

import grails.converters.JSON

class RebateController {

    def coreAPIService
    def routingInformationService
    def dataEntryService

    def viewRebate() {

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
        }

        session.dataEntryModel << [title: "Processing of Rebates - Data Entry",
                tabs: ["basicDetails", "instructionsAndRouting"],
                serviceType: "REBATE",
                documentClass: "REBATE",
                documentType: "",
                documentSubType1: "",
                documentSubType2: "",
                referenceType: "DATA_ENTRY",
				tsdInitiated: "true"
        ]

        // setup gsp to display in tabs
        session.dataEntryModel << [basicDetailsTab: "../product/other/imports/rebate/basic_details_tab"]

        session.dataEntryModel << [basicDetailsAction: "saveRebate"]
        session.dataEntryModel << [routeAction: "updateDataEntryStatus"]

        // routing
        def documentServiceRoute = routingInformationService.getNextMainApprover("REBATE", null, null, null, "DATA_ENTRY", "PROCESS", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode("REBATE", null, null, null, "PROCESS", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences("REBATE", null, null, null, "PROCESS", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        render(view: "../product/index", model: session.dataEntryModel)
    }

    def saveRebate() {
        params.saveAs = ""
        params.unitcode = session.unitcode
        params.username = session.username

        params.each {
            if (it.key.toString().toLowerCase().contains("amount")) {
                it.value = it.value.replaceAll(",", "")
            }
        }

        params.cifNumber = params.cifNumberParam
        params.cifName = params.cifNameParam
        params.accountOfficer = params.accountOfficerParam
        params.ccbdBranchUnitCode = params.ccbdBranchUnitCodeParam

        Map returnedValues = coreAPIService.dummySendCommand(params, "save", "tradeservice")

        def sessionModel = returnedValues["details"]["details"]

        sessionModel << returnedValues["details"]["tradeServiceId"]

        sessionModel << returnedValues["details"]["documentNumber"]

        chain(controller: "rebate", action: "viewRebate", model: sessionModel)
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

        def map = dataEntryService.updateDataEntry(params)

        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }
	
	def getCifDetailsFromDocumentNumber() {
		println params
		def param = [documentNumber: params.documentNumber]
		
		Map returnedValues = coreAPIService.dummySendCommand(param, "getCifDetailsFromDocumentNumber", "otherCharges")
		
		render returnedValues.resultMap as JSON
	}
}
