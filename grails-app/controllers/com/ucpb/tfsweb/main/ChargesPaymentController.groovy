package com.ucpb.tfsweb.main

import grails.converters.JSON
import java.math.MathContext
import java.math.RoundingMode
import java.util.List;
import java.util.Map;

/*	PROLOGUE:
 * 	(revision)
	SCR/ER Number: 20151118-063
	SCR/ER Description: FX UA Loan Settlement cannot create Ets entry, error message show "UA Loan Payment did not match".
	[Revised by:] Jesse James Joson
	[Date revised:] 11/25/2015
	Program [Revision] Details: Compare the PHP settlement amount with the original amount for settlement converted to PHP.
	PROJECT: WEB
	MEMBER TYPE  : Groovy
 */

class ChargesPaymentController {

    def commandService
    def chargesPaymentService
    def parserService
    def apService
    def arService
    def chargesService

    def coreAPIService

    def findServiceChargesPayments() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = chargesPaymentService.findServiceChargesPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

        Boolean reversal = false;
        Boolean viewReversal = false;

        if ((session.chargesModel?.reverseEts != null || session.chargesModel?.reversalPaymentProcessing != null) || session.chargesModel?.reverseDE != null) {
            reversal = true;
        }

        // treat as revesal also for "view mode" of DE being reversed
        if (session.chargesModel?.status != null && session.chargesModel?.status == 'FOR_REVERSAL') {
            //reversal = true;
            viewReversal = true;
        }

        if (params.referenceType == "PAYMENT" || (params.referenceType == "DATA_ENTRY" && params.documentClass == "MD")) {
            //results = chargesPaymentService.constructChargesPaymentGrid(mapList.display, reversal)
            results = chargesPaymentService.constructChargesPaymentGridWithReversalIndicator(mapList.display, reversal, viewReversal)
        } else if (params.referenceType == "ETS") {
            //results = chargesPaymentService.constructServiceChargesGrid(mapList.display)
            results = chargesPaymentService.constructServiceChargesGridWithReversalIndicator(mapList.display, reversal, viewReversal)
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findProductChargesPayments() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList

        mapList = chargesPaymentService.findProductChargesPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

        Boolean reversal = false;
        Boolean viewReversal = false;

        if ((session.chargesModel?.reverseEts != null || session.chargesModel?.reversalPaymentProcessing != null) || session.chargesModel?.reverseDE != null) {
            reversal = true;
        }
//        println 'hqwewqehqwj ' + session.chargesModel?.reversalPaymentProcessing
        // treat as revesal also for "view mode" of DE being reversed
        if (session.chargesModel?.status != null && session.chargesModel?.status == 'FOR_REVERSAL') {
            //reversal = true;
            viewReversal = true;
        }

        if (params.referenceType == "PAYMENT" || params.referenceType == "DATA_ENTRY") {
            if (params.form?.equalsIgnoreCase("basicDetails")) {
                println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL 00"
                results = chargesPaymentService.constructApPayment(mapList.display)
            } else if (params.form?.equalsIgnoreCase("product") && ('MD'.equals(params.documentClass))) {
                println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL 0"
                //results = chargesPaymentService.constructProductChargesPaymentMdGrid(mapList.display)
                results = chargesPaymentService.constructMdPaymentGrid(mapList.display, reversal)
            } else if (params.form?.equalsIgnoreCase("product") && !(params.documentClass in ['DA', 'DP', 'OA', 'DR'])) {
                //results = chargesPaymentService.constructProductChargesPaymentMdGrid(mapList.display)
                println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL 1"
                results = chargesPaymentService.constructProductChargesPaymentMdGridWithReversalIndicator(mapList.display, reversal)
            } else {
                println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL 2"
                //results = chargesPaymentService.constructProductChargesPaymentGrid(mapList.display)
                results = chargesPaymentService.constructProductChargesPaymentGridWithReversalIndicator(mapList.display, reversal, viewReversal)
            }
        } else if (params.referenceType == "ETS") {
            if (params.form?.equalsIgnoreCase("basicDetails")) {
                results = chargesPaymentService.constructApPayment(mapList.display)
                println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A00"
            } else {
                if (params.serviceType?.equalsIgnoreCase("Settlement")) {
                    if (params.documentClass in ['DA', 'DP', 'OA', 'DR']) {
                        println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A01"
                        //results = chargesPaymentService.constructProductChargesGridNonLc(mapList.display)
                        results = chargesPaymentService.constructProductChargesGridNonLcWithReversalIndicator(mapList.display, reversal, viewReversal)
                    } else {
                        println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A02"
                        results = chargesPaymentService.constructProductChargesGridSettlement(mapList.display)
                    }
                } else if ((params.serviceType.equalsIgnoreCase("UA Loan Settlement") ||
                                params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) &&
                                params.documentType.equalsIgnoreCase("DOMESTIC") &&
                                params.referenceType.equalsIgnoreCase("ETS")) {

                    println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A01.5 -- Bug #4066"
                    results = chargesPaymentService.constructProductChargesGridUASettlement(mapList.display)
                } else {
                    if (
                            (params.serviceType.equalsIgnoreCase("Negotiation") && params.documentType.equalsIgnoreCase("DOMESTIC") && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY")))
                    // || ((params.serviceType.equalsIgnoreCase("UA Loan Settlement") || params.serviceType.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) && params.documentType.equalsIgnoreCase("DOMESTIC") && (params.referenceType.equalsIgnoreCase("ETS") || params.referenceType.equalsIgnoreCase("DATA_ENTRY")))
                    ) {
                        println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A03"
                        results = chargesPaymentService.constructProductChargesGridDomestic(mapList.display)
                    } else {
                        println "ANGOL ANGOL ANGOL ANGOL ANGOL ANGOL A04"
                        //results = chargesPaymentService.constructProductChargesGrid(mapList.display)
						results = chargesPaymentService.constructProductChargesGridWithReversalIndicator(mapList.display, reversal, viewReversal)
                    }
                }
            }
        }

//        results.each {
//            //printlnit
//        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def findProceedsPayments() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList

        mapList = chargesPaymentService.findProceedsPayment(maxRows, rowOffset, currentPage, params.tradeServiceId)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results

        Boolean reversal = false;
        Boolean viewReversal = false;

        if (session.chargesModel?.reverseEts != null || session.chargesModel?.reverseDE != null) {
            reversal = true;
        }

        // treat as revesal also for "view mode" of DE being reversed
        if (session.chargesModel?.status != null && session.chargesModel?.status == 'FOR_REVERSAL') {
            //reversal = true;
            viewReversal = true;
        }

        if (params.referenceType == "PAYMENT" || params.referenceType == "DATA_ENTRY") {
            if (params.form?.equalsIgnoreCase("proceedsDetails")) {
                if (params.referenceType?.equals("PAYMENT")) {
					println "Vin Vin Vin Vin Vin 01"
                    // results = chargesPaymentService.constructProceedsChargesPaymentGrid(mapList.display)
                    results = chargesPaymentService.constructProceedsChargesPaymentGridWithReversalIndicator(mapList.display, reversal, viewReversal)
                } else {
					println "Vin Vin Vin Vin Vin 02"
                    results = chargesPaymentService.constructProceedsChargesGrid(mapList.display)
                }
            } else {

				println "Vin Vin Vin Vin Vin 03"
				if (params.serviceType == 'Application'){
					results = chargesPaymentService.constructMdRefund(mapList.display)
				}else{
					results = chargesPaymentService.constructApPayment(mapList.display)
				}
            }
        } else if (params.referenceType == "ETS") {
            if (params.form?.equalsIgnoreCase("proceedsDetails")) {
				println "Vin Vin Vin Vin Vin 04"
                results = chargesPaymentService.constructProceedsChargesGrid(mapList.display)
            } else {
				println "Vin Vin Vin Vin Vin 05"
				results = chargesPaymentService.constructApPayment(mapList.display)
            }
        }

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def addDeleteSettlement() {

        if (params.passOnRateConfirmedByCash && session.dataEntryModel) {
            session.dataEntryModel << [passOnRateConfirmedByCash: params.passOnRateConfirmedByCash]
        }

        def details = session.chargesModel ?: session.dataEntryModel ?: session.model

//        println "weeeeeeeeeeeeeeeeeeee " + params

        details.remove("fundingReferenceNumber")
        details.remove("swift")
        details.remove("bank")
        details.remove("beneficiary")
        details.remove("pddtsAccountNumber")
        details.remove("byOrder");

        details.remove("receivingBank")

        details.remove("senderReference")
        details.remove("bankOperationCode")

        details.remove("orderingAccountNumber") // account
        details.remove("orderingAddress")

        details.remove("accountWithInstitution")
        details.remove("nameAndAddress")

        details.remove("beneficiaryName")
        details.remove("beneficiaryAddress")
        details.remove("beneficiaryAccountNumber")

        details.remove("detailsOfCharges")
        details.remove("senderToReceiverInformation")

        session.chargesModel = details

        Map<String, Object> parameterMap = new HashMap<String, Object>()
        ////println"params:" + params
        params.each {
            if (it.key.equals("chargesPaymentSummary") || it.key.equals("documentPaymentSummary")) {
                String gridValue = "[" + it.value + "]"
                def list = parserService.parseGrid(gridValue)

                Iterator ite = list[0]?.entrySet().iterator()
                while (ite.hasNext()) {
                    Map.Entry pairs = (Map.Entry) ite.next()

                    parameterMap.put(pairs.getKey(), pairs.getValue())
                }
            }

            if (!(it.key.equals("chargesPaymentSummary")) && !(it.key.equals("chargesPaymentSummary"))) {
                parameterMap.put(it.key, it.value)
            }
        }

        parameterMap.put("username", session.username)

        def jsonData = [success: 'true']

        try {
            commandService.updateCommand(params.form, parameterMap, params.statusAction)

            if (session.chargesModel) {
                def negoPayments = chargesPaymentService.findNegotiationPayments(session.chargesModel?.tradeServiceId)

                session.chargesModel << [pddtsFlag: negoPayments.pddts.pddtsFlag]
                session.chargesModel << [mt103Flag: negoPayments.mt103.mt103Flag]

                session.chargesModel << [pddtsAmount: negoPayments.pddts.pddtsAmount]
                session.chargesModel << [mt103Amount: negoPayments.mt103.mt103Amount]
            }
        } catch (Exception e) {
            jsonData = [success: 'false']
        }

        render jsonData as JSON
    }


    def findAccountsPayableByDocumentNumber() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = apService.findAllAccountsPayableByDocumentNumber(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = apService.constructApByDocumentNumber(mapList.display)

        def jsonData = [:]

        if (mapList.display.size() > 1) {
            jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        } else {
            jsonData = [referenceId: mapList.display[0]['ID']]
        }
        render jsonData as JSON
    }

    def findAccountsReceivableByDocumentNumber() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

        def mapList = arService.findAllAccountsReceivableByDocumentNumber(maxRows, rowOffset, currentPage, params)

        def totalRows = mapList.totalRows
        def numberOfPages = Math.ceil(totalRows / maxRows)

        def results = arService.constructArByDocumentNumber(mapList.display)

        def jsonData = [rows: results, page: currentPage, records: totalRows, total: numberOfPages]
        render jsonData as JSON
    }

    def computeLoanMaturityDate() {
        ////println"computing loan maturity date"

        String documentNumber
        String negotiationValueDate

        if (session.etsModel) {
            documentNumber = session.etsModel.lcNumber
            negotiationValueDate = session.etsModel.negotiationValueDate
        } else if (session.chargesModel) {
            documentNumber = session.chargesModel.lcNumber;
            negotiationValueDate = session.chargesModel.negotiationValueDate;
        }

        ////println"documentNumber " + documentNumber
        ////println"negotiationValueDate " + negotiationValueDate

        String maturityDate = chargesPaymentService.getUsancePeriod(documentNumber, negotiationValueDate)

        def jsonData = [maturityDate: maturityDate]
        render jsonData as JSON
    }

    def validatePayments() {
        def result = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "details", "payment/").details

        result.each {
            if ("PAID".equals(it.status)) {
                render([success: false] as JSON)
            }
        }

        render([success: true] as JSON)
    }

    def validateSavedProductPayments2() {
		println 'validateSavedProductPayments2' + params
		
		String tradeServiceId = params.tradeServiceId
		def maxRows = 10
		def currentPage = 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
		def mapList = chargesPaymentService.findProductChargesPayment(maxRows, rowOffset, currentPage, tradeServiceId)
		
		def productPaymentSummary = parserService.parseGrid(params.productPaymentSummary)
		println "mapList.display?.size(): " + mapList.display?.size()
		println "mapList.display: " + mapList.display
		println "productPaymentSummary?.size(): " + productPaymentSummary?.size()
		println "productPaymentSummary: " + productPaymentSummary
		
		println "PARAMS" + params
		if(params.serviceType == 'Application' && params.documentType == 'REFUND'){
			if (Double.parseDouble(params.amountOfRefund.replace(",", "")) == 0.00){
				render ([sucess: true] as JSON)
			}else{
				render ([sucess: false] as JSON)
			}
		}else if(params.documentClass?.equalsIgnoreCase('ar') && params.serviceType?.equalsIgnoreCase('settle')){
			if (Double.parseDouble(params.amount.replace(",", "")) == 0.00){
				render ([sucess: true] as JSON)
			}else{
				render ([sucess: false] as JSON)
			}
		}
		if(mapList.display?.size() != productPaymentSummary?.size() || mapList.display?.size() == 0){
			render ([success: false] as JSON)
		}else {
			if (params.remainingBalance > "0.00"){
				render ([success: false] as JSON)
			}else{
				render ([sucess: true] as JSON)
			}
			def validateCounter = 0
			for (def productPayment : productPaymentSummary){
				for (def displayList : mapList.display){
					if(displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == productPayment.paymentMode.trim().toUpperCase() &&
							displayList?.CURRENCY?.trim() == productPayment?.settlementCurrency?.trim() ?: productPayment?.currency?.trim() &&
                            (new BigDecimal(displayList.AMOUNT) == new BigDecimal(productPayment?.amountSettlement ?: productPayment?.amount).setScale(2, RoundingMode.UNNECESSARY) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_DOWN) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_UP))){
						validateCounter++
					}
				}
			}
			println "validateCounter: " + validateCounter
			if (validateCounter == mapList.display.size()){
				render ([success: true] as JSON)
			} else {
			render ([success: false] as JSON)
			}
		}
	}

    def validateSavedProductPayments() {
		println 'validateSavedProductPayments'
		String tradeServiceId = params.tradeServiceId
		def maxRows = 10
		def currentPage = 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = chargesPaymentService.findProductChargesPayment(maxRows, rowOffset, currentPage, tradeServiceId)
		
		def productPaymentSummary = parserService.parseGrid(params.productPaymentSummary)
		if(mapList.display?.size() != productPaymentSummary?.size()){
			render ([success: false] as JSON)
		}else {
			def validateCounter = 0
			def productPayment1 =  null;
			for (def productPayment : productPaymentSummary){
				for (def displayList : mapList.display){
					if (displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == productPayment.paymentMode.trim().toUpperCase() && displayList?.CURRENCY?.trim() == productPayment?.settlementCurrency?.trim() ?: productPayment?.currency?.trim()) {
						def productPayment2 =  productPayment.paymentMode.trim().toUpperCase();
						println ('****displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() ==' + displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase())
						println ('******productPayment.paymentMode.trim().toUpperCase() ==' + productPayment.paymentMode.trim().toUpperCase())
						
						if ((new BigDecimal(displayList.AMOUNT) == new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.UNNECESSARY)) || (new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_DOWN)) || (new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_UP))) {
							println ('displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() ==' + displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase())
							println ('productPayment.paymentMode.trim().toUpperCase() ==' + productPayment.paymentMode.trim().toUpperCase())
							println ('displayList?.CURRENCY?.trim() ==' + displayList?.CURRENCY?.trim())
							println ('productPayment?.settlementCurrency?.trim() ?: productPayment?.currency?.trim() ==' + productPayment?.settlementCurrency?.trim() ?: productPayment?.currency?.trim())
							println ('new BigDecimal(displayList.AMOUNT) ==' + new BigDecimal(displayList.AMOUNT))
							println ('new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.UNNECESSARY) ==' + new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.UNNECESSARY))
							println ('new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) ==' + new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN))
							println ('new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_DOWN) ==' + new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_DOWN))
							println ('new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) ==' + new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP))
							println ('new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_UP) ==' + new BigDecimal(productPayment.amountSettlement).setScale(2, RoundingMode.HALF_UP))
							validateCounter++
							println (validateCounter)
							productPayment1 == productPayment.paymentMode.trim().toUpperCase();
							if (productPayment1 == productPayment2) {
								println ('In here')
								validateCounter--
							}
						}
					}
				}
			}
			if (validateCounter == mapList.display.size()){
				render ([success: true] as JSON)
			} else {
				render ([success: false] as JSON)
			}
		}
	}

    def validateSavedProceedsPayments() {
		println 'validateSavedProceedsPayments'
		println params
		
		String tradeServiceId = params.tradeServiceId
		def maxRows = 10
		def currentPage = 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = chargesPaymentService.findProceedsPayment(maxRows, rowOffset, currentPage, tradeServiceId)
		
		def proceedsPaymentSummary = parserService.parseGrid(params.proceedsPaymentSummary)
		println "mapList.display?.size(): " + mapList.display?.size()
		if(mapList.display?.size() != proceedsPaymentSummary?.size() || mapList.display?.size() == 0){
			render ([success: false] as JSON)
		}else {
			if (params.remainingBalance > "0.00"){
				render ([success: false] as JSON)
			}else{
				render ([sucess: true] as JSON)
			}
			def validateCounter = 0
			for (def proceedsPayment : proceedsPaymentSummary){
				for (def displayList : mapList.display){
					if(displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == proceedsPayment.paymentMode.trim().toUpperCase() &&
						displayList.CURRENCY.trim() == proceedsPayment.settlementCurrency.trim() &&
                            (new BigDecimal(displayList.AMOUNT) == new BigDecimal(proceedsPayment.amountSettlement ?: proceedsPayment.amount).setScale(2, RoundingMode.UNNECESSARY) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(proceedsPayment.amountSettlement ?: proceedsPayment.amount).setScale(2, RoundingMode.HALF_DOWN) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(proceedsPayment.amountSettlement ?: proceedsPayment.amount).setScale(2, RoundingMode.HALF_UP))){
						validateCounter++
					}
				}
			}
			if (validateCounter == mapList.display.size()){
				render ([success: true] as JSON)
			} else {
			render ([success: false] as JSON)
			}
		}
	}

def validateSavedCharges() {
		println 'validateSavedCharges'
        List<Map<String, Object>> charges = chargesService.findAllChargesByTradeService(params.tradeServiceId)
        def jsonData = [:]

        int err = 0

        if (charges.size() == 0){
            jsonData.put("empty", "No Charges found")
        } else {
            charges.each {
                BigDecimal chargeItem = params.get(it.CHARGEFIELDID) ? new BigDecimal(params.get(it.CHARGEFIELDID)?.replaceAll(",","")) : BigDecimal.ZERO

                if (chargeItem.setScale(2, RoundingMode.CEILING).compareTo(it.ORIGINALAMOUNT) != 0) {
                    jsonData.put(it.CHARGEFIELDID, "value of " + it.CHARGEFIELDID + " did not match. (" + chargeItem.setScale(2, RoundingMode.CEILING) + " = " + it.ORIGINALAMOUNT + ")")
                }
//                if (chargeItem.multiply(new BigDecimal(params.rates)).setScale(2, RoundingMode.CEILING).compareTo(it.AMOUNT) != 0) {
//                	jsonData.put(it.CHARGEFIELDID, "value of " + it.CHARGEFIELDID + " did not match. (" + chargeItem.multiply(new BigDecimal(params.rates)).setScale(2, RoundingMode.CEILING) + " = " + it.AMOUNT + ")")
//                }
            }
        }

        render jsonData as JSON
    }

    def validateSavedChargesPayments2() {
        def maxRows = params.int('rows') ?: 10
        def currentPage = params.int('page') ?: 1
        def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows
		
        def mapList = chargesPaymentService.findServiceChargesPayment(params.tradeServiceId)
		def serviceChargeList = chargesPaymentService.getOriginalAmountServiceCharge(params.tradeServiceId)
		def paymentChargeList = chargesPaymentService.getPaymentAmountServiceCharge(params.tradeServiceId)
        def chargesPaymentSummary = parserService.parseGrid(params.chargesPaymentSummary)
		
        if(mapList.display.size() == 0){
            render ([success: false, message: "Please set-up Charges Payment."] as JSON)
        } else if (mapList.display.size() != chargesPaymentSummary.size()) {
			if(mapList.documentClass == 'EXPORT_ADVISING'){				
				println "paymentChargeList.totalPaymentAmount" + paymentChargeList.totalPaymentAmount
				println "serviceChargeList.totalChargesAmount" + Double.parseDouble(serviceChargeList.totalChargesAmount.toString().replace("[","").replace("]",""))
				if(Double.parseDouble(serviceChargeList.totalChargesAmount.toString().replace("[","").replace("]","")) > Double.parseDouble(paymentChargeList.totalPaymentAmount.replace("[","").replace("]",""))){
					println "false"
					render ([success: false, message: "Charges payment do not match."] as JSON)
	
				}else{
				println "true"
					render ([success: true] as JSON)
				}
			}else{
            	render ([success: false, message: "Charges Payment do not match."] as JSON)
			}
        } else {
            def validateCounter = 0
            for (def chargesPayment : chargesPaymentSummary){
                for (def displayList : mapList.display){
                    if(chargesPayment.amount){
                        if(displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == chargesPayment.paymentMode.trim().toUpperCase() &&
                                displayList.CURRENCY.trim() == chargesPayment.settlementCurrency.trim() &&
//						(new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.UNNECESSARY) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.UNNECESSARY) ||
                                (new BigDecimal(displayList.AMOUNT) == new BigDecimal(chargesPayment.amount.toString().replace(",","")).setScale(2, RoundingMode.UNNECESSARY) ||
                                        new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(chargesPayment.amount.toString().replace(",","")).setScale(2, RoundingMode.HALF_DOWN) ||
                                        new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(chargesPayment.amount.toString().replace(",","")).setScale(2, RoundingMode.HALF_UP))){
                            validateCounter++
                        }
                    } else {
                        if(displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == chargesPayment.paymentMode.trim().toUpperCase() &&
                                displayList.CURRENCY.trim() == chargesPayment.settlementCurrency.trim() &&
//						(new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.UNNECESSARY) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.UNNECESSARY) ||
                                (new BigDecimal(displayList.AMOUNT) == new BigDecimal(chargesPayment.amountSettlement.toString().replace(",","")).setScale(2, RoundingMode.UNNECESSARY) ||
                                        new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(chargesPayment.amountSettlement.toString().replace(",","")).setScale(2, RoundingMode.HALF_DOWN) ||
                                        new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(chargesPayment.amountSettlement.toString().replace(",","")).setScale(2, RoundingMode.HALF_UP))){
                            validateCounter++
                        }
                    }

                }
            }
            if (validateCounter == mapList.display.size()){
                render ([success: true] as JSON)
            } else {
                render ([success: false, message: "Charges Payment do not match."] as JSON)
            }
        }
    }
	
	def validateSavedChargesPayments() {
		println 'validateSavedChargesPayments'
		println params
		String tradeServiceId = params.tradeServiceId
		def maxRows = 10
		def currentPage = 1
		def rowOffset = currentPage == 1 ? 0 : (currentPage - 1) * maxRows

		def mapList = chargesPaymentService.findServiceChargesPayment(maxRows, rowOffset, currentPage, tradeServiceId)
		
		def chargesPaymentSummary = parserService.parseGrid(params.chargesPaymentSummary)
		if(mapList.display.size() != chargesPaymentSummary.size()){
			render ([success: false] as JSON)
		}else if (mapList.display.size() == 0){
			render ([success: true] as JSON)
		}else {
			def validateCounter = 0
			for (def chargesPayment : chargesPaymentSummary){
				for (def displayList : mapList.display){
					if(displayList.PAYMENTINSTRUMENTTYPE.trim().toUpperCase() == chargesPayment.paymentMode.trim().toUpperCase() &&
						displayList.CURRENCY.trim() == chargesPayment.settlementCurrency.trim() &&
//						(new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.UNNECESSARY) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.UNNECESSARY) ||
                            (new BigDecimal(displayList.AMOUNT) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.UNNECESSARY) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_DOWN) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.HALF_DOWN) ||
							new BigDecimal(displayList.AMOUNT).setScale(2, RoundingMode.HALF_UP) == new BigDecimal(chargesPayment.amount).setScale(2, RoundingMode.HALF_UP))){
						validateCounter++
					}
				}
			}
			if (validateCounter == mapList.display.size()){
				render ([success: true] as JSON)
			} else {
			render ([success: false] as JSON)
			}
		}
	}


    def checkBalancePayment() {
        //chargesPaymentService.checkPaymentBalance(params.tradeServiceId)
    }

    def checkPaymentStatusOfPayments() {
        println params
        def hasPaidPayment = chargesPaymentService.checkIfHasPaidPayment(params.documentClass, params.tradeServiceId)
        println "hasPaidPayment > " + hasPaidPayment
        def returnValue = [success: "success"]

        if (hasPaidPayment.toString() == "true") {
            returnValue = [success: "failed", message: "Please reverse all payments."]
        }
		
		if (params.documentClass?.equalsIgnoreCase("rebate")){
			returnValue = [success: "success"]
		}

        render(returnValue as JSON)
    }

    def checkUnpaidPayments() {
		println "in checkUnpaidPayments..."
        println params
        def hasUnpaidPayment = chargesPaymentService.checkIfHasUnpaidPayment(params.tradeServiceId)
        println "hasUnpaidPayment > " + hasUnpaidPayment
        def returnValue = [success: "success"]

        if (hasUnpaidPayment == true) {
            returnValue = [success: "failed", message: "There are still unpaid payments."]
        }

        render(returnValue as JSON)
    }
}
