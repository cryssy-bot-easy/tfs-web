package com.ucpb.tfsweb.other.imports.md.ets

import net.ipc.utils.DateUtils

class MdEtsApplicationRefundController {

    def headerService
    def recomputeService
    def dataEntryService
    def etsService

    def apService
    def arService
    def parserService

    def tabUtilityService

    def chargesService
    def coreAPIService
    def routingInformationService

    def foreignExchangeService
    def ratesService

    // sets service type
    protected String REFERENCE_TYPE = "ETS"
    protected String SERVICE_TYPE = "Application"
    protected String DOCUMENT_CLASS = "MD"
    protected String DOCUMENT_TYPE = "REFUND"

    def viewApplicationRefund() {
        println "viewApplicationRefund"
        // if accessed from create transaction
        if(chainModel) {
            session.etsModel = chainModel
        }

//        session.etsModel << [mdApplication: 'refund']
//        List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency)
//        session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]
//
//        List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
//        session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

        if(session.etsModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/md/index", model: chainModel ?: session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }

    def viewApplicationRefundEts() {
        println "viewApplicationRefundEts"
        // construct header title
        String headerTitle = "MD Refund - eTS"

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            // keep session model
            session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && (!it.key.equals("etsNumber") && !it.key.equals("serviceInstructionId"))) {
                    session.etsModel << it
                }
            }

        } else if (params.etsNumber) {
            Map<String, Object> etsMap = etsService.getEts(params.etsNumber)

            session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            etsMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
//
//            List<Map<String, Object>> charges = chargesService.findAllCharges(params.etsNumber)
//
//            session.etsModel << [charges:charges]
        }  else {
            session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            session.etsModel << [documentNumber: params.documentNumber]
            session.etsModel << [mdCurrency: params.mdCurrency]
            session.etsModel << [outstandingAmount: params.outstandingAmount]

            def md = coreAPIService.dummySendQuery(null, params.documentNumber, "product/", "marginalDeposit/", "details/").details

            session.etsModel << [cifNumber: md.cifNumber]
            session.etsModel << [cifName: md.cifName]
            session.etsModel << [accountOfficer: md.accountOfficer]
            session.etsModel << [ccbdBranchUnitCode: md.ccbdBranchUnitCode]
            session.etsModel << [mdApplicationBookingDate: DateUtils.shortDateFormat(DateUtils.parse(md.modifiedDate.toString()))]

            session.etsModel << [longName: md.longName]
            session.etsModel << [address1: md.address1]
            session.etsModel << [address2: md.address2]
        }

        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
        session.etsModel << [exchange:exchange]

        def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
        session.etsModel << [urrrates:urrrates]

        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, "", "", "", REFERENCE_TYPE.toUpperCase(), "REFUND", session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        println 'documentServiceRoute ' + documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, "", "", "","REFUND", session.etsModel.approvers)
        println routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, "", "", "","REFUND", session.etsModel.approvers)

        // chain to render page
        chain(action:"viewApplicationRefund", model: session.etsModel)
    }

    def saveApplicationRefundEts() {
        println "saveApplicationRefundEts"
        //construct header title
        String headerTitle = "MD Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            session.etsModel << it
        }

//        List<Map<String, Object>> charges = chargesService.findAllCharges(etsMap.serviceInstructionId)
//
//        session.etsModel << [charges:charges]

        // chain to render page
        chain(action:"viewApplicationRefund", model: session.etsModel)
    }

    def updateApplicationRefundEts() {
        println "updateApplicationRefundEts"
        //construct header title
        String headerTitle = "MD Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        session.etsModel << [formName: tabUtilityService.getTabName(params.form)]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        Map<String, Object> dataEntryMap = etsService.updateEts(params)

        dataEntryMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        // chain to render page
        chain(action:"viewApplicationRefund", model:session.etsModel)
    }

    def updateEtsStatus() {
        println "updateEtsStatus"
        //construct header title
        String headerTitle = "MD Refund - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, documentType: DOCUMENT_TYPE, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        etsService.updateEts(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }
}
