package com.ucpb.tfsweb.main.other

import net.ipc.utils.NumberUtils

class OtherChargesService {

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
        def postage

        // corres
        def advisingFee
        def confirmingFee
        def marineInsurance

        // exports
        def exportFxlcAdvisingFeeBase

        println "params.settlementCurrency:"+params.settlementCurrency

        def convertedValuesList = []

        def chargeAmount

        if (params.bankCommissionBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.bankCommissionBase), rates)
            convertedValuesList << ["convertedKey" : "bankCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.commitmentFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.commitmentFeeBase), rates)
            convertedValuesList << ["convertedKey" : "commitmentFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cilexBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.cilexBase), rates)
            convertedValuesList << ["convertedKey" : "cilex", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.notarialFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.notarialFeeBase), rates)
            convertedValuesList << ["convertedKey" : "notarialFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.documentaryStampsBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.documentaryStampsBase), rates)
            convertedValuesList << ["convertedKey" : "documentaryStamps", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cableFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.cableFeeBase), rates)
            convertedValuesList << ["convertedKey" : "cableFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.suppliesFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.suppliesFeeBase), rates)
            convertedValuesList << ["convertedKey" : "suppliesFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.remittanceFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.remittanceFeeBase), rates)
            convertedValuesList << ["convertedKey" : "remittanceFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.cancellationFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.cancellationFeeBase), rates)
            convertedValuesList << ["convertedKey" : "cancellationFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.postageBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.postageBase), rates)
            convertedValuesList << ["convertedKey" : "postage", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        // corres
        if (params.correspondingChargesAdvisingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.correspondingChargesAdvisingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "correspondingChargesAdvisingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.correspondingChargesConfirmingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.correspondingChargesConfirmingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "correspondingChargesConfirmingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        if (params.marineInsuranceBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.marineInsuranceBase), rates)
            convertedValuesList << ["convertedKey" : "marineInsurance", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }

        // exports
        if (params.exportFxlcAdvisingFeeBase) {
            chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.exportFxlcAdvisingFeeBase), rates)
            convertedValuesList << ["convertedKey" : "exportFxlcAdvisingFee", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
        }
		
		// nonlc
		if (params.bookingCommissionBase) {
			chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.bookingCommissionBase), rates)
			convertedValuesList << ["convertedKey" : "bookingCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
		}

		if (params.bspCommissionBase) {
			chargeAmount = convertNewCharge("PHP", params.settlementCurrency, new BigDecimal(params.bspCommissionBase), rates)
			convertedValuesList << ["convertedKey" : "bspCommission", "convertedValue" : NumberUtils.currencyFormat(chargeAmount)]
		}

        return convertedValuesList
    }

    def constructParameterForWebService(params) {
        def paramList = []

        def rateMap = constructRateParam(params)

        // default = php
        // original = sett curr
        def oldAmount
        def newAmount
        def collectibleAmount
        def collectibleAmountInPhp

        def rates = prepareRateForConversion(params)

        def baseCurrency = params.settlementCurrency

        if (params.bankCommissionNew) {
            println 'bankCommission'
            oldAmount = new BigDecimal(params.bankCommission.replaceAll(",", ""))
            newAmount = new BigDecimal(params.bankCommissionNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "BC",
                    amount: params.bankCommissionBase,
                    originalAmount: params.bankCommission,
                    defaultAmount: params.bankCommissionBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.bankCommissionNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.commitmentFeeNew) {
            println 'commitmentFee'
            oldAmount = new BigDecimal(params.commitmentFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.commitmentFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CF",
                    amount: params.commitmentFeeBase,
                    originalAmount: params.commitmentFee,
                    defaultAmount: params.commitmentFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.commitmentFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cilexNew) {
            println 'cilex'
            oldAmount = new BigDecimal(params.cilex.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cilexNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CILEX",
                    amount: params.cilexBase,
                    originalAmount: params.cilex,
                    defaultAmount: params.cilexBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.cilexNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.notarialFeeNew) {
            println 'notarialFee'
            oldAmount = new BigDecimal(params.notarialFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.notarialFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "NOTARIAL",
                    amount: params.notarialFeeBase,
                    originalAmount: params.notarialFee,
                    defaultAmount: params.notarialFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.notarialFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.documentaryStampsNew) {
            println 'documentaryStamps'
            oldAmount = new BigDecimal(params.documentaryStamps.replaceAll(",", ""))
            newAmount = new BigDecimal(params.documentaryStampsNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "DOCSTAMPS",
                    amount: params.documentaryStampsBase,
                    originalAmount: params.documentaryStamps,
                    defaultAmount: params.documentaryStampsBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.documentaryStampsNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cableFeeNew) {
            println 'cableFee'
            oldAmount = new BigDecimal(params.cableFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cableFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CABLE",
                    amount: params.cableFeeBase,
                    originalAmount: params.cableFee,
                    defaultAmount: params.cableFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.cableFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.suppliesFeeNew) {
            println 'suppliesFee'
            oldAmount = new BigDecimal(params.suppliesFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.suppliesFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "SUP",
                    amount: params.suppliesFeeBase,
                    originalAmount: params.suppliesFee,
                    defaultAmount: params.suppliesFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.suppliesFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.remittanceFeeNew) {
            println 'remittanceFee'
            oldAmount = new BigDecimal(params.remittanceFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.remittanceFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "REMITTANCE",
                    amount: params.remittanceFeeBase,
                    originalAmount: params.remittanceFee,
                    defaultAmount: params.remittanceFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.remittanceFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.cancellationFeeNew) {
            println 'cancellationFee'
            oldAmount = new BigDecimal(params.cancellationFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.cancellationFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CANCEL",
                    amount: params.cancellationFeeBase,
                    originalAmount: params.cancellationFee,
                    defaultAmount: params.cancellationFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.cancellationFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.postageNew) {
            println 'postage'
            oldAmount = new BigDecimal(params.postage.replaceAll(",", ""))
            newAmount = new BigDecimal(params.postageNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "POSTAGE",
                    amount: params.postageBase,
                    originalAmount: params.postage,
                    defaultAmount: params.postage,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.postageNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        // corres
        if (params.correspondingChargesAdvisingFeeNew) {
            println 'correspondingChargesAdvisingFee'
            oldAmount = new BigDecimal(params.correspondingChargesAdvisingFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.correspondingChargesAdvisingFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CORRES-ADVISING",
                    amount: params.correspondingChargesAdvisingFeeBase,
                    originalAmount: params.correspondingChargesAdvisingFee,
                    defaultAmount: params.correspondingChargesAdvisingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.correspondingChargesAdvisingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.correspondingChargesConfirmingFeeNew) {
            println 'correspondingChargesConfirmingFee'
            oldAmount = new BigDecimal(params.correspondingChargesConfirmingFee.replaceAll(",", ""))
            newAmount = new BigDecimal(params.correspondingChargesConfirmingFeeNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "CORRES-CONFIRMING",
                    amount: params.correspondingChargesConfirmingFeeBase,
                    originalAmount: params.correspondingChargesConfirmingFee,
                    defaultAmount: params.correspondingChargesConfirmingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.correspondingChargesConfirmingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        if (params.marineInsuranceNew) {
            println 'marineInsurance'
            oldAmount = new BigDecimal(params.marineInsurance.replaceAll(",", ""))
            newAmount = new BigDecimal(params.marineInsuranceNew.replaceAll(",", ""))

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "MARINE",
                    amount: params.marineInsuranceBase,
                    originalAmount: params.marineInsurance,
                    defaultAmount: params.marineInsuranceBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.marineInsuranceNew
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

            if (newAmount.compareTo(oldAmount) >= 0) {   // old is greater than
                collectibleAmount = newAmount.subtract(oldAmount)
            } else {
                collectibleAmount = 0
            }

            collectibleAmountInPhp = convertNewCharge(baseCurrency, "PHP", collectibleAmount, rates)

            def map = [chargeId: "ADVISING-EXPORT",
                    amount: params.exportFxlcAdvisingFeeBase,
                    originalAmount: params.exportFxlcAdvisingFee,
                    defaultAmount: params.exportFxlcAdvisingFeeBase,
                    currency: "PHP",
                    originalCurrency: params.settlementCurrency,
                    collectibleAmountInOriginalCurrency: collectibleAmount,
                    collectibleAmountInDefaultCurrency: collectibleAmountInPhp,
                    newCollectibleAmountInOriginalCurrency: params.exportFxlcAdvisingFeeNew
            ]

            map << rateMap
            map << [transactionType: params.transactionType]
            paramList << map
        }

        return paramList
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

    def convertNewCharge(baseCurrency, targetCurrency, amount, rates) {
        baseCurrency = baseCurrency.trim()
        targetCurrency = targetCurrency.trim()
		if(rates){
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
		} else return amount
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
}
