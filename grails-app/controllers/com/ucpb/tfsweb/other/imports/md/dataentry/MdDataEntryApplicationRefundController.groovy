package com.ucpb.tfsweb.other.imports.md.dataentry

import grails.converters.JSON

class MdDataEntryApplicationRefundController {

    def headerService
    def dataEntryService
    def chargesService
    def routingInformationService
    def ratesService
    def foreignExchangeService

    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Application"
    protected String DOCUMENT_CLASS = "MD"
    protected String DOCUMENT_TYPE = "REFUND"

    // render page
    def viewApplicationRefund() {
        println "viewApplicationRefund"
        if(chainModel) {
            session.dataEntryModel = chainModel
        }

        if(session.dataEntryModel) {
            render(view: "/others/imports/md/index", model:chainModel ?: session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

// trigger viewing of page
    def viewApplicationRefundDataEntry() {
        println  "viewApplicationRefundDataEntry"
        // construct header title
        String headerTitle = "MD Refund - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }



        }


        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
        session.dataEntryModel << [exchange:exchange]

        def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
        session.dataEntryModel << [urrrates:urrrates]



        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, "", "", "", REFERENCE_TYPE.toUpperCase(), "REFUND", session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
        session.nextRoute = documentServiceRoute
        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, "", "", "", "REFUND", session.dataEntryModel.approvers)

        session.removeAttribute("financial")
        session.removeAttribute("postApprovalRequirement")
        session.removeAttribute("amountToCheck")
        session.removeAttribute("signingLimit")
        session.removeAttribute("postingAuthority")

        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, "", "", "", "REFUND", session.dataEntryModel, session.unitcode, session.username)

        session.financial = productReference.financial
        session.postApprovalRequirement = productReference.postApprovalRequirement
        session.amountToCheck = productReference.amountToCheck
        session.signingLimit = productReference.signingLimit
        session.postingAuthority = productReference.postingAuthority
		
		if(params.viewMode){
			session.dataEntryModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
			session.viewMode=params.viewMode
			session.onViewMode=params.onViewMode
		}

        // chain to render page
        chain(action:"viewApplicationRefund", model: session.dataEntryModel)
    }

    def updateApplicationRefundDataEntry() {
        println "updateApplicationRefundDataEntry"
        ////printlnparams
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
            String headerTitle = "MD Refund - Data Entry"

            // keep session model
            session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

            dataEntryMap.each{
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }

            chain(action:"viewApplicationRefund", model:session.dataEntryModel)
        }
    }

    def updateDataEntryStatus() {
        println "updateDataEntryStatus"
        String headerTitle = "MD Refund - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

}
