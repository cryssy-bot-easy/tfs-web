package com.ucpb.tfsweb.utilities

import grails.converters.JSON
import net.ipc.utils.NumberUtils

class ForeignExchangeController {		//TODO: Refractoring and if necessary make to save to database
	def ratesService
	def chargesService
	def foreignExchangeService
	
	def index(){
	}
	
	def getExchangeRates(){
		
		
		def ratesList = ratesService.getRatesByBaseCurrency()
        def param = [currency : session.etsModel?.currency ?: session.chargesModel?.currency ?: params?.currency]
		def forexList = foreignExchangeService.getRatesByCurrencyCode(ratesList.display, param)
		
		def results = foreignExchangeService.constructForeignExchangeGrid(forexList.display)
		def jsonData = [rows: results]
		render jsonData as JSON
	}
	
	def updateExchangeRates(){
//        //printlnparams
        //println"update"
        def currency = session.etsModel?.currency ?: session.chargesModel?.currency
        if (params?.etsModel?.negotiationCurrency){currency = params.etsModel.negotiationCurrency}
		def param = params
//        param.each {
//			////println"this is " + it.key + it.value
//		}
		def updates = foreignExchangeService.updateSpecialRates(currency, param)
//        ////println"updates:"+updates
        render updates as JSON
	}
	
	def convertCashRates(){
//        ////printlnparams
//        def param = [conversion_rate : params.conversion_rate,
//			amount_settlement : params.amount_settlement,
//			amount_lc : params.amount_lc,
//			readonly_settlement : params.readonly_settlement,
//			readonly_lc : params.readonly_lc
//			]
        def param = [
                amount: params.amount,
                conversion_rate: params.conversion_rate,
                base_ccy: params.base_ccy,
                target_ccy: params.target_ccy,
                convertTo: params.convertTo
        ]
        //printlnparam
//		def result = foreignExchangeService.computeConversion(param)
        def result = foreignExchangeService.computeRateConversion(param)
		//////println"results: "+result
		render result as JSON
	}
	
	def convertSettlementRates(){
		def param = [
			currency: params.currency,
			amount: params.amount,
			proceedsCurrency: params.proceedsCurrency,
			usdToPhp: params.usdToPhp,
			thirdsToUsd: params.thirdsToUsd ?: ''
		]
		def result = foreignExchangeService.computeSettlementConversion(param)
		render result as JSON
	}

    def convertCorres(){ // returns to peso amount
        def param = [
                amount: params.amount,
                conversion_rate: params.conversion_rate,
                base_ccy: params.base_ccy,
                target_ccy: params.target_ccy,
                convertTo: params.convertTo
        ]

        def result

        if (!params.target_ccy.equals("PHP")) {
            result = foreignExchangeService.computeRateConversionNotRounded(param)
            def param2 = [
                    amount: result.equivLc,
                    conversion_rate: params.php_rate,
                    base_ccy: params.target_ccy,
                    target_ccy: "PHP",
                    convertTo: params.convertTo
            ]

            result = foreignExchangeService.computeRateConversion(param2)
        } else {
            result = foreignExchangeService.computeRateConversion(param)
        }

        def netBillingAmount = new BigDecimal(result.equivLc?.replaceAll(",","")).minus(new BigDecimal(params.outstandingCorresCharge?.replaceAll(",","")))

        //////
        def newParam = [
                amount: netBillingAmount.toString(),
                conversion_rate: params.php_rate,
                base_ccy: "PHP",
                target_ccy: params.target_ccy,
                convertTo: params.convertTo
        ]

        def newResult = foreignExchangeService.computeRateConversion(newParam)

        def netBillingAmountInBillingCurrency = new BigDecimal(newResult.equivLc?.replaceAll(",",""))

        result << [netBillingAmount: NumberUtils.currencyFormat(netBillingAmount)]
        result << [netBillingAmountInBillingCurrency: NumberUtils.currencyFormat(netBillingAmountInBillingCurrency)]

        render result as JSON
    }

    def pesoize() {
        def exchange = []

        def ratesResult = ratesService.getCorresChargeRates(params.currency, params.settlementCurrency).response.details

        ratesResult.each {
            def text_pass_on_rate
            def text_special_rate
            def pass_on_rate_cash
            def special_rate_cash

            exchange << [rates: it.rates,
                    rate_description: it.description,
                    pass_on_rate: it.conversionRate,
                    special_rate: it.conversionRate,
                    rate_number: it.rateNumber
            ]
        }


        def pesoAmount = foreignExchangeService.convertToPeso(params.amount, params.currency, params.settlementCurrency, exchange)

        render([pesoAmount: pesoAmount] as JSON)
    }

}
