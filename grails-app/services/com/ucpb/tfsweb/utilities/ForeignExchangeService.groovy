package com.ucpb.tfsweb.utilities

import net.ipc.utils.NumberUtils

import java.math.RoundingMode
import java.text.DecimalFormat

class ForeignExchangeService {

    def getRatesByCurrencyCode(mapList, param) {
        def newList = []
        def insert = true
        if (!(param.currency.equals('USD') || param.currency.equals('PHP'))) {
            for (Map<String, Object> temp : mapList) {
                if (temp.get("CURRENCY_CODE").toString()?.trim().equals(param.currency) && temp.get("RATE_NUMBER") == 1 && temp.get("BASE_CURRENCY").toString()?.trim().equals('USD') && insert) {
                    newList.add(temp)
                    insert = false
                }
            }
            insert = true
            for (Map<String, Object> temp : mapList) {
                if (temp.get("CURRENCY_CODE").toString()?.trim().equals(param.currency) && temp.get("RATE_NUMBER") == 2 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP') && insert) {
                    newList.add(temp)
                    insert = false
                }
            }
        }
        insert = true
        for (Map<String, Object> temp : mapList) {
            if (temp.get("CURRENCY_CODE").toString()?.trim().equals('USD') && temp.get("RATE_NUMBER") == 17 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP') && insert) {
                newList.add(temp)
                insert = false
            }
        }
        insert = true
        for (Map<String, Object> temp : mapList) {
            if (temp.get("CURRENCY_CODE").equals('USD').toString()?.trim() && temp.get("RATE_NUMBER") == 3 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP') && temp.get("RATE_DEFINITION").toString().contains("BOOKING RATE ") && insert) {
                newList.add(temp)
                insert = false
            }
        }
        return [display: newList]
    }

    def extractRatesByBaseCurrency(mapList, param) {
        def newList = []
        def insert = true
        for (Map<String, Object> temp : mapList) {
            if (((temp.get("RATE_NUMBER") == 1 && temp.get("BASE_CURRENCY").toString()?.trim().equals('USD')) || (!temp.get("CURRENCY_CODE").toString()?.trim().equals('USD') && temp.get("RATE_NUMBER") == 2 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP'))) && insert) {
                if (!newList.contains(temp)) {
                    newList.add(temp)
                    insert = false
                }
            } else if (!insert) {
                insert = true
            }
        }

        insert = true
        for (Map<String, Object> temp : mapList) {
            if (temp.get("CURRENCY_CODE").toString()?.trim().equals('USD') && temp.get("RATE_NUMBER") == 17 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP') && insert) {
                if (!newList.contains(temp)) {
                    newList.add(temp)
                    insert = false
                }
            }
        }
        insert = true
        for (Map<String, Object> temp : mapList) {
            if (temp.get("CURRENCY_CODE").toString()?.trim().equals('USD') && temp.get("RATE_NUMBER") == 3 && temp.get("BASE_CURRENCY").toString()?.trim().equals('PHP') && temp.get("RATE_DEFINITION").toString().contains("BOOKING RATE ") && insert) {
                if (!newList.contains(temp)) {
                    newList.add(temp)
                    insert = false
                }
            }
        }
        def list = newList.collect {
            [rates: it.get("CURRENCY_CODE")?.trim() + "-" + it.get("BASE_CURRENCY")?.trim(),
                    rate_description: it.get("RATE_DEFINITION"),
                    id: it.get("RATE_NUMBER"),
                    pass_on_rate: it.get("CONVERSION_RATE"),
                    special_rate: it.get("CONVERSION_RATE")                        //TODO: add parameters to override this.
            ]
        }
        return list
    }

    def formatUrrRates(mapList, param){
        //printlnmapList
        def newList = []
        for (Map<String, Object> temp : mapList) {
            if (temp.get("RATE_NUMBER") == 3 ) {
                if (!newList.contains(temp)) {
                    newList.add(temp)
                    //insert = false
                }
            }
        }
        //println"newList:"+newList
        def list = newList.collect {
            [rates: it.get("CURRENCY_CODE")?.trim() + "-" + it.get("BASE_CURRENCY")?.trim()+"_urr",
                    rate_description: it.get("RATE_DEFINITION"),
                    id: it.get("RATE_NUMBER"),
                    pass_on_rate: it.get("CONVERSION_RATE"),
                    special_rate: it.get("CONVERSION_RATE")                        //TODO: add parameters to override this.
            ]
        }
        return list
    }

    def getUrrRate(mapList, param){
        println "getUrrRate"

        //printlnmapList
        def newList = []
        for (Map<String, Object> temp : mapList) {
            if (temp.get("RATE_NUMBER") == 3 ) {
                if (!newList.contains(temp)) {
                    newList.add(temp)
                    //insert = false
                }
            }
        }

        BigDecimal urr = BigDecimal.ZERO;
        newList.each { rate ->
            String currencyCode = rate.get("CURRENCY_CODE")?.trim()
            String baseCurrency = rate.get("BASE_CURRENCY")?.trim()

            if("USD".equalsIgnoreCase(currencyCode) && "PHP".equalsIgnoreCase(baseCurrency)){
                urr =  rate.get("CONVERSION_RATE")
            }
        }
        println "getUrrRate urr:"+urr
        return urr
    }

    def constructForeignExchangeGrid(display) {
        def list = display.collect { rates ->
            [id: rates.get("RATE_NUMBER"),
                    cell: [rates.get("CURRENCY_CODE")?.trim() + "-" + rates.get("BASE_CURRENCY")?.trim(),
                            rates.get("RATE_DEFINITION"),
                            rates.get("CONVERSION_RATE"),
                            rates.get("CONVERSION_RATE")
                    ]]
        }
        return list
    }

    def updateSpecialRates(currency, param) {
        def passOnRatesList = [:]
        def specialRatesList = [:]
        param.each {
            if (it.key.contains("pass_on")) {
                passOnRatesList.put(it.key.replace("_text_", "_"), it.value)
            } else if (it.key.contains("special")) {
                specialRatesList.put(it.key.replace("_text_", "_"), it.value)
            }
        }
        Map<String, Map> result = new HashMap<String, Map>()
        result.put("pass-on", passOnRatesList)
        result.put("special", specialRatesList)
		
        return result
    }

    def computeConversion(param) {
//        ////printlnparam
        def NumFormat = new DecimalFormat("##,###,##0.00")
        def results = [:]
        def conversion_rate = new BigDecimal(param.conversion_rate)
        if (param.amount_lc || param.amount_settlement) {
            if (param.readonly_settlement) {
                def amount_lc = new BigDecimal(param.amount_lc.replace(",", ""))
                def result = amount_lc.divide(conversion_rate, 2)
                results.put("equivSettlement", NumFormat.format(result))
                results.put("equivLc", NumFormat.format(amount_lc))
            } else if (param.readonly_lc) {
                def amount_settlement = new BigDecimal(param.amount_settlement.replace(",", ""))
                def result = amount_settlement.multiply(conversion_rate)
                results.put("equivLc", NumFormat.format(result))
                results.put("equivSettlement", NumFormat.format(amount_settlement))
            } else {
                results.put("equivLc", "")
                results.put("equivSettlement", "")
            }
        } else {
            results.put("equivLc", "")
            results.put("equivSettlement", "")
        }
        return results
    }

    def computeRateConversion(param) {
		println "computeRateConversion"	
        def results = [:]
        BigDecimal conversion_rate = param.conversion_rate ? new BigDecimal(param.conversion_rate) : 1

        println 'passed param ' + param
        String converted
		println param.amount
        if (param.amount) {
            BigDecimal paramAmount = new BigDecimal(param.amount.replace(",", ""))
			println "paramAmount::"+paramAmount.toPlainString() 	

            def result = null
            switch (param.base_ccy) {
                case "PHP":
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(BigDecimal.ONE)
                            break
                        case "USD":
                            result = paramAmount.divide(conversion_rate, 2)
//                            result = paramAmount.multiply(conversion_rate)
                            break
                        default:
                            // jett : round to 4 decimal places so we don't get excess
                            // conversion rate changed to 6 decimal places because rates require 6
                            conversion_rate = conversion_rate.setScale(6, BigDecimal.ROUND_HALF_UP)
                            result = paramAmount.divide(conversion_rate,2,RoundingMode.HALF_UP)
//                            result = paramAmount.multiply(conversion_rate)
                            break
                    }
                    break
                case "USD":
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        case "USD":
						println "angulo"
                            result = paramAmount
                            break
                        default:
                            result = paramAmount.divide(conversion_rate, 2)
//                            result = paramAmount.multiply(conversion_rate)
                            break
                    }
                    break
                default:
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        case "USD":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        default:
                            conversion_rate = conversion_rate.setScale(6, BigDecimal.ROUND_HALF_UP)
                            if (param.target_ccy == param.base_ccy) {
                                result = paramAmount.multiply(BigDecimal.ONE)
                            } else if (param.convertTo.equalsIgnoreCase("LC")) {
                                result = paramAmount.divide(conversion_rate, 2)
                            } else if (param.convertTo.equalsIgnoreCase("SET")) {
                                result = paramAmount.multiply(conversion_rate)
                            }
                            break
                    }
                    break
            }
			println "result::"+result

            if (param.convertTo.equalsIgnoreCase("LC")) {
                //results.put("equivLc", NumberUtils.currencyFormat(result.doubleValue()))
				println "NumberUtils.currencyFormat(result):"+NumberUtils.currencyFormat(result)
                results.put("equivLc", NumberUtils.currencyFormat(result))
                results.put("equivSettlement", param.amount)
            } else if (param.convertTo.equalsIgnoreCase("SET")) {
                results.put("equivLc", param.amount)
                //results.put("equivSettlement", NumberUtils.currencyFormat(result.doubleValue()))
                results.put("equivSettlement", NumberUtils.currencyFormat(result))
				println "param.amount:"+param.amount
				println "param.amount:"+NumberUtils.currencyFormat(result)
            }
        } else {
            results.put("equivLc", "")
            results.put("equivSettlement", "")
        }
		println results
        return results
    }

    def computeRateConversionNotRounded(param) {
        def results = [:]
        BigDecimal conversion_rate = param.conversion_rate ? new BigDecimal(param.conversion_rate) : 1
        println 'passed param ' + param
        String converted
        if (param.amount) {
            BigDecimal paramAmount = new BigDecimal(param.amount.replace(",", ""))

            BigDecimal result = null
            switch (param.base_ccy) {
                case "PHP":
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(BigDecimal.ONE)
                            break
                        case "USD":
                            result = paramAmount.divide(conversion_rate, 2)
                            break
                        default:
                            // jett : round to 4 decimal places so we don't get excess
                            // conversion rate changed to 6 decimal places because rates require 6
                            conversion_rate = conversion_rate.setScale(6, BigDecimal.ROUND_HALF_UP)
                            result = paramAmount.divide(conversion_rate, 2, RoundingMode.HALF_UP)
                            break
                    }
                    break
                case "USD":
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        case "USD":
                            result = paramAmount.multiply(BigDecimal.ONE)
                            break
                        default:
                            result = paramAmount.divide(conversion_rate, 2)
                            break
                    }
                    break
                default:
                    switch (param.target_ccy) {
                        case "PHP":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        case "USD":
                            result = paramAmount.multiply(conversion_rate)
                            break
                        default:
                            conversion_rate = conversion_rate.setScale(6, BigDecimal.ROUND_HALF_UP)
                            if (param.target_ccy == param.base_ccy) {
                                result = paramAmount.multiply(BigDecimal.ONE)
                            } else if (param.convertTo.equalsIgnoreCase("LC")) {
                                result = paramAmount.divide(conversion_rate, 2)
                            } else if (param.convertTo.equalsIgnoreCase("SET")) {
                                result = paramAmount.multiply(conversion_rate)
                            }
                            break
                    }
                    break
            }

            results.put("equivLc", result.toString())
            results.put("equivSettlement", param.amount)
        } else {
            results.put("equivLc", "")
            results.put("equivSettlement", "")
        }
        return results
    }

    def extractExchangeRateUsdToPhpUrr(mapList, param) {
        def tempExchange = extractRatesByBaseCurrency(mapList, param)
//        //println"extractExchangeRateByBaseCurrency:"+param

        def baseCurrency = extractCorrectCurrency(param)
        def USDtoPHP = "USD-PHP"
        def baseCurrencytoPHP = baseCurrency + "-PHP"
        def baseCurrencytoUSD = baseCurrency + "-USD"

        def USDtoPHP_rate = new BigDecimal(1)
        def baseCurrencytoPHP_rate = new BigDecimal(1)
        def baseCurrencytoUSD_rate = new BigDecimal(1)
        def USDtoPHP_urr = new BigDecimal(1)
        def withBaseToPHP = false;


        tempExchange.each { rate ->
            if (rate.rates.equalsIgnoreCase(USDtoPHP) && !rate.rate_description.contains("BOOKING")) {
                USDtoPHP_rate = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(USDtoPHP) && rate.rate_description.contains("BOOKING")) {
                USDtoPHP_urr = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoPHP)) {
                baseCurrencytoPHP_rate = new BigDecimal(rate.pass_on_rate)
                withBaseToPHP = true
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoUSD)) {
                baseCurrencytoUSD_rate = new BigDecimal(rate.pass_on_rate)
            }
        }

        return USDtoPHP_urr
    }

    def extractExchangeRateThirdToPhpUrr(mapList, param) {
        def tempExchange = extractRatesByBaseCurrency(mapList, param)
//        //println"extractExchangeRateByBaseCurrency:"+param

        def baseCurrency = extractCorrectCurrency(param)
        def USDtoPHP = "USD-PHP"
        def baseCurrencytoPHP = baseCurrency + "-PHP"
        def baseCurrencytoUSD = baseCurrency + "-USD"
        def baseCurrencytoPHP_urr = baseCurrency + "-PHP_urr"
        def baseCurrencytoUSD_urr  = baseCurrency + "-USD_urr"

        def USDtoPHP_rate = new BigDecimal(1)
        def baseCurrencytoPHP_rate = new BigDecimal(1)
        def baseCurrencytoUSD_rate = new BigDecimal(1)
        def baseCurrencytoPHP_urr_rate = new BigDecimal(1)
        def baseCurrencytoUSD_urr_rate = new BigDecimal(1)
        def USDtoPHP_urr = new BigDecimal(1)
        def withBaseToPHP = false;


        tempExchange.each { rate ->
            if (rate.rates.equalsIgnoreCase(USDtoPHP) && !rate.rate_description.contains("BOOKING")) {
                USDtoPHP_rate = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(USDtoPHP) && rate.rate_description.contains("BOOKING")) {
                USDtoPHP_urr = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoPHP)) {
                baseCurrencytoPHP_rate = new BigDecimal(rate.pass_on_rate)
                withBaseToPHP = true
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoUSD)) {
                baseCurrencytoUSD_rate = new BigDecimal(rate.pass_on_rate)
            }

            if(rate.rates.equalsIgnoreCase(baseCurrencytoPHP_urr)){
                baseCurrencytoPHP_urr_rate = new BigDecimal(rate.pass_on_rate)
            }else if(rate.rates.equalsIgnoreCase(baseCurrencytoUSD_urr)){
                baseCurrencytoUSD_urr_rate = new BigDecimal(rate.pass_on_rate)
            }
        }

        return USDtoPHP_urr
    }

    /**
     * Method to return the THIRD-USD exchange rate
     * @param mapList List that contains the currency information queried from SIBS
     * @param param map that contains the currency
     * @return exchange rate for THIRD-USD
     */
    def extractExchangeRateByBaseCurrencyAngol(mapList, param) {
        def tempExchange = extractRatesByBaseCurrency(mapList, param)
        ////println"extractExchangeRateByBaseCurrency:"+param

        def baseCurrency = extractCorrectCurrency(param)
        def USDtoPHP = "USD-PHP"
        def baseCurrencytoPHP = baseCurrency + "-PHP"
        def baseCurrencytoUSD = baseCurrency + "-USD"

        def USDtoPHP_rate = new BigDecimal(1)
        def baseCurrencytoPHP_rate = new BigDecimal(1)
        def baseCurrencytoUSD_rate = new BigDecimal(1)
        def USDtoPHP_urr = new BigDecimal(1)
        def withBaseToPHP = false;


        tempExchange.each { rate ->
            if (rate.rates.equalsIgnoreCase(USDtoPHP) && !rate.rate_description.contains("BOOKING")) {
                USDtoPHP_rate = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(USDtoPHP) && rate.rate_description.contains("BOOKING")) {
                USDtoPHP_urr = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoUSD)) {
                baseCurrencytoUSD_rate = new BigDecimal(rate.pass_on_rate)
            }
        }

        return baseCurrencytoUSD_rate


    }

    def extractExchangeRateByBaseCurrency(mapList, param) {
        def tempExchange = extractRatesByBaseCurrency(mapList, param)
        ////println"extractExchangeRateByBaseCurrency:"+param

        def baseCurrency = extractCorrectCurrency(param)
        def USDtoPHP = "USD-PHP"
        def baseCurrencytoPHP = baseCurrency + "-PHP"
        def baseCurrencytoUSD = baseCurrency + "-USD"

        def USDtoPHP_rate = new BigDecimal(1)
        def baseCurrencytoPHP_rate = new BigDecimal(1)
        def baseCurrencytoUSD_rate = new BigDecimal(1)
        def USDtoPHP_urr = new BigDecimal(1)
        def withBaseToPHP = false;


        tempExchange.each { rate ->
            if (rate.rates.equalsIgnoreCase(USDtoPHP) && !rate.rate_description.contains("BOOKING")) {
                USDtoPHP_rate = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(USDtoPHP) && rate.rate_description.contains("BOOKING")) {
                USDtoPHP_urr = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoPHP)) {
                baseCurrencytoPHP_rate = new BigDecimal(rate.pass_on_rate)
                withBaseToPHP = true
            } else if (rate.rates.equalsIgnoreCase(baseCurrencytoUSD)) {
                baseCurrencytoUSD_rate = new BigDecimal(rate.pass_on_rate)
            }
        }

        if (withBaseToPHP) {
            return baseCurrencytoPHP_rate
        } else {
            return baseCurrencytoUSD_rate.multiply(USDtoPHP_rate)
        }

    }

    def extractCorrectCurrency(param) {
        ////println"param.currency:"+param.currency
        ////println"originalCurrency:"+param.originalCurrency
        ////println"negotiationCurrency:"+param.negotiationCurrency

        if(param.currency){
            return param.currency
        } else if (param.originalCurrency){
            return param.originalCurrency
        } else if (param.negotiationCurrency) {
            return param.negotiationCurrency
        } else if(param.shipmentCurrency){
            return param.shipmentCurrency
        }

    }

    def extractUsdToPhpRate(mapList, param) {
        def tempExchange = extractRatesByBaseCurrency(mapList, param)
        def baseCurrency = param.currency;
        def USDtoPHP = "USD-PHP"

        def USDtoPHP_rate = new BigDecimal(1)
        def USDtoPHP_urr = new BigDecimal(1)


        tempExchange.each { rate ->
            if (rate.rates.equalsIgnoreCase(USDtoPHP) && !rate.rate_description.contains("BOOKING")) {
                USDtoPHP_rate = new BigDecimal(rate.pass_on_rate)
            } else if (rate.rates.equalsIgnoreCase(USDtoPHP) && rate.rate_description.contains("BOOKING")) {
                USDtoPHP_urr = new BigDecimal(rate.pass_on_rate)
            }
        }

        return ['USD-PHP': USDtoPHP_rate, 'USD-PHP-URR': USDtoPHP_urr]
    }

    def overwriteSpecialRates(mapList, param) {
        def newList = []
        mapList.each { rate ->
            String temp = rate.rates + "_text_special_rate"

            String specialRate = param[temp]
            if (specialRate && !rate.rate_description.toString().contains("BOOKING")) {
                newList << [rates: rate.rates,
                        rate_description: rate.rate_description,
                        id: rate.id,
                        pass_on_rate: rate.pass_on_rate,
                        special_rate: specialRate
                ]
            } else {
                newList << [rates: rate.rates,
                        rate_description: rate.rate_description,
                        id: rate.id,
                        pass_on_rate: rate.pass_on_rate,
                        special_rate: rate.special_rate
                ]
            }
        }

        return newList
    }
    
    def obtainSettlementCurrency(lcCurrency) {
        ////println"currency >> " + lcCurrency

        def currencies = [
            ["id":"USD", "label":"US Dollar"],
            ["id":"AUD", "label":"Australian Dollar"],
            ["id":"BRL", "label":"Brazilian Real"],
            ["id":"CAD", "label":"Canadian Dollar"],
            ["id":"CHF", "label":"Swiss Franc"],
            ["id":"CNY", "label":"Chinese Yuan"],
            ["id":"EUR", "label":"Euro"],
            ["id":"GBP", "label":"British Pound"],
            ["id":"HKD", "label":"Hong Kong Dollar"],
            ["id":"IDR", "label":"Indonesian Rupiah"],
            ["id":"INR", "label":"Indian Rupee"],
            ["id":"JPY", "label":"Japanese Yen"],
            ["id":"KRW", "label":"South Korean Won"],
            ["id":"MXN", "label":"Mexican Peso"],
            ["id":"MYR", "label":"Malaysian Ringgit"],
            ["id":"PHP", "label":"Philippine Peso"],
            ["id":"RUB", "label":"Russian Ruble"],
            ["id":"SAR", "label":"Saudi Riyal"],
            ["id":"SGD", "label":"Singapore Dollar"],
            ["id":"THB", "label":"Thai Baht"],
            ["id":"AED", "label":"United Arab Emirates Dirham"]
        ]

        def settlementCurrencies = []

        currencies.each {
            if (it.id.equals(lcCurrency) || it.id.equals("PHP") || it.id.equals("USD")) {
                settlementCurrencies << it
            }
        }

        return settlementCurrencies
    }
	
	def obtainDomesticSettlementCurrency(lcCurrency) {
		////println"currency >> " + lcCurrency

		def currencies = [
			["id":"USD", "label":"US Dollar"],
			["id":"PHP", "label":"Philippine Peso"]
		]

		return currencies
	}

	def obtainDomesticProductCurrency(lcCurrency) {
		
		def currencies
		
		switch(lcCurrency){
		case 'PHP':
			currencies = [
				["id":"PHP", "label":"Philippine Peso"],
				["id":"USD", "label":"US Dollar"]
			]
			break;
		case 'USD':
			currencies = [
				["id":"PHP", "label":"Philippine Peso"], // for DM - as per Alex
				["id":"USD", "label":"US Dollar"]
			]
			break;
		default:
			currencies = [
				["id":"PHP", "label":"Philippine Peso"], // for DM - as per Alex
				["id":"USD", "label":"US Dollar"],
				["id":"AUD", "label":"Australian Dollar"],
				["id":"BRL", "label":"Brazilian Real"],
				["id":"CAD", "label":"Canadian Dollar"],
				["id":"CHF", "label":"Swiss Franc"],
				["id":"CNY", "label":"Chinese Yuan"],
				["id":"EUR", "label":"Euro"],
				["id":"GBP", "label":"British Pound"],
				["id":"HKD", "label":"Hong Kong Dollar"],
				["id":"IDR", "label":"Indonesian Rupiah"],
				["id":"INR", "label":"Indian Rupee"],
				["id":"JPY", "label":"Japanese Yen"],
				["id":"KRW", "label":"South Korean Won"],
				["id":"MXN", "label":"Mexican Peso"],
				["id":"MYR", "label":"Malaysian Ringgit"],
				["id":"RUB", "label":"Russian Ruble"],
				["id":"SAR", "label":"Saudi Riyal"],
				["id":"SGD", "label":"Singapore Dollar"],
				["id":"THB", "label":"Thai Baht"],
				["id":"AED", "label":"United Arab Emirates Dirham"]
			]
			break;
		}
		
		def settlementCurrencies = []

        currencies.each {
            if (it.id.equals(lcCurrency) || it.id.equals("PHP") || it.id.equals("USD")) {
                settlementCurrencies << it
            }
        }

        return settlementCurrencies
	}
	def computeSettlementConversion(param) {
		println "computeSettlementConversion"
		BigDecimal amount = new BigDecimal(param.amount)
		BigDecimal usdToPhp = new BigDecimal(param.usdToPhp)
		BigDecimal thirdsToUsd =  param.thirdsToUsd ? new BigDecimal(param.thirdsToUsd) : BigDecimal.ONE
		BigDecimal result
		println "THIRDS TO USD: " + thirdsToUsd
		
		switch(param.currency){
			case 'PHP':
				if(param.proceedsCurrency == 'USD'){
					result = amount.divide(usdToPhp, 2)
				}
				break;
			case 'USD':
				if(param.proceedsCurrency == 'PHP'){
					result = amount.multiply(usdToPhp)
				}
				break;
			default:
				if(param.proceedsCurrency == 'USD'){
					result = amount.multiply(thirdsToUsd).setScale(2, BigDecimal.ROUND_HALF_UP)
				} else if(param.proceedsCurrency == 'PHP'){
					//result = amount.multiply(thirdsToUsd).multiply(usdToPhp)	//comment by robin for Settlement Beneficiary Tab. 
					result = amount.multiply(thirdsToUsd).setScale(2, BigDecimal.ROUND_HALF_UP)
					result = result.multiply(usdToPhp).setScale(2, BigDecimal.ROUND_HALF_UP)
				}
				break;
		}
		//return [proceedsAmount: NumberUtils.currencyFormat(result.doubleValue())]
		return [proceedsAmount: NumberUtils.currencyFormat(result)]
	}

    // converts any currency to peso
    def convertToPeso(amount, baseCurrency, settlementCurrency, availableRates) {
        def conversionRate = getConversionRate(availableRates, baseCurrency, settlementCurrency)

        def param = [
                amount: amount,
                conversion_rate: conversionRate,
                base_ccy: baseCurrency,
                target_ccy: settlementCurrency,
                convertTo: "LC"
        ]

        def result

        if (!settlementCurrency.equals("PHP")) {
            result = computeRateConversionNotRounded(param)
            def param2 = [
                    amount: result.equivLc,
                    conversion_rate: getConversionRate(availableRates, settlementCurrency, "PHP"),
                    base_ccy: settlementCurrency,
                    target_ccy: "PHP",
                    convertTo: "LC"
            ]

            result = computeRateConversion(param2)
        } else {
            result = computeRateConversion(param)
        }


        return result.equivLc
    }

    // gets the multipliable rate
    def getUsableRate(availableRates, baseCurrency, settlementCurrency) {
        for (Map<String, Object> exchangeItem : availableRates) {
            if (exchangeItem.rates.equals(baseCurrency + "-" + settlementCurrency)) {
                return exchangeItem.special_rate
            }
        }

        return BigDecimal.ZERO
    }

    // gets the actual conversion rate to be used
    def getConversionRate(availableRates, baseCurrency, settlementCurrency) {
        if (baseCurrency == settlementCurrency) {
            return 1
        } else if (settlementCurrency != "") {
            def usd_php = getUsableRate(availableRates, "USD", "PHP")
            def usd_php_buying = BigDecimal.ZERO

            if (!usd_php_buying && !usd_php) { //assume dmlc
                usd_php = getUsableRate(availableRates, "USD", "PHP")
                usd_php_buying = usd_php
            }

            if (!usd_php_buying) { //assume dmlc
                usd_php_buying = usd_php
            }

            def base_to_php
            if (baseCurrency == "PHP") {
                base_to_php = 1
            } else if (baseCurrency == "USD") {
                base_to_php = usd_php;
            } else {
                base_to_php = getUsableRate(availableRates, baseCurrency, "USD") * usd_php
            }

            switch (settlementCurrency) {
                case "PHP":
                    return base_to_php
                    break;
                case "USD":
                    return (baseCurrency == "PHP") ? usd_php_buying : (baseCurrency == "USD") ? (usd_php / base_to_php) : getUsableRate(availableRates, baseCurrency, "USD")
                    break;
                default:
                    return (baseCurrency == "PHP") ? (getUsableRate(availableRates, settlementCurrency, "USD") * usd_php) : (baseCurrency == "USD") ? (getUsableRate(availableRates, settlementCurrency, "USD")) : (base_to_php / (getUsableRate(availableRates, settlementCurrency, "USD")  * usd_php));
            }
        }
    }
}