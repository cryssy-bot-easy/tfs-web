package com.ucpb.tfsweb.lc.payments

import grails.converters.JSON

class LcChargesIndemnityIssuanceController {

    def headerService
    def dataEntryService
    def recomputeService
    def chargesService

    def parserService

    def apService
    def arService

    def tabUtilityService

    // sets service type
    protected String REFERENCE_TYPE = "PAYMENT"
    protected String SERVICE_TYPE = "Issuance"
    protected String DOCUMENT_CLASS = "INDEMNITY"
	
	// render page
	def viewIndemnityIssuance() {
		// if accessed from create transaction
		if(chainModel) {
			session.chargesModel = chainModel

            String etsNumber = session.chargesModel.serviceInstructionId ?: ""

            List<Map<String, Object>> charges = chargesService.findAllCharges(etsNumber)

            session.chargesModel << [charges:charges]
            session.chargesModel << [chargesString: parserService.listHashMapToString(charges)]

//            List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.chargesModel.cifNumber ?: "", session.chargesModel.currency ?: "")
//            session.chargesModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//            List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.chargesModel.cifNumber ?: "")
//            session.chargesModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]
        }
		
		
		if(session.chargesModel) {
			// passes chain model if existing else passes session model
			render(view: "/lc/payment/opening/index", model: chainModel ? chainModel : session.chargesModel)
		}else {
			render(view: "/main/unauthorized")
		}
	}
	
	// trigger viewing of page
	def viewIndemnityIssuanceCharges() {
        // get lc class and type
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1.toUpperCase()
        String documentSubType2 = params.documentSubType2

        // construct header title
        String headerTitle = headerService.getChargesTitle(documentType, DOCUMENT_CLASS, documentSubType1, SERVICE_TYPE, documentSubType2)

        // keep session model
        session.chargesModel = [documentType: documentType, documentClass: DOCUMENT_CLASS, documentSubType1: documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.each {
                if (!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.chargesModel << it
                }
            }
        }
		session.chargesModel << [viewMode:params.viewMode,onViewMode:params.onViewMode]
        // chain to render page
        chain(action:"viewIndemnityIssuance", model: session.chargesModel)
	}

    def updateIndemnityIssuanceCharges() {
        if(params.paymentAction?.equalsIgnoreCase("savePaymentMode")) {
            def jsonData = [:]

            try{
                params.put("username", session.username)
                params.put("unitcode", session.unitcode)

                Map<String, Object> dataEntryMap = chargesService.updateCharges(params)

                jsonData = [success:true]

                render jsonData as JSON
            } catch(Exception e) {
                jsonData = [success:false]

                render jsonData as JSON
            }
        } else {
            //construct header title
            String headerTitle = headerService.getChargesTitle(params.documentType, DOCUMENT_CLASS, params.documentSubType1, SERVICE_TYPE, params.documentSubType2)

            // keep session model
            session.chargesModel = [documentType: params.documentType, documentClass: DOCUMENT_CLASS, documentSubType1: params.documentSubType1, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            params.put("username", session.username)
            params.put("unitcode", session.unitcode)
            // trigger command
            Map<String, Object> dataEntryMap = chargesService.updateCharges(params)

            dataEntryMap.each{
                session.chargesModel << it
            }
            session.chargesModel << [formName: tabUtilityService.getTabName(params.form)]
            // chain to render page
            chain(action:"viewIndemnityIssuance", model:session.chargesModel)
        }
    }

    // pay charges (create Debit accounting entry)
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

    // compute total amount
    def computeTotal() {
        def jsonData = [totalAmount: recomputeService.computeTotal(params.amounts)]

        render jsonData as JSON
    }

    // compute balance
    def computeBalance() {
        def computeBalanceResult = recomputeService.computeBalance(params.totalAmountDue, params.totalAmount)


        def jsonData = [balance: computeBalanceResult.balance, excess: computeBalanceResult.excess]

        render jsonData as JSON
    }
}
