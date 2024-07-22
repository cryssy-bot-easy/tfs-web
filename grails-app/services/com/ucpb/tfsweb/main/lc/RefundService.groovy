package com.ucpb.tfsweb.main.lc

import com.google.gson.Gson
import com.google.gson.GsonBuilder
import net.ipc.utils.DateUtils
import net.ipc.utils.NumberUtils

class RefundService {

    def coreAPIService
    def queryService

    def transactionFinder = com.ucpb.tfs.application.query.service.ITradeServiceFinder.class
    def paymentFinder = com.ucpb.tfs.application.query.payment.IPaymentFinder.class

    def getAllTransactions(documentNumber) {
        List<Map<String, Object>> queryResult = queryService.executeQuery(transactionFinder, "findAllTransactionsByDocumentNumber", [documentNumber: documentNumber])

        def returnList = []
        queryResult.each {
            returnList << [id: it.TRADESERVICEID, value: it.SERVICETYPE + " " + DateUtils.shortDateFormat(it.MODIFIEDDATE)]
        }

        return returnList
    }

    def getRefundableProductPayments(documentNumber) {
//        Map<String, Object> param = [documentNumber: params.documentNumber ?: "",
//                tradeServiceId: params.tradeServiceId ?: ""
//        ]
        List<Map<String, Object>> queryResult = queryService.executeQuery(paymentFinder,
                "findRefundablePayments",
                [documentNumber: documentNumber ?: ""])

        return queryResult
    }

    def getRates(currency) {
        def rates = coreAPIService.dummySendQuery([currency: currency], "details", "rates/")

        return rates
    }

    def convertNewCharge(baseCurrency, targetCurrency, amount, rates) {
        baseCurrency = baseCurrency.trim()
        targetCurrency = targetCurrency.trim()

        switch (baseCurrency) {
            case "USD":
                switch (targetCurrency) {
                    case "USD":
                        return amount
                    case "PHP":
                        return amount * rates["USD-PHP_special_rate"]
                    default:
                        return amount / rates["USD-" + targetCurrency + "_special_rate"]
                }
            case "PHP":
                switch (targetCurrency) {
                    case "USD":
                        return (amount / rates["USD-PHP_special_rate"])
                    case "PHP":
                        return amount
                    default:
                        def usdAmount = (amount / rates[targetCurrency + "-USD_special_rate"])
                        return (usdAmount / rates["USD-PHP_special_rate"])
                }
            default:
                switch (targetCurrency) {
                    case "USD":
                        return (amount * rates[baseCurrency+"-USD_special_rate"])
                    case "PHP":
                        def usdAmount = (amount * rates[baseCurrency+"-USD_special_rate"])
                        return usdAmount * rates["USD-PHP_special_rate"]
                    default:
                        if (baseCurrency.equals(targetCurrency)) {
                            return amount
                        }
                }
        }
    }

    def convertNewChargeNoRound(currency, amount, rates) {
        switch (currency) {
            case "USD":
                def newAmount = amount / rates["USD-PHP_special_rate"]
                return newAmount
            case "PHP":
                return amount
            default:
                def toUsd = amount / rates["EUR-USD_special_rate"]
                def newAmount = toUsd / rates["USD-PHP_special_rate"]
                return newAmount
        }
    }

    def convertNewChargeToPeso(baseCurrency, amount, rates) {
        switch (baseCurrency) {
            case "USD":
                def newAmount = amount * rates["USD-PHP_special_rate"]
                return NumberUtils.currencyFormat(newAmount)
            case "PHP":
                return NumberUtils.currencyFormat(amount)
            default:
                def toUsd = amount * rates["EUR-USD_special_rate"]
                def newAmount = toUsd * rates["USD-PHP_special_rate"]
                return NumberUtils.currencyFormat(newAmount)
        }
    }

    def constructRatesList(rates) {
        def rateMapList = []

        def thirdToUsd =  [
                rates : rates?.thirdToUsdRateName,
                description: rates?.thirdToUsdRateDescription,
                passOnRate: rates?.passOnRateThirdToUsd,
                specialRate: rates?.specialRateThirdToUsd
        ]

        def thirdToPhp = [
                rates : rates?.thirdToPhpRateName,
                description: rates?.thirdToPhpRateDescription,
                passOnRate: rates?.passOnRateThirdToPhp,
                specialRate: rates?.specialRateThirdToPhp
        ]

        def usdToPhp = [
                rates : rates?.usdToPhpRateName,
                description: rates?.usdToPhpRateDescription,
                passOnRate: rates?.passOnRateUsdToPhp,
                specialRate: rates?.specialRateUsdToPhp
        ]

        def urr = [
                rates : rates?.urrRateName,
                description: rates?.urrRateDescription,
                passOnRate: rates?.urr,
                specialRate: rates?.urr
        ]

        if (thirdToUsd?.rates) {
            rateMapList << thirdToUsd
        }

        if (usdToPhp?.rates) {
            rateMapList << usdToPhp
        }

        if (urr?.rates) {
            rateMapList << urr
        }

        return rateMapList
    }

    def constructCharges(charges) {
        def chargesMapList = []
        def corresChargeMapList = []

        charges.each {
            String chargeDescription = camelCase(it.chargeDescription)

            if (it.chargeId in ["CORRES-ADVISING", "CORRES-CONFIRMING"]) {
                def chargesMap = ["description" : it.chargeDescription]
                chargesMap << ["settlementCurrency" : it.settlementCurrency]
                chargesMap << ["displayId" : chargeDescription]
                chargesMap << ["displayValue" : it.baseAmount]
                chargesMap << ["currencyId" : chargeDescription + "Currency"]
                chargesMap << ["currencyValue" : it.baseCurrency]
                chargesMap << ["hiddenId" : chargeDescription+"Base"]
                chargesMap << ["newId" : chargeDescription + "New"]

                corresChargeMapList << chargesMap
            } else {
                def chargesMap = ["description" : it.chargeDescription]
                chargesMap << ["settlementCurrency" : it.settlementCurrency]
                chargesMap << ["displayId" : chargeDescription]
                chargesMap << ["displayValue" : it.baseAmount]
                chargesMap << ["currencyId" : chargeDescription + "Currency"]
                chargesMap << ["currencyValue" : it.baseCurrency]
                chargesMap << ["hiddenId" : chargeDescription+"Base"]
                chargesMap << ["newId" : chargeDescription + "New"]

                chargesMapList << chargesMap
            }
        }

        return [chargesMapList: chargesMapList, corresChargeMapList: corresChargeMapList]
    }

    private String camelCase(String wordToCamelCase) {
        StringBuffer result = new StringBuffer(wordToCamelCase.length());
        String strl = wordToCamelCase.toLowerCase();
        boolean bMustCapitalize = false;
        for (int i = 0; i < strl.length(); i++)
        {
            char c = strl.charAt(i);
            if (c >= 'a' && c <= 'z')
            {
                if (bMustCapitalize)
                {
                    result.append(strl.substring(i, i+1).toUpperCase());
                    bMustCapitalize = false;
                }
                else
                {
                    result.append(c);
                }
            }
            else
            {
                bMustCapitalize = true;
            }
        }

        return result
    }

    def constructConvertedValues(params, rates) {
        def bankCommission
        def commitmentFee
        def cilex
        def notarialFee
        def documentaryStamps
        def cableFee
        def suppliesFee
        def remittanceFee
        def cancellationFee

        // corres
        def advisingFee
        def confirmingFee
        def marineInsurance

        def convertedValuesList = []

        def chargeAmount

        if (params.bankCommissionBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.bankCommissionBase), rates)
            convertedValuesList << ["convertedKey" : "bankCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.commitmentFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.commitmentFeeBase), rates)
            convertedValuesList << ["convertedKey" : "commitmentFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cilexBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.cilexBase), rates)
            convertedValuesList << ["convertedKey" : "cilex", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.notarialFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.notarialFeeBase), rates)
            convertedValuesList << ["convertedKey" : "notarialFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.documentaryStampsBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.documentaryStampsBase), rates)
            convertedValuesList << ["convertedKey" : "documentaryStamps", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cableFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.cableFeeBase), rates)
            convertedValuesList << ["convertedKey" : "cableFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.suppliesFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.suppliesFeeBase), rates)
            convertedValuesList << ["convertedKey" : "suppliesFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.remittanceFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.remittanceFeeBase), rates)
            convertedValuesList << ["convertedKey" : "remittanceFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cancellationFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.cancellationFeeBase), rates)
            convertedValuesList << ["convertedKey" : "cancellationFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        // corres
        if (params.correspondingChargesAdvisingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.correspondingChargesAdvisingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "correspondingChargesAdvisingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.correspondingChargesConfirmingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.correspondingChargesConfirmingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "correspondingChargesConfirmingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.marineInsuranceBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.marineInsuranceBase), rates)
            convertedValuesList << ["convertedKey" : "marineInsurance", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        // exports
        if (params.exportFxlcAdvisingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.exportFxlcAdvisingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "exportFxlcAdvisingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }
		
		// nonlc
		if (params.bookingCommissionBase) {
			chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.bookingCommissionBase), rates)
			convertedValuesList << ["convertedKey" : "bookingCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
		}

		if (params.bspCommissionBase) {
			chargeAmount = convertNewCharge("PHP", params.currency, new BigDecimal(params.bspCommissionBase), rates)
			convertedValuesList << ["convertedKey" : "bspCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
		}
        
        return convertedValuesList
    }

    def constructRateParam(params) {
        def map = [:]

        params.each {
            if (it.key.contains("_special_rate")) {
                def rate = it.key.toString().substring(0, 7).split("-")
                if (rate[0].equals("USD")) { //usd
                    if (rate[1].equals("PHP")) { // php
                        map << [newSpecialRateUsdToPhp: it.value]
                    }
                } else { // third
                    if (rate[1].equals("USD")) { // usd
                        map << [newSpecialRateThirdToUsd: it.value]
                    } else if (rate[1].equals("PHP")) { // php
                        map << [newSpecialRateThirdToPhp: it.value]
                    }
                }
            }
        }

        return map
    }

    def prepareRateForConversion(params) {
        def rates = [:]

        params.each {
            if ((it.key != null) && ((String)it.key).contains("special_rate") && (it.value != null)) {
                rates.put(it.key, new BigDecimal(it.value))
            }
        }

        return rates
    }

    def constructParameterForWebService(params) {
        def paramList = []

        def rateMap = constructRateParam(params)

        // default = php
        // original = sett curr
        def oldAmount
        def newAmount
        def refundAmount
        def refundAmountInPhp

        def rates = prepareRateForConversion(params)

        def baseCurrency = params.settlementCurrency

        if (params.bankCommissionNew) {
            println 'bankCommission'
            oldAmount = new BigDecimal(params.bankCommission.replaceAll(",", ""))
            newAmount = new BigDecimal(params.bankCommissionNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "BC",
                       amount: params.bankCommissionBase,
                       originalAmount: params.bankCommission,
                       defaultAmount: params.bankCommissionBase,
                       currency: "PHP",
                       originalCurrency: params.settlementCurrency,
                       refundAmountInOriginalCurrency: refundAmount,
                       refundAmountInDefaultCurrency: refundAmountInPhp,
                       newRefundAmountInOriginalCurrency: params.bankCommissionNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.commitmentFeeNew) {
            println 'commitmentFee'
            oldAmount = new BigDecimal(params.commitmentFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.commitmentFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CF",
                    amount: params.commitmentFeeBase,
                    originalAmount: params.commitmentFee,
                    defaultAmount: params.commitmentFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.commitmentFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cilexNew) {
            println 'cilex'
            oldAmount = new BigDecimal(params.cilex.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cilexNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CILEX",
                    amount: params.cilexBase,
                    originalAmount: params.cilex,
                    defaultAmount: params.cilexBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.cilexNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.notarialFeeNew) {
            println 'notarialFee'
            oldAmount = new BigDecimal(params.notarialFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.notarialFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "NOTARIAL",
                    amount: params.notarialFeeBase,
                    originalAmount: params.notarialFee,
                    defaultAmount: params.notarialFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.notarialFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.documentaryStampsNew) {
            println 'documentaryStamps'
            oldAmount = new BigDecimal(params.documentaryStamps.replaceAll(",", ""))
            newAmount = new BigDecimal(params.documentaryStampsNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "DOCSTAMPS",
                    amount: params.documentaryStampsBase,
                    originalAmount: params.documentaryStamps,
                    defaultAmount: params.documentaryStampsBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.documentaryStampsNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cableFeeNew) {
            println 'cableFee'
            oldAmount = new BigDecimal(params.cableFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cableFeeNew.replaceAll(",", ""))
            println oldAmount
            println newAmount
            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CABLE",
                    amount: params.cableFeeBase,
                    originalAmount: params.cableFee,
                    defaultAmount: params.cableFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.cableFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.suppliesFeeNew) {
            println 'suppliesFee'
            oldAmount = new BigDecimal(params.suppliesFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.suppliesFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "SUP",
                    amount: params.suppliesFeeBase,
                    originalAmount: params.suppliesFee,
                    defaultAmount: params.suppliesFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.suppliesFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.remittanceFeeNew) {
            println 'remittanceFee'
            oldAmount = new BigDecimal(params.remittanceFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.remittanceFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "REMITTANCE",
                    amount: params.remittanceFeeBase,
                    originalAmount: params.remittanceFee,
                    defaultAmount: params.remittanceFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.remittanceFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cancellationFeeNew) {
            println 'cancellationFee'
            oldAmount = new BigDecimal(params.cancellationFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cancellationFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CANCEL",
                    amount: params.cancellationFeeBase,
                    originalAmount: params.cancellationFee,
                    defaultAmount: params.cancellationFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.cancellationFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }
        println params
        // corres
        if (params.correspondingChargesAdvisingFeeNew) {
            println 'correspondingChargesAdvisingFee'
            oldAmount = new BigDecimal(params.correspondingChargesAdvisingFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.correspondingChargesAdvisingFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CORRES-ADVISING",
                    amount: params.correspondingChargesAdvisingFeeBase,
                    originalAmount: params.correspondingChargesAdvisingFee,
                    defaultAmount: params.correspondingChargesAdvisingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.correspondingChargesAdvisingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.correspondingChargesConfirmingFeeNew) {
            println 'correspondingChargesConfirmingFee'
            oldAmount = new BigDecimal(params.correspondingChargesConfirmingFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.correspondingChargesConfirmingFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "CORRES-CONFIRMING",
                    amount: params.correspondingChargesConfirmingFeeBase,
                    originalAmount: params.correspondingChargesConfirmingFee,
                    defaultAmount: params.correspondingChargesConfirmingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.correspondingChargesConfirmingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.marineInsuranceNew) {
            println 'marineInsurance'
            oldAmount = new BigDecimal(params.marineInsurance.replaceAll(",", ""))
            newAmount = new BigDecimal(params.marineInsuranceNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "MARINE",
                    amount: params.marineInsuranceBase,
                    originalAmount: params.marineInsurance,
                    defaultAmount: params.marineInsuranceBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.marineInsuranceNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        // exports
        if (params.exportFxlcAdvisingFeeNew) {
            println 'exportFxlcAdvisingFeeBase'
            oldAmount = new BigDecimal(params.exportFxlcAdvisingFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.exportFxlcAdvisingFeeNew.replaceAll(",", ""))

            if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                refundAmount = oldAmount.subtract(newAmount)
            } else {
                refundAmount = 0
            }

            refundAmountInPhp = convertNewCharge(baseCurrency, "PHP", refundAmount, rates)

            def map = [chargeId: "ADVISING-EXPORT",
                    amount: params.exportFxlcAdvisingFeeBase,
                    originalAmount: params.exportFxlcAdvisingFee,
                    defaultAmount: params.exportFxlcAdvisingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    refundAmountInOriginalCurrency: refundAmount,
                    refundAmountInDefaultCurrency: refundAmountInPhp,
                    newRefundAmountInOriginalCurrency: params.exportFxlcAdvisingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        return paramList
    }

    def computeNewProductAmount(params, rates) {
        return convertNewCharge(params.currency, "PHP", new BigDecimal(params.amount.replaceAll(",", "")), rates)
    }

    def constructPaymentDetails(paymentDetail) {
        def paymentDetailList = []

        paymentDetail.each { pmtDtl ->
            def pmtDtlMap = [settlementCurrency: pmtDtl.currency.currencyCode,
                            amount: NumberUtils.currencyFormat(pmtDtl.amount),
                            amountInLcCurrency: pmtDtl.amountInLcCurrency]

                paymentDetailList << pmtDtlMap
        }

        return paymentDetailList
    }

    def computeNewRateProductAmount(params, rates) {
        def newRateAmountList = []

        int ctr = 0
        params.each {
            if (it.key.contains("newAmount")) {

                def newAmount = convertNewCharge(params.currency, params.get("currency_" + ctr), new BigDecimal(params.get("base_amount_" + ctr).replaceAll(",", "")), rates)

                def keyName = "newAmount_"+ctr
                def map = [:]
                map.put(keyName, NumberUtils.currencyFormat(newAmount))

                newRateAmountList << map
                ctr++
            }
        }

        return newRateAmountList
    }

    def constructNewRateProductParameters(params) {
        def parameterList = []

        def oldAmount
        def newAmount
        def refundAmount
        def refundAmountInPhp

        def rates = prepareRateForConversion(params)
        def rateMap = constructRateParam(params)

        int ctr = 0
        params.each {
            if (it.key.contains("newAmount")) {
                oldAmount = new BigDecimal(params["amount_"+ctr].replaceAll(",", ""))
                newAmount = new BigDecimal(params["newAmount_"+ctr].replaceAll(",", ""))

                if (oldAmount.compareTo(newAmount) >= 0) {   // old is greater than
                    refundAmount = oldAmount.subtract(newAmount)
                } else {
                    refundAmount = 0
                }

                refundAmountInPhp = convertNewCharge(params["currency_"+ctr], "PHP", refundAmount, rates)

                def map = [chargeId: "PRODUCT",
                        amount: params["base_amount_"+ctr],
                        originalAmount: params["amount_"+ctr],
                        defaultAmount: params["base_amount_"+ctr],
                        currency: "PHP",
                        originalCurrency: params["currency_"+ctr],
                        refundAmountInOriginalCurrency: refundAmount,
                        refundAmountInDefaultCurrency: refundAmountInPhp,
                        newRefundAmountInOriginalCurrency: params["newAmount_"+ctr],
                        transactionType: params.transactionType
                ]

                map << rateMap
                parameterList << map
                ctr++
            }
        }

        return parameterList
    }

    def constructPartialProductParameters(params) {
        def parameterList = []

        def oldAmount
        def newAmount
        def refundAmount
        def refundAmountInPhp

        def rateMap = constructRateParam(params)

        def map = [chargeId: "PRODUCT",
                amount: params.amountForRefundInPhp,
                originalAmount: params.amountForRefund,
                defaultAmount: params.amountForRefundInPhp,
                currency: "PHP",
                originalCurrency: params.settlementCurrency,
                refundAmountInOriginalCurrency: params.amountForRefund,
                refundAmountInDefaultCurrency: params.amountForRefundInPhp,
                newRefundAmountInOriginalCurrency: params.amountForRefund,
                transactionType: ''
        ]

        map << rateMap
        parameterList << map

        return parameterList
    }

}
