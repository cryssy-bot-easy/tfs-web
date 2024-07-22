function openconfirmingFeePopup() {
    $("#commitmentFeePopupField").val($("#CF").val());
    var commitmentFeeDefault = defaultValuesUrl;

    var commitmentFeePopupParamsHidden = JSON.stringify($("#commitmentFeePopupParamsHidden").val().replace(/=/g,"\"\:\"").replace(/\{/g,"\{\"").replace(/\}/g,"\"\}").replace(/,/g,"\"\,"))
    if($("#commitmentFeePopupParamsHidden").val()!=""&&JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageNumerator"]!=null && JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageNumerator"]!=""){
        $("#comFeePercentageNumerator").val(JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageNumerator"]);
    }

    if($("#commitmentFeePopupParamsHidden").val()!=""&& JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageDenominator"] !=null && JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageDenominator"]!=""){
        $("#comFeePercentageDenominator").val(JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentageDenominator"]);
    }

    if($("#commitmentFeePopupParamsHidden").val()!=""&& JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentage"]!=null && JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentage"]!="" ){
        $("#comFeePercentage").val(JSON.parse(commitmentFeePopupParamsHidden)["comFeePercentage"]);
    }



    loadPopup("commitmentFeePopup", "popupBackground_commitment_fee");
    centerPopup("commitmentFeePopup", "popupBackground_commitment_fee");
}

function closeconfirmingFeePopup() {
    disablePopup("commitmentFeePopup", "popupBackground_commitment_fee");
}

function recomputeCommitmentFee() {
	var defaultValue = getDefaultValues("CF");
	var params;

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();
    
    var usdToPhpUrr = getUrr("USD");
    
    var recomputeChargesUrl = recomputeUrl;
    
	switch (documentClass){
	case "DA": case "DP": case "OA": case "DR":
		recomputeChargesUrl = recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION_Url;
		params = {
		chargeType: "CF",
        tradeServiceId: $("#tradeServiceId").val(),
        productAmount: $("#commitmentFeeLCAmountPopup").val().toString(),
        cwtFlag: $("input[name='cwtFlag']:checked").val(),
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
		commitmentFeeNumerator: $("#comFeePercentageNumerator").val(),
        commitmentFeeDenominator: $("#comFeePercentageDenominator").val(),
        commitmentFeePercentage: $("#comFeePercentage").val(),
        currency: $("#currency").val(),
        settlementCurrency: $("#settlementCurrency").val(),
        comFeeNumberOfMonths: $("#comFeeNumberOfMonths").val()
		}
		/*params = {
		charge: "commitmentFee",
		productAmount: $("#commitmentFeeLCAmountPopup").val(),
        commitmentFeeNumerator: $("#comFeePercentageNumerator").val(),
        commitmentFeeDenominator: $("#comFeePercentageDenominator").val(),
        commitmentFeePercentage: $("#comFeePercentage").val(),
        tradeServiceId: $("#tradeServiceId").val(),
        etsNumber: $("#etsNumber").val(),
        documentNumber: $("#documentNumber").val(),
        referenceType: $("#referenceType").val(),
        serviceType: $("#serviceType").val(),
        documentType: $("#documentType").val(),
        documentClass: $("#documentClass").val(),
        expiryDate: $("#expiryDate").val()
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
            chargeType: "CF",
            tradeServiceId: $("#tradeServiceId").val(),
            amount: defaultValue.toString(),
            productAmount: $("#commitmentFeeLCAmountPopup").val(),
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
            commitmentFeeNumerator: $("#comFeePercentageNumerator").val(),
            commitmentFeeDenominator: $("#comFeePercentageDenominator").val(),
            commitmentFeePercentage: $("#comFeePercentage").val(),
            currency: $("#currency").val(),
            settlementCurrency: $("#settlementCurrency").val(),
            expiryDate: $("#expiryDate").val(),
            comFeeNumberOfMonths:$("#comFeeNumberOfMonths").val()
        }
        break;
	default:
		params = {
		charge: "commitmentFee",
		amount: $("#commitmentFeeLCAmountPopup").val(),
        commitmentFeeNumerator: $("#comFeePercentageNumerator").val(),
        commitmentFeeDenominator: $("#comFeePercentageDenominator").val(),
        commitmentFeePercentage: $("#comFeePercentage").val(),
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
        comFeeNumberOfMonths: $("#comFeeNumberOfMonths").val()

		}
		break;
	}
	
	$.post(recomputeChargesUrl,params,function(data){
		$("#commitmentFeePopupField").val(formatCurrency(data.convertedamount? data.convertedamount : data.CF));
	})
}

function initializeCommitmentFee() {
    $("#edit_commitment_fee").click(openconfirmingFeePopup);
    $(".popupClose_commitmentFee").click(closeconfirmingFeePopup);

    $("#btnRecomputeCommitmentFee").click(recomputeCommitmentFee);
}

$(initializeCommitmentFee);