package com.ucpb.tfsweb.other.imports.md.dataentry

import grails.converters.JSON

class MdDataEntryCollectionController {

    def headerService
    def dataEntryService
    def chargesService
    def routingInformationService
    def apService
    def parserService
    def arService
    def foreignExchangeService
    def ratesService

    // sets service type
    protected String REFERENCE_TYPE = "DATA_ENTRY"
    protected String SERVICE_TYPE = "Collection"
    protected String DOCUMENT_CLASS = "MD"

    // render page
    def viewCollection() {
        if(chainModel) {
            session.dataEntryModel = chainModel
        }

//        List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.dataEntryModel.cifNumber ?: "", session.dataEntryModel.currency ?: "")
//        session.dataEntryModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//        List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.dataEntryModel.cifNumber ?: "")
//        session.dataEntryModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

        if(session.dataEntryModel) {
            render(view: "/others/imports/md/index", model:chainModel ?: session.dataEntryModel)
        }else{
            render(view: "/main/unauthorized")
        }
    }

// trigger viewing of page
    def viewCollectionDataEntry() {
        // construct header title
        String headerTitle = "MD Collection - Data Entry"

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)


            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
            session.dataEntryModel << [exchange:exchange]

            def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
            session.dataEntryModel << [urrrates:urrrates]

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }
        }

//        def documentServiceRoute = routingInformationService.getNextMainApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.dataEntryModel, session.userLevel)
//        session.nextRoute = documentServiceRoute
//        session.dataEntryModel << routingInformationService.getMainApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.dataEntryModel.approvers)
//
//        def productReference = routingInformationService.getProductReferences(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, SERVICE_TYPE?.toUpperCase(), session.dataEntryModel, session.unitcode, session.username)
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

		if("View Data Entry" == params.dataEntryButtonCaption){
			session.dataEntryModel<<[viewMode:'viewMode']
		}else{
			session.dataEntryModel<<[viewMode:params.viewMode]
			session.dataEntryModel<<[hasRoute:params.hasRoute]
		}
		
        // chain to render page
        chain(action:"viewCollection", model: session.dataEntryModel)
    }

    def updateCollectionDataEntry() {
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
            String headerTitle = "MD Collection - Data Entry"

            // keep session model
            session.dataEntryModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            Map<String, Object> dataEntryMap = dataEntryService.updateDataEntry(params)

            dataEntryMap.each{
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.dataEntryModel << it
                }
            }



            chain(action:"viewCollection", model:session.dataEntryModel)
        }
    }

    def updateDataEntryStatus() {
        String headerTitle = "MD Collection - Data Entry"

        String statusAction = routingInformationService.getStatusAction(session.financial,
                params.statusAction,
                session.signingLimit,
                session.amountToCheck,
                session.dataEntryModel?.status,
                session.postApprovalRequirement)

        params.statusAction = statusAction

        // keep session model
        session.dataEntryModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        dataEntryService.updateDataEntry(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def payItem() {
        def jsonData = [:]
        
        try {
            chargesService.payCharges(params)

            jsonData = [success:true]

            render jsonData as JSON
        } catch(Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }
    
    def getPaymentStatus() {
        Map<String, Object> result = chargesService.findPaymentStatus(params.tradeServiceId)
        ////println"payment status is " + result.PAYMENTSTATUS

        session.dataEntryModel << [paymentStatus: result.PAYMENTSTATUS]

        def jsonData = [paymentStatus: result.PAYMENTSTATUS]

        render jsonData as JSON
    }

    def reversePayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success:true]

            render jsonData as JSON
        } catch(Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

    def errorCorrectPayment() {
        def jsonData = [:]

        try {
            chargesService.undoPayment(params)

            jsonData = [success:true]

            render jsonData as JSON
        } catch(Exception e) {
            jsonData = [success: false]

            render jsonData as JSON
        }
    }

}
