package com.ucpb.tfsweb.utilities

import net.ipc.utils.NumberUtils
import org.jfree.date.SerialDate
import org.jfree.date.SerialDateUtilities
import org.joda.time.DateTime
import org.joda.time.Days
import org.springframework.transaction.annotation.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

class RecomputeService {

    static transactional = true

    // applies to bank commission, commitment fee, confirming fee
    @Transactional(readOnly = true)
    String recomputeForumla1(amount, numerator, denominator, percent, months) {

        BigDecimal lcAmountParam = amount ? new BigDecimal(amount.replaceAll(",", "")) : 0
        Double numeratorParam = numerator ? new Double(numerator.replaceAll(",", "")) : 0
        Double denominatorParam = denominator ? new Double(denominator.replaceAll(",", "")) : 0
        Double percentParam = percent ? new Double(percent.replaceAll(",", "")) : 0
        Double monthsParam = months ? new Double(months.replaceAll(",", "")) : 0


        Double percentD = percentParam / 100

        BigDecimal percentLcAmount = lcAmountParam * percentD * monthsParam

        BigDecimal result = 0

        if (denominator) {
            result = (percentLcAmount * numeratorParam / denominatorParam)
        }

        return NumberUtils.currencyFormat(result.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue())
    }

    // applies to documentary stamp
    @Transactional(readOnly = true)
    String recomputeDocumentaryStamp(amount, centavos) {
        BigDecimal lcAmountParam = amount ? new BigDecimal(amount.replaceAll(",", "")) : 0
        Double centavosParam = centavos ? new Double(centavos.replaceAll(",", "")) : 0

        BigDecimal every200 = lcAmountParam / 200

        BigDecimal result = every200 * centavosParam

        return NumberUtils.currencyFormat(result.doubleValue())
    }

    // compute total of amounts
    @Transactional(readOnly = true)
    String computeTotal(amounts) {
        BigDecimal totalAmount = 0
        amounts?.split(",")?.each {
            BigDecimal amount = (it != null && !(new String(it)).isEmpty()) ? new BigDecimal((new String(it)).replaceAll("\\*", "")) : BigDecimal.ZERO
            totalAmount += amount
        }

        totalAmount = totalAmount.setScale(2, BigDecimal.ROUND_HALF_UP)
        return NumberUtils.currencyFormatComputation(totalAmount.doubleValue())
    }

    // compute balance and excess of 2 amounts
    @Transactional(readOnly = true)
    Map<String, String> computeBalance(totalAmountDue, totalAmount) {
        BigDecimal due = totalAmountDue ? new BigDecimal(totalAmountDue.replaceAll(",", "")) : 0

        BigDecimal amount = totalAmount ? new BigDecimal(totalAmount.replaceAll(",", "")) : 0

        BigDecimal balance = due - amount

        BigDecimal excess
        if (balance.compareTo(BigDecimal.ZERO) < 1) {
            excess = Math.abs(balance.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue())
            balance = BigDecimal.ZERO
        }

        return [balance: NumberUtils.currencyFormatComputation(balance.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue()), excess: NumberUtils.currencyFormatComputation(excess)]
    }

    BigDecimal recomputeCurrency(BigDecimal amount, BigDecimal settlementconversionrateSPECIAL, BigDecimal settlementconversionratePASSON, BigDecimal lcconversionrateSPECIAL, BigDecimal lcconversionratePASSON, lccurrency, settlementcurrency) {
//        println "amount:" + amount
//        println "lcconversionrateSPECIAL:" + lcconversionrateSPECIAL
//        println "lcconversionratePASSON:" + lcconversionratePASSON

        if (settlementcurrency.equalsIgnoreCase(lccurrency)) {
            if (lccurrency.equalsIgnoreCase("PHP")) {
                return amount;
            } else {
                BigDecimal tempAmount = amount.divide(lcconversionratePASSON, 10, BigDecimal.ROUND_HALF_EVEN) //usd
                tempAmount = tempAmount.multiply(lcconversionrateSPECIAL.divide(lcconversionrateSPECIAL, 10, BigDecimal.ROUND_HALF_EVEN)).setScale(4, BigDecimal.ROUND_HALF_UP)
                return tempAmount
            }
        } else {

            if (settlementcurrency.equalsIgnoreCase("PHP")) {

                BigDecimal tempAmount = amount.divide(lcconversionratePASSON, 10, BigDecimal.ROUND_HALF_EVEN) //usd or third
//                println "tempAmount:" + tempAmount
                tempAmount = tempAmount.multiply(lcconversionrateSPECIAL).setScale(2, BigDecimal.ROUND_HALF_UP)
//                println "tempAmount:" + tempAmount
                return tempAmount
            } else {
                BigDecimal tempAmount = amount.divide(lcconversionratePASSON, 10, BigDecimal.ROUND_HALF_EVEN) //usd
                tempAmount = tempAmount.multiply(lcconversionrateSPECIAL.divide(settlementconversionrateSPECIAL, 10, BigDecimal.ROUND_HALF_EVEN)).setScale(2, BigDecimal.ROUND_HALF_UP)
                return tempAmount
            }
        }
    }

    def recomputeNONLCBankCommission(
            BigDecimal productAmount,
            String lccurrency,
            String settlementcurrency,
            String cwtFlag,
            String documentType,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            String conversionStyle,
            BigDecimal bankCommissionNumerator,
            BigDecimal bankCommissionDenominator,
            BigDecimal bankCommissionPercentage,
            BigDecimal cwtPercentage
    ) {
        BigDecimal originalAmount = productAmount

        if ("domestic".equalsIgnoreCase(documentType)) {
            productAmount = computeCorrectProductAmountDM(
                    productAmount,
                    lccurrency,
                    thirdToUsdSpecialConversionRateCurrency,
                    usdToPhpSpecialConversionRate,
                    urr,
                    conversionStyle
            )
        } else {
            productAmount = computeCorrectProductAmount(
                    productAmount,
                    lccurrency,
                    thirdToUsdSpecialConversionRateCurrency,
                    usdToPhpSpecialConversionRate,
                    urr,
                    conversionStyle
            )
        }

        bankCommissionDenominator = bankCommissionDenominator ?: new BigDecimal("8");
        bankCommissionNumerator = bankCommissionNumerator ?: new BigDecimal("1");
        bankCommissionPercentage = bankCommissionPercentage ?: new BigDecimal("0.01");
//        println "bankCommissionPercentage:"+bankCommissionPercentage
//        println "bankCommissionDenominator:"+bankCommissionDenominator
//        println "bankCommissionNumerator:"+bankCommissionNumerator

        if(bankCommissionPercentage.compareTo(BigDecimal.ONE)>=0){
            bankCommissionPercentage =bankCommissionPercentage/100
        }
        cwtPercentage = cwtPercentage ?: new BigDecimal("0.98");


        BigDecimal bankCommissionAmountInitial = new BigDecimal("125");
        BigDecimal tranch01 = new BigDecimal("50000");

        BigDecimal remainingProductAmount = productAmount.subtract(tranch01);
        BigDecimal bankCommissionNext = BigDecimal.ZERO;
        if (remainingProductAmount.compareTo(BigDecimal.ZERO) == 1) {
            bankCommissionNext = remainingProductAmount.multiply(bankCommissionNumerator);
//            System.out.println(bankCommissionNext);
            bankCommissionNext = bankCommissionNext.multiply(bankCommissionPercentage);
//            System.out.println(bankCommissionNext);
            bankCommissionNext = bankCommissionNext.divide(bankCommissionDenominator, 9, BigDecimal.ROUND_HALF_UP);
//            System.out.println(bankCommissionNext);
            bankCommissionNext = bankCommissionNext.add(bankCommissionAmountInitial);
//            System.out.println(bankCommissionNext);
        }

        if ("FOREIGN".equalsIgnoreCase(documentType)) {
            if (bankCommissionNext.compareTo(new BigDecimal("1000")) != 1) {
                bankCommissionNext = new BigDecimal("1000");
            }
        } else {
            if (bankCommissionNext.compareTo(new BigDecimal("500")) != 1) {
                bankCommissionNext = new BigDecimal("500");
            }
        }

        println "cwtFlag:" + cwtFlag
        if ("Y".equalsIgnoreCase(cwtFlag) || "Yes".equalsIgnoreCase(cwtFlag)) {
            bankCommissionNext = bankCommissionNext.multiply(cwtPercentage);
        }

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        return bankCommissionNext.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
    }

    def recompute_NONLC_DocumentaryStamps(
            BigDecimal productAmount,
            String lccurrency,
            String settlementcurrency,
            String TR_LOAN_FLAG,
            BigDecimal trloanAmount,
            String trLoanCurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            String conversionStyle,
            String documentType,
            BigDecimal otherAmount,
            BigDecimal centavos
    ) {
        BigDecimal originalAmount = productAmount
        BigDecimal trLoanAmountPhp
        BigDecimal trLoanAmountNotPaidInPHP
        //convert tr loan amount to original amount
        if ("PHP".equalsIgnoreCase(trLoanCurrency)) {
            trLoanAmountPhp = trloanAmount
//            if ("PHP".equalsIgnoreCase(lccurrency)){
//                trLoanAmountNotPaidInPHP = originalAmount.subtract(trLoanAmountPhp)
//            }  else if ("USD".equalsIgnoreCase(lccurrency)){
//                BigDecimal trLoanAmountUSD = trloanAmount.divide(urr)
//                trLoanAmountNotPaidInPHP = originalAmount.subtract(trLoanAmountUSD)
//                trLoanAmountNotPaidInPHP = trLoanAmountNotPaidInPHP.multiply(usdToPhpSpecialConversionRate)
//            } else {
//                BigDecimal trLoanAmountTHIRD = trloanAmount.divide(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpSpecialConversionRate),6,BigDecimal.ROUND_HALF_UP)
//                trLoanAmountNotPaidInPHP = originalAmount.subtract(trLoanAmountTHIRD)
//                trLoanAmountNotPaidInPHP = trLoanAmountNotPaidInPHP.multiply(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpSpecialConversionRate))
//            }
        } else {
            //USD Default , TR
            println "trloanAmount trloanAmount trloanAmount trloanAmount:" + trloanAmount
            println "urr urr urr urr urr urr:" + urr
            println "trLoanAmountPhp trLoanAmountPhp trLoanAmountPhp trLoanAmountPhp trLoanAmountPhp trLoanAmountPhp:" + trloanAmount.multiply(urr)

            trLoanAmountPhp = trloanAmount.multiply(urr)
//            if ("USD".equalsIgnoreCase(lccurrency)){
//                trLoanAmountNotPaidInPHP = originalAmount.subtract(trloanAmount)
//                trLoanAmountNotPaidInPHP = trLoanAmountNotPaidInPHP.multiply(urr)
//            }  else if ("PHP".equalsIgnoreCase(lccurrency)){
//               trLoanAmountNotPaidInPHP = originalAmount.subtract(trloanAmount.multiply(usdToPhpSpecialConversionRate))
//            } else {
//                BigDecimal trLoanAmountTHIRD = trloanAmount.divide(thirdToUsdSpecialConversionRateCurrency,6,BigDecimal.ROUND_HALF_UP)
//                println "originalAmount"+originalAmount
//                println "trLoanAmountTHIRD"+trLoanAmountTHIRD
//                trLoanAmountNotPaidInPHP = originalAmount.subtract(trLoanAmountTHIRD)
//                println "trLoanAmountNotPaidInPHP"+trLoanAmountNotPaidInPHP
//                trLoanAmountNotPaidInPHP = trLoanAmountNotPaidInPHP.multiply(thirdToUsdSpecialConversionRateCurrency.multiply(usdToPhpSpecialConversionRate))
//                println "trLoanAmountNotPaidInPHP"+trLoanAmountNotPaidInPHP
//            }
        }


        println "trLoanAmountNotPaidInPHP:" + trLoanAmountNotPaidInPHP
        println "conversionStyle conversionStyle conversionStyle conversionStyle:" + conversionStyle


        if ("domestic".equalsIgnoreCase(documentType)) {
            productAmount = computeCorrectProductAmountDM(
                    productAmount,
                    lccurrency,
                    thirdToUsdSpecialConversionRateCurrency,
                    usdToPhpSpecialConversionRate,
                    urr,
                    conversionStyle
            )
        } else {
            productAmount = computeCorrectProductAmount(
                    productAmount,
                    lccurrency,
                    thirdToUsdSpecialConversionRateCurrency,
                    usdToPhpSpecialConversionRate,
                    urr,
                    conversionStyle
            )
        }


        trLoanAmountNotPaidInPHP = productAmount.subtract(trLoanAmountPhp)
        println "productAmount after conversion doc stamps:" + productAmount
        println "trLoanAmountPhp after conversion doc stamps:" + trLoanAmountPhp
        println "trLoanAmountNotPaidInPHP after conversion doc stamps:" + productAmount - trLoanAmountPhp
        println "trLoanAmountNotPaidInPHP after conversion doc stamps:" + trLoanAmountNotPaidInPHP

        BigDecimal temp;
        BigDecimal stepAmount = new BigDecimal("200")
        BigDecimal normallySettled = BigDecimal.ZERO;
        if (trloanAmount != null) {
            normallySettled = otherAmount
            trloanAmount = getRoundedNearest(trLoanAmountPhp, new BigDecimal("5000"))
        } else {
            normallySettled = productAmount;
            trloanAmount = BigDecimal.ZERO;
        }

        BigDecimal step = new BigDecimal("5000");
        BigDecimal payStep01 = new BigDecimal("20");
        BigDecimal payStep02 = new BigDecimal("10");
        BigDecimal holderTRLoan = BigDecimal.ZERO;
        if (trloanAmount.compareTo(step) > 0) {
            // if trloan amount is greater than step(5000) and tr
            holderTRLoan = payStep01.add(trloanAmount.subtract(step).divide(step, BigDecimal.ROUND_HALF_UP).multiply(payStep02));
        } else if (trloanAmount.compareTo(BigDecimal.ZERO) > 0) {
            // if trloan amount is less than 500 but greater than zero
            holderTRLoan = payStep01;
        }

        BigDecimal holderNormallySettled = BigDecimal.ZERO;
        if (!"domestic".equalsIgnoreCase(documentType)) {
            if (normallySettled.compareTo(BigDecimal.ZERO) > 0) {
                println "getRoundedNearest200(normallySettled):" + getRoundedNearest200(normallySettled)
                holderNormallySettled = centavos.multiply(divideUp(getRoundedNearest200(normallySettled), stepAmount));
            }
        }




        BigDecimal holder = holderNormallySettled.add(holderTRLoan);

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        if (holder.compareTo(BigDecimal.ZERO) == 1) {
            return holder.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        } else {
            return BigDecimal.ZERO;
        }
    }

    def recompute_NONLC_RemittanceFee(
            BigDecimal remittanceMinimum,
            String remittanceFlag,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency
    ) {
        println "remittanceFlag:" + remittanceFlag
        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        if ("Y".equalsIgnoreCase(remittanceFlag)) {
            return remittanceMinimum.multiply(urr).divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        } else {
            return BigDecimal.ZERO
        }
    }

    def recompute_NONLC_CableFee(
            BigDecimal cableFeeMinimum,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            String cableFeeFlag
    ) {

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        if ("Y".equalsIgnoreCase(cableFeeFlag)) {
            return cableFeeMinimum.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        } else if ("null".equalsIgnoreCase(cableFeeFlag)) {
            return cableFeeMinimum.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        } else {
            return BigDecimal.ZERO
        }

    }


    def recompute_NONLC_NotarialFee(
            BigDecimal notarialFee,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency
    ) {

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )

        return notarialFee.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)

    }


    def recompute_NONLC_BspCommission(
            BigDecimal bspCommissionMinimum,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency
    ) {

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        bspCommissionMinimum.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
    }

    def recompute_NONLC_Booking(
            BigDecimal bookingFeeMinimum,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal cwtPercentage,
            String cwtFlag
    ) {

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        println "cwtFlag:" + cwtFlag
        println "cwtPercentage:" + cwtPercentage
        if ("Y".equalsIgnoreCase(cwtFlag)) {
            return bookingFeeMinimum.multiply(cwtPercentage).divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        } else {
            return bookingFeeMinimum.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
        }

    }

    def recompute_NONLC_CILEX(
            BigDecimal productAmount,
            BigDecimal cilexNumerator,
            BigDecimal cilexDenominator,
            BigDecimal cilexPercentage,
            String cwtFlag,
            BigDecimal cwtPercentage,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate
    ) {
        BigDecimal cilex = productAmount.multiply(cilexNumerator).multiply(cilexPercentage).divide(cilexDenominator, 9, BigDecimal.ROUND_HALF_UP);

        BigDecimal cilexMinimumInPhp = new BigDecimal("20");
        cilexMinimumInPhp = cilexMinimumInPhp.multiply(urr);

        System.out.println("cilexMinimumInPhp:" + cilexMinimumInPhp);
        System.out.println("cilex:" + cilex);
        if (cilex.compareTo(cilexMinimumInPhp) != 1) {
            cilex = cilexMinimumInPhp;
        }

        if ("Y".equalsIgnoreCase(cwtFlag)) {
            cilex = cilex.multiply(cwtPercentage);
        }


        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        println "cilex:" + cilex
        println "cilex divided by settlement conversion rate:" + cilex.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP);
        return cilex.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP);

    }

    private static BigDecimal computeCorrectProductAmountDM(
            BigDecimal productAmount,
            String lccurrency,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            BigDecimal urr,
            String conversionStyle
    ) {

        BigDecimal conversionRate = computeConversionRateProductAmountChargesDM(
                lccurrency,
                thirdToUsdSpecialConversionRateCurrency,
                usdToPhpSpecialConversionRate,
                urr,
                conversionStyle
        )
        return productAmount.multiply(conversionRate)

    }


    private static BigDecimal computeCorrectProductAmount(
            BigDecimal productAmount,
            String lccurrency,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            BigDecimal urr,
            String conversionStyle
    ) {

        BigDecimal conversionRate = computeConversionRateProductAmountCharges(
                lccurrency,
                thirdToUsdSpecialConversionRateCurrency,
                usdToPhpSpecialConversionRate,
                urr,
                conversionStyle
        )
        return productAmount.multiply(conversionRate)

    }

    //TODO: Fix with sell rate
    private static BigDecimal computeConversionRateProductAmountCharges(
            String lccurrency,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            BigDecimal urr,
            String conversionStyle
    ) {

        if (!"USD".equalsIgnoreCase(lccurrency) && !"PHP".equalsIgnoreCase(lccurrency)) {
            if ("sell-sell".equalsIgnoreCase(conversionStyle)) {
                return usdToPhpSpecialConversionRate.multiply(thirdToUsdSpecialConversionRateCurrency)
            } else {
                return urr.multiply(thirdToUsdSpecialConversionRateCurrency)
            }

        } else if ("USD".equalsIgnoreCase(lccurrency)) {
            if ("sell-sell".equalsIgnoreCase(conversionStyle)) {
                return usdToPhpSpecialConversionRate
            } else {
                return urr
            }
        } else if ("PHP".equalsIgnoreCase(lccurrency)) {
            return BigDecimal.ONE
        }

    }

    private static BigDecimal computeConversionRateProductAmountChargesDM(
            String lccurrency,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            BigDecimal urr,
            String conversionStyle
    ) {

        if (!"USD".equalsIgnoreCase(lccurrency) && !lccurrency.equalsIgnoreCase("PHP")) {
            if ("sell-sell".equalsIgnoreCase(conversionStyle)) {
                return urr.multiply(thirdToUsdSpecialConversionRateCurrency)
            } else {
                return urr.multiply(thirdToUsdSpecialConversionRateCurrency)
            }

        } else if ("USD".equalsIgnoreCase(lccurrency)) {
            if ("sell-sell".equalsIgnoreCase(conversionStyle)) {
                return urr
            } else {
                return urr
            }
        } else if ("PHP".equalsIgnoreCase(lccurrency)) {
            return BigDecimal.ONE
        }

    }

    private static BigDecimal computeConversionRateSettlementCharges(
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency
    ) {
        if (lccurrency.equalsIgnoreCase(settlementcurrency)) {
            // Use THIRD-USD Sell rate and usdToPhpSpecialConversionRate or usdToPhpSpecialConversionRate
            if (!settlementcurrency.equalsIgnoreCase("USD") && !settlementcurrency.equalsIgnoreCase("PHP")) {
                return urr.multiply(thirdToUsdSpecialConversionRateSettlementCurrency)
            } else if (lccurrency.equalsIgnoreCase("USD")) {
                return urr
            } else if (lccurrency.equalsIgnoreCase("PHP")) {
                return BigDecimal.ONE
            }

        } else {
            if (!settlementcurrency.equalsIgnoreCase("USD") && !settlementcurrency.equalsIgnoreCase("PHP")) {
                //paid in THIRD USD PESO
                return urr.multiply(thirdToUsdSpecialConversionRateSettlementCurrency)
            } else if (settlementcurrency.equalsIgnoreCase("USD")) {
                //paid in peso or usd
                return urr
            } else {
                //paid in peso or usd
                return BigDecimal.ONE
            }
        }
    }

    def recompute_LC_DOMESTIC_OPENING_BankCommission(
            BigDecimal productAmount,
            String lccurrency,
            String settlementcurrency,
            String cwtFlag,
            String documentType,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            String conversionStyle,
            BigDecimal bankCommissionNumerator,
            BigDecimal bankCommissionDenominator,
            BigDecimal bankCommissionPercentage,
            BigDecimal cwtPercentage,
            String expiryDate,
            BigDecimal bankCommissionMonths
    ) {
        BigDecimal originalAmount = productAmount
        productAmount = computeCorrectProductAmount(
                productAmount,
                lccurrency,
                thirdToUsdSpecialConversionRateCurrency,
                usdToPhpSpecialConversionRate,
                urr,
                conversionStyle
        )
        bankCommissionDenominator = bankCommissionDenominator ?: new BigDecimal("8");
        bankCommissionNumerator = bankCommissionNumerator ?: new BigDecimal("1");
        bankCommissionPercentage = bankCommissionPercentage ?: new BigDecimal("0.01");
        cwtPercentage = cwtPercentage ?: new BigDecimal("0.98");


        BigDecimal charge = getBankCommission_LC_Opening(
                expiryDate,
                bankCommissionNumerator,
                bankCommissionDenominator,
                bankCommissionPercentage,
                productAmount,
                cwtPercentage,
                cwtFlag
        )

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        return charge.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
    }

    def recompute_LC_DOMESTIC_OPENING_DocumentaryStamps(
            BigDecimal productAmount,
            String lccurrency,
            String settlementcurrency,
            String TR_LOAN_FLAG,
            BigDecimal trloanAmount,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            String conversionStyle
    ) {


        BigDecimal originalAmount = productAmount
        productAmount = computeCorrectProductAmount(
                productAmount,
                lccurrency,
                thirdToUsdSpecialConversionRateCurrency,
                usdToPhpSpecialConversionRate,
                urr,
                conversionStyle
        )

        BigDecimal temp;
        BigDecimal stepAmount = new BigDecimal("200")
        BigDecimal normallySettled = BigDecimal.ZERO
        if (trloanAmount != null) {
            normallySettled = productAmount.subtract(trloanAmount)

        } else {
            normallySettled = productAmount
            trloanAmount = BigDecimal.ZERO
        }

        BigDecimal step = new BigDecimal("5000")
        BigDecimal payStep01 = new BigDecimal("20")
        BigDecimal payStep02 = new BigDecimal("10")
        BigDecimal holderTRLoan = BigDecimal.ZERO

        if (trloanAmount.compareTo(step) > 0) {
            trloanAmount = getRoundedNearest(trloanAmount, step)
            // if trloan amount is greater than step(5000) and tr
            holderTRLoan = payStep01.add(trloanAmount.subtract(step).divide(step, BigDecimal.ROUND_HALF_UP).multiply(payStep02));
        } else if (trloanAmount.compareTo(BigDecimal.ZERO) > 0) {
            // if trloan amount is less than 500 but greater than zero
            holderTRLoan = payStep01;
        }

        BigDecimal holderNormallySettled = BigDecimal.ZERO;
        if (normallySettled.compareTo(BigDecimal.ZERO) > 0) {
            holderNormallySettled = new BigDecimal("0.30").multiply(divideUp(getRoundedNearest200(normallySettled), stepAmount));
        }


        BigDecimal holder = holderNormallySettled.add(holderTRLoan);

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
        println "settlementConversionRate:" + settlementConversionRate
        if (holder.compareTo(BigDecimal.ZERO) == 1) {
            return holder.divide(settlementConversionRate, 2, BigDecimal.ROUND_UP)
        } else {
            return BigDecimal.ZERO;
        }

    }


    public static BigDecimal getCommitmentFee_LC_Opening(
            BigDecimal productAmount,
            String lccurrency,
            String settlementcurrency,
            String documentType,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateCurrency,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency,
            BigDecimal usdToPhpSpecialConversionRate,
            String conversionStyle,
            BigDecimal usancePeriod,
            String expiryDate,
            String documentSubType1,
            String documentSubType2,
            BigDecimal commitmentFeeNumerator,
            BigDecimal commitmentFeeDenominator,
            BigDecimal commitmentFeePercentage,
            String cwtFlag,
            BigDecimal cwtPercentage
    ) {

        BigDecimal originalAmount = productAmount
        productAmount = computeCorrectProductAmount(
                productAmount,
                lccurrency,
                thirdToUsdSpecialConversionRateCurrency,
                usdToPhpSpecialConversionRate,
                urr,
                conversionStyle
        )

        if (commitmentFeeNumerator == null) {
            commitmentFeeNumerator = new BigDecimal("1");
        }
        if (commitmentFeeDenominator == null) {
            commitmentFeeDenominator = new BigDecimal("4");
        }
        if (commitmentFeePercentage == null) {
            commitmentFeePercentage = new BigDecimal("0.01");
        } else if (commitmentFeePercentage.compareTo(BigDecimal.ONE) == 1) {
            commitmentFeePercentage = commitmentFeePercentage.divide(new BigDecimal("100"), 2, BigDecimal.ROUND_HALF_UP);
        }

        if (cwtPercentage == null) {
            cwtPercentage = new BigDecimal("0.98");
        }

        BigDecimal result = BigDecimal.ZERO;

        if ("CASH".equalsIgnoreCase(documentSubType1) && "SIGHT".equalsIgnoreCase(documentSubType2)) {
//            println "STANDBY-SIGHT"
            return BigDecimal.ZERO;
        } else if ("STANDBY".equalsIgnoreCase(documentSubType1) && "SIGHT".equalsIgnoreCase(documentSubType2)) {
//            println "STANDBY-SIGHT"
            BigDecimal months = getMonthsTill(expiryDate);
            if (months.compareTo(BigDecimal.ONE) != 1) {
                months = BigDecimal.ONE;
            }
            result = productAmount.multiply(divideUp(commitmentFeeNumerator, commitmentFeeDenominator)).multiply(commitmentFeePercentage).multiply(months);
//            System.out.println("months:" + months);
//            System.out.println("result:" + result);
        } else if ("REGULAR".equalsIgnoreCase(documentSubType1) && "SIGHT".equalsIgnoreCase(documentSubType2)) {
//            println "REGULAR-SIGHT"
            result = productAmount.multiply(divideUp(commitmentFeeNumerator, commitmentFeeDenominator)).multiply(commitmentFeePercentage);
//            System.out.println("result:" + result);
        } else if ("REGULAR".equalsIgnoreCase(documentSubType1) && "USANCE".equalsIgnoreCase(documentSubType2)) {
            BigDecimal months = getMonthsOf(usancePeriod);

            if (months.compareTo(BigDecimal.ONE) != 1) {
                months = BigDecimal.ONE;
            }

            result = productAmount.multiply(divideUp(commitmentFeeNumerator, commitmentFeeDenominator)).multiply(commitmentFeePercentage).multiply(months);
//            System.out.println("month:" + months);
//            System.out.println("result:" + result);
        }

        //Minimum Checking here
        BigDecimal minimumPhp = new BigDecimal("500");
        BigDecimal resultAfterCwt = new BigDecimal("0");
        if (result.compareTo(minimumPhp) != 1) {
//            println "result -1"
            resultAfterCwt = minimumPhp.setScale(2, BigDecimal.ROUND_HALF_UP);
        } else {
//            println "result non -1"
            resultAfterCwt = result.setScale(2, BigDecimal.ROUND_HALF_UP);
        }

        if ("Y".equalsIgnoreCase(cwtFlag.trim())) {
            resultAfterCwt = resultAfterCwt.multiply(cwtPercentage);
        }

        return resultAfterCwt.setScale(2, BigDecimal.ROUND_HALF_UP);

    }

    public static BigDecimal getBankCommission_LC_Opening(
            String expiryDate,
            BigDecimal bankCommissionNumerator,
            BigDecimal bankCommissionDenominator,
            BigDecimal bankCommissionPercentage,
            BigDecimal productAmount,
            BigDecimal cwtPercentage,
            String cwtFlag
    ) {
        BigDecimal months = getMonthsTill(expiryDate);
        System.out.println(months);
        if (months.compareTo(BigDecimal.ONE) < 1) {
            months = BigDecimal.ONE;
        }

        BigDecimal result = multiplyNumeratorDenominatorPercentageAmountMonths(bankCommissionNumerator, bankCommissionDenominator, bankCommissionPercentage, productAmount, months);
        System.out.println("result" + result);
        if (result.compareTo(new BigDecimal("1000")) < 1) {
            result = new BigDecimal("1000.00");
        }

        if ("Y".equalsIgnoreCase(cwtFlag)) {
            result = result.multiply(cwtPercentage);
        }

        return result;
    }


    def recompute_SuppliesFee_LC_DOMESTIC_Opening(
            BigDecimal suppliesFee,
            String lccurrency,
            String settlementcurrency,
            BigDecimal urr,
            BigDecimal thirdToUsdSpecialConversionRateSettlementCurrency
    ) {

        BigDecimal settlementConversionRate = computeConversionRateSettlementCharges(
                lccurrency,
                settlementcurrency,
                urr,
                thirdToUsdSpecialConversionRateSettlementCurrency
        )
//        println "settlementConversionRate:" + settlementConversionRate
        return suppliesFee.divide(settlementConversionRate, 2, BigDecimal.ROUND_HALF_UP)
    }


    public static BigDecimal divideUp(BigDecimal numerator, BigDecimal denominator) {
        //Added default scale because dividing small numbers were returning zero 1/8 or 1/4
        return numerator.divide(denominator, 20, BigDecimal.ROUND_HALF_UP);
    }

    public static BigDecimal getRoundedNearest200(
            BigDecimal amount
    ) {
        //NOTE: remainder can be negative
        //TODO: Handle negative
        BigDecimal remainder = amount.remainder(new BigDecimal("200"));
        if (remainder.compareTo(new BigDecimal("0")) == 0) {
            return amount;
        } else {
            BigDecimal newAmount = new BigDecimal("200").subtract(remainder).add(amount);
            return newAmount;
        }
    }

    public static BigDecimal getRoundedNearest(
            BigDecimal amount, BigDecimal roundTo
    ) {
        //NOTE: remainder can be negative
        //TODO: Handle negative
        BigDecimal remainder = amount.remainder(roundTo);
//        println "remainder" + remainder
//        println "amount:" + amount
//        println "roundTo:" + roundTo
        if (remainder.compareTo(new BigDecimal("0")) == 0) {
            return amount;
        } else {
            BigDecimal newAmount = roundTo.subtract(remainder).add(amount);
//            println "newAmount:" + newAmount
            return newAmount;
        }
    }

    /**
     * @param date
     * @return
     */
    public static BigDecimal getMonthsTill(String date) {

        DateFormat formatter = new SimpleDateFormat("MM/dd/yy");

        try {
            Date endDate = formatter.parse(date);
//            System.out.println("endDate:" + endDate.toString());
//            System.out.println("startDate:" + new Date().toString());

            //Days actual convention
            Integer days = SerialDateUtilities.dayCountActual(
                    SerialDate.createInstance(new Date()),
                    SerialDate.createInstance(endDate));

            //Days 30/360 convention
//            Integer days = SerialDateUtilities.dayCount30ISDA(
//                    SerialDate.createInstance(new Date()),
//                    SerialDate.createInstance(endDate)
//            );

            // get a rounded up version of this using a math hack
            // rounding up: (numerator + denominator-1) / denominator
            // rounding down: (numerator + (denominator)/2) / denominator
            //System.out.println("months:" + ((days + 29) / 30));
            //return (days + 29) / 30;
//            System.out.println("days:" + days);
//            System.out.println("months:" + new BigDecimal(days.toString()).divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP));
            return new BigDecimal(days).divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP);

        } catch (Exception e) {
            // todo: handle invalid dates here
            return new BigDecimal(0);
        }
    }

    public static BigDecimal getMonthsTill(String dateFrom, String dateTo) {
//        System.out.println("getMonthsTill");
//        System.out.println("Date From:" + dateFrom);
//        System.out.println("Date To:" + dateTo);

        DateFormat formatter = new SimpleDateFormat("MM/dd/yy");

        try {
            Date startDate = formatter.parse(dateFrom);
            Date endDate = formatter.parse(dateTo);
//            System.out.println("dateFrom:" + dateFrom);
//            System.out.println("dateTo:" + dateTo);

            //Uses Actual
            Integer days = SerialDateUtilities.dayCountActual(
                    SerialDate.createInstance(new Date()),
                    SerialDate.createInstance(endDate));

//            //Uses Days 30/360 Convention
//            Integer days = SerialDateUtilities.dayCount30ISDA(
//                    SerialDate.createInstance(startDate),
//                    SerialDate.createInstance(endDate)
//            );
//            System.out.println("days 360:" + days);

            DateTime dateTimeFrom = new DateTime(startDate);
            DateTime dateTimeTo = new DateTime(endDate);
            int daysint = Days.daysBetween(dateTimeFrom, dateTimeTo).getDays();
            Integer daysInt = new Integer(daysint);

//            System.out.println("days 365:" + daysint);

            // get a rounded up version of this using a math hack
            // rounding up: (numerator + denominator-1) / denominator
            // rounding down: (numerator + (denominator)/2) / denominator
//            System.out.println("months:" + ((days + 29) / 30));
//            System.out.println("days:" + days);
//            System.out.println("months 360:" + new BigDecimal(days).divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP));
//            System.out.println("months 365:" + new BigDecimal(daysInt).divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP));
            return new BigDecimal(daysInt).divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP);

        } catch (Exception e) {
            // todo: handle invalid dates here
            return new BigDecimal(0);
        }
    }

    public static BigDecimal divideUp(BigDecimal numerator, BigDecimal denominator, int scale) {

        return numerator.divide(denominator, scale, BigDecimal.ROUND_HALF_UP);

    }

    // converts an amount to peso using the rate provided
    public static BigDecimal Pesoize(BigDecimal amount, BigDecimal toPesoRate) {
        return new BigDecimal(0.0);
    }

    //returns number of months rounded up
    public static BigDecimal getMonthsOf(BigDecimal daysPeriod) {
        if (daysPeriod == null) {
            daysPeriod = new BigDecimal("0");
        }
        return daysPeriod.divide(new BigDecimal("30"), 6, BigDecimal.ROUND_HALF_UP);
    }

    public static BigDecimal multiplyNumeratorDenominatorPercentageAmountMonths(
            BigDecimal numerator,
            BigDecimal denominator,
            BigDecimal percentage,
            BigDecimal productAmount,
            BigDecimal months
    ) {
//        System.out.println("numerator:" + numerator);
//        System.out.println("denominator:" + denominator);
//        System.out.println("percentage:" + percentage);
//        System.out.println("productAmount:" + productAmount);
//        System.out.println("months:" + months);
//        System.out.println("multiplied value:" + divideUp(numerator, denominator).multiply(percentage).multiply(productAmount).multiply(months));
        return divideUp(numerator, denominator).multiply(percentage).multiply(productAmount).multiply(months);

    }


}
