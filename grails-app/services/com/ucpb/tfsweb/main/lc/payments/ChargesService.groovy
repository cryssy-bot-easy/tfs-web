package com.ucpb.tfsweb.main.lc.payments

import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils


class ChargesService {

    def commandService
    def dataEntryService
    def parserService
    def queryService

    def tradeServiceChargeFinder = com.ucpb.tfs.application.query.reference.IServiceChargeFinder.class

    def tradeServiceFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class

    List<Map<String, Object>> findAllCharges(etsNumber) {

        String methodName = "findAllChargesByServiceInstructionId"
        Map<String, Object> param = [serviceInstructionNumber: etsNumber]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargeFinder, methodName, param)
//        println "service charge queryResult:"+ queryResult
        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()

        queryResult.each { serviceCharges ->
            def map = [:]
            map.put("CHARGECURRENCY", evaluateCharge(serviceCharges.CHARGEID)?.id + "Currency")
            map.put("CHARGEFIELDID", evaluateCharge(serviceCharges.CHARGEID)?.id)
            map.put("EDITCHARGEID", evaluateCharge(serviceCharges.CHARGEID)?.link)
            map.put("CHARGEHIDDEN", evaluateCharge(serviceCharges.CHARGEID)?.id + "PopupParams")
            map.put("DEFAULTAMOUNT", serviceCharges.DEFAULTAMOUNT)
            map.put("CHARGEDISPLAYVALUE", evaluateCharge(serviceCharges.CHARGEID)?.displayName)
            map.put("CHARGEID", serviceCharges.CHARGEID)
            map.put("AMOUNT", serviceCharges.AMOUNT)
            map.put("OVERRIDENFLAG", serviceCharges.OVERRIDENFLAG)
            returnList.add(map)
        }
//        println "returnList:"+returnList
        return returnList
    }		

    List<Map<String, Object>> findAllChargesByTradeService(tradeServiceId) {

        String methodName = "findAllChargesByTradeServiceId"
        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargeFinder, methodName, param)

        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
//        println "service charge queryResult:"+queryResult
        queryResult.each { serviceCharges ->
            def map = [:]
            map.put("CHARGECURRENCY", evaluateCharge(serviceCharges.CHARGEID)?.id + "Currency")
            map.put("CHARGEFIELDID", evaluateCharge(serviceCharges.CHARGEID)?.id)
            map.put("EDITCHARGEID", evaluateCharge(serviceCharges.CHARGEID)?.link)
            map.put("CHARGEHIDDEN", evaluateCharge(serviceCharges.CHARGEID)?.id + "PopupParams")
            map.put("DEFAULTAMOUNT", serviceCharges.DEFAULTAMOUNT)
            map.put("CHARGEDISPLAYVALUE", evaluateCharge(serviceCharges.CHARGEID)?.displayName)
            map.put("CHARGEID", serviceCharges.CHARGEID)
            map.put("AMOUNT", serviceCharges.AMOUNT)
            map.put("ORIGINALAMOUNT", serviceCharges.ORIGINALAMOUNT)
            returnList.add(map)
        }

        return returnList
    }
	
	List<Map<String, Object>> findAllApprovedEtsCharges(tradeServiceId) {
		
		String methodName = "findAllApprovedEtsChargesByTradeServiceId"
		Map<String, Object> param = [tradeServiceId: tradeServiceId]
		
		List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargeFinder, methodName, param)
		List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
		
		queryResult.each { approvedEtsServiceCharges ->
			def map = [:]
			map.put("approvedEtsChargeDisplayName", approvedEtsServiceCharges.DISPLAYNAME)
			map.put("approvedEtsChargeOriginalCurrency", approvedEtsServiceCharges.ORIGINALCURRENCY)
			map.put("approvedEtsChargeOriginalAmount", approvedEtsServiceCharges.ORIGINALAMOUNT)
			map.put("approvedEtsChargeCurrency", approvedEtsServiceCharges.CURRENCY)
			map.put("approvedEtsChargeAmount", approvedEtsServiceCharges.AMOUNT)
			map.put("approvedEtsChargeIdCurrency", approvedEtsServiceCharges.CHARGEID + "currencyEtsApproved")
			map.put("approvedEtsChargeIdAmount", approvedEtsServiceCharges.CHARGEID + "amountEtsApproved")
			returnList.add(map)
		}
		return returnList
	}

    /**
     * Returns map containing values needed by UI to display charges and charges popup properly
     * @param chargeId
     * @return
     */
    Map<String, Object> evaluateCharge(chargeId) {
        //TODO make this configurable in database

        def methodName='findAllChargeByChargeId'
        def param=['chargeId':chargeId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceChargeFinder, methodName, param)

        List<Map<String, Object>> returnList = new ArrayList<Map<String, Object>>()
        //println "service charge queryResult:"+queryResult
        def map = [:]
        queryResult.each { charge ->
            map.put("id", charge.CHARGEID.toString())
            map.put("link", charge.LINK.toString())
            map.put("displayName", charge.DISPLAYNAME.toString())
        }
        //println "charge map:" + map
        return map

//        switch (chargeId) {
//            case "BC":
//                return [id: "BC", link: "edit_bank_commission", displayName: "Bank Commission"]
//            case "CF":
//                return [id: "CF", link: "edit_commitment_fee", displayName: "Commitment Fee"]
//            case "DOCSTAMPS":
//                return [id: "DOCSTAMPS", link: "edit_documentary_stamp", displayName: "Documentary Stamp"]
//            case "CABLE":
//                return [id: "CABLE", link: "edit_cable_fee", displayName: "Cable Fee"]
//            case "SUP":
//                return [id: "SUP", link: "edit_supplies_fee", displayName: "Supplies Fee"]
//            case "CILEX":
//                return [id: "CILEX", link: "edit_cilex_fee", displayName: "CILEX Fee"]
//            case "CORRES-ADVISING":
//                return [id: "CORRES-ADVISING", link: "edit_advising_fee", displayName: "Advising Fee"]
//            case "CORRES-CONFIRMING":
//                return [id: "CORRES-CONFIRMING", link: "edit_confirming_fee", displayName: "Confirming Fee"]
//            case "NOTARIAL":
//                return [id: "NOTARIAL", link: "edit_notarial_fee", displayName: "Notarial Fee"]
//            case "INTEREST":
//                return [id: "INTEREST", link: "edit_interest_fee", displayName: "Interest Fee"]
//            case "BOOKING":
//                return [id: "BOOKING", link: "edit_booking_commission", displayName: "Booking Commission"]
//            case "CANCEL":
//                return [id: "CANCEL", link: "edit_cancellation_fee", displayName: "Cancellation Fee"]
//            case "BSP":
//                return [id: "BSP", link: "edit_bsp_registration_fee", displayName: "BSP Registration Fee"]
//            case "REMITTANCE":
//                return [id: "REMITTANCE", link: "edit_remittance_fee", displayName: "Remittance Fee"]
//            case "ADVISING-EXPORT":
//                return [id: "ADVISING-EXPORT", link: "edit_exports_advising_fee", displayName: "Export-FXLC Advising Fee"]
//            case "OTHER-EXPORT":
//                return [id: "OTHER-EXPORT", displayName: "Other Local Bank Charges"]
//            case "POSTAGE":
//                return [id: "POSTAGE", displayName: "Postage Fee"]
//        }


//        switch (chargeId) {
//            case "BC":
//                return [id: "bankCommission", link: "edit_bank_commission", displayName: "Bank Commission"]
//            case "CF":
//                return [id: "commitmentFee", link: "edit_commitment_fee", displayName: "Commitment Fee"]
//            case "DOCSTAMPS":
//                return [id: "documentaryStamp", link: "edit_documentary_stamp", displayName: "Documentary Stamp"]
//            case "CABLE":
//                return [id: "cableFee", link: "edit_cable_fee", displayName: "Cable Fee"]
//            case "SUP":
//                return [id: "suppliesFee", link: "edit_supplies_fee", displayName: "Supplies Fee"]
//            case "CILEX":
//                return [id: "cilexFee", link: "edit_cilex_fee", displayName: "CILEX Fee"]
//            case "CORRES-ADVISING":
//                return [id: "advisingFee", link: "edit_advising_fee", displayName: "Advising Fee"]
//            case "CORRES-CONFIRMING":
//                return [id: "confirmingFee", link: "edit_confirming_fee", displayName: "Confirming Fee"]
//            case "NOTARIAL":
//                return [id: "notarialFee", link: "edit_notarial_fee", displayName: "Notarial Fee"]
//            case "INTEREST":
//                return [id: "interestFee", link: "edit_interest_fee", displayName: "Interest Fee"]
//            case "BOOKING":
//                return [id: "bookingCommission", link: "edit_booking_commission", displayName: "Booking Commission"]
//            case "CANCEL":
//                return [id: "cancellationFee", link: "edit_cancellation_fee", displayName: "Cancellation Fee"]
//			case "BSP":
//				return [id: "bspFee", link: "edit_bsp_registration_fee", displayName: "BSP Registration Fee"]
//            case "REMITTANCE":
//                return [id: "remittanceFee", link: "edit_remittance_fee", displayName: "Remittance Fee"]
//            case "ADVISING-EXPORT":
//                return [id: "exportsAdvisingFee", link: "edit_exports_advising_fee", displayName: "Export-FXLC Advising Fee"]
//            case "OTHER-EXPORT":
//                return [id: "otherAdvisingFee", displayName: "Other Local Bank Charges"]
//            case "POSTAGE":
//                return [id: "postageFee", displayName: "Postage Fee"]
//        }
    }

    Map<String, Object> updateCharges(params) {
        ////println"updateCharges"

        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")

        // if charges / negotiation / lc cash payment tab
        if (params.foreignExchangeRates || params.foreignExchangeRatesLc) {
            def foreignExchangeRates

            if (params.form.equalsIgnoreCase("charges")) {
                foreignExchangeRates = parserService.parseGrid(params.foreignExchangeRates)
                params.remove("foreignExchangeRates")
            } else if (params.form.equalsIgnoreCase("lcPayment") || params.form.equalsIgnoreCase("proceeds")) {
                foreignExchangeRates = parserService.parseGrid(params.foreignExchangeRatesLc)
                params.remove("foreignExchangeRatesLc")
            }

            // setup foreign exchange rates parameter
            foreignExchangeRates.each {
                if (it.rates.equalsIgnoreCase("OFC-USD")) {
                    params.ofcUsdRate = it.rates
                    params.ofcUsdRateDescription = it.rateDescription
                    params.ofcUsdPassOnRate = it.passOnRate
                    params.ofcUsdSpecialRate = it.specialRate
                } else if (it.rates.equalsIgnoreCase("OFC-PHP")) {
                    params.ofcPhpRate = it.rates
                    params.ofcPhpRateDescription = it.rateDescription
                    params.ofcPhpPassOnRate = it.passOnRate
                    params.ofcPhpSpecialRate = it.specialRate
                } else if (it.rates.equalsIgnoreCase("USD-PHP")) {
                    params.usdPhpRate = it.rates
                    params.usdPhpRateDescription = it.rateDescription
                    params.usdPhpPassOnRate = it.passOnRate
                    params.usdPhpSpecialRate = it.specialRate
                }
            }
        }

        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.username:" + params.username
        ////println"{}{}{}{}{}{}{}{}{}{}{}{}params.unitcode:" + params.unitcode

        String statusAction = params.statusAction ?: ""

        Map<String, String> parameterMap = new HashMap<String, String>()

        // set value of parameter map
        params.each {
            println "causing error " + it.key + " " + it.value
            if (!(it.value instanceof java.util.ArrayList)) {
                //it.value = it.value
                if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Maturity Adjustment")) {
                    it.value = "UA_LOAN_MATURITY_ADJUSTMENT"
                } else if(it.key.equalsIgnoreCase("serviceType") && it.value.equalsIgnoreCase("UA Loan Settlement")) {
                    it.value = "UA_LOAN_SETTLEMENT"
                } else {
                    //it.value = it.value
					if (it.value) {
						println "key:value - " + it.key + ":" + it.value
						Scanner sc = new Scanner(it.value)
	//                    if(sc.hasNextBigDecimal() && !(it.key.contains("address") || it.key.contains("Address") || it.key.contains("description") || it.key.contains("Description") || it.key.contains("Narrative"))){
						if (sc.hasNextBigDecimal()) {
							if (hasLetters(it.value.toString()) || 
								it.key?.toString()?.toUpperCase().contains("ACCOUNTNUMBER") ||
								it.key?.toString()?.toUpperCase().contains("REFERENCENUMBER") ||
								it.key?.toString()?.toUpperCase().contains("PARTICIPANTCODE") ||
								it.key?.toString()?.toUpperCase().contains("TINNUMBER") ||
								it.key?.toString()?.toUpperCase().contains("COMMODITYCODE") ||
								it.key?.toString()?.toUpperCase().matches(".*MT\\d\\d\\d.*") || 
                                it.key?.toString()?.toUpperCase().contains("CCBDBRANCHUNITCODE")
                                ){
								it.value = it.value
							} else {
								it.value = sc?.nextBigDecimal()?.toString()
							}
						} else {
							it.value = it.value
						}
					}
					println "END VALUE: " + it.value
                }
            }

            parameterMap.put(it.key, it.value)
        }

        commandService.updateCommand(params.form, parameterMap, statusAction)

        Map<String, Object> dataEntry = dataEntryService.getDataEntry(params.tradeServiceId)

        return dataEntry
    }

    Map<String, Object> payCharges(params) {
        ////printlnparams
        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")
        Map<String, String> parameterMap = new HashMap<String, String>()

        params.each {
            if (!(it.value instanceof java.util.ArrayList)) {
//                Scanner scanner = new Scanner(it.value)
//                if(scanner.hasNextInt()){
//                    it.value = scanner.nextInt().toString()
//                }else if(scanner.hasNextBigDecimal()) {
//                    it.value = scanner.nextBigDecimal().toString()
//                } else {
//                    if(it.key.equalsIgnoreCase("setupString")) {
//                        def result = it.value.split('&').inject([:]) { map, token ->
//                            token.split('=').with { map[it[0]] = it[1] }
//                            map
//                        }
//                        it.value = result
//                    } else {
//                        it.value = it.value
//                    }
//                }
                if (it.key.equals("setupString")) {
                    //////println"setup string is " + it.value + "."
                    if (it.value) {
                        def result = it.value.split('&').inject([:]) { map, token ->
                            token.split('=').with { map[it[0]] = it[1] }
                            map
                        }
                        it.value = result
                    }
                } else {
                    Scanner scanner = new Scanner(it.value)

                    if (scanner.hasNextBigDecimal()) {
                        it.value = scanner.nextBigDecimal().toString()
                    } else {
                        it.value = it.value
                    }
                }
            }

            parameterMap.put(it.key, it.value)
        }
        //println"parameterMap >> " + parameterMap
        String statusAction = params.statusAction ?: ""

        commandService.updateCommand(params.form, parameterMap, statusAction)
        Map<String, Object> dataEntry = dataEntryService.getDataEntry(params.tradeServiceId)

        return dataEntry
    }

    Map<String, Object> createLoan(params) {
        ////printlnparams
        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")
        Map<String, String> parameterMap = new HashMap<String, String>()

        params.each {
            if (!(it.value instanceof java.util.ArrayList)) {
                if (it.key.equals("setupString")) {
                    if (it.value) {
                        def result = it.value.split('&').inject([:]) { map, token ->
                            token.split('=').with { map[it[0]] = it[1] }
                            map
                        }
                        it.value = result
                    }
                } else {
                    Scanner scanner = new Scanner(it.value)

                    if (scanner.hasNextBigDecimal()) {
                        it.value = scanner.nextBigDecimal().toString()
                    } else {
                        it.value = it.value
                    }
                }
            }

            parameterMap.put(it.key, it.value)
        }

//        String statusAction = params.statusAction ?: ""

        commandService.updateCommand(params.form, parameterMap, "createLoan")
        Map<String, Object> dataEntry = dataEntryService.getDataEntry(params.tradeServiceId)

        return dataEntry
    }

    Map<String, Object> undoPayment(params) {
        // removes action and controller parameters
        params.remove("action")
        params.remove("controller")

        Map<String, String> parameterMap = new HashMap<String, String>()

        // sets value of parameter map
        params.each {
            if (!(it.value instanceof java.util.ArrayList)) {
                Scanner scanner = new Scanner(it.value)

                if (scanner.hasNextInt()) {
                    it.value = scanner.nextInt().toString()
                } else if (scanner.hasNextBigDecimal()) {
                    it.value = scanner.nextBigDecimal().toString()
                } else {
                    if (it.key.equalsIgnoreCase("setupString")) {
                        if (!StringUtils.isEmpty(it.value)) {
                            ////System.out.println("******* " + it.value);
                            def result = it.value.split('&').inject([:]) { map, token ->
                                token.split('=').with { map[it[0]] = it[1] }
                                map
                            }
                            it.value = result
                        }
                    } else {
                        it.value = it.value
                    }
                }
            }

            parameterMap.put(it.key, it.value)
        }

        String statusAction = params.statusAction ?: ""

        commandService.updateCommand(params.form, parameterMap, statusAction)

        Map<String, Object> dataEntry = dataEntryService.getDataEntry(params.tradeServiceId)

        return dataEntry
    }

    Map<String, Object> findPaymentStatus(tradeServiceId) {
        String methodName = "findPaymentStatus"

        Map<String, Object> param = [tradeServiceId: tradeServiceId]

        List<Map<String, Object>> queryResult = queryService.executeQuery(tradeServiceFinder, methodName, param)

        return queryResult[0]
    }
	
	private boolean hasLetters(String s) {
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
}
