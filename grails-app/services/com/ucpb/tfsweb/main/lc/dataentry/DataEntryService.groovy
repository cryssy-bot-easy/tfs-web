package com.ucpb.tfsweb.main.lc.dataentry
import grails.converters.JSON
import net.ipc.utils.DateUtils

/**  PROLOGUE:
 * 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] John Patrick C. Bautista
	[Date Revised:] 08/16/2017
	Program [Revision] Details: Added method to get data entry records depending on the parameters.
	PROJECT: tfs-web
	MEMBER TYPE  : Groovy
	Project Name: DataEntryService
 */
class DataEntryService {
	
	def commandService
	def queryService
	def foreignExchangeService
	def ratesService

	def parserService

	def finder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class
	def attachmentFinder = com.ucpb.tfs.application.query.instruction.IAttachmentFinder.class
	def tradeServiceChargesPaymentFinder = com.ucpb.tfs.application.query.payment.IPaymentFinder.class

	def getDataEntryByServiceInstructionId(serviceInstructionId) {
		// sets method name and parameters
		String methodName = "findTradeServiceByServiceInstructionId"
		println "***************************************"
		Map<String, Object> param = [serviceInstructionId: serviceInstructionId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		def tradeServiceId = queryResult[0].TRADESERVICEID

		List<Map<String, Object>> queryResultProduct = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProductChargePaymentDetail", [tradeServiceId: tradeServiceId])

		Map<String, Object> details = JSON.parse(queryResult[0].DETAILS)

		Map<String, Object> dataEntry = new HashMap<String, Object>()

		details.each {
			dataEntry.put(it.key, it.value)
		}

		def loanCheck = []
		for(int x=0;x<queryResultProduct.size();x++){
			if(queryResultProduct[x]?.PAYMENTINSTRUMENTTYPE in ['TR_LOAN','IB_LOAN','UA_LOAN']){
				loanCheck.add(queryResultProduct[x]?.PAYMENTINSTRUMENTTYPE)
				dataEntry.put("showLoanDetailstab", true);
				break;
			}
		}
		dataEntry.put("loanCheck", loanCheck)



		dataEntry.put("approvers", queryResult[0].APPROVERS)
		dataEntry.put("approvalLevel", (dataEntry.approvers.isEmpty()) ? 1 :  dataEntry.approvers.split(",").size()+1)

//        //println"approval level: " + dataEntry.approvalLevel

		dataEntry.put("tradeServiceId", queryResult[0].TRADESERVICEID)
		dataEntry.put("tradeServiceReferenceNumber", queryResult[0].TRADESERVICEREFERENCENUMBER)
		dataEntry.put("etsNumber", queryResult[0].SERVICEINSTRUCTIONID)
		println queryResult[0].SERVICEINSTRUCTIONID
		dataEntry.put("serviceInstructionId", queryResult[0].SERVICEINSTRUCTIONID)
		dataEntry.put("documentNumber", queryResult[0].DOCUMENTNUMBER)
		dataEntry.put("status", queryResult[0].STATUS)

		dataEntry.put("serviceType", queryResult[0].SERVICETYPE)
		dataEntry.put("documentClass", queryResult[0].DOCUMENTCLASS)
		dataEntry.put("documentType", queryResult[0].DOCUMENTTYPE)
		dataEntry.put("documentSubType1", queryResult[0].DOCUMENTSUBTYPE1)
		dataEntry.put("documentSubType2", queryResult[0].DOCUMENTSUBTYPE2)
		//dataEntry.put("negotiationNumber",queryResult[0].NEGOTIATIONNUMBER)
		dataEntry.put("paymentStatus", queryResult[0].PAYMENTSTATUS)

		dataEntry.put("maximumCreditAmount",queryResult[0].MAXIMUMCREDITAMOUNT)

		return dataEntry
	}
	
	// return data entry
	Map<String, Object> getDataEntry(tradeServiceId) {
		println "getDataEntry"
		// sets method name and parameters
		String methodName = "findTradeService"

		Map<String, Object> param = [tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		List<Map<String, Object>> queryResultProduct = queryService.executeQuery(tradeServiceChargesPaymentFinder, "findProductChargePaymentDetail", param)
		
		Map<String, Object> details = JSON.parse(queryResult[0].DETAILS)

		Map<String, Object> dataEntry = new HashMap<String, Object>()

		details.each {
			println "key:"+ it.key + " val:"+it.value
			dataEntry.put(it.key, it.value)
		}
		
		
		dataEntry.put("approvers", queryResult[0].APPROVERS)
		dataEntry.put("approvalLevel", (dataEntry.approvers?.isEmpty()) ? 1 :  dataEntry.approvers?.split(",").size()+1)

//        //println"approval level: " + dataEntry.approvalLevel

		dataEntry.put("tradeServiceId", queryResult[0].TRADESERVICEID)
		dataEntry.put("tradeServiceReferenceNumber", queryResult[0].TRADESERVICEREFERENCENUMBER)
		dataEntry.put("etsNumber", queryResult[0].SERVICEINSTRUCTIONID)
		dataEntry.put("serviceInstructionId", queryResult[0].SERVICEINSTRUCTIONID)
		dataEntry.put("documentNumber", queryResult[0].DOCUMENTNUMBER)
		dataEntry.put("status", queryResult[0].STATUS)

		dataEntry.put("serviceType", queryResult[0].SERVICETYPE)
		dataEntry.put("documentClass", queryResult[0].DOCUMENTCLASS)
		dataEntry.put("documentType", queryResult[0].DOCUMENTTYPE)
		dataEntry.put("documentSubType1", queryResult[0].DOCUMENTSUBTYPE1)
		dataEntry.put("documentSubType2", queryResult[0].DOCUMENTSUBTYPE2)
		//dataEntry.put("negotiationNumber",queryResult[0].NEGOTIATIONNUMBER)
		dataEntry.put("paymentStatus", queryResult[0].PAYMENTSTATUS)

		println '&&&&&&&&&&&&&&&&&&&&&&&&&queryResult[0].TRADESERVICEID ' + queryResult[0].TRADESERVICEID
		println '&&&&&&&&&&&&&&&&&&&&&&&&&queryResult[0].PAYMENTSTATUS ' + queryResult[0].PAYMENTSTATUS
		println "ANGOL ANGOL ANGOL DATA ENTRY SERVICE"
		println "queryResult[0].SERVICETYPE:"+ queryResult[0].SERVICETYPE
		println "queryResult[0].DOCUMENTCLASS:"+ queryResult[0].DOCUMENTCLASS
		println "queryResult[0].DOCUMENTTYPE:"+ queryResult[0].DOCUMENTTYPE
		println "queryResult[0].DOCUMENTSUBTYPE1:"+ queryResult[0].DOCUMENTSUBTYPE1
		println "queryResult[0].DOCUMENTSUBTYPE2:"+ queryResult[0].DOCUMENTSUBTYPE2
		println "queryResult[0].PAYMENTSTATUS:"+ queryResult[0].PAYMENTSTATUS
		//Adding this for CASH LC WITH ENOUGH PAYMENT AMOUNT

		// commented out as per Joey - marv(17Oct2013)
//        if(queryResult[0].SERVICETYPE.toString().equalsIgnoreCase("NEGOTIATION")
//             &&queryResult[0].DOCUMENTCLASS.toString().equalsIgnoreCase("LC")
//             &&queryResult[0].DOCUMENTSUBTYPE1.toString().equalsIgnoreCase("CASH")
//        ){
//
//            println  "details.get(\"overdrawnAmount\").toString():"+details.get("overdrawnAmount")?.toString();
//            if(details.get("overdrawnAmount")){
//                String strOverDrawnAmount = details.get("overdrawnAmount")?.toString();
//                try {
//                    if(strOverDrawnAmount != null && !strOverDrawnAmount.equalsIgnoreCase("")){
//                        BigDecimal overDrawnAmount = new BigDecimal(details.get("overdrawnAmount").toString())
//                        if (overDrawnAmount.compareTo(BigDecimal.ZERO)){
//                            println "ADDED FOR OVERDRAWN CHECKING"
//                            dataEntry.put("paymentStatus", "NO_PAYMENT_REQUIRED" )
//                        }
//                    }
//                } catch (Exception e){
//                    e.printStackTrace()
//                }
//            }
//
//            println  "queryResult[0].outstandingBalance:"+details.get("outstandingBalance")
//            println  "queryResult[0].negotiationAmount:"+details.get("negotiationAmount")
//            if( details.get("outstandingBalance") && details.get("negotiationAmount")){
//                try {
//                    BigDecimal negotiationAmount = new BigDecimal(details.get("negotiationAmount")?.toString());
//                    BigDecimal outstandingBalance = new BigDecimal(details.get("outstandingBalance")?.toString());
//                    println negotiationAmount.compareTo(outstandingBalance)
//                    if(negotiationAmount.compareTo(outstandingBalance)!=1){
//                        dataEntry.put("paymentStatus", "NO_PAYMENT_REQUIRED" )
//                    }
//                } catch (Exception e){
//                    e.printStackTrace()
//                }
//            }
//        }


		
		def loanCheck = []
		for(int x=0;x<queryResultProduct?.size();x++){
			if(queryResultProduct[x]?.PAYMENTINSTRUMENTTYPE in ['TR_LOAN','IB_LOAN','UA_LOAN']){
				loanCheck.add(queryResultProduct[x]?.PAYMENTINSTRUMENTTYPE)
				dataEntry.put("showLoanDetailstab", true);
				break;
			}
			
			if(queryResult[0]?.SERVICETYPE?.equalsIgnoreCase("NEGOTIATION") &&
				queryResult[0]?.DOCUMENTCLASS?.equalsIgnoreCase("LC") &&
				queryResult[0]?.DOCUMENTSUBTYPE1?.equalsIgnoreCase("REGULAR") &&
				queryResult[0]?.DOCUMENTSUBTYPE2?.equalsIgnoreCase("USANCE") &&
				queryResultProduct[x]?.PAYMENTINSTRUMENTTYPE == "UA_LOAN" &&
				 queryResultProduct[x]?.STATUS == "UNPAID"){
				dataEntry.put("paymentStatus", "UNPAID" )
			}
		}
		dataEntry.put("loanCheck", loanCheck)
		
		println "dataEntry.get(\"paymentStatus\"):"+dataEntry.get("paymentStatus")

		dataEntry.put("maximumCreditAmount",queryResult[0].MAXIMUMCREDITAMOUNT)
		
		return dataEntry
	}
	
	// return non-ets data entry
	Map<String, Object> getNonEtsDataEntry(tradeServiceId) {
		println "getNonEtsDataEntry"
		// sets method name and parameters
		String methodName = "findNonEtsTradeService"
//		//printlnmethodName+"("+tradeServiceId+")"
		Map<String, Object> param = [tradeServiceId: tradeServiceId]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		Map<String, Object> details = JSON.parse(queryResult[0].DETAILS)

		Map<String, Object> dataEntry = new HashMap<String, Object>()

		details.each {
			dataEntry.put(it.key, it.value)
		}
		
		dataEntry.put("approvers", queryResult[0].APPROVERS)
		dataEntry.put("approvalLevel", (dataEntry.approvers ? dataEntry.approvers.split(",").size()+1 : 1))
		////println"approvers >> " + queryResult[0].APPROVERS
		////println"approvalLevel >> " + dataEntry.get("approvalLevel")
		
		dataEntry.put("tradeServiceId", queryResult[0].TRADESERVICEID)
		dataEntry.put("tradeServiceReferenceNumber", queryResult[0].TRADESERVICEREFERENCENUMBER)
		dataEntry.put("documentNumber", queryResult[0].DOCUMENTNUMBER)
		dataEntry.put("status", queryResult[0].STATUS)

		dataEntry.put("serviceType", queryResult[0].SERVICETYPE)
		dataEntry.put("documentClass", queryResult[0].DOCUMENTCLASS)
		dataEntry.put("documentType", queryResult[0].DOCUMENTTYPE)
		dataEntry.put("documentSubType1", queryResult[0].DOCUMENTSUBTYPE1)
		dataEntry.put("documentSubType2", queryResult[0].DOCUMENTSUBTYPE2)
		dataEntry.put("paymentStatus", queryResult[0].PAYMENTSTATUS)

		return dataEntry
	}
	
	Map<String, Object> getAllDataEntryWithParams(maxRows, rowOffset, currentPage, params) {
		println "getAllDataEntryWithParams"
		String methodName = "icInquiry"
		
		Map<String, Object> param = [
				documentNumber: params.documentNumber ?: "",
				cifName: params.cifName ?: "",
				currency: params.currency ?: "", //lc currency
				lcAmountFrom: params.lcAmountFrom?.toString()?.replaceAll(',', '') ?: "",
				lcAmountTo: params.lcAmountTo?.toString()?.replaceAll(',', '') ?: "",
				icNumber: params.icNumber ?: "",
				icAmountFrom: params.icAmountFrom ?: "",
				icAmountTo: params.icAmountTo ?: "",
				icDateFrom: params.icDateFrom ?: "",
				icDateTo: params.icDateTo ?: "",
				unitCode: params.unitCode ?: ""
		]
		
		println "param " +param
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		println queryResult
		for(HashMap<String, Object> temp : queryResult){
			////println"temporary: " + temp
		}
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()?:0) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	Map<String, Object> findAllDataEntryWithParams(maxRows, rowOffset, currentPage, params) {
		println "findAllDataEntryWithParams"
		String methodName = "lcInquiry"
		
		Map<String, Object> param = [documentNumber: params.documentNumber ?: "",
				cifName: params.cifName ?: "",
				expiryDate: params.expiryDate ?: "",
				currency: params.currency ?: "",
				status: params.status ?: "",
				openingDateFrom: params.openingDateFrom ?: "",
				openingDateTo: params.openingDateTo ?: "",
				outstandingLcAmountFrom: params.outstandingLcAmountFrom?.toString()?.replaceAll(',', '') ?: "",
				outstandingLcAmountTo: params.outstandingLcAmountTo?.toString()?.replaceAll(',', '') ?: "",
				unitCode: params.unitCode ?: "",
				unitcode: params.unitcode ?: ""
		]
		println "apram " +param
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		println queryResult
		for(HashMap<String, Object> temp : queryResult){
			////println"temporary: " + temp
		}
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()?:0) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	Map<String, Object> findAllNonLcDataEntryWithParams(maxRows, rowOffset, currentPage, params) {
		println "findAllNonLcDataEntryWithParams"
		String methodName = "nonLcInquiry"
		
		Map<String, Object> param = [documentNumber: params.documentNumber ?: "",
				status: params.status ?: "",
				cifName: params.cifName ?: "",
				negotiationDateFrom: params.negotiationDateFrom ?: "",
				negotiationDateTo: params.negotiationDateTo ?: "",
				userrole: params.userrole ?: "",
				unitCode: params.unitCode ?: "",
				unitcode: params.unitcode ?: ""
		]
		println "apram " +param
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	/*Map<String, Object> findAllNonLcDataEntryWithParams(maxRows, rowOffset, currentPage, params) {
		String methodName = "nonLcInquiry"

		Map<String, Object> param = [documentNumber: params.documentNumber ?: "",
				status: params.status ?: "",
				cifName: params.cifName ?: "",
				negotiationDateFrom: params.negotiationDateFrom ?: "",
				negotiationDateTo: params.negotiationDateTo ?: ""
		]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}*/

	Map<String, Object> findAllNegotiationDataEntry(maxRows, rowOffset, currentPage, params) {
		println "findAllNegotiationDataEntry"
		String methodName = "negotiationInquiry"

		Map<String, Object> param = [documentNumber: params.documentNumber ?: "",
				clientName: params.clientName ?: "",
				negotiationNumber: params.negotiationNumber ?: "",
				cifName: params.cifName ?: "",
				negotiationDateFrom: params.negotiationDateFrom ?: "",
				negotiationDateTo: params.negotiationDateTo ?: "",
				unitCode: params.unitCode ?: "",
				unitcode: params.unitcode ?: ""
		]
		println "params : " + param

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), queryResult: queryResult]
	}
	
	Map<String, Object> findAllNegotiationDataEntryByCache(maxRows, rowOffset, currentPage, queryResult) {
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size(), queryResult: queryResult]
	}

	public boolean hasLetters(String s) {
		if (s == null) return false

		for (int i = 0; i < s.length(); i ++) {
			char c = s.charAt(i);

			if (Character.isLetter(c)) return true

			if (!Character.isDigit(c)) {
				if (c.toString() in [",", "."]) {
					continue
				} else {
					return true
				}
			}
		}
		return false;
	}
	
	Map<String, Object> saveDataEntry(params) {
		println"THE PARAMS: "+params
		String saveAs = params.saveAs

		// removes action and controller parameters
		params.remove("form")
		params.remove("action")
		params.remove("controller")
		params.remove("saveAs")
		
		Map<String, String> parameterMap = new HashMap<String, String>()
	
		// sets value of parameter map
		params.each {
			
			if(it.key.equalsIgnoreCase("ccbdBranchUnitCode") || it.key.equalsIgnoreCase("unitcode")) {
				println "unit code key: " + it.key + ", value: " + it.value
//				it.value = String.format("%03d", Integer.parseInt(it.value))
			} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("Negotiation Acknowledgement")) {
				it.value = "NEGOTIATION_ACKNOWLEDGEMENT"
			} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("Negotiation Acceptance")) {
				it.value = "NEGOTIATION_ACCEPTANCE"
			} else {
				if (it.value) {
					println "key:value - " + it.key + ":" + it.value
					Scanner scanner = new Scanner(it.value)
//                    if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address") || it.key.contains("description") || it.key.contains("Description") || it.key.contains("Narrative"))){
					if (scanner.hasNextBigDecimal()) {
						println "hahaha > " + it.value
						if (hasLetters(it.value.toString()) ||
							it.key?.toString()?.toUpperCase().contains("TINNUMBER") ||
							it.key?.toString()?.toUpperCase().contains("COMMODITYCODE") ||
							it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE")) {
							it.value = it.value
							println "HAS LETTERS VALUE: > " + it.value
						} else {
							it.value = scanner?.nextBigDecimal()?.toString()
							println "NO LETTERS VALUE: > " + it.value
						}
					} else {
						it.value = it.value
					}
				}
				println "END VALUE: " + it.value
			}
			parameterMap.put(it.key, it.value)
		}
		
		//TODO Change This

		def exchangeRate = foreignExchangeService.extractExchangeRateByBaseCurrency(ratesService.getRatesByBaseCurrency().display, params)
		def exchangeRateUrr = foreignExchangeService.extractExchangeRateUsdToPhpUrr(ratesService.getRatesByBaseCurrency().display, params)
		def usdToPHPSpecialRateExchangeRate = foreignExchangeService.extractUsdToPhpRate(ratesService.getRatesByBaseCurrency().display, ['currency':''])
		def baseCurrency = foreignExchangeService.extractCorrectCurrency(params)
		if(baseCurrency.toString().equalsIgnoreCase("USD")){
			parameterMap.put("creationExchangeRate",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
		} else {
			parameterMap.put("creationExchangeRate",exchangeRate.setScale(8,BigDecimal.ROUND_HALF_UP))
		}
		parameterMap.put("creationExchangeRateUsdToPHPSpecialRate",usdToPHPSpecialRateExchangeRate['USD-PHP'].setScale(8,BigDecimal.ROUND_HALF_UP))
		parameterMap.put("creationExchangeRateUsdToPHPUrr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))
		parameterMap.put("urr",exchangeRateUrr.setScale(8,BigDecimal.ROUND_HALF_UP))


		println "baseCurrency:"+baseCurrency
		if(!baseCurrency.toString().equalsIgnoreCase("PHP") && !baseCurrency.toString().equalsIgnoreCase("USD")){
			def thirdToUsd = foreignExchangeService.extractExchangeRateByBaseCurrencyAngol(ratesService.getRatesByBaseCurrency().display,params)
			println "thirdToUsd:"+thirdToUsd
			parameterMap.put(baseCurrency+"-USD",thirdToUsd.setScale(8,BigDecimal.ROUND_UP))
		}



		String tokenValue = commandService.createCommand(parameterMap, saveAs)
		////println"TOKEN VALUE------"+tokenValue
		String tradeServiceId = ""

		try {
			tradeServiceId = queryService.retrieveEtsNumberFromToken(tokenValue)
			////println"TRADESERVICEID-------"+tradeServiceId
		} catch(Exception e) {
		}

		Map<String, Object> dataEntry = getNonEtsDataEntry(tradeServiceId)

		return dataEntry
	}

	Map<String, Object> updateDataEntry(params) {

		String saveAs = params.saveAs
		
		// removes action and controller parameters
		params.remove("action")
		params.remove("controller")

//        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.username:"+params.username
//        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.unitcode:"+params.unitcode

		Map<String, String> parameterMap = new HashMap<String, String>()

		// default required documents
		if(params.requiredDocumentsList) {
			params.requiredDocumentsList = parserService.parseGrid(params.requiredDocumentsList)
		}
		
		if(params.relatedRequiredDocumentsList) {
			params.relatedRequiredDocumentsList = parserService.parseGrid(params.relatedRequiredDocumentsList)
		}

		if(params.proceedsPaymentSummary) {
			params.proceedsPaymentSummary = parserService.parseGrid(params.proceedsPaymentSummary)
		}
		
		if(params.documentPaymentSummary) {
			params.documentPaymentSummary = parserService.parseGrid(params.documentPaymentSummary)
		}

		// new required documents
		if(params.addedDocumentsList) {
			params.addedDocumentsList = parserService.parseGrid(params.addedDocumentsList)
		}
		
		if(params.relatedAddedDocumentsList) {
			params.relatedAddedDocumentsList = parserService.parseGrid(params.relatedAddedDocumentsList)
		}

		// default instructions to the paying/accepting/negotiating bank
		if(params.instructionToBankList) {
			params.instructionToBankList = parserService.parseGrid(params.instructionToBankList)
		}

		// default additional condition
		if(params.additionalConditionsList) {
			params.additionalConditionsList = parserService.parseGrid(params.additionalConditionsList)
		}
		
		if(params.relatedAdditionalConditionsList) {
			params.relatedAdditionalConditionsList = parserService.parseGrid(params.relatedAdditionalConditionsList)
		}

		// new additional condition
		if(params.addedAdditionalConditionsList) {
			params.addedAdditionalConditionsList = parserService.parseGrid(params.addedAdditionalConditionsList)
		}
		
		if(params.relatedAddedAdditionalConditionsList) {
			params.relatedAddedAdditionalConditionsList = parserService.parseGrid(params.relatedAddedAdditionalConditionsList)
		}

		// transmittal letter
		if(params.transmittalLetterList) {
			params.transmittalLetterList = parserService.parseGrid(params.transmittalLetterList)
			params.remove("originalCopy")
			params.remove("duplicateCopy")
		}

		if(params.addedTransmittalLetterList) {
			params.addedTransmittalLetterList = parserService.parseGrid(params.addedTransmittalLetterList)
			params.remove("originalCopy")
			params.remove("duplicateCopy")
		}

		// swift charges
		if(params.swiftChargesList) {
			params.swiftChargesList = parserService.parseGrid(params.swiftChargesList)
			params.remove("swiftCurrency")
			params.remove("swiftAmount")
//            params.remove("swiftChargesList")
		}
		// sets value of parameter map
		println "PARAMS!"+params
		params.each {
			if(!(it.value instanceof java.util.List)) {
				if(it.key.equalsIgnoreCase("ccbdBranchUnitCode") || it.key.equalsIgnoreCase("unitcode")) {
					println "unit code key: " + it.key + ", value: " + it.value
//					it.value = String.format("%03d", Integer.parseInt(it.value))
				} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
					it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
				} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
					it.value = "UA_LOAN_SETTLEMENT"
				} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("Negotiation Discrepancy")) {
					it.value = "NEGOTIATION_DISCREPANCY"
				} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("Negotiation Acknowledgement")) {
					it.value = "NEGOTIATION_ACKNOWLEDGEMENT"
				} else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("Negotiation Acceptance")) {
					it.value = "NEGOTIATION_ACCEPTANCE"
				} else {
					println it.key + " - " + it.value
					Scanner scanner = new Scanner(it.value)

					//if(scanner.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address"))){
					if (scanner.hasNextBigDecimal()) {
						println 'hello > ' + it.value + ' ' + hasLetters(it.value) + " " + it.key?.toString()?.toUpperCase().contains("ACCOUNTNUMBER")

						if (hasLetters(it.value) ||
							it.key?.toString()?.toUpperCase().contains("ACCOUNTNUMBER") ||
							it.key?.toString()?.toUpperCase().contains("REFERENCENUMBER") ||
							it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE") ||
							it.key?.toString()?.toUpperCase().contains("TINNUMBER") ||
							it.key?.toString()?.toUpperCase().contains("COMMODITYCODE") ||
							it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE") ||
							it.key?.toString()?.toUpperCase().matches(".*MT\\d\\d\\d.*")) {
							it.value = it.value
						} else {
							it.value = scanner.nextBigDecimal().toString()
						}
					} else {
						it.value = it.value
					}
				}
			}


			if ("availableWithFlagValue".equals(it.key)) {
				println "availableWithFlagValue detected"
				parameterMap.put("availableWithFlag", it.value)
			}

			////println">>>>>>>>>>>>>>>>>>>>>>>> " + it.value + " = " + it.value.getClass()
			parameterMap.put(it.key, it.value)
		}
		
		String statusAction = params.statusAction ?: ""
	
		println 'commandService.updateCommand(' + params.form + ', ' + parameterMap + ', ' + statusAction + ')'
		commandService.updateCommand(params.form, parameterMap, statusAction)

//        Map<String, Object> dataEntry = getDataEntry(params.tradeServiceId)
		Map<String, Object> dataEntry = null;
		try {
			dataEntry = getDataEntry(params.tradeServiceId)
		} catch(Exception e) {
			// encountered for non ets data entry
			////println"non - lc"
			dataEntry = getNonEtsDataEntry(params.tradeServiceId)
		}

		return dataEntry
	}


	String uploadAttachedToTradeService(params) {
		////println"uploadAttachedToEts"
		// removes action and controller parameters
		params.remove("action")
		params.remove("controller")
		params.remove("fileLocation")
		params.form = "attachedDocuments"
		params.statusAction = "uploadDocument"


		String statusAction = params.statusAction ?: ""
		String docType = params.docType ?: ""

		Map<String, String> parameterMap = new HashMap<String, String>()

		// set value of parameter map
		params.each {
			parameterMap.put(it.key, it.value)
		}

		String token = commandService.uploadCommand(parameterMap)


		return token
	}

	//Returns attachment list from query
	def getAttachmentList(maxRows, rowOffset, currentPage){
		String methodName = "findAllAttachments"
		Map<String, Object> param = [:]
		List<Map<String, Object>> queryResult = queryService.executeQuery(attachmentFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()

		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()?:0]

	}


	//Returns attachment list from query
	def getAttachmentList( maxRows, rowOffset, currentPage, tradeServiceIdHolder){
		String methodName = "findAttachmentsOfTradeService"
		Map<String, Object> param = [tradeServiceId: tradeServiceIdHolder]
		List<Map<String, Object>> queryResult = queryService.executeQuery(attachmentFinder, methodName, param)

		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()

		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()?:0]

	}

	//Returns Grid Formatted Attachment list
	def getGridFormattedAttachments(List display, String tradeServiceId) {
		def list = display.collect { attach ->
			[id: attach.ID,
					cell:[
							attach.ATTACHMENTTYPE?:'--',
							attach.FILENAME?:'filename',
							attach.CREATEDDATE ? DateUtils.dateTimeFormat(attach.CREATEDDATE) : '--',
							"<a href=\"javascript:void(0)\" class=\"jqgrid_inline_links\" onclick=\"var id='" + attach.ID + "'; var tradeServiceId='"+ tradeServiceId + "'; var grid_id='grid_list_attached_documents'; onViewFileClicked(id,grid_id,tradeServiceId);\">view</a>",
							"<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id='" + attach.ID + "'; var tradeServiceId='"+ tradeServiceId + "'; var grid_id='grid_list_attached_documents'; onDeleteFileClicked(id,grid_id,tradeServiceId);\">delete</a>"
					]
			]
		}

		return list

	}

	Map<String, Object> findAllIndemnityIssuance(maxRows, rowOffset, currentPage, params) {
		println "findAllIndemnityIssuance"
		String methodName = "indemnityInquiry"

		
		Map<String, Object> param = [
				documentNumber: params.documentNumber ?: "",
				cifName: params.cifName ?: "",
				originalLcAmount: params.originalLcAmount ?: "",
				indemnityNumber: params.bgNumber  ?: "",
				shipmentNumber: params.shipmentNumber ?: "",
				shipmentAmount: params.shipmentAmount ?: "",
				status: params.status ?: "",
				unitCode: params.unitCode ?: "",
				unitcode: params.unitcode ?: ""
		]

		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		Integer toIndex = ((currentPage * maxRows) < queryResult.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

	// data entry inquiry
	Map<String, Object> findAllDataEntry(maxRows, rowOffset, currentPage, params) {
		println "findAllDataEntry"
		String methodName = "dataEntryInquiry"

//        String documentClass
//        String serviceType = params.transactionName
//
//        if(params.transactionName?.contains("CANCELLATION")) {
//            serviceType = params.transactionName.split("-")[0]
//            documentClass = params.transactionName.split("-")[1]
//        }
		List<String> documentClassList=new ArrayList<String>()

		switch(params.documentClass){
			case "NON-LC":
				documentClassList.addAll(['DA','DP','DR','OA'])
				break;
			case "AUXILIARY_IMPORT_PRODUCTS":
				documentClassList.addAll(['MD','AP','AR','CORRES_CHARGE','IMPORT_CHARGES',
					'UA','BG','BE','BGBE','CDT'])
				break;
			case "EXPORT_BILLS":
				documentClassList.addAll(['BC','BP'])
				break;
			case ['LC','MD','AP','AR','DA','DP','DR','OA','UA','BG','BG','BGBE','INDEMNITY',
					'CORRES_CHARGE','IMPORT_ADVANCE','IMPORT_CHARGES','CDT','MT','EXPORT_ADVANCE',
					'EXPORT_ADVISING','BP','BC','REBATE']:
				documentClassList.add(params.documentClass)
				break;
			default:
				break;
		}

		Map<String, Object> param = [unitCode:params.unitCode ?: "",
				documentNumber:params.documentNumber ? "%"+params.documentNumber+"%" : "",
				cifName: params.cifName ? "%"+params.cifName?.toUpperCase()+"%" : "",
				status: params.status ?: "",
                documentClass: documentClassList,
				documentType: params.documentType ?: "",
				documentSubType1: params.documentSubType1 ?: "",
                serviceType: params.serviceType ?: "",
				dateTime: params.dateOfTransaction ?: ""
		]
//		println "DETAENTRY PARAMZ:"+param
//		println "PRODUCT PARAMZ:"+params

		println "data entry params: " + param
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, methodName, param)
		
		println queryResult
		Integer toIndex = ((currentPage * maxRows) < queryResult?.size()) ? (currentPage * maxRows) : queryResult?.size()
		return [display: queryResult?.subList(rowOffset, toIndex), totalRows: queryResult?.size()]
	}

    def countNumberOfAmendments(documentNumber) { 
		List<Map<String, Object>> queryResult = queryService.executeQuery(finder, "countNumberOfAmendments", [documentNumber: documentNumber ?: ""])
		//println"number of amendments: " + queryResult
		return new Double(queryResult[0] != null ? queryResult[0]?.NUMBEROFAMENDMENTS.toString() : new Double("0"))
	}
	
}