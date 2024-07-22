package com.ucpb.tfsweb.other.imports.corres.ets

import grails.converters.JSON

class CorresChargeEtsSettlementController {

    def etsService
    def ratesService
    def parserService
    def apService
    def arService
    def foreignExchangeService

    def corresChargesSettlementService

    protected String SERVICE_TYPE = "SETTLEMENT" //"APPLICATION"
    protected String DOCUMENT_CLASS = "CORRES_CHARGE"

    def viewSettlement() {
        // if accessed from create transaction
        if(chainModel) {
            session.etsModel = chainModel
        }

        Map<String,Map<String, Object>> rates = ratesService.getDailyRates()
        session.etsModel << [rates:rates]

        List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency ?: "")
        session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]

        List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
        session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

        def paramz = parserService.sessionModelToHashMap(session.etsModel)

        def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
        exchange = foreignExchangeService.overwriteSpecialRates(exchange,paramz)

        session.etsModel << [exchange:exchange]

        if(session.etsModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/ets/index", model: chainModel ?: session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }

    def viewSettlementEts() {
        // construct header title
        String headerTitle = "Settlement of Actual Corres Charges - eTS"

        // keep session model
        session.etsModel = [referenceType: "ETS", documentClass: DOCUMENT_CLASS, serviceType: SERVICE_TYPE, title: headerTitle, windowed: null]
        
        Map<String, Object> corresCharge = corresChargesSettlementService.findCorresCharge(params.documentNumber)
//        Map<String, Object> details = JSON.parse(corresCharge.details)
        ////printlncorresCharge
        session.etsModel << [ccbdBranchUnitCode: corresCharge.CCBDBRANCHUNITCODE,
                outstandingCorresCharge: corresCharge.OUTSTANDINGBALANCE,
                cifName: corresCharge.CIFNAME,
                cifNumber: corresCharge.CIFNUMBER,
                accountOfficer: corresCharge.ACCOUNTOFFICER,
                documentNumber: corresCharge.DOCUMENTNUMBER
        ]

        // chain to render page
        chain(action:"viewSettlement", model: session.etsModel)
    }

    def saveSettlementEts() {
        //construct header title
        String headerTitle = "Settlement of Actual Corres Charges - eTS"

        // keep session model
        session.etsModel = [referenceType: "ETS", documentClass: DOCUMENT_CLASS, serviceType: SERVICE_TYPE, title: headerTitle, referenceType: "ETS", windowed: null]

        params.saveAs = ""
        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        def urr = foreignExchangeService.getUrrRate(ratesService.getRatesUrr().display, chainModel)
        params.put("USD-PHP_urr", urr)


        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                session.etsModel << it
            }
        }

        // chain to render page
        chain(action:"viewSettlement", model: session.etsModel)
    }
}
