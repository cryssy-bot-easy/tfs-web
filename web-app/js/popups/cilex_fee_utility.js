
/**
 * PROLOGUE
 * SCR/ER Description: To enable editing of Cilex charge
 *	[Revised by:] Jesse James Joson
 *	Program [Revision] Details: Correct the paramter to be passed in the computation of the charges
 *	Date deployment: 6/16/2016 
 *	Member Type: Javascript
 *	Project: Web
 *	Project Name: cilex_fee_utility.js 
*/

function openCilexFeePopup() {
    $("#cilexFeePopupField").val($("#CILEX").val());
    var cilexDefault = defaultValuesUrl;

    var cilexFeePopupParamsHidden = JSON.stringify($("#cilexFeePopupParamsHidden").val().replace(/=/g,"\"\:\"").replace(/\{/g,"\{\"").replace(/\}/g,"\"\}").replace(/,/g,"\"\,"))
    if($("#cilexFeePopupParamsHidden").val()!=""&&JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageNumerator"]!=null && JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageNumerator"]!=""){
        $("#cilexPercentageNumerator").val(JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageNumerator"]);
    }

    if($("#cilexFeePopupParamsHidden").val()!=""&& JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageDenominator"] !=null && JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageDenominator"]!=""){
        $("#cilexPercentageDenominator").val(JSON.parse(cilexFeePopupParamsHidden)["cilexPercentageDenominator"]);
    }

    if($("#cilexFeePopupParamsHidden").val()!=""&& JSON.parse(cilexFeePopupParamsHidden)["cilexPercentage"]!=null && JSON.parse(cilexFeePopupParamsHidden)["cilexPercentage"]!="" ){
        $("#cilexPercentage").val(JSON.parse(cilexFeePopupParamsHidden)["cilexPercentage"]);
    }


    loadPopup("cilexFeePopup", "popupBackground_cilex_fee");
    centerPopup("cilexFeePopup", "popupBackground_cilex_fee");
}

function closeCilexFeePopup() {
    disablePopup("cilexFeePopup", "popupBackground_cilex_fee");
}

function recomputeCilexFee() {
	var defaultValue = getDefaultValues("CILEX");
    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();
    
    var usdToPhpUrr = getUrr("USD");

    var recomputeChargesUrl = recomputeUrl;

    console.log("thirdToUsdSpecialConversionRateCurrency: "+ $("#USD-PHP_text_special_rate").val());
    console.log("thirdToUsdSpecialConversionRateSettlementCurrency: "+ $("#EUR-USD_text_special_rate").val());
    
	var params;
	switch (documentClass){
	case "DA": case "DP": case "OA": case "DR":
		recomputeChargesUrl = recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION_Url;
		params = {
		chargeType: "CILEX",
        tradeServiceId: $("#tradeServiceId").val(),
        amount: defaultValue.toString(),
        productAmount: $("#cilexLCAmountPopup").val().toString(),
        cwtFlag: $("input[name='cwtFlag']:checked").val(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        cilexNumerator: $("#cilexPercentageNumerator").val(),
        cilexDenominator: $("#cilexPercentageDenominator").val(),
        cilexPercentage: $("#cilexPercentage").val(),
        currency: $("#currency").val(),
        settlementCurrency: $("#settlementCurrency").val()
		}
		/*params = {
        charge: "cilexFee",
        productAmount: $("#cilexLCAmountPopup").val(),
        cilexNumerator: $("#cilexPercentageNumerator").val(),
        cilexDenominator: $("#cilexPercentageDenominator").val(),
        cilexPercentage: $("#cilexPercentage").val(),
        tradeServiceId: $("#tradeServiceId").val(),
        etsNumber: $("#etsNumber").val(),
        documentNumber: $("#documentNumber").val(),
        referenceType: $("#referenceType").val(),
        serviceType: $("#serviceType").val(),
        documentType: $("#documentType").val(),
        documentClass: $("#documentClass").val(),
        documentSubType1: $("#documentSubType1").val(),
        documentSubType2: $("#documentSubType2").val(),
        expiryDate: $("#expiryDate").val()
    }*/
		break;
        case "LC":
            if(serviceType =="OPENING")   {
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if(documentType == "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            } else if(serviceType =="NEGOTIATION"){
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url;
                } else if(documentType == "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url;
                }
            } else {
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if(documentType == "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            }
            params = {
                chargeType: "CILEX",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: defaultValue.toString(),
                productAmount: $("#cilexLCAmountPopup").val().toString(),
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
                cilexNumerator: $("#cilexPercentageNumerator").val(),
                cilexDenominator: $("#cilexPercentageDenominator").val(),
                cilexPercentage: $("#cilexPercentage").val(),
                currency: $("#currency").val(),
                settlementCurrency: $("#settlementCurrency").val(),
                expiryDate: $("#expiryDate").val()
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
                    chargeType: "CILEX",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: $("#cilexLCAmountPopup").val().toString(),
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
                    cilexNumerator: $("#cilexPercentageNumerator").val(),
                    cilexDenominator: $("#cilexPercentageDenominator").val(),
                    cilexPercentage: $("#cilexPercentage").val(),
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
                    chargeType: "CILEX",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: $("#cilexLCAmountPopup").val().toString(),
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
                    cilexNumerator: $("#cilexPercentageNumerator").val(),
                    cilexDenominator: $("#cilexPercentageDenominator").val(),
                    cilexPercentage: $("#cilexPercentage").val(),
                    currency: $("#currency").val(),
                    settlementCurrency: $("#settlementCurrency").val(),
                    expiryDate: $("#lcExpiryDate").val(),
                    chargesOverridenFlag: "N"
                }
        	break;
	default:
        if(serviceType =="OPENING")   {
            if(documentType == "FOREIGN"){
                recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
            } else if(documentType == "DOMESTIC"){
                recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
            }
        } else if(serviceType =="NEGOTIATION"){
            if(documentType == "FOREIGN"){
                recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url;
            } else if(documentType == "DOMESTIC"){
                recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url;
            }
        } else {
            if(documentType == "FOREIGN"){
                recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
            } else if(documentType == "DOMESTIC"){
                recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
            }
        }
        params = {
            chargeType: "CILEX",
            tradeServiceId: $("#tradeServiceId").val(),
            amount: defaultValue.toString(),
            productAmount: $("#cilexLCAmountPopup").val().toString(),
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
            cilexNumerator: $("#cilexPercentageNumerator").val(),
            cilexDenominator: $("#cilexDenominator").val(),
            cilexPercentage: $("#cilexPercentagePercentage").val(),
            currency: $("#currency").val(),
            settlementCurrency: $("#settlementCurrency").val(),
            expiryDate: $("#expiryDate").val()
        }
		break;
	}
    $.post(recomputeChargesUrl,params,function(data){
        $("#cilexFeePopupField, #cilexNet").val(formatCurrency(data.convertedamount ? data.convertedamount : data.CILEX));
                
        if ((documentClass == "BC" && serviceType =="SETTLEMENT") || 
        		(documentClass == "BP" && serviceType =="NEGOTIATION")){

        	$("#cilexCwt").val(formatCurrency(data.cilexCwt));
        	$("#grossCilex").val(formatCurrency(data.cilexGross));
        }
    })
}

function initializeCilexFee() {
    $("#edit_cilex_fee").click(openCilexFeePopup);
    $(".popupClose_cilex_fee").click(closeCilexFeePopup);

    $("#btnRecomputeCilexFee").click(recomputeCilexFee);
}

$(initializeCilexFee);