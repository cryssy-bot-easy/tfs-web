package com.ucpb.tfsweb.other.imports.md.ets

import grails.converters.JSON
import com.ucpb.tfsweb.main.RatesService

/**
 (revision)
 SCR/ER Number: 
 SCR/ER Description: No Foreign Exchange Rates in payment tab.
 [Revised by:] Jonh Henry Alabin
 [Date deployed:] June 16,2017
 Program [Revision] Details: Add foreign Exchange Rates method  for Payment Details Tab .
 Member Type: Groovy
 Project: WEB
 Project Name: MdEtsCollectionController.groovy
  */


class MdEtsCollectionController {

    def headerService
    def recomputeService
    def dataEntryService
    def etsService
    def mdService

    def apService
    def arService
    def parserService

    def tabUtilityService

    def chargesService
	//added by henry
	RatesService ratesService
	//end
    def routingInformationService
    def foreignExchangeService
  

    // sets service type
    protected String REFERENCE_TYPE = "ETS"
    protected String SERVICE_TYPE = "Collection"
    protected String DOCUMENT_CLASS = "MD"

    def viewCollection() {
        // if accessed from create transaction
        if(chainModel) {
            session.etsModel = chainModel
        }

        List<Map<String, Object>> accountsPayable = apService.findAllAccountsPayableByCifNumber(session.etsModel.cifNumber ?: "", session.etsModel.currency ?: "")
        session.etsModel << [accountsPayable: parserService.listHashMapToString(accountsPayable)]

        List<Map<String, Object>> accountsReceivable = arService.findAllAccountsReceivableByCifNumber(session.etsModel.cifNumber ?: "")
        session.etsModel << [accountsReceivable: parserService.listHashMapToString(accountsReceivable)]

        if(session.etsModel) {
            // passes chain model if existing else passes session model
            render(view: "/others/imports/md/index", model: chainModel ?: session.etsModel)
        }else {
            render(view: "/main/unauthorized")
        }
    }

    def viewCollectionEts() {
        String documentType = ""
        String documentSubType1 = ""
        String documentSubType2 = ""

        if (params.tradeServiceId) {
            Map<String, Object> dataEntryMap = dataEntryService.getDataEntry(params.tradeServiceId)

            dataEntryMap.remove("etsDate")
            dataEntryMap.remove("processDate")

            // construct header title
            String headerTitle = "MD Collection - eTS"

            // keep session model
            session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            def exchange = foreignExchangeService.extractRatesByBaseCurrency(ratesService.getRatesByBaseCurrency().display, chainModel)
            session.etsModel << [exchange:exchange]

            def urrrates = foreignExchangeService.formatUrrRates(ratesService.getRatesUrr().display, chainModel)
            session.etsModel << [urrrates:urrrates]


            dataEntryMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass") && (!it.key.equals("etsNumber") && !it.key.equals("serviceInstructionId"))) {
                    session.etsModel << it
                }
            }

        } else if (params.etsNumber) {
            Map<String, Object> etsMap = etsService.getEts(params.etsNumber)

            String headerTitle = "MD Collection - eTS"

            session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

            etsMap.each {
                if(!it.key.equals("referenceType") && !it.key.equals("serviceType") && !it.key.equals("documentClass")) {
                    session.etsModel << it
                }
            }
        }
		// added by Henry
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
						pass_on_rate: pass_on_rate,
						special_rate: special_rate,
	
						text_pass_on_rate: text_pass_on_rate,
						pass_on_rate_cash: pass_on_rate_cash,
						text_special_rate: text_special_rate,
						special_rate_cash: special_rate_cash
				]
			}
	
			session.etsModel << [exchange: exchange]
			//end 
        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
        // chain to render page
        chain(action:"viewCollection", model: session.etsModel)
    }

    def saveCollectionEts() {
        String documentType = ""
        String documentSubType1 = ""
        String documentSubType2 = ""

        //construct header title
        String headerTitle = "MD Collection - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        // trigger command
        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        Map<String, Object> etsMap = etsService.saveEts(params)

        etsMap.each{
            session.etsModel << it
        }

        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        // chain to render page
        chain(action:"viewCollection", model: session.etsModel)
    }

    def updateCollectionEts() {
        String documentType = ""
        String documentSubType1 = ""
        String documentSubType2 = ""
        //construct header title
        String headerTitle = "MD Collection - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

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

        def documentServiceRoute = routingInformationService.getNextBranchApprover(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2, REFERENCE_TYPE.toUpperCase(), SERVICE_TYPE?.toUpperCase(), session.username, session.userrole.id, session.unitcode, session.etsModel)
        session.nextRoute = documentServiceRoute
        session.etsModel << routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)

        println "session.nextRoute >>> " + session.nextRoute
        println "session.route >>> " + routingInformationService.getBranchApprovalMode(DOCUMENT_CLASS, documentType, documentSubType1, documentSubType2,SERVICE_TYPE?.toUpperCase(), session.etsModel.approvers)
		// added by Henry
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
						pass_on_rate: pass_on_rate,
						special_rate: special_rate,
	
						text_pass_on_rate: text_pass_on_rate,
						pass_on_rate_cash: pass_on_rate_cash,
						text_special_rate: text_special_rate,
						special_rate_cash: special_rate_cash
				]
			}
	
			session.etsModel << [exchange: exchange]
			//end
        // chain to render page
        chain(action:"viewCollection", model:session.etsModel)
    }

    def updateEtsStatus() {
        //construct header title
        String headerTitle = "MD Collection - eTS"

        // keep session model
        session.etsModel = [documentClass: DOCUMENT_CLASS, title: headerTitle, serviceType: SERVICE_TYPE, referenceType: REFERENCE_TYPE]

        params.put("username", session.username)
        params.put("unitcode", session.unitcode)
        // trigger command
        etsService.updateEts(params)

        // chain to render page
        redirect(controller: "unactedTransactions", action: "viewUnacted")
    }

    def displayOutstandingBalance() {
        // md application inquiry for branch
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = mdService.findAllMdApplication(maxRows, rowOffset, currentPage, params)
        ////println"mapList.display >> " + mapList.display
        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)
        def results = mdService.constructOutstandingBalance(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }
}
