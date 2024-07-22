package com.ucpb.tfsweb.other.imports.md.dataentry

import grails.converters.JSON
import net.ipc.utils.DateUtils

class MdDataEntryApplicationController {

    def headerService
    def dataEntryService
    def chargesService
    def routingInformationService
    def tabUtilityService
    def coreAPIService
    def foreignExchangeService
    def ratesService
	def chargesPaymentService
	
    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Application"
    protected String DOCUMENT_CLASS = "MD"
    protected String DOCUMENT_TYPE = "APPLICATION"

    // render page
    def viewApplication() {
        if(chainModel) {
            session.dataEntryModel = chainModel
        }

//        session.dataEntryModel << [mdApplication: 'applyrefund']

        if(session.dataEntryModel) {
            render(view: "/others/imports/md/index", model:chainModel ?: session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

// trigger viewing of page
    def viewApplicationDataEntry() {
        // construct header title
        String headerTitle = "MD Application - Data Entry"

        if (params.tradeServiceId) {
            session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            Map<String, Object> dataEntryMap = dataEntryService.getNonEtsDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        } else {
            session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

//            session.dataEntryModel << [documentNumber: params.documentNumber]
//            def md = coreAPIService.dummySendQuery([settlementAccountNumber: params.documentNumber], "get", "marginalDeposit/")?.details
            def md = coreAPIService.dummySendQuery(null, params.documentNumber, "product/", "marginalDeposit/", "details/").details

            session.dataEntryModel << [documentNumber: md?.settlementAccountNumber?.settlementAccountNumber]
            session.dataEntryModel << [cifNumber: md?.cifNumber]
            session.dataEntryModel << [cifName: md?.cifName]
            session.dataEntryModel << [accountOfficer: md?.accountOfficer]
            session.dataEntryModel << [ccbdBranchUnitCode: md?.ccbdBranchUnitCode]
            session.dataEntryModel << [mdCurrency: params.mdCurrency]
            session.dataEntryModel << [outstandingAmount: params.outstandingAmount]

            session.dataEntryModel << [tsdInitiated: "true"]
        }

        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
        session.dataEntryModel << [exchange:exchange]

        def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
        session.dataEntryModel << [urrrates:urrrates]

//        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, "", "", "", SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)
//
//        session.financial = productReference.financial
//        session.postApprovalRequirement = productReference.postApprovalRequirement
//        session.amountToCheck = productReference.amountToCheck
//        session.signingLimit = productReference.signingLimit
//        session.postingAuthority = productReference.postingAuthority
        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, "", "", "", REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, "", "", "",SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, "", "", "", SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority

        // chain to render page
        chain(action:"viewApplication", model: session.dataEntryModel)
    }

    def saveApplicationDataEntry() {
        String headerTitle = "MD Application - Data Entry"

        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.saveAs = "PENDING"

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> dataEntryMap = dataEntryService.saveDataEntry(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                session.dataEntryModel << it
            }
        }        

        chain(action:"viewApplication", model: session.dataEntryModel)
    }

    def updateApplicationDataEntry() {
        // chain to render page
        if(params.paymentAction?.equalsIgnoreCase("savePaymentMode")) {
            def jsonData = [:]

            try{
                Map<String, Object> dataEntryMap = chargesService.updateCharges(params)

                jsonData = [success:true]

                render jsonData as JSON
            } catch(Exception e) {
                jsonData = [success:false]

                render jsonData as JSON
            }
        }else {
            //construct header title
            String headerTitle = "MD Application - Data Entry"

            // keep session model
            session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]
            session.dataEntryModel << [formName: tabUtilityService.getTabName(params.form)]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

            dataEntryMap.each{
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && !it.key.equals("documentType")) {
                    session.dataEntryModel << it
                }
            }

            chain(action:"viewApplication", model:session.dataEntryModel)
        }
    }

    def updateDataEntryStatus() {
        String headerTitle = "MD Application - Data Entry"

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }
	
	def getPnNumber(){
		def jsonData = [:]
		
		Map<String, Object> dataEntryMap = chargesPaymentService.getPnNumber(params.documentNumber)

		jsonData = [pnNumber : dataEntryMap.get('pnNumber')]
		
		render jsonData as JSON
	}

}
