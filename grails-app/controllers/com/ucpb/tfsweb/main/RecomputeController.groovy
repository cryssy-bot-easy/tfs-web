package com.ucpb.tfsweb.main

import grails.converters.JSON

/**
	PROLOGUE:
	(revision)
	SCR/ER Number:
	SCR/ER Description: Wrong computation and no accounting entry was generated for Doc Stamp fee.
	[Revised by:] Lymuel Arrome Saul
	[Date revised:] 2/5/2016
	Program [Revision] Details: Added variable which retrieves the Peso amount of Doc Stamp fee in function recomputeCurrency_BC_FOREIGN_SETTLEMENT()
	Date deployment: 2/9/2016
	Member Type: GROOVY
	Project: CORE
	Project Name: ChargesCalculator.groovy

*/


/**
 PROLOGUE:
 (revision)
 SCR/ER Number:
 SCR/ER Description: Incorrect bank com amount computed. system computed 1/4 of 1% instead of 1/8 of 1%. (Redmine 3763)
 [Revised by:] Robin C. Rafael
 [Date revised:] 2/5/2016
 Program [Revision] Details: on recomputeCurrency_BP_FOREIGN_NEGOTIATION() function, bankCommissionDenominator is set to 4
 Date deployment: 
 Member Type: GROOVY
 Project: CORE
 Project Name: ChargesCalculator.groovy

*/
/**
 *  Revised by: Cedrick C. Nungay
 *  Details: Changes hard-coded parameters of computing
 *      document stamps into data retrieved from database.
 *  Date revised: 02/01/2018
*/
/**
 *  Revised by: Cedrick C. Nungay
 *  Details: Updated computation of document stamps on recomputeCurrency_NON_LC_SETTLEMENT_NEW method.
 *  Date revised: 03/20/2018
 */
/**
 *  Revised by: Cedrick C. Nungay
 *  Details: Added values for forFirstAmount and forNextAmount on recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION
 *  	and recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION method.
 *  Date revised: 03/21/2018
 */
/**
 *  Revised by: Cedrick C. Nungay
 *  Details: Added parameters returned by some computations.
 *  Date revised: 04/13/2018
 */
/**
 *  Revised by: Cedrick C. Nungay
 *  Details: Update approach on getting documentstamps on recomputeCurrency_NON_LC_SETTLEMENT_NEW.
 *  Date revised: 04/20/2018
 */
class RecomputeController {

    def recomputeService
    def ratesService
    def commandService
    def etsService
    def coreAPIService
    def foreignExchangeService
    def chargesParameterRepository

    /***
     * compute total amount
     * @return
     */
    def computeTotal() {

        def param = [currency: session.etsModel?.currency ?: session.chargesModel?.currency ?: params?.currency]
        def tmp = recomputeService.computeTotal(params.amounts)
        def jsonData = [totalAmount: tmp]

        render jsonData as JSON
    }

    /***
     * compute balance
     * @return
     */
    def computeBalance() {
        def computeBalanceResult = recomputeService.computeBalance(params.totalAmountDue, params.totalAmount)
        // TODO: consider currency in computation of balance and excess - Marv
        def jsonData = [balance: computeBalanceResult.balance, excess: computeBalanceResult.excess]

        render jsonData as JSON
    }

    /***
     * recompute action
     * @return
     */
    def recompute() {
        String result

        if (
                params.charge.equalsIgnoreCase("bankCommission") || params.charge.equalsIgnoreCase("commitmentFee") || params.charge.equalsIgnoreCase("confirmingFee") || params.charge.equalsIgnoreCase("cilexFee") || params.charge.equalsIgnoreCase("BC") || params.charge.equalsIgnoreCase("CF") || params.charge.equalsIgnoreCase("CORRES-CONFIRMING") || params.charge.equalsIgnoreCase("CILEX")
        ) {
            result = recomputeService.recomputeForumla1(params.amount, params.numerator, params.denominator, params.percentage, params.months)
        } else {
            result = recomputeService.recomputeDocumentaryStamp(params.amount, params.centavos)
        }

        def jsonData = [result: result]

        render jsonData as JSON
    }

    def recomputeCurrency() {
        def jsonData = [:]
        if (params.amount &&
                params.settlementconversionrateSPECIAL &&
                params.settlementconversionratePASSON &&
                params.lcconversionrateSPECIAL &&
                params.lcconversionratePASSON &&
                params.settlementCurrency && params.currency) {
            BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
            BigDecimal settlementconversionrateSPECIAL = new BigDecimal(params.settlementconversionrateSPECIAL.toString())
            BigDecimal settlementconversionratePASSON = new BigDecimal(params.settlementconversionratePASSON.toString())
            BigDecimal lcconversionrateSPECIAL = new BigDecimal(params.lcconversionrateSPECIAL.toString())
            BigDecimal lcconversionratePASSON = new BigDecimal(params.lcconversionratePASSON.toString())

            String lccurrency = params.currency
            String settlementcurrency = params.settlementCurrency

            def tmp = recomputeService.recomputeCurrency(amount, settlementconversionrateSPECIAL, settlementconversionratePASSON, lcconversionrateSPECIAL, lcconversionratePASSON, lccurrency, settlementcurrency)
            //println "tmp": +tmp
            jsonData = [convertedamount: tmp]

        } else {
            jsonData = [convertedamount: ""]
        }

        render jsonData as JSON
    }

    def recomputeCharge() {
        ////println "recomputeCharge params:"+params
        params.username = session.etsModel.username

        String chargeToCompute

        if (params?.charge?.equalsIgnoreCase("bankCommission") || params?.charge?.equalsIgnoreCase("BC")) {
            params.chargeToCompute = "BC"
            params.charge = "BC"
        } else if (params?.charge?.equalsIgnoreCase("commitmentFee") || params?.charge?.equalsIgnoreCase("CF")) {
            params.chargeToCompute = "CF"
            params.charge = "CF"
        } else if (params?.charge?.equalsIgnoreCase("confirmingFee") || params?.charge?.equalsIgnoreCase("CORRES-CONFIRMING")) {
            params.chargeToCompute = "CORRES-CONFIRMING"
            params.charge = "CORRES-CONFIRMING"
        } else if (params?.charge?.equalsIgnoreCase("cilexFee") || params?.charge?.equalsIgnoreCase("CILEX")) {
            params.chargeToCompute = "CILEX"
            params.charge = "CILEX"
        } else if (params?.charge?.equalsIgnoreCase("documentarystamp") || params?.charge?.equalsIgnoreCase("DOCSTAMPS") || params?.chargeType?.equalsIgnoreCase("DOCSTAMPS")) {
            params.chargeToCompute = "DOCSTAMPS"
            params.charge = "DOCSTAMPS"
        } else if (params?.charge?.equalsIgnoreCase("postagefee") || params?.charge?.equalsIgnoreCase("POSTAGE")) {
            params.chargeToCompute = "POSTAGE"
            params.charge = "POSTAGE"
        } 
        // trigger command
        String token = etsService.computeValue(params)
        BigDecimal computedValue = etsService.getComputedValue(token)
        def jsonData = [result: computedValue]

        //println "jsonDataCharges: " + jsonData
        render jsonData as JSON

    }

    def recomputeCurrencyAmendment() {

        //TODO: HANDLE AMENDMENT HERE
        def jsonData = [:]

        if (params.amount && params.settlementconversionrateSPECIAL && params.settlementconversionratePASSON && params.lcconversionrateSPECIAL && params.lcconversionratePASSON && params.settlementCurrency && params.currency) {
            BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
            BigDecimal settlementconversionrateSPECIAL = new BigDecimal(params.settlementconversionrateSPECIAL.toString())
            BigDecimal settlementconversionratePASSON = new BigDecimal(params.settlementconversionratePASSON.toString())
            BigDecimal lcconversionrateSPECIAL = new BigDecimal(params.lcconversionrateSPECIAL.toString())
            BigDecimal lcconversionratePASSON = new BigDecimal(params.lcconversionratePASSON.toString())

            String lccurrency = params.currency
            String settlementcurrency = params.settlementCurrency

            def tmp = recomputeService.recomputeCurrency(amount, settlementconversionrateSPECIAL, settlementconversionratePASSON, lcconversionrateSPECIAL, lcconversionratePASSON, lccurrency, settlementcurrency)

            jsonData = [convertedamount: tmp]

        } else {
            jsonData = [convertedamount: ""]
        }

        render jsonData as JSON

    }

    def recomputeCurrency_NON_LC_SETTLEMENT() {
        //NOTE:"Temporary Work Around for NON LC Rates!!!!!!"
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
        String tmpAmount = params.productAmount.toString().replace(',', '')
        Integer t = tmpAmount.lastIndexOf(".")
        t = t + 3;
        if (tmpAmount.length() < t) {
            t = tmpAmount.length()
        }
        BigDecimal productAmount = new BigDecimal(tmpAmount.substring(0, t))

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString())
        BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateSettlementCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateSettlementCurrency?.toString())

        BigDecimal usdToPhpPassOnConversionRate = new BigDecimal(params.usdToPhpPassOnConversionRate?.toString())
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString())

        BigDecimal urr = new BigDecimal(params.urr?.toString())
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString())

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        String chargesOverridenFlag = "N"
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def conversionStyleMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getConversionToBeUsed", "")
        String conversionStyle = conversionStyleMap.get("style")


        def tmp
        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

//            def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": params.chargeType], "tradeservice/getServiceCharge", "")
//            BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
//
//            if (settlementcurrency.equalsIgnoreCase("PHP")) {
//                tmp = amount
//            } else if (settlementcurrency.equalsIgnoreCase("USD")) {
//                tmp = amount.divide(usdToPhpUrr, 2, BigDecimal.ROUND_HALF_UP)
//            } else {
//                tmp = amount.divide(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpUrr), 2, BigDecimal.ROUND_HALF_UP)
//            }

            tmp = getChargeWithRest(tradeserviceId, params.chargeType, settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

        } else if ("BC".equalsIgnoreCase(params.chargeType)) {
            String cwtFlag = params.cwtFlag
            String documentType = params.documentType

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : null
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : null
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : null
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : null

            tmp = recomputeService.recomputeNONLCBankCommission(
                    productAmount,
                    lccurrency,
                    settlementcurrency,
                    cwtFlag,
                    documentType,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    bankCommissionNumerator,
                    bankCommissionDenominator,
                    bankCommissionPercentage,
                    cwtPercentage
            )
        } else if ("DOCSTAMPS".equalsIgnoreCase(params.chargeType)) {
            String documentType = params.documentType
            String TR_LOAN_AMOUNT = "0.0    "
            String TR_LOAN_AMOUNT_currency = "PHP"
            String OTHER_AMOUNT = "0.0"
            if (params.tradeServiceId) {
                def TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getTrLoanAmount", "")
                TR_LOAN_AMOUNT = TR_LOAN_AMOUNTMap.get("trloanamount")
                TR_LOAN_AMOUNT_currency = TR_LOAN_AMOUNTMap.get("currency")

                TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getOtherSettlementAmount", "")
                OTHER_AMOUNT = TR_LOAN_AMOUNTMap.get("otherAmount")

            }
            BigDecimal trloanAmount = new BigDecimal(TR_LOAN_AMOUNT.replace(',', ''))
            BigDecimal otherAmount = new BigDecimal(OTHER_AMOUNT.replace(',', ''))
            String TR_LOAN_FLAG = params.TR_LOAN_FLAG
            tmp = recomputeService.recompute_NONLC_DocumentaryStamps(
                    productAmount,
                    lccurrency,
                    settlementcurrency,
                    TR_LOAN_FLAG,
                    trloanAmount,
                    TR_LOAN_AMOUNT_currency,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    documentType,
                    otherAmount,
                    0.30
            )
        } else if ("REMITTANCE".equalsIgnoreCase(params.chargeType)) {
            String remittanceFlag = "N"
            if (params.tradeServiceId) {
                def remittanceFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getRemittanceFlag", "")
                remittanceFlag = remittanceFlagMap.get("remittanceFlag")
            }
            BigDecimal remittanceMinimum = new BigDecimal("18")
            tmp = recomputeService.recompute_NONLC_RemittanceFee(
                    remittanceMinimum,
                    remittanceFlag,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
        } else if ("CABLE".equalsIgnoreCase(params.chargeType)) {
            String cableFeeFlag = "N"

            if (params.tradeServiceId) {
                def cableFeeFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCableFeeFlag", "")
                cableFeeFlag = cableFeeFlagMap.get("cableFeeFlag")
            }

            BigDecimal cableFeeMinimum
            if ("DOMESTIC".equalsIgnoreCase(params.documentType)) {
                cableFeeMinimum = new BigDecimal("500")

            } else {//FOR FOREIGN
                cableFeeFlag = "Y"
                cableFeeMinimum = new BigDecimal("1000")
            }

            tmp = recomputeService.recompute_NONLC_CableFee(
                    cableFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cableFeeFlag
            )

        } else if ("BOOKING".equalsIgnoreCase(params.chargeType)) {
            BigDecimal bookingFeeMinimum = new BigDecimal("500")
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98
            String cwtFlag = params.cwtFlag
            tmp = recomputeService.recompute_NONLC_Booking(
                    bookingFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cwtPercentage,
                    cwtFlag)
        } else if ("BSP".equalsIgnoreCase(params.chargeType)) {
            BigDecimal bookingFeeMinimum = new BigDecimal("100")
            tmp = recomputeService.recompute_NONLC_BspCommission(
                    bookingFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency
            )
        } else if ("NOTARIAL".equalsIgnoreCase(params.chargeType)) {
            BigDecimal notarialFeeMinimum = new BigDecimal("50")
            tmp = recomputeService.recompute_NONLC_NotarialFee(
                    notarialFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
        } else if ("CILEX".equalsIgnoreCase(params.chargeType)) {
            String cwtFlag = params.cwtFlag

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : new BigDecimal("1")
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : new BigDecimal("4")
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : new BigDecimal("0.01")
            String cilexAmountString = "0"
            if (params.tradeServiceId) {
                def cilexAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCilexAmount", "")
                cilexAmountString = cilexAmountMap.get("cilexAmount")
            }

            BigDecimal cilexAmount = new BigDecimal(cilexAmountString)
            tmp = recomputeService.recompute_NONLC_CILEX(
                    cilexAmount,
                    cilexNumerator,
                    cilexDenominator,
                    cilexPercentage,
                    cwtFlag,
                    new BigDecimal("0.98"),
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate
            )
        }
        jsonData = [convertedamount: tmp]


        render jsonData as JSON
    }

    def recomputeCurrency_NON_LC_SETTLEMENT_NEW() {
        println "recomputeCurrency_NON_LC_SETTLEMENT_NEW"
        //NOTE:"Temporary Work Around for NON LC Rates!!!!!!"
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
        String tmpAmount = params.productAmount.toString().replace(',', '')
        Integer t = tmpAmount.lastIndexOf(".")
        t = t + 3;
        if (tmpAmount.length() < t) {
            t = tmpAmount.length()
        }
        BigDecimal productAmount = new BigDecimal(tmpAmount.substring(0, t))

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString())
        BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateSettlementCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateSettlementCurrency?.toString())

        BigDecimal usdToPhpPassOnConversionRate = new BigDecimal(params.usdToPhpPassOnConversionRate?.toString())
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString())

        BigDecimal urr = new BigDecimal(params.urr?.toString())
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString())

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        String chargesOverridenFlag = "N"
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def conversionStyleMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getConversionToBeUsed", "")
        String conversionStyle = conversionStyleMap.get("style")


        def tmp
        BigDecimal bankComm, docStamps, remittanceFee, cableFee, bookingFee, bspFee, notarialFee, cilex
        BigDecimal bankCommOriginal, docStampsOriginal, remittanceFeeOriginal, cableFeeOriginal, bookingFeeOriginal, bspFeeOriginal, notarialFeeOriginal, cilexOriginal
        BigDecimal bankCommnocwtAmount, cilexnocwtAmount
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {
            println "settlementcurrency:"+settlementcurrency

            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bookingFee = getChargeWithRest(tradeserviceId, "BOOKING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bspFee = getChargeWithRest(tradeserviceId, "BSP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            notarialFee = getChargeWithRest(tradeserviceId, "NOTARIAL", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankCommOriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStampsOriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFeeOriginal = getDefaultChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeOriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bookingFeeOriginal = getDefaultChargeWithRest(tradeserviceId, "BOOKING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bspFeeOriginal = getDefaultChargeWithRest(tradeserviceId, "BSP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            notarialFeeOriginal = getDefaultChargeWithRest(tradeserviceId, "NOTARIAL", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexOriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankCommnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = bankComm + docStamps + remittanceFee + cableFee + bookingFee + bspFee + notarialFee + cilex
            temp = [
                    BC: bankComm,
                    DOCSTAMPS: docStamps,
                    REMITTANCE: remittanceFee,
                    CABLE: cableFee,
                    BOOKING: bookingFee,
                    BSP: bspFee,
                    NOTARIAL: notarialFee,
                    CILEX: cilex,
                    TOTAL: total,
                    BCoriginal: bankCommOriginal,
                    DOCSTAMPSoriginal: docStampsOriginal,
                    REMITTANCEoriginal: remittanceFeeOriginal,
                    CABLEoriginal: cableFeeOriginal,
                    BOOKINGoriginal: bookingFeeOriginal,
                    BSPoriginal: bspFeeOriginal,
                    NOTARIALoriginal: notarialFeeOriginal,
                    CILEXoriginal: cilexOriginal,
                    BCnocwtAmount: bankCommnocwtAmount,
                    CILEXnocwtAmount:cilexnocwtAmount
            ]

        } else {

            String cwtFlag = "N"
            if (params.tradeServiceId) {
                def cwtFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCwtFlag", "")
                cwtFlag = cwtFlagMap.get("cwtFlag")
            }


            String documentType = params.documentType

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : null
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : null
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : null
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : new BigDecimal("0.98")

            bankComm = recomputeService.recomputeNONLCBankCommission(
                    productAmount,
                    lccurrency,
                    settlementcurrency,
                    cwtFlag,
                    documentType,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    bankCommissionNumerator,
                    bankCommissionDenominator,
                    bankCommissionPercentage,
                    cwtPercentage
            )


            bankCommOriginal = recomputeService.recomputeNONLCBankCommission(
                    productAmount,
                    lccurrency,
                    "PHP",
                    cwtFlag,
                    documentType,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    bankCommissionNumerator,
                    bankCommissionDenominator,
                    bankCommissionPercentage,
                    cwtPercentage
            )


            bankCommnocwtAmount = recomputeService.recomputeNONLCBankCommission(
                    productAmount,
                    lccurrency,
                    "PHP",
                    "N",//cwtFlag
                    documentType,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    bankCommissionNumerator,
                    bankCommissionDenominator,
                    bankCommissionPercentage,
                    cwtPercentage
            )

//            String documentType = params.documentType
            String TR_LOAN_AMOUNT = "0.0    "
            String TR_LOAN_AMOUNT_currency = "PHP"
            String OTHER_AMOUNT = "0.0"
            if (params.tradeServiceId) {
                def TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getTrLoanAmount", "")
                TR_LOAN_AMOUNT = TR_LOAN_AMOUNTMap.get("trloanamount")
                TR_LOAN_AMOUNT_currency = TR_LOAN_AMOUNTMap.get("currency")

                TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getOtherSettlementAmount", "")
                OTHER_AMOUNT = TR_LOAN_AMOUNTMap.get("otherAmount")

            }
            BigDecimal trloanAmount = new BigDecimal(TR_LOAN_AMOUNT.replace(',', ''))
            BigDecimal otherAmount = new BigDecimal(OTHER_AMOUNT.replace(',', ''))
            String TR_LOAN_FLAG = params.TR_LOAN_FLAG

            def result
            if (documentType.equalsIgnoreCase('DOMESTIC')) {
                result = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: "PHP",
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount,
                    documentType: documentType,
                ], "charges/getDMNONLCSettlementCharge", "").get("result")
            } else {
                result = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: params.settlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount,
                    documentType: documentType,
                ], "charges/getFXNONLCSettlementCharge", "").get("result")
            }
            docStamps = new BigDecimal(result.get("DOCSTAMPS").toString())
            docStampsOriginal = new BigDecimal(result.get("DOCSTAMPSoriginal").toString())


            BigDecimal bookingFeeMinimum = new BigDecimal("500")
//            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98
//            String cwtFlag = params.cwtFlag
            bookingFee = recomputeService.recompute_NONLC_Booking(
                    bookingFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cwtPercentage,
                    cwtFlag)
            bookingFeeOriginal = recomputeService.recompute_NONLC_Booking(
                    bookingFeeMinimum,
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cwtPercentage,
                    cwtFlag)

            BigDecimal bspFeeMinimum = new BigDecimal("100")
            bspFee = recomputeService.recompute_NONLC_BspCommission(
                    bspFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency
            )
            bspFeeOriginal = recomputeService.recompute_NONLC_BspCommission(
                    bspFeeMinimum,
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency
            )

            BigDecimal notarialFeeMinimum = new BigDecimal("50")
            notarialFee = recomputeService.recompute_NONLC_NotarialFee(
                    notarialFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)

            notarialFeeOriginal = recomputeService.recompute_NONLC_NotarialFee(
                    notarialFeeMinimum,
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)

//            String cwtFlag = params.cwtFlag

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : new BigDecimal("1")
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : new BigDecimal("4")
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : new BigDecimal("0.01")
            String cilexAmountString = "0"
            if (params.tradeServiceId) {
                def cilexAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCilexAmount", "")
                cilexAmountString = cilexAmountMap.get("cilexAmount")
            }

            BigDecimal cilexAmount = new BigDecimal(cilexAmountString)
            cilex = recomputeService.recompute_NONLC_CILEX(
                    cilexAmount,
                    cilexNumerator,
                    cilexDenominator,
                    cilexPercentage,
                    cwtFlag,
                    new BigDecimal("0.98"),
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate
            )

            cilexOriginal = recomputeService.recompute_NONLC_CILEX(
                    cilexAmount,
                    cilexNumerator,
                    cilexDenominator,
                    cilexPercentage,
                    cwtFlag,
                    new BigDecimal("0.98"),
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate
            )

            cilexnocwtAmount = recomputeService.recompute_NONLC_CILEX(
                    cilexAmount,
                    cilexNumerator,
                    cilexDenominator,
                    cilexPercentage,
                    "N",//cwtFlag
                    new BigDecimal("0.98"),
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate
            )

            String cableFeeFlag = "N"

            if (params.tradeServiceId) {
                def cableFeeFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCableFeeFlag", "")
                cableFeeFlag = cableFeeFlagMap.get("cableFeeFlag")
            }

            BigDecimal cableFeeMinimum
            if ("DOMESTIC".equalsIgnoreCase(params.documentType)) {
                cableFeeMinimum = new BigDecimal("500")

            } else {//FOR FOREIGN
                cableFeeFlag = "Y"
                cableFeeMinimum = new BigDecimal("1000")
            }

            cableFee = recomputeService.recompute_NONLC_CableFee(
                    cableFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cableFeeFlag
            )

            cableFeeOriginal = recomputeService.recompute_NONLC_CableFee(
                    cableFeeMinimum,
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cableFeeFlag
            )

            String remittanceFlag = "N"
            if (params.tradeServiceId) {
                def remittanceFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getRemittanceFlag", "")
                remittanceFlag = remittanceFlagMap.get("remittanceFlag")
            }
            BigDecimal remittanceMinimum = new BigDecimal("18")
            remittanceFee = recomputeService.recompute_NONLC_RemittanceFee(
                    remittanceMinimum,
                    remittanceFlag,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
            remittanceFeeOriginal = recomputeService.recompute_NONLC_RemittanceFee(
                    remittanceMinimum,
                    remittanceFlag,
                    lccurrency,
                    "PHP",
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)


            total = bankComm + docStamps + cableFee + remittanceFee + bookingFee + bspFee + notarialFee + cilex
        }

        jsonData = [
                BC: bankComm,
                DOCSTAMPS: docStamps,
                REMITTANCE: remittanceFee,
                CABLE: cableFee,
                BOOKING: bookingFee,
                BSP: bspFee,
                NOTARIAL: notarialFee,
                CILEX: cilex,
                TOTAL: total,
                BCoriginal: bankCommOriginal,
                DOCSTAMPSoriginal: docStampsOriginal,
                REMITTANCEoriginal: remittanceFeeOriginal,
                CABLEoriginal: cableFeeOriginal,
                BOOKINGoriginal: bookingFeeOriginal,
                BSPoriginal: bspFeeOriginal,
                NOTARIALoriginal: notarialFeeOriginal,
                CILEXoriginal: cilexOriginal,
                BCnocwtAmount: bankCommnocwtAmount,
                CILEXnocwtAmount:cilexnocwtAmount
        ]

        println "jsonData::::"+jsonData


        render jsonData as JSON
    }

    def recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION() {
        //NOTE:"Temporary Work Around for NON LC Rates!!!!!!"
        println "recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION"
        def jsonData = [:]

        String tradeserviceId = null
        if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        }
        if (tradeserviceId == null && session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        }
        if (tradeserviceId == null && session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        //println "TRADESERVICEID" + tradeserviceId

        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
        String tmpAmount = params.productAmount.toString().replace(',', '')
        //println "orig:" + tmpAmount
        Integer t = tmpAmount.lastIndexOf(".")
        t = t + 3;
        if (tmpAmount.length() < t) {
            t = tmpAmount.length()
        }
        BigDecimal productAmount = new BigDecimal(tmpAmount.substring(0, t))

        //println "params > " + params
        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString())
        BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateSettlementCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateSettlementCurrency?.toString())

        BigDecimal usdToPhpPassOnConversionRate = new BigDecimal(params.usdToPhpPassOnConversionRate?.toString())
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString())

        BigDecimal urr = new BigDecimal(params.urr?.toString())
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString())

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        String chargesOverridenFlag = "N"
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        //println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag


        def conversionStyleMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getConversionToBeUsed", "")
        String conversionStyle = conversionStyleMap.get("style")


        def tmp, tmpOriginal
        BigDecimal cwt = BigDecimal.ZERO
        BigDecimal gross = BigDecimal.ZERO


        if ("BC".equalsIgnoreCase(params.chargeType)) {
            //println "BC"
            String cwtFlag = params.cwtFlag
            String documentType = params.documentType

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : null
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : null
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : null
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : null

            tmp = recomputeService.recomputeNONLCBankCommission(
                    productAmount,
                    lccurrency,
                    settlementcurrency,
                    cwtFlag,
                    documentType,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate,
                    conversionStyle,
                    bankCommissionNumerator,
                    bankCommissionDenominator,
                    bankCommissionPercentage,
                    cwtPercentage
            )

            if ("Y".equalsIgnoreCase(cwtFlag)) {
//                println "angols giancarlo giancarlo"
                gross = tmp.divide(new BigDecimal("0.98"), 12, BigDecimal.ROUND_FLOOR)
                cwt = gross.minus(tmp)
            }

        } else if ("DOCSTAMPS".equalsIgnoreCase(params.chargeType)) {
            //println "DOCSTAMPS"
            String documentType = params.documentType
            String TR_LOAN_AMOUNT = "0.0    "
            String TR_LOAN_AMOUNT_currency = "PHP"
            String OTHER_AMOUNT = "0.0"
            String paramsCentavos = params.centavos ?: "0.60"
            BigDecimal centavos = new BigDecimal(paramsCentavos)
            if (!centavos && centavos > 0) {
                centavos = 0.6
            }

            if (params.tradeServiceId) {
                def TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getTrLoanAmount", "")
                TR_LOAN_AMOUNT = TR_LOAN_AMOUNTMap.get("trloanamount")
                TR_LOAN_AMOUNT_currency = TR_LOAN_AMOUNTMap.get("currency")

                TR_LOAN_AMOUNTMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getOtherSettlementAmount", "")
                OTHER_AMOUNT = TR_LOAN_AMOUNTMap.get("otherAmount")


            }
            BigDecimal trloanAmount = new BigDecimal(TR_LOAN_AMOUNT.replace(',', ''))
            BigDecimal otherAmount = new BigDecimal(OTHER_AMOUNT.replace(',', ''))
            String TR_LOAN_FLAG = params.TR_LOAN_FLAG
            def chargesResultFlagMap
            if (documentType.equalsIgnoreCase('FOREIGN')) {
                chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: params.settlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount,
                    documentType: documentType,
                    centavos: centavos,
                    forFirst: params.forFirst,
                    forNext: params.forNext,
                    forFirstAmount: params.forFirstAmount,
                    forNextAmount: params.forNextAmount,
                    settlementMode: params.settlementMode
                ], "charges/getFXNONLCSettlementCharge", "")
            } else if (documentType.equalsIgnoreCase('DOMESTIC')) {
                chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount,
                    documentType: documentType,
                    centavos: centavos,
                    forFirst: params.forFirst,
                    forNext: params.forNext,
                    forFirstAmount: params.forFirstAmount,
                    forNextAmount: params.forNextAmount
                ], "charges/getDMNONLCSettlementCharge", "")
                    }
            tmp = new BigDecimal(chargesResultFlagMap.get("result").get("DOCSTAMPS").toString())
            tmpOriginal = new BigDecimal(chargesResultFlagMap.get("result").get("DOCSTAMPSoriginal").toString())
        } else if ("REMITTANCE".equalsIgnoreCase(params.chargeType)) {
            //println "REMITTANCE"
            String remittanceFlag = "N"
            if (params.tradeServiceId) {
                def remittanceFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getRemittanceFlag", "")
                remittanceFlag = remittanceFlagMap.get("remittanceFlag")
                //println "remittanceFlag::::::::::::::::::::::::::::::::::" + remittanceFlag
            }
            BigDecimal remittanceMinimum = new BigDecimal("18")
            tmp = recomputeService.recompute_NONLC_RemittanceFee(
                    remittanceMinimum,
                    remittanceFlag,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
        } else if ("CABLE".equalsIgnoreCase(params.chargeType)) {
            //println "CABLE"
            String cableFeeFlag = "N"

            if (params.tradeServiceId) {
                def cableFeeFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCableFeeFlag", "")
                cableFeeFlag = cableFeeFlagMap.get("cableFeeFlag")
                //println "cableFeeFlag::::::::::::::::::::::::::::::::::" + cableFeeFlag
            }

            BigDecimal cableFeeMinimum
            if ("DOMESTIC".equalsIgnoreCase(params.documentType)) {
                cableFeeMinimum = new BigDecimal("500")

            } else {//FOR FOREIGN
                cableFeeFlag = "Y"
                cableFeeMinimum = new BigDecimal("1000")
            }

            tmp = recomputeService.recompute_NONLC_CableFee(
                    cableFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    cableFeeFlag
            )

        } else if ("BOOKING".equalsIgnoreCase(params.chargeType)) {
            //println "BOOKING"
            String cwtFlag = params.cwtFlag
            BigDecimal bookingFeeMinimum = new BigDecimal("500")
            tmp = recomputeService.recompute_NONLC_Booking(
                    bookingFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    new BigDecimal("0.98"),
                    cwtFlag
            )
        } else if ("BSP".equalsIgnoreCase(params.chargeType)) {
//            println "BSP"
            BigDecimal bookingFeeMinimum = new BigDecimal("100")
            tmp = recomputeService.recompute_NONLC_BspCommission(
                    bookingFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
        } else if ("NOTARIAL".equalsIgnoreCase(params.chargeType)) {
//            println "NOTARIAL"
            BigDecimal notarialFeeMinimum = new BigDecimal("50")
            tmp = recomputeService.recompute_NONLC_NotarialFee(
                    notarialFeeMinimum,
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateSettlementCurrency)
        } else if ("CILEX".equalsIgnoreCase(params.chargeType)) {
//            println "CILEX"
            String cwtFlag = params.cwtFlag

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : new BigDecimal("1")
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : new BigDecimal("4")
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : new BigDecimal("0.01")

            if (cilexPercentage >= 1) {
                cilexPercentage = cilexPercentage / 100
            }
            String cilexAmountString = "0"
            if (params.tradeServiceId) {
                def cilexAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getCilexAmount", "")
                cilexAmountString = cilexAmountMap.get("cilexAmount")
//                println "cilexAmountString::::::::::::::::::::::::::::::::::" + cilexAmountString
            }

            BigDecimal cilexAmount = new BigDecimal(cilexAmountString)
            tmp = recomputeService.recompute_NONLC_CILEX(
                    cilexAmount,
                    cilexNumerator,
                    cilexDenominator,
                    cilexPercentage,
                    cwtFlag,
                    new BigDecimal("0.98"),
                    lccurrency,
                    settlementcurrency,
                    urr,
                    thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate
            )
        }

        jsonData = [convertedamount: tmp, DOCSTAMPSoriginal: tmpOriginal, gross: gross, cwt: cwt]
        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_OPENING() {
        println "<-------------------recomputeCurrency_LC_DOMESTIC_OPENING-------------------->"
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replaceAll(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
//
//        BigDecimal productAmount = new BigDecimal(tmpAmount)

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee
        def bankComoriginal, commFeeoriginal, suppFeeoriginal
        def bankComnocwtAmount, commFeenocwtAmount
        BigDecimal total
        Map temp = [:]


        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFee = getChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeenocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = bankCom + commFee + suppFee
            temp = [
                    BC: bankCom,
                    CF: commFee,
                    SUP: suppFee,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    SUPoriginal: suppFeeoriginal,
                    BCnocwtAmount: bankComnocwtAmount,
                    CFnocwtAmount: commFeenocwtAmount
            ]

        } else {


            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01


            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: "0.00",
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
            ], "charges/getDMOpeningCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("SUP").toString()))
        }

        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                SUP: temp.get("SUP"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CForiginal: temp.get("CForiginal"),
                SUPoriginal: temp.get("SUPoriginal"),
                BCnocwtAmount: temp.get("BCnocwtAmount"),
                CFnocwtAmount: temp.get("CFnocwtAmount")
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString())
        BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateSettlementCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateCurrency?.toString())
        BigDecimal thirdToUsdPassOnConversionRateSettlementCurrency = new BigDecimal(params.thirdToUsdPassOnConversionRateSettlementCurrency?.toString())

        BigDecimal usdToPhpPassOnConversionRate = new BigDecimal(params.usdToPhpPassOnConversionRate?.toString())
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString())

        BigDecimal urr = new BigDecimal(params.urr?.toString())
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString())

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency
        String expiryDate = params.expiryDate

        String chargesOverridenFlag = "N"
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")


        def conversionStyleMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getConversionToBeUsed", "")
        String conversionStyle = conversionStyleMap.get("style")


        def tmp

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01
        BigDecimal bankCommissionMonths = params.bankComNumberOfMonths ? new BigDecimal(params.bankComNumberOfMonths) : 0

        if (bankCommissionPercentage >= 1) {
            bankCommissionPercentage = bankCommissionPercentage / 100
        }

        BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
        BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
        BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01
        BigDecimal commitmentFeeMonths = params.comFeeNumberOfMonths ? new BigDecimal(params.comFeeNumberOfMonths) : 0

        if (commitmentFeePercentage >= 1) {
            commitmentFeePercentage = commitmentFeePercentage / 100
        }


        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: "0.00",
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                bankCommissionMonths: bankCommissionMonths.toPlainString(),
                commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
                commitmentFeeMonths: commitmentFeeMonths.toPlainString()
        ], "charges/getDMOpeningCharge", "")
        def temp = chargesResultFlagMap.get("result")


        if ("BC".equalsIgnoreCase(params.chargeType)) {
            tmp = new BigDecimal(temp.get("BC").toString())
        } else if ("CF".equalsIgnoreCase(params.chargeType)) {
            tmp = new BigDecimal(temp.get("CF").toString())
        } else if ("DOCSTAMPS".equalsIgnoreCase(params.chargeType)) {
            tmp = new BigDecimal(temp.get("DOCSTAMPS").toString())
        }
        jsonData = [convertedamount: tmp]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_NEGOTIATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docStamps, cableFee, remittanceFee
        def docStampsoriginal, cableFeeoriginal, remittanceFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            docStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            docStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = docStamps + cableFee + remittanceFee
            temp = [
                    DOCSTAMPS: docStamps,
                    CABLE: cableFee,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
                    DOCSTAMPS: docStamps,
                    CABLE: cableFee,
                    REMITTANCE: remittanceFee,
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            String expiryDate = params.expiryDate
            String etsDate = params.etsDate
            BigDecimal usancePeriod = new BigDecimal(params.usancePeriod ?: 0)

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    expiryDate: expiryDate,
                    etsDate: etsDate,
                    usancePeriod: usancePeriod.toPlainString()
            ], "charges/getDMNegotiationCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("DOCSTAMPS").toString()).add(new BigDecimal(temp.get("REMITTANCE").toString())).add(new BigDecimal(temp.get("CABLE").toString()))
        }

        jsonData = [
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                REMITTANCE: temp.get("REMITTANCE"),
                CABLE: temp.get("CABLE"),
                TOTAL: total,
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                REMITTANCEoriginal: temp.get("REMITTANCEoriginal"),
                CABLEoriginal: temp.get("CABLEoriginal")
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
//        BigDecimal productAmount = new BigDecimal(tmpAmount.substring(0, t))

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docStamps, cableFee, remittanceFee
        BigDecimal total
        Map temp = [:]

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98
        BigDecimal usancePeriod = new BigDecimal(params.usancePeriod ?: 0)

        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: "0.00",
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                usancePeriod: usancePeriod.toPlainString(),
                forFirst: params.forFirst,
                forNext: params.forNext,
                forFirstAmount: params.forFirstAmount,
                forNextAmount: params.forNextAmount,
        ], "charges/getDMNegotiationCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("DOCSTAMPS").toString()).add(new BigDecimal(temp.get("REMITTANCE").toString())).add(new BigDecimal(temp.get("CABLE").toString()))

        //println "total:" + total
        jsonData = [
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                REMITTANCE: temp.get("REMITTANCE"),
                CABLE: temp.get("CABLE"),
                TOTAL: total
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_AMENDMENT() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }
//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee
        def bankComnocwtAmount, commFeenocwtAmount
        def bankComoriginal, commFeeoriginal, suppFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFee = getChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeenocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = bankCom + commFee + suppFee
            temp = [
                    BC: bankCom,
                    CF: commFee,
                    SUP: suppFee,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    SUPoriginal: suppFeeoriginal,
                    BCnocwtAmount: bankComnocwtAmount,
                    CFnocwtAmount: commFeenocwtAmount
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01


            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
            ], "charges/getDMAmendmentCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("SUP").toString()))
        }

        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                SUP: temp.get("SUP"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CForiginal: temp.get("CForiginal"),
                SUPoriginal: temp.get("SUPoriginal"),
                BCnocwtAmount: temp.get("BCnocwtAmount"),
                CFnocwtAmount: temp.get("CFnocwtAmount"),

        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

        if (bankCommissionPercentage >= 1) {
            bankCommissionPercentage = bankCommissionPercentage / 100
        }

        BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
        BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
        BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01

        if (commitmentFeePercentage >= 1) {
            commitmentFeePercentage = commitmentFeePercentage / 100
        }


        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
        ], "charges/getDMAmendmentCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("SUP").toString()))

        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                SUP: temp.get("SUP"),
                TOTAL: total
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_UA_LOAN_MATURITY_ADJUSTMENT() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee
        def bankComnocwtAmount, commFeenocwtAmount
        def bankComoriginal, commFeeoriginal, suppFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFee = getChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComnocwtAmount = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeenocwtAmount = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = bankCom + commFee + suppFee
            temp = [
                    BC: bankCom,
                    CF: commFee,
                    SUP: suppFee,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    SUPoriginal: suppFeeoriginal,
                    BCnocwtAmount: bankComnocwtAmount,
                    CFnocwtAmount: commFeenocwtAmount
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01


            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
            ], "charges/getDUALoanMaturityAdjustmentCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("SUP").toString()))
        }

        //println "total: " + total
        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                SUP: temp.get("SUP"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CForiginal: temp.get("CForiginal"),
                SUPoriginal: temp.get("SUPoriginal"),
                BCnocwtAmount: temp.get("BCnocwtAmount"),
                CFnocwtAmount: temp.get("CFnocwtAmount")
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_UA_LOAN_MATURITY_ADJUSTMENT_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }

        BigDecimal productAmount = BigDecimal.ZERO;

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

        BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
        BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
        BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01


        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: productAmount.toPlainString(),
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
        ], "charges/getDUALoanMaturityAdjustmentCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("SUP").toString()))

        //println "total: " + total
        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                SUP: temp.get("SUP"),
                TOTAL: total
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docStamps, cableFee, remittanceFee
        def docStampsoriginal, cableFeeoriginal, remittanceFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            docStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            docStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = docStamps + cableFee + remittanceFee
            temp = [
                    DOCSTAMPS: docStamps,
                    CABLE: cableFee,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docStampsoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    REMITTANCEoriginal: remittanceFeeoriginal
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            String expiryDate = params.expiryDate
            String etsDate = params.etsDate
            BigDecimal usancePeriod = new BigDecimal(params.usancePeriod ?: 0)

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    expiryDate: expiryDate,
                    etsDate: etsDate,
                    usancePeriod: usancePeriod.toPlainString()
            ], "charges/getDUALoanSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("DOCSTAMPS").toString()).add(new BigDecimal(temp.get("REMITTANCE").toString())).add(new BigDecimal(temp.get("CABLE").toString()))

            println " ```````````````````` DOCSTAMPS = ${temp.get("DOCSTAMPS")}"
            println " ```````````````````` REMITTANCE = ${temp.get("REMITTANCE")}"
            println " ```````````````````` CABLE = ${temp.get("CABLE")}"
        }

        //println "total:" + total
        jsonData = [
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                REMITTANCE: temp.get("REMITTANCE"),
                CABLE: temp.get("CABLE"),
                TOTAL: total,
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                REMITTANCEoriginal: temp.get("REMITTANCEoriginal"),
                CABLEoriginal: temp.get("CABLEoriginal")
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docStamps, cableFee, remittanceFee
        BigDecimal total
        Map temp = [:]


        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        String expiryDate = params.expiryDate
        String etsDate = params.etsDate
        BigDecimal usancePeriod = new BigDecimal(params.usancePeriod ?: 0)

        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: tradeserviceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: productAmount.toPlainString(),
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                expiryDate: expiryDate,
                etsDate: etsDate,
                usancePeriod: usancePeriod.toPlainString(),
                forFirst: params.forFirst,
                forNext: params.forNext,
                forFirstAmount: params.forFirstAmount,
                forNextAmount: params.forNextAmount
        ], "charges/getDUALoanSettlementCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("DOCSTAMPS").toString()).add(new BigDecimal(temp.get("REMITTANCE").toString())).add(new BigDecimal(temp.get("CABLE").toString()))

        println " ```````````````````` DOCSTAMPS = ${temp.get("DOCSTAMPS")}"
        println " ```````````````````` REMITTANCE = ${temp.get("REMITTANCE")}"
        println " ```````````````````` CABLE = ${temp.get("CABLE")}"

        //println "total:" + total
        jsonData = [
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                REMITTANCE: temp.get("REMITTANCE"),
                CABLE: temp.get("CABLE"),
                TOTAL: total
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_OPENING() {
        println "recomputeCurrency_LC_FOREIGN_OPENING"
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
//        BigDecimal productAmount = new BigDecimal(tmpAmount.substring(0, t))


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, suppFee, docstamps, cableFee, advising, confirming, cilex
        def bankComnocwtAmount, commFeenocwtAmount, cilexnocwtAmount
        def bankComoriginal, commFeeoriginal, suppFeeoriginal, docstampsoriginal, cableFeeoriginal, advisingoriginal, confirmingoriginal, cilexoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {
            println "settlementcurrency:"+settlementcurrency
            println "thirdToUsdSpecialConversionRateCurrency:"+thirdToUsdSpecialConversionRateCurrency

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFee = getChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            advising = getChargeWithRest(tradeserviceId, "CORRES-ADVISING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            confirming = getChargeWithRest(tradeserviceId, "CORRES-CONFIRMING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            println "BCoriginal:" + bankComoriginal
            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            suppFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "SUP", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            advisingoriginal = getDefaultChargeWithRest(tradeserviceId, "CORRES-ADVISING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            confirmingoriginal = getDefaultChargeWithRest(tradeserviceId, "CORRES-CONFIRMING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeenocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            //get remote for advising and confirming tag
            def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getAdvanceCorresChargesFlag", "")
            String advisingFlag = getServiceChargeAmountMap.get("advanceCorresChargesFlag");
            if (!advisingFlag.equalsIgnoreCase("Y")) {
                advising = 0
                advisingoriginal = 0 //TODO CHECK THESE
            }

            getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getConfirmationInstructionsFlag", "")
            String confirmingFlag = getServiceChargeAmountMap.get("confirmationInstructionsFlag");
            if (!confirmingFlag.equalsIgnoreCase("Y")) {
                confirming = 0
                confirmingoriginal = 0
            }

            total = bankCom + commFee + suppFee + docstamps + cableFee + advising + confirming + cilex

            jsonData = [
                    BC: bankCom,
                    CF: commFee,
                    DOCSTAMPS: docstamps,
                    CABLE: cableFee,
                    SUP: suppFee,
                    CILEX: cilex,
                    "CORRES-ADVISING": advising,
                    "CORRES-CONFIRMING": confirming,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    SUPoriginal: suppFeeoriginal,
                    CILEXoriginal: cilexoriginal,
                    "CORRES-ADVISINGoriginal": advisingoriginal,
                    "CORRES-CONFIRMINGoriginal": confirmingoriginal,
                    BCnocwtAmount:bankComnocwtAmount,
                    CFnocwtAmount:commFeenocwtAmount,
                    CILEXnocwtAmount: cilexnocwtAmount
            ]
            println "jsonData:" + jsonData

        } else {


            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            BigDecimal confirmingFeeNumerator = params.confirmingFeeNumerator ? new BigDecimal(params.confirmingFeeNumerator) : 1
            BigDecimal confirmingFeeDenominator = params.confirmingFeeDenominator ? new BigDecimal(params.confirmingFeeDenominator) : 8
            BigDecimal confirmingFeePercentage = params.confirmingFeePercentage ? new BigDecimal(params.confirmingFeePercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: "0.00",
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString(),
                    confirmingFeeNumerator: confirmingFeeNumerator.toPlainString(),
                    confirmingFeeDenominator: confirmingFeeDenominator.toPlainString(),
                    confirmingFeePercentage: confirmingFeePercentage.toPlainString(),
                    centavos: params.centavos
            ], "charges/getFXOpeningCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("TOTAL").toString())

            bankCom = new BigDecimal(temp.get("BC").toString())
            commFee = new BigDecimal(temp.get("CF").toString())
            suppFee = new BigDecimal(temp.get("SUP").toString())
            docstamps = new BigDecimal(temp.get("DOCSTAMPS").toString())
            cableFee = new BigDecimal(temp.get("CABLE").toString())
            advising = new BigDecimal(temp.get("CORRES-ADVISING").toString())
            confirming = new BigDecimal(temp.get("CORRES-CONFIRMING").toString())
            cilex = new BigDecimal(temp.get("CILEX").toString())

            bankComoriginal = new BigDecimal(temp.get("BCoriginal").toString())
            commFeeoriginal = new BigDecimal(temp.get("CForiginal").toString())
            suppFeeoriginal = new BigDecimal(temp.get("SUPoriginal").toString())
            docstampsoriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal").toString())
            cableFeeoriginal = new BigDecimal(temp.get("CABLEoriginal").toString())
            advisingoriginal = new BigDecimal(temp.get("CORRES-ADVISINGoriginal").toString())
            confirmingoriginal = new BigDecimal(temp.get("CORRES-CONFIRMINGoriginal").toString())
            cilexoriginal = new BigDecimal(temp.get("CILEXoriginal").toString())


            bankComnocwtAmount = new BigDecimal(temp.get("BCnocwtAmount").toString())
            commFeenocwtAmount = new BigDecimal(temp.get("CFnocwtAmount").toString())
            cilexnocwtAmount = new BigDecimal(temp.get("CILEXnocwtAmount").toString())

            //get remote for advising and confirming tag
            def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getAdvanceCorresChargesFlag", "")
            String advisingFlag = getServiceChargeAmountMap.get("advanceCorresChargesFlag");
            println "advisingFlag advisingFlag advisingFlag::" + advisingFlag
            if (!advisingFlag.equalsIgnoreCase("Y")) {
                advising = 0
                advisingoriginal = 0
            }

            getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getConfirmationInstructionsFlag", "")
            String confirmingFlag = getServiceChargeAmountMap.get("confirmationInstructionsFlag");
            println "confirmingFlag confirmingFlag confirmingFlag :::" + confirmingFlag
            if (!confirmingFlag.equalsIgnoreCase("Y")) {
                confirming = 0
                confirmingoriginal = 0
            }


            total = bankCom + commFee + suppFee + docstamps + cableFee + advising + confirming + cilex

            //println "total:" + total
            jsonData = [
                    BC: bankCom,
                    CF: commFee,
                    DOCSTAMPS: docstamps,
                    CABLE: cableFee,
                    SUP: suppFee,
                    CILEX: cilex,
                    "CORRES-ADVISING": advising,
                    "CORRES-CONFIRMING": confirming,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    SUPoriginal: suppFeeoriginal,
                    CILEXoriginal: cilexoriginal,
                    "CORRES-ADVISINGoriginal": advisingoriginal,
                    "CORRES-CONFIRMINGoriginal": confirmingoriginal,
                    BCnocwtAmount: bankComnocwtAmount,
                    CFnocwtAmount: commFeenocwtAmount,
                    CILEXnocwtAmount: cilexnocwtAmount

            ]
        }

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)


        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        //println "recomputeCurrency_LC_DOMESTIC_OPENING:" + params

        def bankCom, commFee, suppFee, docstamps, cableFee, advising, confirming, cilex, docstampsOriginal
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01
        if (bankCommissionPercentage >= 1) {
            bankCommissionPercentage = bankCommissionPercentage / 100
        }

        BigDecimal bankCommissionMonths = params.bankComNumberOfMonths ? new BigDecimal(params.bankComNumberOfMonths) : 0


        BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
        BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
        BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01
        if (commitmentFeePercentage >= 1) {
            commitmentFeePercentage = commitmentFeePercentage / 100
        }
        BigDecimal commitmentFeeMonths = params.comFeeNumberOfMonths ? new BigDecimal(params.comFeeNumberOfMonths) : 0


        BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
        BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
        BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01
        if (cilexPercentage >= 1) {
            cilexPercentage = cilexPercentage / 100
        }


        BigDecimal confirmingFeeNumerator = params.confirmingFeeNumerator ? new BigDecimal(params.confirmingFeeNumerator) : 1
        BigDecimal confirmingFeeDenominator = params.confirmingFeeDenominator ? new BigDecimal(params.confirmingFeeDenominator) : 8
        BigDecimal confirmingFeePercentage = params.confirmingFeePercentage ? new BigDecimal(params.confirmingFeePercentage) : 0.01
        if (confirmingFeePercentage >= 1) {
            confirmingFeePercentage = confirmingFeePercentage / 100
        }
        BigDecimal confirmingFeeMonths = params.confirmFeeNumberOfMonths ? new BigDecimal(params.confirmFeeNumberOfMonths) : 0

        BigDecimal centavos = params.centavos ? new BigDecimal(params.centavos) : 0.3

        String chargeSettlementCurrency = params.settlementCurrency
        //println "chargeSettlementCurrency:" + chargeSettlementCurrency
        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                chargeSettlementCurrency: chargeSettlementCurrency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: "0.0",
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                bankCommissionMonths: bankCommissionMonths.toPlainString(),
                commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
                commitmentFeeMonths: commitmentFeeMonths.toPlainString(),
                confirmingFeeNumerator: confirmingFeeNumerator.toPlainString(),
                confirmingFeeDenominator: confirmingFeeDenominator.toPlainString(),
                confirmingFeePercentage: confirmingFeePercentage.toPlainString(),
                confirmingFeeMonths: confirmingFeeMonths.toPlainString(),
                cilexPercentage: cilexPercentage.toPlainString(),
                cilexDenominator: cilexDenominator.toPlainString(),
                cilexNumerator: cilexNumerator.toPlainString(),
                centavos: centavos.toPlainString(),
                recompute:"Y" //To tell ChargesRestServices that it is for recompute
        ], "charges/getFXOpeningCharge", "")
        temp = chargesResultFlagMap.get("result")

        bankCom = new BigDecimal(temp.get("BC").toString())
        commFee = new BigDecimal(temp.get("CF").toString())
        suppFee = new BigDecimal(temp.get("SUP").toString())
        docstamps = new BigDecimal(temp.get("DOCSTAMPS").toString())
        docstampsOriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal").toString())
        cableFee = new BigDecimal(temp.get("CABLE").toString())
        advising = new BigDecimal(temp.get("CORRES-ADVISING").toString())
        confirming = new BigDecimal(temp.get("CORRES-CONFIRMING").toString())
        cilex = new BigDecimal(temp.get("CILEX").toString())
        total = new BigDecimal(temp.get("TOTAL").toString())

        BigDecimal bankComnocwtAmount = bankCom
        BigDecimal commFeenocwtAmount = commFee
        BigDecimal cilexnocwtAmount = cilex

        //get remote for advising and confirming tag
        def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getAdvanceCorresChargesFlag", "")
        String advisingFlag = getServiceChargeAmountMap.get("advanceCorresChargesFlag");
        println "advisingFlag advisingFlag advisingFlag::" + advisingFlag
        if (!advisingFlag.equalsIgnoreCase("Y")) {
            advising = 0
        }

        getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getConfirmationInstructionsFlag", "")
        String confirmingFlag = getServiceChargeAmountMap.get("confirmationInstructionsFlag");
        println "confirmingFlag confirmingFlag confirmingFlag :::" + confirmingFlag
        if (!confirmingFlag.equalsIgnoreCase("Y")) {
            confirming = 0
        }


        total = bankCom + commFee + suppFee + docstamps + cableFee + advising + confirming + cilex

        jsonData = [
                BC: bankCom,
                CF: commFee,
                DOCSTAMPS: docstamps,
                DOCSTAMPSoriginal: docstampsOriginal,
                CABLE: cableFee,
                SUP: suppFee,
                CILEX: cilex,
                "CORRES-ADVISING": advising,
                "CORRES-CONFIRMING": confirming,
                TOTAL: total,
                BCnocwtAmount: bankComnocwtAmount,
                CFnocwtAmount: commFeenocwtAmount,
                CILEXnocwtAmount: cilexnocwtAmount
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_NEGOTIATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def cableFee, notarialFee, documentaryStamps, cilex
        def cilexnocwtAmount
        def cableFeeoriginal, notarialFeeoriginal, documentaryStampsoriginal, cilexoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            notarialFee = getChargeWithRest(tradeserviceId, "NOTARIAL", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            documentaryStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            notarialFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "NOTARIAL", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            documentaryStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            cilexnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            //TODO: add advising confirming
            total = cableFee + notarialFee + documentaryStamps + cilex
            //println "total:" + total
            temp = [
                    CABLE: cableFee,
                    NOTARIAL: notarialFee,
                    DOCSTAMPS: documentaryStamps,
                    CILEX: cilex,
                    TOTAL: total,
                    CABLEoriginal: cableFeeoriginal,
                    NOTARIALoriginal: notarialFeeoriginal,
                    DOCSTAMPSoriginal: documentaryStampsoriginal,
                    CILEXoriginal: cilexoriginal,
                    CILEXnocwtAmount: cilexnocwtAmount
            ]

        } else {

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            String cwtFlag = params.cwtFlag ?: "N"
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal documentaryStampsCentavos = params.documentaryStampsCentavos ? new BigDecimal(params.documentaryStampsCentavos) : 0.3

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString(),
                    documentaryStampsCentavos: documentaryStampsCentavos
            ], "charges/getFXNegotiationCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("TOTAL").toString())
        }

        //println "total:" + total

        jsonData = [
                CABLE: temp.get("CABLE"),
                NOTARIAL: temp.get("NOTARIAL"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                CILEX: temp.get("CILEX"),
                TOTAL: total,
                CABLEoriginal: temp.get("CABLEoriginal"),
                NOTARIALoriginal: temp.get("NOTARIALoriginal"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                CILEXoriginal: temp.get("CILEXoriginal"),
                CILEXnocwtAmount: temp.get("CILEXnocwtAmount")
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        }
        if (tradeserviceId == null && session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        }
        if (tradeserviceId == null && session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        //println "TRADESERVICEID:" + tradeserviceId

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        //println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        //println "recomputeCurrency_LC_DOMESTIC_OPENING:" + params

        def cableFee, notarialFee, documentaryStamps, cilex
        BigDecimal total
        Map temp = [:]

        BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
        BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
        BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

        BigDecimal documentaryStampsCentavos = params.documentaryStampsCentavos ? new BigDecimal(params.documentaryStampsCentavos) : 0.3


        String chargeSettlementCurrency = params.settlementCurrency
        //println "chargeSettlementCurrency:" + chargeSettlementCurrency
        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                chargeSettlementCurrency: chargeSettlementCurrency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                cilexNumerator: cilexNumerator.toPlainString(),
                cilexDenominator: cilexDenominator.toPlainString(),
                cilexPercentage: cilexPercentage.toPlainString(),
                documentaryStampsCentavos: documentaryStampsCentavos,
                recompute:"Y",
                forFirst: params.forFirst,
                forNext: params.forNext,
                forFirstAmount: params.forFirstAmount,
                forNextAmount: params.forNextAmount,
        ], "charges/getFXNegotiationCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("TOTAL").toString())


        jsonData = [
                CABLE: temp.get("CABLE"),
                NOTARIAL: temp.get("NOTARIAL"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                CILEX: temp.get("CILEX"),
                TOTAL: total
        ]


        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_AMENDMENT() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        //println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        println "recomputeCurrency_LC_AMENDMENT_AMENDMENT:" + params

        def bankCom, commFee, suppFee, cableFee, advisingFee, confirmingFee, documentaryStamps
        def bankComnocwtAmount, commFeenocwtAmount
        def bankComoriginal, commFeeoriginal, suppFeeoriginal, cableFeeoriginal, advisingFeeoriginal, confirmingFeeoriginal, documentaryStampsoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            documentaryStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            advisingFee = getChargeWithRest(tradeserviceId, "CORRES-ADVISING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            confirmingFee = getChargeWithRest(tradeserviceId, "CORRES-CONFIRMING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            documentaryStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            advisingFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CORRES-ADVISING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            confirmingFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CORRES-CONFIRMING", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFeenocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = bankCom + commFee + cableFee + documentaryStamps + advisingFee + confirmingFee
            //println "total:" + total
            temp = [
                    BC: bankCom,
                    CF: commFee,
                    CABLE: cableFee,
                    DOCSTAMPS: documentaryStamps,
                    'CORRES-ADVISING': advisingFee,
                    'CORRES-CONFIRMING': confirmingFee,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CForiginal: commFeeoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    DOCSTAMPSoriginal: documentaryStampsoriginal,
                    'CORRES-ADVISINGoriginal': advisingFeeoriginal,
                    'CORRES-CONFIRMINGoriginal': confirmingFeeoriginal,
                    BCnocwtAmount: bankComnocwtAmount,
                    CFnocwtAmount: commFeenocwtAmount
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01


            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: "0.00",
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
                    chargeSettlementCurrency: params.chargeSettlementCurrency
            ], "charges/getFXAmendmentCharge", "")
            temp = chargesResultFlagMap.get("result")
//            total =
            def bctemp = temp.get("BC")?.toString() ? new BigDecimal(temp.get("BC")?.toString()) : BigDecimal.ZERO
            def cftemp = temp.get("CF")?.toString() ? new BigDecimal(temp.get("CF")?.toString()) : BigDecimal.ZERO
            def cabletemp = temp.get("CABLE")?.toString() ? new BigDecimal(temp.get("CABLE")?.toString()) : BigDecimal.ZERO
            def docstampstemp = temp.get("DOCSTAMPS")?.toString() ? new BigDecimal(temp.get("DOCSTAMPS")?.toString()) : BigDecimal.ZERO
            def advisingtemp = temp.get("CORRES-ADVISING")?.toString() ? new BigDecimal(temp.get("CORRES-ADVISING")?.toString()) : BigDecimal.ZERO
            def confirmingtemp = temp.get("CORRES-CONFIRMING")?.toString() ? new BigDecimal(temp.get("CORRES-CONFIRMING")?.toString()) : BigDecimal.ZERO
            total = bctemp + cftemp + cabletemp + docstampstemp + advisingtemp + confirmingtemp
        }

        //println "total:" + total
        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                CABLE: temp.get("CABLE"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                "CORRES-ADVISING": temp.get("CORRES-ADVISING"),
                "CORRES-CONFIRMING": temp.get("CORRES-CONFIRMING"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CForiginal: temp.get("CForiginal"),
                CABLEoriginal: temp.get("CABLEoriginal"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                "CORRES-ADVISINGoriginal": temp.get("CORRES-ADVISINGoriginal"),
                "CORRES-CONFIRMINGoriginal": temp.get("CORRES-CONFIRMINGoriginal"),
                BCnocwtAmount:temp.get("BCnocwtAmount"),
                CFnocwtAmount:temp.get("CFnocwtAmount"),
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }



        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        println "recomputeCurrency_LC_AMENDMENT_AMENDMENT:" + params

        def bankCom, commFee, suppFee, cableFee, advisingFee, confirmingFee, documentaryStamps
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

        if (bankCommissionPercentage >= 1) {
            bankCommissionPercentage = bankCommissionPercentage / 100
        }

        BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
        BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
        BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01

        if (commitmentFeePercentage >= 1) {
            commitmentFeePercentage = commitmentFeePercentage / 100
        }


        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                //productAmount: productAmount,
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
                chargeSettlementCurrency: params.settlementCurrency,
                centavos: params.centavos
        ], "charges/getFXAmendmentCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("BC").toString()) +
                new BigDecimal(temp.get("CF").toString()) +
                new BigDecimal(temp.get("CABLE").toString()) +
                new BigDecimal(temp.get("DOCSTAMPS").toString()) +
                new BigDecimal(temp.get("CORRES-ADVISING").toString()) +
                new BigDecimal(temp.get("CORRES-CONFIRMING").toString())

        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                CABLE: temp.get("CABLE"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal"),
                "CORRES-ADVISING": temp.get("CORRES-ADVISING"),
                "CORRES-CONFIRMING": temp.get("CORRES-CONFIRMING"),
                TOTAL: total
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_ADJUSTMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def cilex
        def cilexnocwtAmount
        def cilexoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            jsonData = [
                    CILEX: cilex,
                    TOTAL: cilex,
                    CILEXoriginal: cilexoriginal,
                    CILEXnocwtAmount: cilexnocwtAmount
            ]


        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    cilexPercentage: cilexPercentage,
                    cilexDenominator: cilexDenominator,
                    cilexNumerator: cilexNumerator
            ], "charges/getFXAdjustmentCharge", "")
            temp = chargesResultFlagMap.get("result")

            cilex = new BigDecimal(temp.get("CILEX"))
            cilexoriginal = new BigDecimal(temp.get("CILEXoriginal"))

            //println "total:" + total
            jsonData = [
                    CILEX: cilex,
                    TOTAL: cilex,
                    CILEXoriginal: cilexoriginal,
                    CILEXnocwtAmount: temp.get("CILEXnocwtAmount")
            ]
        }

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_ADJUSTMENT_EDIT_COMPUTATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        //println "orig:" + tmpAmount
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")


        def bankCom, commFee, suppFee, docstamps, cableFee, advising, confirming, cilex
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
        BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator ) : 4
        BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

        String chargeSettlementCurrency = params.settlementCurrency

        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                chargeSettlementCurrency: chargeSettlementCurrency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: productAmount.toPlainString(),
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                cilexPercentage: cilexPercentage,
                cilexDenominator: cilexDenominator,
                cilexNumerator: cilexNumerator
        ], "charges/getFXAdjustmentCharge", "")
        temp = chargesResultFlagMap.get("result")

        cilex = new BigDecimal(temp.get("CILEX"))

        jsonData = [
                CILEX: cilex,
                TOTAL: cilex
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_UA_LOAN_MATURITY_ADJUSTMENT() {

        def jsonData = [:]

        String tradeserviceId = null
        if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        }
        if (tradeserviceId == null && session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        }
        if (tradeserviceId == null && session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def commFee, cableFee
        def commFeenocwtAmount
        def commFeeoriginal, cableFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            commFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            commFeenocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = commFee + cableFee

            temp = [
                    CF: commFee,
                    CABLE: cableFee,
                    TOTAL: total,
                    CForiginal: commFeeoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    CFnocwtAmount: commFeenocwtAmount
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    settlementCurrency: settlementcurrency,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
            ], "charges/getFXUALoanMaturityAdjustmentCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("CF").toString()) + new BigDecimal(temp.get("CABLE").toString())
        }

        jsonData = [
                CF: temp.get("CF"),
                CABLE: temp.get("CABLE"),
                TOTAL: total,
                CForiginal: temp.get("CForiginal"),
                CABLEoriginal: temp.get("CABLEoriginal"),
                CFnocwtAmount: temp.get("CFnocwtAmount")
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_UA_LOAN_MATURITY_ADJUSTMENT_EDIT_COMPUTATION() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        //println "orig:" + tmpAmount
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, commFee, cableFee
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            commFee = getChargeWithRest(tradeserviceId, "CF", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = bankCom + commFee + cableFee

            temp = [
                    BC: bankCom,
                    CF: commFee,
                    CABLE: cableFee
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01


            BigDecimal commitmentFeeNumerator = params.commitmentFeeNumerator ? new BigDecimal(params.commitmentFeeNumerator) : 1
            BigDecimal commitmentFeeDenominator = params.commitmentFeeDenominator ? new BigDecimal(params.commitmentFeeDenominator) : 4
            BigDecimal commitmentFeePercentage = params.commitmentFeePercentage ? new BigDecimal(params.commitmentFeePercentage) : 0.01
            BigDecimal commitmentFeeMonths = params.comFeeNumberOfMonths ? new BigDecimal(params.comFeeNumberOfMonths) : 0.01

            if (commitmentFeeMonths >= 1) {
                commitmentFeeMonths = commitmentFeeMonths / 100
            }


            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    commitmentFeeNumerator: commitmentFeeNumerator.toPlainString(),
                    commitmentFeeDenominator: commitmentFeeDenominator.toPlainString(),
                    commitmentFeePercentage: commitmentFeePercentage.toPlainString(),
            ], "charges/getUALoanMaturityAdjustmentCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CF").toString())).add(new BigDecimal(temp.get("CABLE").toString()))
        }

        //println "total: " + total
        jsonData = [
                BC: temp.get("BC"),
                CF: temp.get("CF"),
                CABLE: temp.get("CABLE"),
                TOTAL: total
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docstamps, cilex
        def cilexnocwtAmount
        def docstampsoriginal, cilexoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            cilexnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = docstamps + cilex

            jsonData = [
                    DOCSTAMPS: docstamps,
                    CILEX: cilex,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    CILEXoriginal: cilexoriginal,
                    CILEXnocwtAmount: cilexnocwtAmount
            ]
            //println "jsonData:" + jsonData

        } else {


            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString(),
            ], "charges/getFXUALoanSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("TOTAL").toString())

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            cilex = new BigDecimal(temp.get("CILEX"))

            docstampsoriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal"))
            cilexoriginal = new BigDecimal(temp.get("CILEXoriginal"))

            cilexnocwtAmount = new BigDecimal(temp.get("CILEXnocwtAmount"))

            total = docstamps + cilex

            //println "total:" + total
            jsonData = [
                    DOCSTAMPS: docstamps,
                    CILEX: cilex,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    CILEXoriginal: cilexoriginal,
                    CILEXnocwtAmount: cilexnocwtAmount
            ]
        }

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        //println "orig:" + tmpAmount
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        //println "recomputeCurrency_LC_DOMESTIC_OPENING:" + params

        def docstamps, cilex, docstampsOriginal
        BigDecimal total
        Map temp = [:]

        String documentClass = params.documentClass
        String documentType = params.documentType
        String documentSubType1 = params.documentSubType1
        String documentSubType2 = params.documentSubType2

        String cwtFlag = params.cwtFlag
        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

        BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
        BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
        BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

        String chargeSettlementCurrency = params.settlementCurrency
        //println "chargeSettlementCurrency:" + chargeSettlementCurrency
        def chargesResultFlagMap = coreAPIService.dummySendQuery([
                tradeServiceId: params.tradeServiceId,
                productCurrency: params.currency,
                chargeSettlementCurrency: chargeSettlementCurrency,
                urr: urr,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                productAmount: productAmount.toPlainString(),
                documentClass: documentClass,
                documentType: documentType,
                documentSubType1: documentSubType1,
                documentSubType2: documentSubType2,
                cwtFlag: cwtFlag,
                cwtPercentage: cwtPercentage.toPlainString(),
                cilexNumerator: cilexNumerator.toPlainString(),
                cilexDenominator: cilexDenominator.toPlainString(),
                cilexPercentage: cilexPercentage.toPlainString(),
                forFirst: params.forFirst,
                forNext: params.forNext,
                forFirstAmount: params.forFirstAmount,
                forNextAmount: params.forNextAmount
        ], "charges/getFXUALoanSettlementCharge", "")
        temp = chargesResultFlagMap.get("result")
        total = new BigDecimal(temp.get("TOTAL").toString())

        docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
        cilex = new BigDecimal(temp.get("CILEX"))
        docstampsOriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal"))



        total = docstamps + cilex

        //println "total:" + total
        jsonData = [

                DOCSTAMPS: docstamps,
                DOCSTAMPSoriginal: docstampsOriginal,
                CILEX: cilex,
                TOTAL: total
        ]

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_INDEMNITY_CANCELLATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        //String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag


        def cancellationFee
        def cancellationFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId, "chargeId": "CANCEL"], "tradeservice/getServiceCharge", "")
            BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
            //String currency = getServiceChargeAmountMap.get("currency")

            cancellationFee = serviceChargeAmount

            cancellationFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CANCEL", settlementcurrency, 0.0, 0.0)



            jsonData = [
                    CANCEL: cancellationFee,
                    TOTAL: cancellationFee,
                    CANCELoriginal: cancellationFeeoriginal
            ]

        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98


            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
            ], "charges/getFXIndemnityCancellationCharge", "")
            temp = chargesResultFlagMap.get("result")

            cancellationFee = new BigDecimal(temp.get("CANCEL"))
            cancellationFeeoriginal = new BigDecimal(temp.get("CANCELoriginal"))

            //println "total:" + total
            jsonData = [

                    CANCEL: cancellationFee,
                    TOTAL: cancellationFee,
                    CANCELoriginal: cancellationFeeoriginal
            ]
        }

        render jsonData as JSON
    }

    def recomputeCurrency_LC_FOREIGN_INDEMNITY_ISSUANCE() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }
//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        //println "orig:" + tmpAmount
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def docstamps, bankComm
        def bankCommnocwtAmount
        def docstampsoriginal, bankCommoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankCommoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankCommnocwtAmount = getNoCwtChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = docstamps + bankComm

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    BCoriginal: bankCommoriginal,
                    BCnocwtAmount: bankCommnocwtAmount
            ]
            //println "jsonData:" + jsonData

        } else {


            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            String chargeSettlementCurrency = "PHP"
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString()
            ], "charges/getFXIndemnityIssuanceCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("TOTAL").toString())

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            bankComm = new BigDecimal(temp.get("BC"))

            docstampsoriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal"))
            bankCommoriginal = new BigDecimal(temp.get("BCoriginal"))

            bankCommnocwtAmount = new BigDecimal(temp.get("BCnocwtAmount"))

            total = docstamps + bankComm

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    BCoriginal: bankCommoriginal,
                    BCnocwtAmount:bankCommnocwtAmount
            ]
        }

        render jsonData as JSON
    }

    def getDefaultValues() {
        def jsonData = [:]

        def defaultValuesMap = coreAPIService.dummySendQuery([:], "getDefaultValues", "charges/")

        jsonData = defaultValuesMap.get("result")

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_IMPORT_ADVANCE_PAYMENT() {
        println "recomputeCurrency_IMPORT_ADVANCE_PAYMENT"
        println "params:"+params
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        //String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, cableFee, cilex, docStamps
        def bankComoriginal, cableFeeoriginal, cilexoriginal, docStampsoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = bankCom + cableFee + cilex + docStamps
            //println "total:" + total
            temp = [
                    BC: bankCom,
                    CABLE: cableFee,
                    CILEX: cilex,
                    DOCSTAMPS: docStamps,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CABLEoriginal: cableFeeoriginal,
                    CILEXoriginal: cilexoriginal,
                    DOCSTAMPSoriginal: docStampsoriginal
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    settlementCurrency: params.settlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString()
            ], "charges/getImportAdvancePaymentCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CABLE").toString())).add(new BigDecimal(temp.get("CILEX").toString())).add(new BigDecimal(temp.get("DOCSTAMPS").toString()))
        }

        jsonData = [
                BC: temp.get("BC"),
                CABLE: temp.get("CABLE"),
                CILEX: temp.get("CILEX"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CABLEoriginal: temp.get("CABLEoriginal"),
                CILEXoriginal: temp.get("CILEXoriginal"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal")
        ]

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_IMPORT_ADVANCE_REFUND() {

        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

//        BigDecimal amount = new BigDecimal(params.amount.toString().replace(',', ''))
//        String tmpAmount = params.productAmount.toString().replace(',', '')
//        //println "orig:" + tmpAmount
//        Integer t = tmpAmount.lastIndexOf(".")
//        t = t + 3;
//        if (tmpAmount.length() < t) {
//            t = tmpAmount.length()
//        }
        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        //String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, docStamps
        def bankComoriginal, docStampsoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docStampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = bankCom + docStamps
            //println "total:" + total
            temp = [
                    BC: bankCom,
                    DOCSTAMPS: docStamps,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    DOCSTAMPSoriginal: docStampsoriginal
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString()
            ], "charges/getImportAdvanceRefundCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("DOCSTAMPS").toString()))
        }

        jsonData = [
                BC: temp.get("BC"),
                DOCSTAMPS: temp.get("DOCSTAMPS"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                DOCSTAMPSoriginal: temp.get("DOCSTAMPSoriginal")
        ]

        render jsonData as JSON
    }
	
	//TODO:: Check if BCnocwtAmount is correct
	def recomputeCurrency_EXPORT_ADVANCE_REFUND() {
		println "recomputeCurrency_EXPORT_ADVANCE_REFUND"
        println "params:"+params
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal productAmount = BigDecimal.ZERO

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        //String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def bankCom, cableFee
        def bankComoriginal, cableFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankCom = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
       
            cableFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
       

            total = bankCom + cableFee
            //println "total:" + total
            temp = [
                    BC: bankCom,
                    CABLE: cableFee,
                    TOTAL: total,
                    BCoriginal: bankComoriginal,
                    CABLEoriginal: cableFeeoriginal,
            ]

        } else {

            String documentClass = params.documentClass
            String documentType = params.documentType
            String documentSubType1 = params.documentSubType1
            String documentSubType2 = params.documentSubType2

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    settlementCurrency: params.settlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: productAmount.toPlainString(),
                    documentClass: documentClass,
                    documentType: documentType,
                    documentSubType1: documentSubType1,
                    documentSubType2: documentSubType2,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString()
            ], "charges/getExportAdvanceRefundCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("BC").toString()).add(new BigDecimal(temp.get("CABLE").toString()))
        }

        jsonData = [
                BC: temp.get("BC"),
                CABLE: temp.get("CABLE"),
                TOTAL: total,
                BCoriginal: temp.get("BCoriginal"),
                CABLEoriginal: temp.get("CABLEoriginal"),
        ]

        render jsonData as JSON
	}

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_EXPORTS_ADVISING_Url() {

        println "##################################### recomputeCurrency_EXPORTS_ADVISING_Url()"

        def jsonData = [:]

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")

        def exportsAdvisingFee, otherAdvisingFee, cableFee
        def exportsAdvisingFeeoriginal, otherAdvisingFeeoriginal, cableFeeoriginal
        def exportsAdvisingFeenocwtAmount, otherAdvisingFeenocwtAmount
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId, "chargeId": "ADVISING-EXPORT"], "tradeservice/getServiceCharge", "")
            BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
            //println "in overriden serviceChargeAmount:" + serviceChargeAmount

            exportsAdvisingFee = serviceChargeAmount

            exportsAdvisingFeeoriginal = getDefaultChargeWithRest(params.tradeServiceId, "ADVISING-EXPORT", "PHP", BigDecimal.ONE, BigDecimal.ONE)

            println "================== params = ${params}"

            if (params.documentClass.equals('EXPORT_ADVISING') && params.documentSubType1.equals('FIRST_ADVISING')) {
                getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId, "chargeId": "CABLE"], "tradeservice/getServiceCharge", "")
                serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
                //println "in overriden serviceChargeAmount:" + serviceChargeAmount

                cableFee = serviceChargeAmount
                exportsAdvisingFeeoriginal = getDefaultChargeWithRest(params.tradeServiceId, "ADVISING-EXPORT", "PHP", BigDecimal.ONE, BigDecimal.ONE)


                total = exportsAdvisingFee + cableFee
                temp = [
                        "ADVISING-EXPORT": exportsAdvisingFee,
                        CABLE: cableFee,
                        "ADVISING-EXPORToriginal": exportsAdvisingFeeoriginal,
                        CABLEoriginal: cableFeeoriginal,
                        "ADVISING-EXPORTnocwtAmount":exportsAdvisingFeenocwtAmount
                ]
                println "hahaha " + exportsAdvisingFee
            } else if (params.documentClass.equals('EXPORT_ADVISING') && params.documentSubType1.equals('SECOND_ADVISING')) {
                getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId, "chargeId": "OTHER-EXPORT"], "tradeservice/getServiceCharge", "")
                serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))

                otherAdvisingFee = serviceChargeAmount

                otherAdvisingFeeoriginal = getDefaultChargeWithRest(params.tradeServiceId, "OTHER-ADVISING", "PHP", BigDecimal.ONE, BigDecimal.ONE)

                total = exportsAdvisingFee + otherAdvisingFee

                temp = [
                        "ADVISING-EXPORT": exportsAdvisingFee,
                        "OTHER-EXPORT": otherAdvisingFee,
                        "ADVISING-EXPORToriginal": exportsAdvisingFeeoriginal,
                        "OTHER-EXPORToriginal": otherAdvisingFeeoriginal,
                        "ADVISING-EXPORTnocwtAmount":exportsAdvisingFeenocwtAmount
                ]
            }

        } else {

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency
            ], "charges/getExportsAdvisingCharge", "")
			println "chargesResultFlagMap" + chargesResultFlagMap
            def temp1 = chargesResultFlagMap.get("result")
            println "temp1:"+temp1
            exportsAdvisingFee = temp1.get("ADVISING-EXPORT")
            exportsAdvisingFeenocwtAmount = temp1.get("ADVISING-EXPORTnocwtAmount")
            exportsAdvisingFeeoriginal = temp1.get("ADVISING-EXPORToriginal")

            println " otherAdvisingFee otherAdvisingFee otherAdvisingFee:"+otherAdvisingFee
            println " exportsAdvisingFee exportsAdvisingFee exportsAdvisingFee:"+exportsAdvisingFee

            if (params.documentClass.equals('EXPORT_ADVISING') && params.documentSubType1.equals('FIRST_ADVISING')) {
                cableFee = temp1.get("CABLE")
                cableFeeoriginal = temp1.get("CABLEoriginal")
                temp = [
                        "ADVISING-EXPORT": exportsAdvisingFee,
                        "ADVISING-EXPORToriginal": exportsAdvisingFeeoriginal,
                        "ADVISING-EXPORTnocwtAmount":exportsAdvisingFeenocwtAmount,
                        CABLE: cableFee,
                        CABLEoriginal: cableFeeoriginal
                ]

            } else if (params.documentClass.equals('EXPORT_ADVISING') && params.documentSubType1.equals('SECOND_ADVISING')) {
                otherAdvisingFee = temp1.get("OTHER-EXPORT")
                otherAdvisingFeeoriginal = temp1.get("OTHER-EXPORToriginal")

                temp = [
                        "ADVISING-EXPORT": exportsAdvisingFee,
                        "ADVISING-EXPORToriginal": exportsAdvisingFeeoriginal,
                        "ADVISING-EXPORTnocwtAmount":exportsAdvisingFeenocwtAmount,
                        "OTHER-EXPORT": otherAdvisingFee,
                        "OTHER-EXPORToriginal": otherAdvisingFeeoriginal,
                ]
            }

            println "hahahah " + temp
            if (temp.get("CABLE") != null) {
                total = new BigDecimal(temp.get("ADVISING-EXPORT").toString()).add(new BigDecimal(temp.get("CABLE").toString()))
            } else if (temp.get("OTHER-EXPORT") != null) {
                total = new BigDecimal(temp.get("ADVISING-EXPORT").toString()).add(new BigDecimal(temp.get("OTHER-EXPORT").toString()))
            }
        }

        //println "total:" + total
        if (temp.get("CABLE") != null) {
            jsonData = [
                    "ADVISING-EXPORT": temp.get("ADVISING-EXPORT"),
                    "ADVISING-EXPORToriginal": temp.get("ADVISING-EXPORToriginal"),
                    "ADVISING-EXPORTnocwtAmount": temp.get("ADVISING-EXPORTnocwtAmount"),
                    CABLE: temp.get("CABLE"),
                    CABLEoriginal: temp.get("CABLEoriginal"),
                    TOTAL: total
            ]
        } else if (temp.get("OTHER-EXPORT") != null) {
            jsonData = [
                    "ADVISING-EXPORT": temp.get("ADVISING-EXPORT"),
                    "ADVISING-EXPORToriginal": temp.get("ADVISING-EXPORToriginal"),
                    "ADVISING-EXPORTnocwtAmount": temp.get("ADVISING-EXPORTnocwtAmount"),
                    "OTHER-EXPORT": temp.get("OTHER-EXPORT"),
                    "OTHER-EXPORToriginal": temp.get("OTHER-EXPORToriginal"),
                    TOTAL: total
            ]
        } else {
            jsonData = [
                    "ADVISING-EXPORT": temp.get("ADVISING-EXPORT"),
                    "ADVISING-EXPORToriginal": temp.get("ADVISING-EXPORToriginal"),
                    "ADVISING-EXPORTnocwtAmount": temp.get("ADVISING-EXPORTnocwtAmount"),
                    TOTAL: temp.get("ADVISING-EXPORT")
            ]
        }
        println "hehehe " + jsonData

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BC_DOMESTIC_SETTLEMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        //String lccurrency = params.currency
        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        def docstamps, bankComm, cilex, postage, remittanceFee
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            postage = getChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)


            total = docstamps + bankComm + cilex + postage + remittanceFee

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    CILEX: cilex,
                    POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total
            ]

        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 4
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString()
            ], "charges/getDomesticBillsCollectionSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            bankComm = new BigDecimal(temp.get("BC"))
            cilex = new BigDecimal(temp.get("CILEX"))
            postage = new BigDecimal(temp.get("POSTAGE"))
            remittanceFee = new BigDecimal(temp.get("REMITTANCE"))

            total = docstamps + bankComm + cilex + postage + remittanceFee

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    CILEX: cilex,
                    POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total
            ]
        }

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BP_DOMESTIC_NEGOTIATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        def docstamps, bankComm, cilex, postage, remittanceFee
        def docstampsoriginal, bankCommoriginal, cilexoriginal, postageoriginal, remittanceFeeoriginal
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {
            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            postage = getChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            bankCommoriginal = getDefaultChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            docstampsoriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilexoriginal = getDefaultChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            postageoriginal = getDefaultChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFeeoriginal = getDefaultChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            total = docstamps + bankComm + cilex + postage + remittanceFee

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    CILEX: cilex,
                    POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    BCoriginal: bankCommoriginal,
                    CILEXoriginal: cilexoriginal,
                    POSTAGEoriginal: postageoriginal,
                    REMITTANCEoriginal: remittanceFeeoriginal
            ]

        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 4
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency
            println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
					productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString()
            ], "charges/getDomesticBillsPaymentNegotiationCharge", "")
            temp = chargesResultFlagMap.get("result")
            total = new BigDecimal(temp.get("TOTAL").toString())

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            bankComm = new BigDecimal(temp.get("BC"))
            cilex = new BigDecimal(temp.get("CILEX"))
            postage = new BigDecimal(temp.get("POSTAGE"))
            remittanceFee = new BigDecimal(temp.get("REMITTANCE"))

            docstampsoriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal"))
            bankCommoriginal = new BigDecimal(temp.get("BCoriginal"))
            cilexoriginal = new BigDecimal(temp.get("CILEXoriginal"))
            postageoriginal = new BigDecimal(temp.get("POSTAGEoriginal"))
            remittanceFeeoriginal = new BigDecimal(temp.get("REMITTANCEoriginal"))

            total = docstamps + bankComm + cilex + postage + remittanceFee

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    CILEX: cilex,
                    POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
                    DOCSTAMPSoriginal: docstampsoriginal,
                    BCoriginal: bankCommoriginal,
                    CILEXoriginal: cilexoriginal,
                    POSTAGEoriginal: postageoriginal,
                    REMITTANCEoriginal: remittanceFeeoriginal
            ]
        }

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BP_DOMESTIC_SETTLEMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        def otherExport
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            otherExport = getChargeWithRest(tradeserviceId, "OTHER-EXPORT", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            jsonData = [
                    'OTHER-EXPORT': otherExport,
                    TOTAL: otherExport
            ]
        } else {


            String chargeSettlementCurrency = params.settlementCurrency

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
            ], "charges/getDomesticBillsPaymentSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")

            otherExport = new BigDecimal(temp.get("OTHER-EXPORT"))

            jsonData = [
                    'OTHER-EXPORT': otherExport,
                    TOTAL: otherExport
            ]
        }

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BC_FOREIGN_SETTLEMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)
        String settlementcurrency = params.settlementCurrency
 
        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag
        def docstamps, bankComm, cilex, postage, remittanceFee, docstampsOriginal, postageOriginal
        BigDecimal total
        Map temp = [:]
		
		def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": "BC"], "tradeservice/getServiceCharge", "")
		String serviceChargeCurrency = getServiceChargeAmountMap.get("currency")
		
		if (!settlementcurrency.equalsIgnoreCase(serviceChargeCurrency) || params.chargesOverridenFlag == "N") {
			chargesOverridenFlag = "N"
		}

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {
            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            postage = getChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			docstampsOriginal = getDefaultChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			postageOriginal = getDefaultChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
 		   total = docstamps + bankComm + cilex + postage + remittanceFee
			 jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
                    CILEX: cilex,
					POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
					DOCSTAMPSoriginal: docstampsOriginal,
					POSTAGEoriginal: postageOriginal
            ]

        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 4
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage).divide(100) : 0.01

            BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
            BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
            BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage).divide(100) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    productCurrency: params.currency,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    productAmount: "0.00",
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
                    cilexNumerator: cilexNumerator.toPlainString(),
                    cilexDenominator: cilexDenominator.toPlainString(),
                    cilexPercentage: cilexPercentage.toPlainString(),
                    centavos: params.centavos
            ], "charges/getExportBillsCollectionSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            bankComm = new BigDecimal(temp.get("BC"))
            cilex = new BigDecimal(temp.get("CILEX"))
            postage = new BigDecimal(temp.get("POSTAGE"))
            remittanceFee = new BigDecimal(temp.get("REMITTANCE"))
			docstampsOriginal = new BigDecimal(temp.get("DOCSTAMPSoriginal"))
			postageOriginal = new BigDecimal(temp.get("POSTAGEoriginal"))

            total = docstamps + bankComm + cilex + postage + remittanceFee
			
            jsonData = [
                    DOCSTAMPS: docstamps,
                    DOCSTAMPSoriginal: docstampsOriginal,
                    BC: bankComm,
                    CILEX: cilex,
                    POSTAGE: postage,
                    REMITTANCE: remittanceFee,
                    TOTAL: total,
					bankComGross: new BigDecimal(temp.get("bankComGross")),
					bankComCwt: new BigDecimal(temp.get("bankComCwt")),
					cilexGross: new BigDecimal(temp.get("cilexGross")),
					cilexCwt: new BigDecimal(temp.get("cilexCwt"))
            ]
        }
		
        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BC_FOREIGN_CANCELLATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: params.tradeServiceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag


        def cableFee, courierFee
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            cableFee = getChargeWithRest(tradeserviceId, "CABLE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            courierFee = getChargeWithRest(tradeserviceId, "COURIER", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)

            total = cableFee + courierFee

            jsonData = [
                    CABLE: cableFee,
                    COURIER: courierFee,
                    TOTAL: total
            ]

        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            String chargeSettlementCurrency = params.settlementCurrency
            //println "chargeSettlementCurrency:" + chargeSettlementCurrency
            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString()
            ], "charges/getExportBillsCollectionCancellationCharge", "")
            temp = chargesResultFlagMap.get("result")

            cableFee = new BigDecimal(temp.get("CABLE"))
            courierFee = new BigDecimal(temp.get("COURIER"))

            total = cableFee + courierFee

            jsonData = [

                    CABLE: cableFee,
                    COURIER: courierFee,
                    TOTAL: total
            ]
        }

        render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BP_FOREIGN_NEGOTIATION() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }

        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag
        def docstamps, bankComm, cilex, postage, remittanceFee, corresExport,postageOriginal
        BigDecimal total
        Map temp = [:]
		
		
		def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": "BC"], "tradeservice/getServiceCharge", "")
		String serviceChargeCurrency = getServiceChargeAmountMap.get("currency")
		
		if (!settlementcurrency.equalsIgnoreCase(serviceChargeCurrency) || params.chargesOverridenFlag == "N") {
			chargesOverridenFlag = "N"
		}		
		
//		println "paramsXX : " + params
//		println "paramsXXXX : " + params.bankComParams
//		println "paramsXXXXXX : " + params.("bankComParams[grossBankCommission]")
//		if(params.bankComParams.grossBankCommission!=null && !params.bankComParams.grossBankCommission.equals("")){
//			println "params.bankComParams : " + params.bankComParams
//			println "params.bankComParams.bankComPercentageNumerator : " + params.bankComParams?.bankComPercentageNumerator
//			println "params.bankComParams.bankComPercentageDenominator : " + params.bankComParams?.bankComPercentageDenominator
//			println "params.bankComParams.bankComPercentage : " + params.bankComParams?.bankComPercentage
//			
////			println "bankComPercentageNumerator : " + params.bankCommissionPopupParamsHidden.bankComPercentageNumerator
////			println "bankComPercentageDenominator : " + params.bankCommissionPopupParamsHidden.bankComPercentageDenominator
////			println "bankComPercentage : " + params.bankCommissionPopupParamsHidden.bankComPercentage			
//		}
//		if(params.cilexFeePopupParamsHidden!=null){
//			println "cilexFeePopupParamsHidden : " + params.cilexFeePopupParamsHidden
////			println "cilexPercentageNumerator : " + params.cilexFeePopupParamsHidden.cilexPercentageNumerator
////			println "cilexPercentageDenominator : " + params.cilexFeePopupParamsHidden.cilexPercentageDenominator
////			println "cilexPercentage : " + params.cilexFeePopupParamsHidden.cilexPercentage
//		}
		
		if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {
			
			docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			cilex = getChargeWithRest(tradeserviceId, "CILEX", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			postage = getChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			remittanceFee = getChargeWithRest(tradeserviceId, "REMITTANCE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			corresExport = getChargeWithRest(tradeserviceId, "CORRES-EXPORT", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			postageOriginal = getDefaultChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			total = docstamps + bankComm + cilex + postage + remittanceFee + corresExport

			jsonData = [
				DOCSTAMPS: docstamps,
				BC: bankComm,
				CILEX: cilex,
				POSTAGE: postage,
				REMITTANCE: remittanceFee,
				'CORRES-EXPORT': corresExport,
				POSTAGEoriginal: postageOriginal,
				TOTAL: total
			]

		} else {

	        String cwtFlag = params.cwtFlag
	        BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98
	        BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
	        BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 4 //comment by robs
	        BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage).divide(100) : 0.01
	
	        BigDecimal cilexNumerator = params.cilexNumerator ? new BigDecimal(params.cilexNumerator) : 1
	        BigDecimal cilexDenominator = params.cilexDenominator ? new BigDecimal(params.cilexDenominator) : 4
	        BigDecimal cilexPercentage = params.cilexPercentage ? new BigDecimal(params.cilexPercentage).divide(100) : 0.01
	
	        String chargeSettlementCurrency = params.settlementCurrency
	        
	        def chargesResultFlagMap = coreAPIService.dummySendQuery([
	            tradeServiceId: params.tradeServiceId,
	            productCurrency: params.currency,
	            chargeSettlementCurrency: chargeSettlementCurrency,
	            urr: urr,
	            usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
	            thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
	            cwtFlag: cwtFlag,
	            cwtPercentage: cwtPercentage.toPlainString(),
	            bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
	            bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
	            bankCommissionPercentage: bankCommissionPercentage.toPlainString(),
	            cilexNumerator: cilexNumerator.toPlainString(),
	            cilexDenominator: cilexDenominator.toPlainString(),
	            cilexPercentage: cilexPercentage.toPlainString()
	        ], "charges/getExportBillsPaymentNegotiationCharge", "")
	        temp = chargesResultFlagMap.get("result")
	
	        docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
	        bankComm = new BigDecimal(temp.get("BC"))
	        cilex = new BigDecimal(temp.get("CILEX"))
	        postage = new BigDecimal(temp.get("POSTAGE"))
	        remittanceFee = new BigDecimal(temp.get("REMITTANCE"))
	        corresExport = new BigDecimal(temp.get("CORRES-EXPORT"))
	        postageOriginal = new BigDecimal(temp.get("POSTAGEoriginal"))
	
	
	
	        total = docstamps + bankComm + cilex + postage + remittanceFee + corresExport
	
	        jsonData = [
	            DOCSTAMPS: docstamps,
	            BC: bankComm,
	            CILEX: cilex,
	            POSTAGE: postage,
	            REMITTANCE: remittanceFee,
	            'CORRES-EXPORT': corresExport,
	            TOTAL: total,
	            bankComGross: new BigDecimal(temp.get("bankComGross")),
	            bankComCwt: new BigDecimal(temp.get("bankComCwt")),
	            cilexGross: new BigDecimal(temp.get("cilexGross")),
	            cilexCwt: new BigDecimal(temp.get("cilexCwt"))
	        ]
		}
		
		render jsonData as JSON
    }

    //TODO:: Check if BCnocwtAmount is correct
    def recomputeCurrency_BP_FOREIGN_SETTLEMENT() {
        def jsonData = [:]

        String tradeserviceId = null
        if (params.tradeServiceId) {
            tradeserviceId = params.tradeServiceId
        } else if (session.etsModel) {
            tradeserviceId = session.etsModel.tradeServiceId
        } else if (session.dataEntryModel) {
            tradeserviceId = session.dataEntryModel.tradeServiceId
        } else if (session.chargesModel) {
            tradeserviceId = session.chargesModel.tradeServiceId
        }


        BigDecimal thirdToUsdSpecialConversionRateCurrency = new BigDecimal(params.thirdToUsdSpecialConversionRateCurrency?.toString() ?: 0)
        BigDecimal usdToPhpSpecialConversionRate = new BigDecimal(params.usdToPhpSpecialConversionRate?.toString() ?: 0)
        BigDecimal urr = new BigDecimal(params.urr?.toString() ?: 0)
        BigDecimal usdToPhpUrr = new BigDecimal(params.usdToPhpUrr?.toString() ?: 0)

        String settlementcurrency = params.settlementCurrency

        def chargesOverridenFlagMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId], "tradeservice/getChargesOverridenFlag", "")
        String chargesOverridenFlag = chargesOverridenFlagMap.get("chargesOverridenFlag")
        println "chargesOverridenFlag::::::::::::::::::::::::::::::::::" + chargesOverridenFlag

        def docstamps, bankComm
        BigDecimal total
        Map temp = [:]

        if ("Y".equalsIgnoreCase(chargesOverridenFlag)) {

            docstamps = getChargeWithRest(tradeserviceId, "DOCSTAMPS", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            bankComm = getChargeWithRest(tradeserviceId, "BC", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
			postage = getChargeWithRest(tradeserviceId, "POSTAGE", settlementcurrency, usdToPhpUrr, thirdToUsdSpecialConversionRateCurrency)
            total = docstamps + bankComm

            jsonData = [
                    DOCSTAMPS: docstamps,
                    BC: bankComm,
					POSTAGE :postage,
                    TOTAL: total
            ]
		
        } else {

            String cwtFlag = params.cwtFlag
            BigDecimal cwtPercentage = params.cwtPercentage ? new BigDecimal(params.cwtPercentage) : 0.98

            BigDecimal bankCommissionNumerator = params.bankCommissionNumerator ? new BigDecimal(params.bankCommissionNumerator) : 1
            BigDecimal bankCommissionDenominator = params.bankCommissionDenominator ? new BigDecimal(params.bankCommissionDenominator) : 8
            BigDecimal bankCommissionPercentage = params.bankCommissionPercentage ? new BigDecimal(params.bankCommissionPercentage) : 0.01

            String chargeSettlementCurrency = params.settlementCurrency

            def chargesResultFlagMap = coreAPIService.dummySendQuery([
                    tradeServiceId: params.tradeServiceId,
                    chargeSettlementCurrency: chargeSettlementCurrency,
                    urr: urr,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    cwtFlag: cwtFlag,
                    cwtPercentage: cwtPercentage.toPlainString(),
                    bankCommissionNumerator: bankCommissionNumerator.toPlainString(),
                    bankCommissionDenominator: bankCommissionDenominator.toPlainString(),
                    bankCommissionPercentage: bankCommissionPercentage.toPlainString()
            ], "charges/getExportBillsPaymentSettlementCharge", "")
            temp = chargesResultFlagMap.get("result")
            println "temp:"+temp

            docstamps = new BigDecimal(temp.get("DOCSTAMPS"))
            bankComm = new BigDecimal(temp.get("BC"))
			postage = new BigDecimal(temp.get("POSTAGE"))
            total = docstamps + bankComm

            jsonData = [

                    DOCSTAMPS: docstamps,
                    BC: bankComm,,
					POSTAGE: postage,
                    TOTAL: total
            ]
        }

        render jsonData as JSON
    }

    def recomputeCwt (){
        println "origAmount:"+params.origAmount
        String tempOrigAmount = params.origAmount
        BigDecimal originalAmount = new BigDecimal(tempOrigAmount.replace(',',''))
        BigDecimal cwtAmount = new BigDecimal("0.98").multiply(originalAmount)
        println "cwtAmount:"+cwtAmount
        def jsonData = [cwtAmount:cwtAmount]
        return jsonData


    }

    private BigDecimal getChargeWithRest(String tradeserviceId, String chargeId, String settlementcurrency, BigDecimal usdToPhpUrr, BigDecimal thirdToUsdSpecialConversionRateCurrency) {
        BigDecimal chargeAmount
        def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": chargeId], "tradeservice/getServiceCharge", "")
        BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
        String currency = getServiceChargeAmountMap.get("currency")
        println ""
        println "chargeId:" + chargeId
        println "serviceChargeAmount:" + serviceChargeAmount
        println "currency:" + currency
        println ""

        if (currency != null) {
            if (settlementcurrency.equalsIgnoreCase(currency)) {
                println "00"
                chargeAmount = serviceChargeAmount
            } else if (settlementcurrency.equalsIgnoreCase("PHP") && currency.equalsIgnoreCase("USD")) {
                println "01"
                chargeAmount = serviceChargeAmount.multiply(usdToPhpUrr)//TODO change this to USD_To_PHP_SellRate
            } else if (settlementcurrency.equalsIgnoreCase("PHP") && (!currency.equalsIgnoreCase("USD") && !currency.equalsIgnoreCase("PHP"))) {
                println "02"
                chargeAmount = serviceChargeAmount.multiply(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpUrr))//TODO change this to USD_To_PHP_SellRate
            } else if (settlementcurrency.equalsIgnoreCase("USD") && currency.equalsIgnoreCase("PHP")) {
                println "03"
                chargeAmount = serviceChargeAmount.divide(usdToPhpUrr, 2, BigDecimal.ROUND_UP)//TODO change this to USD_To_PHP_SellRate
            } else if (settlementcurrency.equalsIgnoreCase("USD") && (!currency.equalsIgnoreCase("USD") && !currency.equalsIgnoreCase("PHP"))) {
                println "04"
                chargeAmount = serviceChargeAmount.divide(thirdToUsdSpecialConversionRateCurrency, 2, BigDecimal.ROUND_UP)//TODO change this to USD_To_PHP_SellRate
            } else if (!settlementcurrency.equalsIgnoreCase("USD")&& !settlementcurrency.equalsIgnoreCase("PHP") && (!currency.equalsIgnoreCase("USD") && !currency.equalsIgnoreCase("PHP"))) {
                println "05"
                chargeAmount = serviceChargeAmount.divide(thirdToUsdSpecialConversionRateCurrency, 2, BigDecimal.ROUND_UP)//TODO change this to USD_To_PHP_SellRate
            } else {
                println "07"
                chargeAmount = serviceChargeAmount.divide(usdToPhpUrr.multiply(thirdToUsdSpecialConversionRateCurrency) , 2, BigDecimal.ROUND_UP)//TODO change this to USD_To_PHP_SellRate
            }
        } else {
            chargeAmount = BigDecimal.ZERO
        }

        chargeAmount
    }

    private BigDecimal getChargeWithRestOLD(String tradeserviceId, String chargeId, String settlementcurrency, BigDecimal usdToPhpUrr, BigDecimal thirdToUsdSpecialConversionRateCurrency) {
        BigDecimal chargeAmount
        def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": chargeId], "tradeservice/getServiceCharge", "")
        BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
        String currency = getServiceChargeAmountMap.get("currency")

        if (settlementcurrency.equalsIgnoreCase(currency)) {
            chargeAmount = serviceChargeAmount
        } else if (settlementcurrency.equalsIgnoreCase("PHP")) {
            chargeAmount = serviceChargeAmount
        } else if (settlementcurrency.equalsIgnoreCase("USD")) {
            chargeAmount = serviceChargeAmount.divide(usdToPhpUrr, 2, BigDecimal.ROUND_UP)//TODO change this to USD_To_PHP_SellRate
        } else {
            chargeAmount = serviceChargeAmount.divide(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpUrr), 2, BigDecimal.ROUND_UP) //TODO change this to USD_To_PHP_SellRate
        }
        chargeAmount
    }

    private BigDecimal getDefaultChargeWithRest(String tradeserviceId, String chargeId, String settlementcurrency, BigDecimal usdToPhpUrr, BigDecimal thirdToUsdSpecialConversionRateCurrency) {
        println "getDefaultChargeWithRest"

        BigDecimal chargeAmount
        def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": chargeId], "tradeservice/getDefaultServiceCharge", "")
        println "default amount for charge id2 ${chargeId}:" + getServiceChargeAmountMap.get("amount")
        BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
        String currency = getServiceChargeAmountMap.get("currency")

//        if (settlementcurrency.equalsIgnoreCase(currency)) {
//            chargeAmount = serviceChargeAmount
//        } else if (settlementcurrency.equalsIgnoreCase("PHP")) {
//            chargeAmount = serviceChargeAmount
//        } else if (settlementcurrency.equalsIgnoreCase("USD")) {
//            chargeAmount = serviceChargeAmount.divide(usdToPhpUrr, 2, BigDecimal.ROUND_HALF_UP)//TODO change this to USD_To_PHP_SellRate
//        } else {
//            chargeAmount = serviceChargeAmount.divide(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpUrr), 2, BigDecimal.ROUND_HALF_UP) //TODO change this to USD_To_PHP_SellRate
//        }
        return serviceChargeAmount
    }

    private BigDecimal getNoCwtChargeWithRest(String tradeserviceId, String chargeId, String settlementcurrency, BigDecimal usdToPhpUrr, BigDecimal thirdToUsdSpecialConversionRateCurrency) {
        println "getNoCwtChargeWithRest"

        BigDecimal chargeAmount
        def getServiceChargeAmountMap = coreAPIService.dummySendQuery([tradeServiceId: tradeserviceId, "chargeId": chargeId], "tradeservice/getNoCwtServiceCharge", "")
        println "default amount for charge id ${chargeId}:" + getServiceChargeAmountMap.get("amount")
        BigDecimal serviceChargeAmount = new BigDecimal(getServiceChargeAmountMap.get("amount"))
        String currency = getServiceChargeAmountMap.get("currency")

//        if (settlementcurrency.equalsIgnoreCase(currency)) {
//            chargeAmount = serviceChargeAmount
//        } else if (settlementcurrency.equalsIgnoreCase("PHP")) {
//            chargeAmount = serviceChargeAmount
//        } else if (settlementcurrency.equalsIgnoreCase("USD")) {
//            chargeAmount = serviceChargeAmount.divide(usdToPhpUrr, 2, BigDecimal.ROUND_HALF_UP)//TODO change this to USD_To_PHP_SellRate
//        } else {
//            chargeAmount = serviceChargeAmount.divide(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpUrr), 2, BigDecimal.ROUND_HALF_UP) //TODO change this to USD_To_PHP_SellRate
//        }
        return serviceChargeAmount
    }
}
