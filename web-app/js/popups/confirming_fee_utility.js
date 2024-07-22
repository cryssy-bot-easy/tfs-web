function opencommitmentFeePopup() {
	var confirmingFeeDefault = defaultValuesUrl;

	var confirmingFeePopupParamsHidden = JSON.stringify($("#confirmingFeePopupParamsHidden").val().replace(/=/g,"\"\:\"").replace(/\{/g,"\{\"").replace(/\}/g,"\"\}").replace(/,/g,"\"\,"))
    if($("#confirmingFeePopupParamsHidden").val()!=""&&JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageNumerator"]!=null && JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageNumerator"]!=""){
        $("#confirmFeePercentageNumerator").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageNumerator"]);
        $("#confirmFeePercentageNumerator2").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageNumerator"]);
    }

    if($("#confirmingFeePopupParamsHidden").val()!=""&& JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageDenominator"] !=null && JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageDenominator"]!=""){
        $("#confirmFeePercentageDenominator").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageDenominator"]);
        $("#confirmFeePercentageDenominator2").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentageDenominator"]);
    }

    if($("#confirmingFeePopupParamsHidden").val()!=""&& JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentage"]!=null && JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentage"]!="" ){
        $("#confirmFeePercentage").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentage"]);
        $("#confirmFeePercentage2").val(JSON.parse(confirmingFeePopupParamsHidden)["confirmFeePercentage"]);
    }


    loadPopup("confirmingFeePopup", "popupBackground_confirming_fee");
    centerPopup("confirmingFeePopup", "popupBackground_confirming_fee");
}

function closecommitmentFeePopup() {
    disablePopup("confirmingFeePopup", "popupBackground_confirming_fee");
}

function recomputeConfirmingFee() {


    var recomputeChargesUrl = recomputeUrl;

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var usdToPhpUrr = getUrr("USD");



	var params;
	switch (documentClass){
	case "DA": case "DP": case "OA": case "DR":
		params = {
        charge:"confirmingFee",
        productAmount:$("#confirmingFeeLCAmountPopup").val(),
        confirmingFeeNumerator:$("#confirmFeePercentageNumerator").val(),
        confirmingFeeDenominator:$("#confirmFeePercentageDenominator").val(),
        confirmingFeePercentage:$("#confirmFeePercentage").val(),
        tradeServiceId:$("#tradeServiceId").val(),
        etsNumber:$("#etsNumber").val(),
        documentNumber:$("#documentNumber").val(),
        referenceType:$("#referenceType").val(),
        serviceType:$("#serviceType").val(),
        documentType:$("#documentType").val(),
        documentClass:$("#documentClass").val(),
        expiryDate:$("#expiryDate").val()
	}
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
                chargeType: "CORRES-CONFIRMING",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: "0.0",
                productAmount: $("#confirmFeeLCAmountCurrency").val(),
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
                confirmingFeeNumerator: $("#confirmFeePercentageNumerator").val(),
                confirmingFeeDenominator: $("#confirmFeePercentageDenominator").val(),
                confirmingFeePercentage: $("#confirmFeePercentage").val(),
                currency: $("#currency").val(),
                settlementCurrency: $("#settlementCurrency").val(),
                expiryDate: $("#expiryDate").val(),
                confirmFeeNumberOfMonths: $("#confirmFeeNumberOfMonths").val()
            }
            break;

	default:
		params = {
		charge:"confirmingFee",
        amount:$("#confirmingFeeLCAmountPopup").val(),
        confirmingFeeNumerator:$("#confirmFeePercentageNumerator").val(),
        confirmingFeeDenominator:$("#confirmFeePercentageDenominator").val(),
        confirmingFeePercentage:$("#confirmFeePercentage").val(),
        tradeServiceId:$("#tradeServiceId").val(),
        etsNumber:$("#etsNumber").val(),
        documentNumber:$("#documentNumber").val(),
        referenceType:$("#referenceType").val(),
        serviceType:$("#serviceType").val(),
        documentType:$("#documentType").val(),
        documentClass:$("#documentClass").val(),
        documentSubType1:$("#documentSubType1").val(),
        documentSubType2:$("#documentSubType2").val(),
        expiryDate:$("#expiryDate").val()
		}
		break;
	}

    $.post(recomputeChargesUrl, params, function (data) {
        //$("#confirmingFeePopupField").val(data.result);
//        $("#confirmingFeePopupField ,#netBankCommission").val(formatCurrency(data.convertedamount ? data.convertedamount : data.BC));
        $("#confirmingFeePopupField").val(formatCurrency(data.convertedamount ? data.convertedamount : data['CORRES-CONFIRMING']));
    })
}

function initializeConfirmingFee() {
    $("#edit_confirming_fee").click(opencommitmentFeePopup);
    $(".popupClose_confirming_fee").click(closecommitmentFeePopup);

    $("#btnRecomputeConfirmingFee").click(recomputeConfirmingFee);
}

$(initializeConfirmingFee);