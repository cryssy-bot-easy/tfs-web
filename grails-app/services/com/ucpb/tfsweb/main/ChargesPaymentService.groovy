package com.ucpb.tfsweb.main

import java.util.List;
import java.util.Map;

import grails.converters.JSON
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils
import org.apache.commons.lang.StringUtils
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.transaction.annotation.Transactional


/**
 * (revision)
 *	SCR/ER Number:
 *	SCR/ER Description: Missing Save Button in EBP Nego and EBC Settlement Data Entry (Redmine# 4213)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date revised:] 05/23/2017 (tfs Rev# 7497)
 *	[Date deployed:] 06/16/2017
 *	Program [Revision] Details: Updated the condition for interest rate.
 *	Member Type: Groovy
 *	Project: WEB
 *	Project Name: ExportBillsPurchaseController.groovy
 */
class ChargesPaymentService {

    def queryService
    def foreignExchangeService
    def coreAPIService

    def tradeServiceChargesPaymentFinder = com.ucpb.tfs.application.query.payment.IPaymentFinder.class
	
	def serviceChargeFinder = com.ucpb.tfs.application.query.reference.IServiceChargeFinder.class

	def tradeServiceFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class
	
	@Transactional(readOnly = true)
	Map<String, Object> getPnNumber(documentNumber){
		Map<String, Object> param = [docucmentNumber: documentNumber]
		
		List<Map<String,Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findPaymentPNNumberByDocumentNumber", param)
		
		return [pnNumber: queryResult.PNNUMBER.toString().replace("[", "").replace("]", "")]
	}
	
	@Transactional(readOnly = true)
	Map<String, Object> getPaymentAmountServiceCharge(tradeServiceId){
		
		Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]
		
		println "PARAMETER" + tradeServiceId
		
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findPaymentServiceCharge", param)
		
		println queryResult.AMOUNT.toString()
		return [totalPaymentAmount: queryResult.AMOUNT.toString()]
		}
	
	@Transactional(readOnly = true)
	 Map<String, Object> getOriginalAmountServiceCharge(tradeServiceId){
		 
		 Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]
		 
		 println "PARAMETER" +tradeServiceId
		 
		 List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		 List<Map<String, Object>> queryResult = queryService.executeQuery(serviceChargeFinder, "findSumServiceCharge", param)
		 
		 return [totalChargesAmount: queryResult.TOTALAMOUNT.toString()]
		 }
	
    @Transactional(readOnly = true)
    Map<String, Object> findServiceChargesPayment(tradeServiceId) {

        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findServiceChargesPaymentDetail", param)
		
		def map = [:] 
		
		queryResult.each{ details ->
			map.put("details", details.DETAILS)
        }
		
		
		JSONObject object = new JSONObject(map.get("details"))
		
		String documentClass = object.getString("documentClass");
		String amountPaid = object.getString("totalAmountCharges");
		
		println "amountPaid" + amountPaid
        return [display: queryResult, totalRows: queryResult?.size(), documentClass: documentClass, amountPaid: amountPaid]
    }

    // find all service charges payment
    @Transactional(readOnly = true)
    Map<String, Object> findServiceChargesPayment(maxRows, rowOffset, currentPage, tradeServiceId) {

		println "tradeServiceId: " + tradeServiceId
        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findServiceChargesPaymentDetail", param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }

	// find approved ets service charges payment
	List<Map<String, Object>> findAllApprovedEtsServicePayment(tradeServiceId) {
		String methodName = "findServiceChargesEtsPaymentDetail"
		Map<String, Object> param = [tradeServiceId: tradeServiceId]
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, methodName, param)
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		
		queryResult.each { approvedEtsServicePayment ->
			def map = [:]
			map.put("approvedEtsServicePaymentReferenceNumber", approvedEtsServicePayment.REFERENCENUMBER)
			map.put("approvedEtsServicePaymentPaymentInstrumentType", approvedEtsServicePayment.PAYMENTINSTRUMENTTYPE)
			map.put("approvedEtsServicePaymentCurrency", approvedEtsServicePayment.CURRENCY)
			map.put("approvedEtsServicePaymentAmount", approvedEtsServicePayment.AMOUNT)
			map.put("approvedEtsServicePaymentStatus", approvedEtsServicePayment.STATUS)
			map.put("approvedEtsServicePaymentPaymentInstrumentTypeAmount", approvedEtsServicePayment.PAYMENTINSTRUMENTTYPE + "serviceAmountEtsApproved")
			returnList.add(map)
		}
		return returnList
	}

    // find all product charges payment
    @Transactional(readOnly = true)
    Map<String, Object> findProductChargesPayment(maxRows, rowOffset, currentPage, tradeServiceId) {

        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProductChargePaymentDetail", param)
        println "queryResult:" + queryResult
        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
	
	// find approved ets product charges payment
	List<Map<String, Object>> findAllApprovedEtsProductPayment(tradeServiceId) {
		String methodName = "findProductChargeEtsPaymentDetail"
		Map<String, Object> param = [tradeServiceId: tradeServiceId]
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, methodName, param)
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		
		queryResult.each { approvedEtsProductPayment ->
			def map = [:]
			map.put("approvedEtsProductPaymentReferenceNumber", approvedEtsProductPayment.REFERENCENUMBER)
			map.put("approvedEtsProductPaymentPnNumber", approvedEtsProductPayment.PNNUMBER)
			map.put("approvedEtsProductPaymentPaymentInstrumentType", approvedEtsProductPayment.PAYMENTINSTRUMENTTYPE)
			map.put("approvedEtsProductPaymentCurrency", approvedEtsProductPayment.CURRENCY)
			map.put("approvedEtsProductPaymentAmount", approvedEtsProductPayment.AMOUNT)
			map.put("approvedEtsProductPaymentStatus", approvedEtsProductPayment.STATUS)
			map.put("approvedEtsProductPaymentPaymentInstrumentTypeAmount", approvedEtsProductPayment.PAYMENTINSTRUMENTTYPE + "productAmountEtsApproved")
			returnList.add(map)
		}
		return returnList
	}

    // find all product charges payment
    @Transactional(readOnly = true)
    String getCilexFlag(tradeServiceId) {
        println "getCilexFlag"+tradeServiceId
        Map<String, Object> param = [tradeServiceId: tradeServiceId ?tradeServiceId.trim(): ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProductChargePaymentDetail", param)
        println"queryResult:"+queryResult

        String cilexFlag = 'false';
        queryResult.each { oneOfPayments ->
            println"oneOfPayments:"+oneOfPayments
            if (!oneOfPayments?.CURRENCY?.toString()?.equalsIgnoreCase("PHP")) {
                cilexFlag = 'true'
            }
        }
        println"cilexFlag:"+cilexFlag
        return cilexFlag
    }

    @Transactional(readOnly = true)
    Map<String, Object> findProceedsPayment(maxRows, rowOffset, currentPage, tradeServiceId) {

        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProceedsPaymentDetail", param)

        Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
        return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
    }
	
	// find approved ets proceeds charges payment
	List<Map<String, Object>> findAllApprovedEtsProceedsPayment(tradeServiceId) {
		String methodName = "findProceedsEtsPaymentDetail"
		Map<String, Object> param = [tradeServiceId: tradeServiceId]
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, methodName, param)
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		
		queryResult.each { approvedEtsProceedsPayment ->
			def map = [:]
			map.put("approvedEtsProceedsPaymentReferenceNumber", approvedEtsProceedsPayment.REFERENCENUMBER)
			map.put("approvedEtsProceedsPaymentPaymentInstrumentType", approvedEtsProceedsPayment.PAYMENTINSTRUMENTTYPE)
			map.put("approvedEtsProceedsPaymentCurrency", approvedEtsProceedsPayment.CURRENCY)
			map.put("approvedEtsProceedsPaymentAmount", approvedEtsProceedsPayment.AMOUNT)
			map.put("approvedEtsProceedsPaymentStatus", approvedEtsProceedsPayment.STATUS)
			map.put("approvedEtsProceedsPaymentPaymentInstrumentTypeAmount", approvedEtsProceedsPayment.PAYMENTINSTRUMENTTYPE + "proceedsAmountEtsApproved")
			returnList.add(map)
		}
		return returnList
	}

    @Transactional(readOnly = true)
    def constructServiceChargesGrid(display) {
        constructServiceChargesGridWithReversalIndicator(display, false, false)
    }

    // construct service charges grid
    @Transactional(readOnly = true)
    def constructServiceChargesGridWithReversalIndicator(display, isReversal, isViewReversed) {
        def list = display.collect {
            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPERATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPERATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPERATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)
			
			Map<String, Object> map = JSON.parse(it.DETAILS)

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            (isReversal || isViewReversed) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP"))) ? it.REFERENCENUMBER : "",
                            it.ACCOUNTNAME
                    ]
            ]
        }
        ////println"constructServiceChargesGrid:"+list
        return list
    }

    @Transactional(readOnly = true)
    def constructProductChargesGrid(display, isReversal, isViewReversed) {
        constructProductChargesGridWithReversalIndicator(display, false, false)
    }

    // construct product charges grid
    @Transactional(readOnly = true)
    def constructProductChargesGridWithReversalIndicator(display, isReversal, isViewReversed) {
        def list = display.collect {

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String interestTermCode = it.INTERESTTERMCODE ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("interestTermCode=" + interestTermCode + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode)

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]
//            println "paramD" + it.ACCOUNTNAME
            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            map.documentType ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,map.documentType.toUpperCase()) : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
                            (isReversal || isViewReversed) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.SEQUENCENUMBER,
							'',
							it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly = true)
    def constructProductChargesGridNonLc(display) {
        constructProductChargesGridNonLcWithReversalIndicator(display, false, false)
    }

    @Transactional(readOnly = true)
    def constructProductChargesGridNonLcWithReversalIndicator(display, isReversal, isViewReversed) {
        def list = display.collect {
//			println "ITTTTTUUUU:"+it
			
            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String interestTermCode = it.INTERESTTERMCODE ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("interestTermCode=" + interestTermCode + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode + "&")

            setupString.append("loanPaymentCode=" + (it.PAYMENTCODE ?: "") + "&")
            setupString.append("withCramApproval=" + ((it.WITHCRAMAPPROVAL != null) ? it.WITHCRAMAPPROVAL : ""))
//            println ">>>>>>>>>>>>>>> " + setupString.toString()
            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)
//            println "ratesList:" + ratesList

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: map.currency, //it.LCCURRENCY,
                    convertTo: "LC"
            ]

//            //printlnparam

            def result = foreignExchangeService.computeRateConversion(param)
			
//			println "CHARGESPAYMENTTTUU:"+map.documentType
			
			
            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
                            (isReversal || isViewReversed) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.sequenceNumber ?: "",
							"",
							"",
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly = true)
    def constructProductChargesGridDomestic(display) {

        def list = display.collect {

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String interestTermCode = it.INTERESTTERMCODE ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
        	String loanPaymentCode = it.PAYMENTCODE ?: ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String pnNumber = it.PNNUMBER ?: ""
			String withCramApproval = it.WITHCRAMAPPROVAL ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("interestTermCode=" + interestTermCode + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanPaymentCode=" + loanPaymentCode + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode + "&")
            setupString.append("withCramApproval=" + withCramApproval)

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.FACILITYID,
                            it.FACILITYTYPE,
                            it.FACILITYREFERENCENUMBER,
                            //it.sequenceNumber ?: "",
                            //NumberUtils.currencyFormat(new Double(it.AMOUNT ?: (it.AMOUNTINLCCURRENCY?:0)))
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY ? it.AMOUNTINLCCURRENCY : it.AMOUNT)),
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly = true)
    def constructProductPaymentDomestic(display) {

        def list = display.collect {

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode)

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            String status = ""

            String paymentString = ""

            if ("UNPAID".equalsIgnoreCase(it.STATUS)) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                	paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }
            } else {
                status = "Paid"

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
//                    paymentString = "<input type=\"button\" class=\"input_button_negative actionWidget\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    paymentString = "<input type=\"button\" class=\"input_button_negative actionWidget\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative actionWidget\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            pnNumber,
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.STATUS,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            //(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.sequenceNumber ?: "",
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly = true)
    def constructProductChargesGridSettlement(display) {

        def list = display.collect {

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode + "&")

            setupString.append("loanPaymentCode=" + (it.PAYMENTCODE ?: "") + "&")
            setupString.append("withCramApproval=" + (it.WITHCRAMAPPROVAL ?: ""))



            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""
            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
//                            pnNumber,
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }
	
	@Transactional(readOnly = true)
	def constructMdRefund(display) {
		
		def list = display.collect {

			String status = ""

			String paymentString = ""
			Map<String, Object> map = JSON.parse(it.DETAILS)

			if ("UNPAID".equalsIgnoreCase(it.STATUS)) {
				status = "Not Paid"
				if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
				} else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
					paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
				} else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
					paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payCreditToCasa(id);\"/>";
				} else {
					paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
				}
			} else {
				status = "Paid"
				
				if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
				} else {
					paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"

					if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("MC_ISSUANCE")) {
						paymentString = ""
					}
				}
			}
			println "referenceId: " + it.REFERENCEID
			[id: it.ID,
					cell: [
							(it.PAYMENTINSTRUMENTTYPE in ["CASA", 'AP', 'AR']) ? it.REFERENCENUMBER : "",
							map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") :
								("AP".equalsIgnoreCase(map.documentClass) && "Refund".equalsIgnoreCase(map.serviceType)) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"credit") :
								("MD".equalsIgnoreCase(map.documentClass) && "Application".equalsIgnoreCase(map.serviceType) && "REFUND".equalsIgnoreCase(map.documentType)) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"credit") :
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
							it.CURRENCY,
							NumberUtils.currencyFormat(it.AMOUNT),
							"<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
							status,
							paymentString,
							(!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA"))) ? it.REFERENCENUMBER : "",
							it.PAYMENTINSTRUMENTTYPE,
							it.ACCOUNTNAME,
							it.REFERENCEID,
							DateUtils.shortDateFormat(it.PAIDDATE)
					]
			]
		}

		return list
	}

    @Transactional(readOnly = true)
    def constructApPayment(display) {

        def list = display.collect {

            String status = ""

            String paymentString = ""
			Map<String, Object> map = JSON.parse(it.DETAILS)

            if ("UNPAID".equalsIgnoreCase(it.STATUS)) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                	paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }
            } else {
                status = "Paid"
				

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"

                    if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("MC_ISSUANCE")) {
                        paymentString = ""
                    }
                }
            }
			println "referenceId: " + it.REFERENCEID
            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE in ["CASA", 'AP', 'AR']) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								("AP".equalsIgnoreCase(map.documentClass) && "Refund".equalsIgnoreCase(map.serviceType)) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"credit") :
								("MD".equalsIgnoreCase(map.documentClass) && "Application".equalsIgnoreCase(map.serviceType) && "REFUND".equalsIgnoreCase(map.documentType)) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"credit") :
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(it.AMOUNT),
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA"))) ? it.REFERENCENUMBER : "",
                            it.PAYMENTINSTRUMENTTYPE,
							it.ACCOUNTNAME,
							it.REFERENCEID,
							DateUtils.shortDateFormat(it.PAIDDATE)
                    ]
            ]
        }

        return list
    }

    @Transactional(readOnly = true)
    def constructProceedsChargesGrid(display) {
		println "ets ets ets"
        def list = display.collect {

//            StringBuilder rates = new StringBuilder()
//
//            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
//            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
//            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""
//             //TODO add special rates
//            rates.append("passOnRateUsdToPhp="+passOnRateUsdToPhp+",")
//            rates.append("passOnRateThirdToUsd="+passOnRateThirdToUsd+",")
//            rates.append("passOnRateThirdToPhp="+passOnRateThirdToPhp+",")
//
//            String urr = it.URR ?: ""
//            rates.append("urr="+urr)

            [id: it.ID,
                    cell: [
                            formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, "credit"),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
//                            "amount in lc currency",
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
//                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }
	
	@Transactional(readOnly = true)
	def constructProceedsChargesGridWithReversalIndicator(display, isReversal, isViewReversed) {
		def list = display.collect {

			String bookingCurrency = it.BOOKINGCURRENCY ?: ""
			String interestRate = it.INTERESTRATE ?: ""
			String interestTerm = it.INTERESTTERM ?: ""
			String interestTermCode = it.INTERESTTERMCODE ?: ""
			String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
			String loanTerm = it.LOANTERM ?: ""
			String loanTermCode = it.LOANTERMCODE ?: ""
			String repricingTerm = it.REPRICINGTERM ?: ""
			String repricingTermCode = it.REPRICINGTERMCODE ?: ""

			StringBuilder setupString = new StringBuilder()
			setupString.append("bookingCurrency=" + bookingCurrency + "&")
			setupString.append("interestRate=" + interestRate + "&")
			setupString.append("interestTerm=" + interestTerm + "&")
			setupString.append("interestTermCode=" + interestTermCode + "&")
			setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
			setupString.append("loanTerm=" + loanTerm + "&")
			setupString.append("loanTermCode=" + loanTermCode + "&")
			setupString.append("repricingTerm=" + repricingTerm + "&")
			setupString.append("repricingTermCode=" + repricingTermCode)

			StringBuilder rates = new StringBuilder()

			String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
			String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
			String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

			rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
			rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
			rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

			String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
			String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
			String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

			////printlnspecialRateThirdToPhp
			////printlnspecialRateThirdToUsd
			////printlnspecialRateUsdToPhp

			rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
			rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
			rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

			String urr = it.URR ?: ""
			rates.append("urr=" + urr)

			List<Object> ratesList = new ArrayList<Object>()
			ratesList.add(0, it.PASSONRATETHIRDTOPHP)
			ratesList.add(1, it.PASSONRATETHIRDTOUSD)
			ratesList.add(2, it.PASSONRATEUSDTOPHP)
			ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
			ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
			ratesList.add(5, it.SPECIALRATEUSDTOPHP)
			ratesList.add(6, it.URR)

			Map<String, Object> map = JSON.parse(it.DETAILS)

			def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
			BigDecimal conversionRate = rate

			def param = [
					amount: it.AMOUNT.toString(),
					conversion_rate: conversionRate,
					base_ccy: it.CURRENCY,
					target_ccy: it.LCCURRENCY,
					convertTo: "LC"
			]
//            println "paramD" + it.ACCOUNTNAME
			def result = foreignExchangeService.computeRateConversion(param)

			[id: it.ID,
					cell: [
							map.documentType ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,map.documentType.toUpperCase()) :
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, "credit"),
							it.CURRENCY,
							NumberUtils.currencyFormat(new Double(it.AMOUNT)),
							NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
							(isReversal || isViewReversed) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
							it.PAYMENTINSTRUMENTTYPE,
							it.REFERENCEID,
							rates.toString(),
							(!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
							(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
							setupString.toString(),
							it.SEQUENCENUMBER,
							'',
							it.ACCOUNTNAME
					]
			]
		}

		return list
	}

    def constructProceedsChargesPaymentGrid(display) {
        constructProceedsChargesPaymentGridWithReversalIndicator(display, false, false)
    }

    @Transactional(readOnly = true)
    def constructProceedsChargesPaymentGridWithReversalIndicator(display, isReversal, isViewReversal) {
        def list = display.collect {

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""
            //TODO add special rates
            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            String paymentString = ""

            String status = ""
            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                	paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("PDDTS") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("SWIFT") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("MC_ISSUANCE")) {
                    paymentString = ""
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCreditCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payCreditToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }

                if (isReversal || isViewReversal) {
                    paymentString = ""
                }

            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else {
                status = "Paid"
                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("PDDTS") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("SWIFT") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("MC_ISSUANCE")) {
                    status = "Paid"
                    paymentString = ""
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE, "credit"),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
//                            "amount in lc currency",
                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
//                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                    		it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    // construct service charges grid with payment
    @Transactional(readOnly = true)
    def constructChargesPaymentGrid(display) {
        return constructChargesPaymentGridWithReversalIndicator(display, false, false)
    }

    // construct service charges grid with payment
    @Transactional(readOnly = true)
    def constructChargesPaymentGridWithReversalIndicator(display, isReversal, isViewReversal) {

        def list = display.collect {
            String paymentString = ""
            String status = "" 
			println "PN NUMBER!: " + (it.PNNUMBER == -9999)
            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""

            StringBuilder setupString = new StringBuilder()
            if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("IB_LOAN") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("TR_LOAN") || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("interestRate=" + interestRate + "&")
                setupString.append("interestTerm=" + interestTerm + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
                setupString.append("loanTerm=" + loanTerm + "&")
                setupString.append("loanTermCode=" + loanTermCode + "&")
                setupString.append("repricingTerm=" + repricingTerm + "&")
                setupString.append("repricingTermCode=" + repricingTermCode)
            } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN")) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate)
            }

            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                	paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
				    status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }

                if (isReversal || isViewReversal) {
                    paymentString = ""
                }

            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else {
                status = "Paid"

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
//                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
                    	paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }

                // SHOULD NEVER BE REMOVED TO BE ABLE TO REVERSE THE PAYMENT
//                if (isReversal || isViewReversal) {
//                    paymentString = ""
//                }
            }

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""


            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

//            List<Object> ratesList = new ArrayList<Object>()
//            ratesList.add(0,it.PASSONRATETHIRDTOPHP)
//            ratesList.add(1,it.PASSONRATETHIRDTOUSD)
//            ratesList.add(2,it.PASSONRATEUSDTOPHP)
//
//            def rate = getRates(it.LCCURRENCY, it.CURRENCY, ratesList)
//            BigDecimal conversionRate = rate
//
//            def param = [
//                    amount: it.AMOUNT.toString(),
//                    conversion_rate: conversionRate,
//                    base_ccy: it.CURRENCY,
//                    target_ccy: it.LCCURRENCY,
//                    convertTo: "LC"
//            ]
//
//            def result = foreignExchangeService.computeRateConversion(param)

			Map<String, Object> map = JSON.parse(it.DETAILS)
			
            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                     map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") :
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            (isReversal || isViewReversal) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            it.ACCOUNTNAME
//                            result.equivLc,
//                            setupString.toString()
                    ]
            ]
        }
        ////println"("+list+")"
        return list
    }

    @Transactional(readOnly = true)
    def constructProductChargesPaymentMdGrid(display) {
        constructProductChargesPaymentMdGridWithReversalIndicator(display, false)
    }

    @Transactional(readOnly = true)
    def constructProductChargesPaymentMdGridWithReversalIndicator(display, isReversal) {

        def list = display.collect {
            String paymentString = ""
            String status = ""
			
            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: "0"
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String paymentTerm = it.PAYMENTTERM ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()


            if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("interestRate=" + interestRate + "&")
                setupString.append("interestTerm=" + interestTerm + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
                setupString.append("loanTerm=" + loanTerm + "&")
                setupString.append("loanTermCode=" + loanTermCode + "&")
                setupString.append("repricingTerm=" + repricingTerm + "&")
                setupString.append("repricingTermCode=" + repricingTermCode + "&")

                setupString.append("loanPaymentCode="+ (it.PAYMENTCODE ?: "null") + "&")

                setupString.append("withCramApproval="+ (it.WITHCRAMAPPROVAL ?: "null") + "&")
            } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN")) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate)
            }

            def finalSetupString = setupString.toString()
//            println finalSetupString
            if (finalSetupString.endsWith("&")) {
                finalSetupString = finalSetupString.substring(0, (finalSetupString.length() - 1))
            }

            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                	paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }

                if (isReversal) {
                    paymentString = ""
                }
            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else if ("PROCESSING".equalsIgnoreCase(it.STATUS)) {
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + it.ID + "\'; inquireLoanStatus(id);\"/>"
                status = "Processing"
            } else {
                status = "Paid"
				if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Accepted"
				}

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)

            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)
            def temp000 = result.equivLc

            if(it.AMOUNTINLCCURRENCY){
                 temp000 = NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY))
            }
//            println "hahaha " + temp000
            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            it.PNNUMBER,
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            isReversal ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            temp000,//result.equivLc,
                            //setupString.toString(),
                            finalSetupString,
                            it.SEQUENCENUMBER,
                            it.ACCOUNTNAME
                    ]
            ]
        }
        ////println"("+list+")"
        return list
    }

    @Transactional(readOnly = true)
    def constructUaPaymentProcessingGrid(display, isReversal) {

        def list = display.collect {
            String paymentString = ""
            String status = ""

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String paymentTerm = it.PAYMENTTERM ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()
            if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("interestRate=" + interestRate + "&")
                setupString.append("interestTerm=" + interestTerm + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
                setupString.append("loanTerm=" + loanTerm + "&")
                setupString.append("loanTermCode=" + loanTermCode + "&")
                setupString.append("repricingTerm=" + repricingTerm + "&")
                setupString.append("repricingTermCode=" + repricingTermCode + "&")

                setupString.append("loanPaymentCode="+ (it.PAYMENTCODE ?: "") + "&")
                setupString.append("withCramApproval="+ (it.WITHCRAMAPPROVAL ?: "") + "&")

            } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN")) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate)
            }

            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }
            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else if ("PROCESSING".equalsIgnoreCase(it.STATUS)) {
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + it.ID + "\'; inquireLoanStatus(id);\"/>"
                status = "Processing"
            } else {
                status = "Accepted"

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
//                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)

            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)
            def temp000 = result.equivLc

            if(it.AMOUNTINLCCURRENCY){
                temp000 = NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY))
            }
//            println "hahaha " + temp000

//            println it.PAYMENTINSTRUMENTTYPE

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            it.PNNUMBER,
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ?
                                formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") :
                                formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            isReversal ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            temp000,//result.equivLc,
                            setupString.toString(),
                            it.SEQUENCENUMBER,
                            it.ACCOUNTNAME
                    ]
            ]
        }
        ////println"("+list+")"
        return list
    }

    @Transactional(readOnly = true)
    def constructMdPaymentGrid(display, isReversal) {

        def list = display.collect {
            String paymentString = ""
            String status = ""

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String paymentTerm = it.PAYMENTTERM ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()
            if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("interestRate=" + interestRate + "&")
                setupString.append("interestTerm=" + interestTerm + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
                setupString.append("loanTerm=" + loanTerm + "&")
                setupString.append("loanTermCode=" + loanTermCode + "&")
                setupString.append("repricingTerm=" + repricingTerm + "&")
                setupString.append("repricingTermCode=" + repricingTermCode)

            } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN")) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate)
            }

            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                	paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }
            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else if ("PROCESSING".equalsIgnoreCase(it.STATUS)) {
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + it.ID + "\'; inquireLoanStatus(id);\"/>"
                status = "Processing"
            } else {
                status = "Paid"

                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }
            }

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)

            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
                            isReversal ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            status,
                            paymentString,
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),
                            it.ACCOUNTNAME,
							setupString.toString(),
                            it.SEQUENCENUMBER
                    ]
            ]
        }
        ////println"("+list+")"
        return list
    }


    @Transactional(readOnly = true)
    def constructProductChargesPaymentGrid(display) {
        return constructProductChargesPaymentGridWithReversalIndicator(display, false, false)
    }

    @Transactional(readOnly = true)
    def constructProductChargesPaymentGridWithReversalIndicator(display, isReversal, isViewReversal) {

        def list = display.collect {
            String paymentString = ""
            String status = ""

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String paymentTerm = it.PAYMENTTERM ?: ""

            StringBuilder setupString = new StringBuilder()
            if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("interestRate=" + interestRate + "&")
                setupString.append("interestTerm=" + interestTerm + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
                setupString.append("loanTerm=" + loanTerm + "&")
                setupString.append("loanTermCode=" + loanTermCode + "&")
                setupString.append("repricingTerm=" + repricingTerm + "&")
                setupString.append("repricingTermCode=" + repricingTermCode)

            } else if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("UA_LOAN")) {
                setupString.append("bookingCurrency=" + bookingCurrency + "&")
                setupString.append("loanMaturityDate=" + loanMaturityDate)
            }

			println "it.STATUS: " + it.STATUS
            if (it.STATUS.equalsIgnoreCase("UNPAID")) {
                status = "Not Paid"
                if ("IB_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "TR_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "DBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE) || "EBP".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Not Accepted"
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + it.ID + "\'; showLoanDetails(id);\"/>";
                } else if ("CASA".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
//                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payViaCasa(id);\"/>";
                    paymentString = "<input type=\"button\" class=\"input_button actionWidget\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; payDebitToCasa(id);\"/>";
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + it.ID + "\'; onPayClick(id);\"/>";
                }

                if (isReversal || isViewReversal) {
                    paymentString = ""
                }
            } else if ("REJECTED".equalsIgnoreCase(it.STATUS)) {
                status = "Rejected";
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Rejected\" onclick=\"var id=\'" + it.ID + "\'; getLoanErrors(id);\"/>";
            } else if ("PROCESSING".equalsIgnoreCase(it.STATUS)) {
                paymentString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + it.ID + "\'; inquireLoanStatus(id);\"/>"
                status = "Processing"
            } else {
                status = "Paid"
				if ("UA_LOAN".equalsIgnoreCase(it.PAYMENTINSTRUMENTTYPE)) {
					status = "Accepted"
				}
                if (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) {
					if(it.PNNUMBER && Long.valueOf(it.PNNUMBER.toString()).equals(Long.valueOf(-9999))){
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectTfsPayment(id);\"/>"
					}else{
						paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + it.ID + "\'; errorCorrectCasaPayment(id);\"/>"
					}
                } else {
                    paymentString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + it.ID + "\'; onReversePaymentClick(id);\"/>"
                }

                // SHOULD NEVER BE REMOVED TO BE ABLE TO REVERSE THE PAYMENT
//                if (isViewReversal && !isReversal) {
//                    paymentString = ""
//                }
            }

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)

            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)

            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)
//            println "weaewaeawea " + it.AMOUNTINLCCURRENCY

            if ("CORRES_CHARGE".equalsIgnoreCase(map.documentClass) && "SETTLEMENT".equalsIgnoreCase(map.serviceType)) {			
	            [id: it.ID,
	                    cell: [
	                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
	                            it.PNNUMBER,
								map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ? 
									formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") : 
									formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
	                            it.CURRENCY,
	                            NumberUtils.currencyFormat(new Double(it.AMOUNT)),
	                            (isReversal || isViewReversal) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
	                            status,
	                            paymentString,
	                            it.PAYMENTINSTRUMENTTYPE,
	                            it.REFERENCEID,
	                            rates.toString(),
	                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
	                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),//result.equivLc,
	                            setupString.toString(),
	                            it.SEQUENCENUMBER,	"", "",						
	                            it.ACCOUNTNAME
	                    ]
	            ]
			} else {
				[id: it.ID,
					cell: [
							(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
							it.PNNUMBER,
							map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ?
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") :
								formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
							it.CURRENCY,
							NumberUtils.currencyFormat(new Double(it.AMOUNT)),
							(isReversal || isViewReversal) ? "" : "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
							status,
							paymentString,
							it.PAYMENTINSTRUMENTTYPE,
							it.REFERENCEID,
							rates.toString(),
							(!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
							NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),//result.equivLc,
							setupString.toString(),
							it.SEQUENCENUMBER,
							it.ACCOUNTNAME
					]
				]
			}
        }
        ////println"("+list+")"
        return list
    }

    String formatModeOfPayment(paymentMode, paymentType) {

        switch (paymentMode) {
            case "CASA":
                if ("credit".equals(paymentType)) {
                    return "Credit to CASA"
                } else {
                    return "Debit from CASA"
                }
            case "CHECK":
                return "Check"
            case "CASH":
                return "Cash"
            case "AP":
                return "Apply AP"
            case "AR":
                return "Set-up AR"
            case "REMITTANCE":
                return "Remittance / IBT"
            case "MC_ISSUANCE":
                return "Issuance to MC"
            case "SWIFT":
                return "Remittance via SWIFT"
            case "PDDTS":
                return "Remittance via PDDTS"
            case "IB_LOAN":
                return "IB Loan"
            case "DBP":
				return "DBP Loan"
            case "EBP":
				return "EBP Loan"
            case "TR_LOAN":
				if("DOMESTIC".equals(paymentType)){
					return "DTR Loan"
				}else{
					return "TR Loan"
				}
            case "UA_LOAN":
				if("DOMESTIC".equals(paymentType)){
					return "DUA Loan"
				}else{
					return "UA Loan"
				}
            case "MD":
                return "Apply MD"
            case "IBT_BRANCH":
                return "IBT-Branch"
        }
    }

    String formatModeOfPayment(paymentMode) {
		
        switch (paymentMode) {
            case "CASA":
                return "Debit from CASA"
            case "CHECK":
                return "Check"
            case "CASH":
                return "Cash"
            case "AP":
                return "Apply AP"
            case "AR":
                return "Set-up AR"
            case "REMITTANCE":
                return "Remittance / IBT"
            case "MC_ISSUANCE":
                return "Issuance to MC"
            case "SWIFT":
                return "Remittance via SWIFT"
            case "PDDTS":
                return "Remittance via PDDTS"
            case "IB_LOAN":
                return "IB Loan"
            case "DBP":
                return "DBP Loan"
            case "EBP":
				return "EBP Loan"
            case "TR_LOAN":
                return "TR Loan"
            case "UA_LOAN":
                return "UA Loan"
            case "MD":
                return "Apply MD"
            case "IBT_BRANCH":
                return "IBT-Branch"
        }
    }

    Map<String, Object> findAllPayments(tradeServiceId) {
        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProductChargePaymentDetail", param)

        int loanCounter = 0
        queryResult.each {
            if (it.containsValue("TR_LOAN") || it.containsValue("IB_LOAN") || it.containsValue("UA_LOAN") || it.containsValue("DBP") || it.containsValue("EBP")) {
                loanCounter++
            }
        }

        Map<String, Object> returnMap = [payments: constructPayments(queryResult), loanCount: loanCounter]
        return returnMap
    }

    List<Map<String, Object>> constructPayments(queryResult) {
        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()

        queryResult.each {
            Map<String, Object> map = new HashMap<String, Object>()

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp)

            map.put("LOANTERMCODE", it.LOANTERMCODE ?: "")
            map.put("REPRICINGTERM", it.REPRICINGTERM ?: "")
            map.put("LOANMATURITYDATE", it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : "")
            map.put("BOOKINGCURRENCY", it.BOOKINGCURRENCY ?: "")
            map.put("REFERENCENUMBER", it.REFERENCENUMBER ?: "")
            map.put("PAYMENTINSTRUMENTTYPE", it.PAYMENTINSTRUMENTTYPE ?: "")
            map.put("LOANTERM", it.LOANTERM ?: "")
            map.put("STATUS", it.STATUS ?: "")
            map.put("AMOUNT", it.AMOUNT ? NumberUtils.currencyFormat(it.AMOUNT) : "")
            map.put("REPRICINGTERMCODE", it.REPRICINGTERMCODE ?: "")
            map.put("INTERESTTERM", it.INTERESTTERM ?: "")
            map.put("CURRENCY", it.CURRENCY ?: "")
            map.put("INTERESTRATE", it.INTERESTRATE ?: "")
            map.put("ID", it.ID ?: "")
            map.put("RATES", rates.toString())
            map.put("PAYMENTTERM", it.PAYMENTTERM ?: "")
            map.put("FACILITYID", it.FACILITYID ?: "")
            map.put("LOANTERM", it.LOANTERM)
            map.put("INTERESTTERMCODE", StringUtils.trim(it.INTERESTTERMCODE) ?: "")
            map.put("PAYMENTCODE", it.PAYMENTCODE ?: "")
            map.put("PNNUMBER", it.PNNUMBER ?: "")
            map.put("AGRIAGRATAGGING", it.AGRIAGRATAGGING ?: "")
            map.put("NUMBEROFFREEFLOATDAYS", it.NUMBEROFFREEFLOATDAYS ?: "")


            returnList.add(map)
        }

        return returnList
    }

    def getRates(lcCurrency, currency, rates) {
        //println'lcCurrency > ' + lcCurrency
        //println'currency > ' + currency
        //println'rates > ' + rates
        if (lcCurrency && currency && rates) {
            switch (currency) {
                case "USD":
                    switch (lcCurrency) {
                        case "USD":
                            return 1
                        case "PHP":
                            return rates[5] ?: 0  //rates[2]
                        default:
                            return rates[4] ?: 0 //rates[1]
                    }
                case "PHP":
                    switch (lcCurrency) {
                        case "USD":
                            return rates[5] ?: 0  //rates[2]
                        case "PHP":
                            return 1
                        default:
                            // return rates [3] //rates[0]
                            // jett:  x / sell usd-php / sell usd-third
                            BigDecimal USDtoPHP = new BigDecimal(rates[5] ?: 0)
                            BigDecimal THIRDtoUSD = new BigDecimal(rates[4] ?: 0)
                            return (THIRDtoUSD.setScale(8, BigDecimal.ROUND_HALF_UP)).multiply(USDtoPHP.setScale(8, BigDecimal.ROUND_HALF_UP))
                    //return rates[5]*rates[4] //rates[0]
                    }
                default:
                    switch (lcCurrency) {
                        case "USD":
                            return rates[4] ?: 0 //rates [1]
                        case "PHP":
                            return rates[3] ?: 0 //rates[0]
                        default:
                            return 1
                    }
            }
        }
    }

    String getUsancePeriod(documentNumber, negotiationValueDate) {
        Map<String, Object> param = [documentNumber: documentNumber ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceFinder, "findUsancePeriodByDocumentNumber", param)

        Integer usancePeriod = queryResult[0]['USANCEPERIOD']
        Date negoDate = DateUtils.parse(negotiationValueDate)

        Calendar cal = Calendar.getInstance()
        cal.setTime(negoDate)
        cal.add(Calendar.DATE, usancePeriod)

        if (cal.get(Calendar.DAY_OF_WEEK).equals(Calendar.SATURDAY)) {
            cal.add(Calendar.DATE, 2)
        } else if (cal.get(Calendar.DAY_OF_WEEK).equals(Calendar.SUNDAY)) {
            cal.add(Calendar.DATE, 1)
        }

        ////printlncal.getTime()

        return DateUtils.shortDateFormat(cal.getTime())
    }

    def findNegotiationPayments(tradeServiceId) {
        Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProceedsPaymentDetail", param)

        def pddtsFlag = "N"

        def mt103Flag = "N"


        int pddtsCtr = 0
        int mt103Ctr = 0

        BigDecimal pddtsAmount = BigDecimal.ZERO
        BigDecimal mt103Amount = BigDecimal.ZERO

        queryResult.each {
            if (it.containsKey("PAYMENTINSTRUMENTTYPE") && it.containsValue("PDDTS")) {
                pddtsCtr++
                pddtsAmount = it.AMOUNT
            }

            if (it.containsKey("PAYMENTINSTRUMENTTYPE") && it.containsValue("SWIFT")) {
                mt103Ctr++
                mt103Amount = it.AMOUNT
            }
        }

        if (pddtsCtr > 0) {
            pddtsFlag = "Y"
        }

        if (mt103Ctr > 0) {
            mt103Flag = "Y"
        }

        return [pddts: [pddtsFlag: pddtsFlag, pddtsAmount: pddtsAmount], mt103: [mt103Flag: mt103Flag, mt103Amount: mt103Amount]]
    }

    def findProceedsExportAdvance(maxRows, rowOffset, currentPage, tradeServiceId) {

    }

    @Transactional(readOnly = true)
    def constructProductChargesGridUASettlement(display) {

        def list = display.collect {

            String bookingCurrency = it.BOOKINGCURRENCY ?: ""
            String interestRate = it.INTERESTRATE ?: ""
            String interestTerm = it.INTERESTTERM ?: ""
            String loanMaturityDate = it.LOANMATURITYDATE ? DateUtils.shortDateFormat(it.LOANMATURITYDATE) : ""
            String loanTerm = it.LOANTERM ?: ""
            String loanTermCode = it.LOANTERMCODE ?: ""
            String repricingTerm = it.REPRICINGTERM ?: ""
            String repricingTermCode = it.REPRICINGTERMCODE ?: ""
            String pnNumber = it.PNNUMBER ?: ""

            StringBuilder setupString = new StringBuilder()
            setupString.append("bookingCurrency=" + bookingCurrency + "&")
            setupString.append("interestRate=" + interestRate + "&")
            setupString.append("interestTerm=" + interestTerm + "&")
            setupString.append("loanMaturityDate=" + loanMaturityDate + "&")
            setupString.append("loanTerm=" + loanTerm + "&")
            setupString.append("loanTermCode=" + loanTermCode + "&")
            setupString.append("repricingTerm=" + repricingTerm + "&")
            setupString.append("repricingTermCode=" + repricingTermCode)

            StringBuilder rates = new StringBuilder()

            String passOnRateThirdToPhp = it.PASSONRATETHIRDTOPHP ?: ""
            String passOnRateThirdToUsd = it.PASSONRATETHIRDTOUSD ?: ""
            String passOnRateUsdToPhp = it.PASSONRATEUSDTOPHP ?: ""

            rates.append("passOnRateUsdToPhp=" + passOnRateUsdToPhp + ",")
            rates.append("passOnRateThirdToUsd=" + passOnRateThirdToUsd + ",")
            rates.append("passOnRateThirdToPhp=" + passOnRateThirdToPhp + ",")

            String specialRateThirdToPhp = it.SPECIALRATETHIRDTOPHP ?: ""
            String specialRateThirdToUsd = it.SPECIALRATETHIRDTOUSD ?: ""
            String specialRateUsdToPhp = it.SPECIALRATEUSDTOPHP ?: ""
            ////printlnspecialRateThirdToPhp
            ////printlnspecialRateThirdToUsd
            ////printlnspecialRateUsdToPhp

            rates.append("specialRateUsdToPhp=" + specialRateUsdToPhp + ",")
            rates.append("specialRateThirdToUsd=" + specialRateThirdToUsd + ",")
            rates.append("specialRateThirdToPhp=" + specialRateThirdToPhp + ",")

            String urr = it.URR ?: ""
            rates.append("urr=" + urr)
            List<Object> ratesList = new ArrayList<Object>()
            ratesList.add(0, it.PASSONRATETHIRDTOPHP)
            ratesList.add(1, it.PASSONRATETHIRDTOUSD)
            ratesList.add(2, it.PASSONRATEUSDTOPHP)
            ratesList.add(3, it.SPECIALRATETHIRDTOPHP)
            ratesList.add(4, it.SPECIALRATETHIRDTOUSD)
            ratesList.add(5, it.SPECIALRATEUSDTOPHP)
            ratesList.add(6, it.URR)

            Map<String, Object> map = JSON.parse(it.DETAILS)

            def rate = getRates(it.LCCURRENCY ?: (map.currency ?: map.negotiationCurrency), it.CURRENCY, ratesList)
            BigDecimal conversionRate = rate

            def param = [
                    amount: it.AMOUNT.toString(),
                    conversion_rate: conversionRate,
                    base_ccy: it.CURRENCY,
                    target_ccy: it.LCCURRENCY,
                    convertTo: "LC"
            ]

            def result = foreignExchangeService.computeRateConversion(param)

            [id: it.ID,
                    cell: [
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            map.documentType && "DOMESTIC".equalsIgnoreCase(map.documentType) ?
                                formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE,"DOMESTIC") :
                                formatModeOfPayment(it.PAYMENTINSTRUMENTTYPE),
                            it.CURRENCY,
//                            NumberUtils.currencyFormat(new Double(it.AMOUNTINLCCURRENCY?:0)),

                            NumberUtils.currencyFormat(new Double(it.AMOUNT?:0)),

                            "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + it.ID + "\'; onDeletePaymentSummary(id);\">delete</a>",
                            it.PAYMENTINSTRUMENTTYPE,
                            it.REFERENCEID,
                            rates.toString(),
                            (!(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP")) && !(it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR"))) ? it.REFERENCENUMBER : "",
                            (it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("CASA") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AP") || it.PAYMENTINSTRUMENTTYPE.equalsIgnoreCase("AR")) ? it.REFERENCENUMBER : "",
                            setupString.toString(),
                            it.FACILITYID,
                            it.FACILITYTYPE,
                            it.FACILITYREFERENCENUMBER,
                            it.AMOUNTINLCCURRENCY,
                            it.ACCOUNTNAME
                    ]
            ]
        }

        return list
    }

    def checkIfHasPaidPayment(documentClass, tradeServiceId) {
        println documentClass
//        if (!documentClass.toUpperCase().contains("ADVISING") && !documentClass.toUpperCase().equals("BP")) {
        if (!documentClass.toUpperCase().contains("ADVISING") && !(documentClass.toUpperCase() in ["BP", "CORRES_CHARGE", "BC", "IMPORT_CHARGES", "IMPORT_ADVANCE", "EXPORT_ADVANCE"])) {
            return "false"
        }

        def response = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId], "checkPaymentStatusOfPayments", "payment/")?.details
		println response
        return response
    }

    def checkIfHasUnpaidPayment(tradeServiceId) {
        def response = coreAPIService.dummySendQuery([tradeServiceId : tradeServiceId], "checkUnpaidStatusOfPayments", "payment/")?.details
		println response
        return response
    }
	
	def findAllPaymentsForAmla(tradeServiceId) {
		Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]
		
//		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, methodName, param)
		def queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findAllPaymentProductForAmla", param)
		
		return queryResult;
	}
	
	def findAllPaymentsForExports(tradeServiceId) {
		Map<String, Object> param = [tradeServiceId: tradeServiceId ?: ""]
		
//		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, methodName, param)
		def queryResult = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findAllPaymentProductForExports", param)
		
		return queryResult;
	}
}
