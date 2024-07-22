package com.ucpb.tfsweb.main

import java.math.BigDecimal;

class RatesService {

    def ratesfinder = com.ucpb.tfs.application.query.interfaces.RatesService.class

    def queryService
    def coreAPIService

    def chargesPaymentService
    def foreignExchangeService

    def getDailyRates() {
        Map<String, Object> param = [:]
        List<Map<String, Object>> queryResult = queryService.executeQuery(ratesfinder, "getDailyRates", param)
        Map<String, Map<String, Object>> maxHolder = new HashMap<String, Map<String, Object>>()
        //////println"size:" + queryResult?.size()

        for (Map<String, Object> temp : queryResult) {

            //TODO Check if RATE_DEFINITION in(1,2,3)
            if (maxHolder.containsKey(temp.get("CURRENCY_CODE"))) {
                def ttmp = maxHolder.get(temp.get("CURRENCY_CODE"))
                def oldInttmp = ttmp.get("RATE_NUMBER")
                def newInttmp = temp.get("RATE_NUMBER")

                if (oldInttmp.compareTo(newInttmp) < 0) {
                    //replace one in maxHolder
                    maxHolder.put(temp.get("CURRENCY_CODE"), temp)
                }
            } else {
                maxHolder.put(temp.get("CURRENCY_CODE"), temp)
            }
        }

        Map<String, Object> newHolder = new HashMap<String, Object>()
        for (String mxKey : maxHolder.keySet()) {
            newHolder.put(mxKey, maxHolder.get(mxKey).get("CONVERSION_RATE"))
        }
//        ////println"newHolder:" + newHolder


        return newHolder
    }

    def getDailyRatesForNoCharges() {
        Map<String, Object> param = [:]
        List<Map<String, Object>> queryResult = queryService.executeQuery(ratesfinder, "getDailyRates", param)
        Map<String, Map<String, Object>> maxHolder = new HashMap<String, Map<String, Object>>()
        //////println"size:" + queryResult?.size()

        for (Map<String, Object> temp : queryResult) {
            //get URR USD-PHP Rate 3
            //get SELL RATE THIRD-USD Rate


            //TODO Check if RATE_DEFINITION in(1,2,3)
            if (maxHolder.containsKey(temp.get("CURRENCY_CODE"))) {
                def ttmp = maxHolder.get(temp.get("CURRENCY_CODE"))
                def oldInttmp = ttmp.get("RATE_NUMBER")
                def newInttmp = temp.get("RATE_NUMBER")

                if (oldInttmp.compareTo(newInttmp) < 0) {
                    //replace one in maxHolder
                    maxHolder.put(temp.get("CURRENCY_CODE"), temp)
                }
            } else {
                maxHolder.put(temp.get("CURRENCY_CODE"), temp)
            }
        }

        Map<String, Object> newHolder = new HashMap<String, Object>()
        for (String mxKey : maxHolder.keySet()) {
            newHolder.put(mxKey, maxHolder.get(mxKey).get("CONVERSION_RATE"))
        }
//        ////println"newHolder:" + newHolder


        return newHolder
    }
	
	def getRatesByBaseCurrency() {
		Map<String, Object> param = [:]
        List<Map<String, Object>> queryResult = queryService.executeQuery(ratesfinder, "getDailyRates", param)
        //////println"getRatesByBaseCurrency:"+queryResult
        return [display: queryResult]
	}

    def getRatesUrr() {
        Map<String, Object> param = [:]
        List<Map<String, Object>> queryResult = queryService.executeQuery(ratesfinder, "getDailyRates", param)
        //println"getRatesByBaseCurrency:"+queryResult
        return [display: queryResult]
    }

    def getUrrConversionRate(String sourceCurrency,String targetCurrency){
        List<Map<String, Object>> queryResult = queryService.executeQuery(ratesfinder, "getUrrConversionRate", [sourceCurrency : sourceCurrency, targetCurrency : targetCurrency])
        if(queryResult){
            return queryResult.get(0);
        }
        return null;
    }

    def getPesoAmount(amount, currency) {
        def rate = 1

        if (!currency?.equals("PHP")) {
            def urr = getUrrConversionRate(currency, "PHP")
            //printlnurr
            rate = urr?.CONVERSION_RATE ?: 1
        }

        def pesoAmount = amount * rate

        return pesoAmount
    }

    def getRates(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "details", "rates/")

        return rates
    }
    
    def getRatesEB(currency) {
    	def rates = coreAPIService.dummySendQuery([currency: currency], "detailsEB", "rates/")
    			
    			return rates
    }

    def getSellRates(currency, rateNumber) {
        def rates = coreAPIService.dummySendQuery([currency: currency, rateNumber: rateNumber], "sellRates", "rates/")

        return rates
    }

    def getRegularSellRates(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "regularSellRates", "rates/")

        return rates
    }

    def getCashSellRates(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "cashSellRates", "rates/")

        return rates
    }

    def getRegularSellRatesDM(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "regularSellRatesDM", "rates/")

        return rates
    }

    def getCashSellRatesDM(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "cashSellRatesDM", "rates/")

        return rates
    }

    def convertToPeso(tradeServiceId, currency, amount) {
        Map savedRates = (Map)coreAPIService.dummySendQuery([tradeServiceId: tradeServiceId], "savedRates", "rates/").response.details[0]

        List<Object> ratesList = new ArrayList<Object>()

        ratesList.add(savedRates.PASSONRATETHIRDTOPHP ?: null)
        ratesList.add(savedRates.PASSONRATETHIRDTOUSD ?: null)
        ratesList.add(savedRates.PASSONRATEUSDTOPHP ?: null)
        ratesList.add(savedRates.SPECIALRATETHIRDTOPHP ?: null)
        ratesList.add(savedRates.SPECIALRATETHIRDTOUSD ?: null)
        ratesList.add(savedRates.SPECIALRATEUSDTOPHP ?: null)
        ratesList.add(savedRates.URR ?: null)

        def rate = chargesPaymentService.getRates(currency, 'PHP', ratesList)

//        BigDecimal conversionRate = rate

        def param = [
                amount: amount,
                conversion_rate: rate,
                base_ccy: currency,
                target_ccy: "PHP",
                convertTo: "LC"
        ]

        def result = foreignExchangeService.computeRateConversion(param)

        return new BigDecimal(result.equivLc.replaceAll(",",""))
    }

    def getCorresChargeRates(billingCurrency, settlementCurrency) {
        def ratesList = coreAPIService.dummySendQuery([billingCurrency: billingCurrency, settlementCurrency: settlementCurrency], "getCorresChargesRates", "rates/")

        return ratesList
    }

    def getBankNotSellRates(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "bankNoteSellRates", "rates/")

        return rates
    }
	
	def getConversionRateByType(String sourceCurrency,String targetCurrency, int rateType){
		Map<String,Object> parameters = [sourceCurrency:sourceCurrency,targetCurrency:targetCurrency,rateType:rateType]
		BigDecimal queryResult = queryService.executeQuery(ratesfinder, "getConversionRateByTypeToday", parameters)
		
		return queryResult
	}
}
