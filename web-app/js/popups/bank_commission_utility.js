/**
 * PROLOGUE
 * SCR/ER Description: To enable editing of bank comission charge
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Correct the paramter to be passed in the computation of the charges
 *	Date deployment: 6/16/2016 
 *	Member Type: Javascript
 *	Project: Web
 *	Project Name: bank_commission_utility.js 
*/

function openBankCommissionPopup() {
    $("#bankCommissionPopupField").val($("#BC").val());

    var bankCommissionPopupParamsHidden = JSON.stringify($("#bankCommissionPopupParamsHidden").val().replace(/=/g,"\"\:\"").replace(/\{/g,"\{\"").replace(/\}/g,"\"\}").replace(/,/g,"\"\,"))
//    if($("#bankCommissionPopupParamsHidden").val()!=""&&JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentageNumerator"]!=null && JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentageNumerator"]!=""){
    if(bankCommissionPopupParamsHidden!=""&&JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageNumerator"]!=null && JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageNumerator"]!=""){
        $("#bankComPercentageNumerator").val(JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageNumerator"]);
    }

//    if($("#bankCommissionPopupParamsHidden").val()!=""&& JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentageDenominator"] !=null && JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentageDenominator"]!=""){
    if(bankCommissionPopupParamsHidden!=""&& JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageDenominator"] !=null && JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageDenominator"]!=""){
        $("#bankComPercentageDenominator").val(JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentageDenominator"]);
    }

//    if($("#bankCommissionPopupParamsHidden").val()!=""&& JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentage"]!=null && JSON.parse(JSON.stringify($("#bankCommissionPopupParamsHidden").val()))["bankComPercentage"]!="" ){
    if(bankCommissionPopupParamsHidden!=""&& JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentage"]!=null && JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentage"]!="" ){
        $("#bankComPercentage").val(JSON.parse(bankCommissionPopupParamsHidden)["bankComPercentage"]);
    }

    var bankCommissionDefault = defaultValuesUrl;

    loadPopup("bankCommissionPopup", "popupBackground_bank_commission");
    centerPopup("bankCommissionPopup", "popupBackground_bank_commission");
}

function closeBankCommissionPopup() {
    disablePopup("bankCommissionPopup", "popupBackground_bank_commission");
}


function recomputeBankCommission() {
    var defaultValue = getDefaultValues("BC");

    var serviceTypeLocal = $("#serviceType").val();
    var documentTypeLocal = $("#documentType").val();
    var documentClassLocal = $("#documentClass").val();
    var documentSubType1Local = $("#documentSubType1").val();
    var documentSubType2Local = $("#documentSubType2").val();
    console.log("currency: " + currency);
    console.log("settlementCurrency: " + settlementCurrency);

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var usdToPhpUrr = getUrr("USD");

    var bankComPercentageNumeratorLocal = $("#bankComPercentageNumerator").val();
    if (bankComPercentageNumeratorLocal == "" || bankComPercentageNumeratorLocal === undefined) {
        bankComPercentageNumeratorLocal = $("#bankComPercentageNumerator2").val();
    }

    var bankComPercentageDenominatorLocal = $("#bankComPercentageDenominator").val();
    if (bankComPercentageDenominatorLocal == "" || bankComPercentageDenominatorLocal === undefined) {
        bankComPercentageDenominatorLocal = $("#bankComPercentageDenominator2").val();
    }

    var bankComPercentageLocal = $("#bankComPercentage").val();
    if (bankComPercentageLocal == "" || bankComPercentageLocal === undefined) {
        bankComPercentageLocal = $("#bankComPercentage2").val();
    }


    var amountToLocal = $("#amountTo").val();
    if (amountToLocal == "") {
        amountToLocal = "0";
    }

    var recomputeChargesUrl = recomputeUrl;
    
    console.log("thirdToUsdSpecialConversionRateCurrency: "+ $("#USD-PHP_text_special_rate").val());
    console.log("thirdToUsdSpecialConversionRateSettlementCurrency: "+ $("#EUR-USD_text_special_rate").val());
    
    var params;
    switch (documentClass) {
        case "DA":
        case "DP":
        case "OA":
        case "DR":
            recomputeChargesUrl = recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION_Url;
            params = {
                chargeType: "BC",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: defaultValue.toString(),
                productAmount: $("#bankCommissionLCAmountPopup").val().toString(),
                cwtFlag: $("input[name='cwtFlag']:checked").val(),
                documentType: $("#documentType").val(),
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
                thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
                thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
                usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                bankCommissionNumerator: bankComPercentageNumeratorLocal,
                bankCommissionDenominator: bankComPercentageDenominatorLocal,
                bankCommissionPercentage: bankComPercentageLocal,
                currency: $("#currency").val(),
                settlementCurrency: $("#settlementCurrency").val()
            }
            /*params = {
             charge: "bankCommission",
             productAmount: $("#bankCommissionLCAmountPopup").val(),
             bankCommissionNumerator: bankComPercentageNumeratorLocal,
             bankCommissionDenominator: bankComPercentageDenominatorLocal,
             bankCommissionPercentage: bankComPercentageLocal,
             tradeServiceId: $("#tradeServiceId").val(),
             etsNumber: $("#etsNumber").val(),
             documentNumber: $("#documentNumber").val(),
             referenceType: $("#referenceType").val(),
             serviceType: $("#serviceType").val(),
             documentType: $("#documentType").val(),
             documentClass: $("#documentClass").val(),
             expiryDate: $("#expiryDate").val(),
             cwtFlag: $("input[name='cwtFlag']:checked").val()
             }*/
            break;
        case "LC":
            if (serviceType == "OPENING" || serviceType == "Opening") {
                if (documentType == "FOREIGN") {
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if (documentType == "DOMESTIC") {
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            } else if (serviceType == "NEGOTIATION" || serviceType == "Negotiation") {
                if (documentType == "FOREIGN") {
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url;
                } else if (documentType == "DOMESTIC") {
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url;
                }
            } else if (serviceType == "AMENDMENT" || serviceType == "Amendment") {
                if (documentType == "FOREIGN") {
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION_Url;
                } else if (documentType == "DOMESTIC") {
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION_Url;
                }
            } else {
                if (documentType == "FOREIGN") {
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if (documentType == "DOMESTIC") {
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            }
            params = {
                chargeType: "BC",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: defaultValue.toString(),
                productAmount: $("#bankCommissionLCAmountPopup").val(),
                cwtFlag: $("input[name='cwtFlag']:checked").val(),
                documentType: $("#documentType").val(),
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
                thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
                thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
                usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                bankCommissionNumerator: bankComPercentageNumeratorLocal,
                bankCommissionDenominator: bankComPercentageDenominatorLocal,
                bankCommissionPercentage: bankComPercentageLocal,
                currency: $("#currency").val(),
                settlementCurrency: $("#settlementCurrency").val(),
                expiryDate: $("#expiryDate").val(),
                bankComNumberOfMonths: $("#bankComNumberOfMonths").val()
            }
            break;
        case "BP":
        	if(serviceType =="NEGOTIATION"){
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_BP_FOREIGN_NEGOTIATION_Url;
                    usdToPhpSpecialConversionRate = $("#USD-PHP_text_special_rate").val();
                    
                	if (currency == 'PHP') {
                		thirdToUsdSpecialConversionRateCurrency = "0";
                	} else if (currency == 'USD') {
                		thirdToUsdSpecialConversionRateCurrency = $("#USD-PHP_text_special_rate").val();
                	} else {
                		thirdToUsdSpecialConversionRateCurrency = $("#" + currency + "-USD_text_special_rate").val();
                	}
                	
                	if (settlementCurrency == 'PHP') {
                		thirdToUsdSpecialConversionRateSettlementCurrency = "0";
                	} else if (settlementCurrency == 'USD') {
                		thirdToUsdSpecialConversionRateSettlementCurrency = $("#USD-PHP_text_special_rate").val();
                	} else {
                		thirdToUsdSpecialConversionRateSettlementCurrency = $("#" + settlementCurrency + "-USD_text_special_rate").val();
                	}
                	
                    console.log("thirdToUsdSpecialConversionRateCurrency: "+thirdToUsdSpecialConversionRateCurrency);
                    console.log("thirdToUsdSpecialConversionRateSettlementCurrency: "+thirdToUsdSpecialConversionRateSettlementCurrency);
                    console.log("usdToPhpSpecialConversionRate: "+usdToPhpSpecialConversionRate);
                    
                } else if(documentType == "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_BP_DOMESTIC_NEGOTIATION_Url;
                }
        	} else if(serviceType =="SETTLEMENT"){
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_BP_FOREIGN_SETTLEMENT_Url;
                } else if(documentType == "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_BP_DOMESTIC_SETTLEMENT_Url;
                }
        	}
        	params = {
                    chargeType: "BC",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: $("#bankCommissionLCAmountPopup").val().toString(),
                    cwtFlag: $("input[name='cwtFlag']:checked").val(),
                    documentType: $("#documentType").val(),
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
                    thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
                    thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
                    usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                    urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,                    
                    bankCommissionNumerator: bankComPercentageNumeratorLocal,
                    bankCommissionDenominator: bankComPercentageDenominatorLocal,
                    bankCommissionPercentage: bankComPercentageLocal,
                    currency: $("#currency").val(),
                    settlementCurrency: $("#settlementCurrency").val(),
                    expiryDate: $("#lcExpiryDate").val(),
                    chargesOverridenFlag: "N"
                }
        	break;
        case "BC":
        	if(serviceType =="SETTLEMENT"){
        		if(documentType == "FOREIGN"){
        			recomputeChargesUrl = recomputeCurrency_BC_FOREIGN_SETTLEMENT_Url;
        			usdToPhpSpecialConversionRate = $("#USD-PHP_text_special_rate").val();
                    
                	if (currency == 'PHP') {
                		thirdToUsdSpecialConversionRateCurrency = "0";
                	} else if (currency == 'USD') {
                		thirdToUsdSpecialConversionRateCurrency = $("#USD-PHP_text_special_rate").val();
                	} else {
                		thirdToUsdSpecialConversionRateCurrency = $("#" + currency + "-USD_text_special_rate").val();
                	}
                	
                	if (settlementCurrency == 'PHP') {
                		thirdToUsdSpecialConversionRateSettlementCurrency = "0";
                	} else if (settlementCurrency == 'USD') {
                		thirdToUsdSpecialConversionRateSettlementCurrency = $("#USD-PHP_text_special_rate").val();
                	} else {
                		thirdToUsdSpecialConversionRateSettlementCurrency = $("#" + settlementCurrency + "-USD_text_special_rate").val();
                	}
                	
                    console.log("thirdToUsdSpecialConversionRateCurrency: "+thirdToUsdSpecialConversionRateCurrency);
                    console.log("thirdToUsdSpecialConversionRateSettlementCurrency: "+thirdToUsdSpecialConversionRateSettlementCurrency);
                    console.log("usdToPhpSpecialConversionRate: "+usdToPhpSpecialConversionRate);
             
        		} else if(documentType == "DOMESTIC"){
        			recomputeChargesUrl = recomputeCurrency_BC_DOMESTIC_SETTLEMENT_Url;
        		}
        	}
        	params = {
                    chargeType: "BC",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: $("#bankCommissionLCAmountPopup").val().toString(),
                    cwtFlag: $("input[name='cwtFlag']:checked").val(),
                    documentType: $("#documentType").val(),
                    thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                    thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
                    thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
                    thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
                    usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                    usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
                    usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                    urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                    bankCommissionNumerator: bankComPercentageNumeratorLocal,
                    bankCommissionDenominator: bankComPercentageDenominatorLocal,
                    bankCommissionPercentage: bankComPercentageLocal,
                    currency: $("#currency").val(),
                    settlementCurrency: $("#settlementCurrency").val(),
                    expiryDate: $("#lcExpiryDate").val(),
                    chargesOverridenFlag: "N"
                }
        	break;
        default:
            params = {
                chargeType: "BC",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: defaultValue.toString(),
                productAmount: $("#bankCommissionLCAmountPopup").val().toString(),
                cwtFlag: $("input[name='cwtFlag']:checked").val(),
                documentType: $("#documentType").val(),
                thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
                thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
                thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
                thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
                usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
                usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
                usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
                bankCommissionNumerator: bankComPercentageNumeratorLocal,
                bankCommissionDenominator: bankComPercentageDenominatorLocal,
                bankCommissionPercentage: bankComPercentageLocal,
                currency: $("#currency").val(),
                settlementCurrency: $("#settlementCurrency").val(),
                bankComNumberOfMonths: $("#bankComNumberOfMonths").val()
            }
            /*params = {
             charge: "bankCommission",
             amount: $("#bankCommissionLCAmountPopup").val(),
             bankCommissionNumerator: bankComPercentageNumeratorLocal,
             bankCommissionDenominator: bankComPercentageDenominatorLocal,
             bankCommissionPercentage: bankComPercentageLocal,
             tradeServiceId: $("#tradeServiceId").val(),
             etsNumber: $("#etsNumber").val(),
             documentNumber: $("#documentNumber").val(),
             referenceType: $("#referenceType").val(),
             serviceType: $("#serviceType").val(),
             documentType: $("#documentType").val(),
             documentClass: $("#documentClass").val(),
             documentSubType1: $("#documentSubType1").val(),
             documentSubType2: $("#documentSubType2").val(),
             expiryDate: $("#expiryDate").val(),
             cwtFlag: $("input[name='cwtFlag']:checked").val()
             }*/
            break;
    }

    /*
    if (documentTypeLocal == "FOREIGN"
        && documentClassLocal == "LC"
        && serviceTypeLocal == "Amendment") {
        params = {
            chargeType: "BC",
            charge: "bankCommission",
            amount: $("#bankCommissionLCAmountPopup").val(),
            bankCommissionNumerator: bankComPercentageNumeratorLocal,
            bankCommissionDenominator: bankComPercentageDenominatorLocal,
            bankCommissionPercentage: bankComPercentageLocal,
            tradeServiceId: $("#tradeServiceId").val(),
            etsNumber: $("#etsNumber").val(),
            documentNumber: $("#documentNumber").val(),
            referenceType: $("#referenceType").val(),
            serviceType: $("#serviceType").val(),
            documentType: $("#documentType").val(),
            documentClass: $("#documentClass").val(),
            documentSubType1: $("#documentSubType1").val(),
            documentSubType2: $("#documentSubType2").val(),
            expiryDate: $("#expiryDate").val(),
            cwtFlag: $("input[name='cwtFlag']:checked").val(),
            tenorSwitch: $("#tenorSwitch").val(),
            amountSwitch: $("#amountSwitch").val(),
            lcAmountFlagDisplay: $("#lcAmountFlag").val(),
            expiryDateSwitchDisplay: $("#expiryDateSwitch").val(),
            expiryDateFlag: $("#expiryDateFlag").val(),
            confirmationInstructionsFlagSwitch: $("#confirmationInstructionsFlagSwitch").val(),
            outstandingBalance: $("#outstandingBalance").val(),
            amountTo: amountToLocal,
            expiryDateModifiedDays: $("#expiryDateModifiedDays").val(),
            expiryDateTo: $("#expiryDateTo").val(),
            narrativeSwitchDisplay: $("#narrativeSwitch").val()
        }

    } else if (documentTypeLocal == "DOMESTIC"
        && documentClassLocal == "LC"
        && serviceTypeLocal == "Amendment") {
        params = {
            chargeType: "BC",
            charge: "bankCommission",
            amount: $("#bankCommissionLCAmountPopup").val(),
            bankCommissionNumerator: bankComPercentageNumeratorLocal,
            bankCommissionDenominator: bankComPercentageDenominatorLocal,
            bankCommissionPercentage: bankComPercentageLocal,
            tradeServiceId: $("#tradeServiceId").val(),
            etsNumber: $("#etsNumber").val(),
            documentNumber: $("#documentNumber").val(),
            referenceType: $("#referenceType").val(),
            serviceType: $("#serviceType").val(),
            documentType: $("#documentType").val(),
            documentClass: $("#documentClass").val(),
            documentSubType1: $("#documentSubType1").val(),
            documentSubType2: $("#documentSubType2").val(),
            expiryDate: $("#expiryDate").val(),
            cwtFlag: $("input[name='cwtFlag']:checked").val(),
            tenorSwitch: $("#tenorSwitch").val(),
            amountSwitch: $("#amountSwitch").val(),
            lcAmountFlagDisplay: $("#lcAmountFlag").val(),
            expiryDateSwitchDisplay: $("#expiryDateSwitch").val(),
            expiryDateFlag: $("#expiryDateFlag").val(),
            confirmationInstructionsFlagSwitch: $("#confirmationInstructionsFlagSwitch").val(),
            outstandingBalance: $("#outstandingBalance").val(),
            amountTo: amountToLocal,
            expiryDateModifiedDays: $("#expiryDateModifiedDays").val(),
            expiryDateTo: $("#expiryDateTo").val(),
            narrativeSwitchDisplay: $("#narrativeSwitch").val()
        }
    }
*/

    $.post(recomputeChargesUrl, params, function (data) {
        $("#bankCommissionPopupField ,#netBankCommission").val(formatCurrency(data.convertedamount ? data.convertedamount : data.BC));


        if(data['cwt'] && data['gross']){
            if($("input[name='cwtFlag']:checked").val()=="Y"){
                $("#bankComCwt").val(formatCurrency(data['cwt']));
                $("#grossBankCommission").val(formatCurrency(data['gross']));
            } else {
                $("#bankComCwt").val(formatCurrency("0.00"));
                $("#grossBankCommission").val(formatCurrency(netBankCom));
            }
        }
        
        if ((documentClass == "BC" && serviceType =="SETTLEMENT") || 
        		(documentClass == "BP" && serviceType =="NEGOTIATION")){

        	$("#bankComCwt").val(formatCurrency(data.bankComCwt));
        	$("#grossBankCommission").val(formatCurrency(data.bankComGross));
        }        
        
    })
}

function mirrorBankComPercentageNumerator2() {
    $("#bankComPercentageNumerator").val($("#bankComPercentageNumerator2").val());
}

function mirrorBankComPercentageDenominator2() {
    $("#bankComPercentageDenominator").val($("#bankComPercentageDenominator2").val());
}
function mirrorBankComPercentage2() {
    $("#bankComPercentage").val($("#bankComPercentage2").val());
}

function mirrorBankComNumberOfMonths2() {
    $("#bankComNumberOfMonths").val($("#bankComNumberOfMonths2").val());
}

function initializeBankCommission() {
    $("#edit_bank_commission").click(openBankCommissionPopup);
    $(".popupClose_bank_commission").click(closeBankCommissionPopup);
    $("#btnRecomputeBankCommission").click(recomputeBankCommission);

}

$(initializeBankCommission);