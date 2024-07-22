/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/20/2018
	Program [Revision] Details:
		- Updated value of centavos field.
		- Updated some conditions and value on recomputeDocumentaryStamp method.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: documentary_stamp_utility.js
 
 */
/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/21/2018
	Program [Revision] Details:
		- added forFirstAmount and forNextAmount parameter on recomputeDocumentaryStamp.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: documentary_stamp_utility.js
 
 */
/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 04/13/2018
	Program [Revision] Details: Added parameters passed for computation and updated setting of value documentaryStampPhp.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: documentary_stamp_utility.js
 
 */
/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 04/20/2018
	Program [Revision] Details: Updated currency passed on getting rates.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: documentary_stamp_utility.js
 
 */

function openDocumentaryStampPopup() {
    $("#documentaryStampPopupField").val($("#DOCSTAMPS").val());
    var documentaryStampDefault = defaultValuesUrl;
//    $.post(documentaryStampDefault,{},function(data){
//    	$("#centavos").val(data["docStampsAmountPer"]);
//	});
    var documentaryStampPopupParamsHidden = JSON.stringify($("#documentaryStampPopupParamsHidden").val().replace(/=/g,"\"\:\"").replace(/\{/g,"\{\"").replace(/\}/g,"\"\}").replace(/,/g,"\"\,"))
	if ($('#centavosPopup').val() !== null) {
		$("#centavos").val($('#centavosPopup').val());
	} else if($("#documentaryStampPopupParamsHidden").val()!=""&&JSON.parse(documentaryStampPopupParamsHidden)["centavos"]!=null && JSON.parse(documentaryStampPopupParamsHidden)["centavos"]!=""){
		$("#centavos").val(JSON.parse(documentaryStampPopupParamsHidden)["centavos"]);
    }

    loadPopup("documentaryStampPopup", "popupBackground_doc_stamp");
    centerPopup("documentaryStampPopup", "popupBackground_doc_stamp");
}

function closeDocumentaryStampPopup() {
    disablePopup("documentaryStampPopup", "popupBackground_doc_stamp");
}

function recomputeDocumentaryStamp() {
	var defaultValue = getDefaultValues("DOCSTAMPS");
	var currency = $("#currency").val();

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var usdToPhpUrr = getUrr("USD");
    
    var recomputeChargesUrl = recomputeUrl;
    
	var params;
	switch (documentClass){
	case "DA": case "DP": case "OA": case "DR":
		recomputeChargesUrl = recomputeCurrency_NON_LC_SETTLEMENT_EDIT_COMPUTATION_Url;
		params = {
		chargeType: "DOCSTAMPS",
        tradeServiceId: $("#tradeServiceId").val(),
        amount: defaultValue.toString(),
        productAmount: defaultValue.toString(),
        documentType:$("#documentType").val(),
        TR_LOAN_FLAG: $("#TR_LOAN_FLAG").val(),
        cwtFlag: $("input[name='cwtFlag']:checked").val(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: $("#currency").val(),
        settlementCurrency: $("#settlementCurrency").val(),
        centavos: $("#centavos").val(),
        forFirst: $("#documentaryStampForFirst").val(),
        forNext: $("#documentaryStampForNextPopup").val(),
        forFirstAmount: $("#documentaryStampForFirstAmountPopup").val(),
        forNextAmount: $("#documentaryStampAmountForNextAmountPopup").val(),
        settlementMode: $("#settlementMode").val()
		}
		/*params = {
    	charge: "documentaryStamp",
    	productAmount: $("#documentaryStampLCAmountPopup").val(),
    	centavos: $("#centavos").val(),
    	forEvery200: $("#forEvery200").val()
	}*/
		break;
        case "LC":
            if(serviceType.toUpperCase() === "OPENING")   {
                if(documentType === "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if(documentType === "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            } else if(serviceType.toUpperCase() === "NEGOTIATION"){
                currency = $('#negotiationCurrency').val();
                if(documentType === "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url;
                    thirdToUsdSpecialConversionRateCurrency = stripCommas($("#" + currency + "-USD_special_rate_charges").val());
                } else if(documentType === "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url;
                }
            } else if(serviceType.toUpperCase() === "UA LOAN SETTLEMENT"){
                if(documentType === "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url;
                } else if(documentType === "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url;
                }
            } else if(serviceType.toUpperCase() === "AMENDMENT"){
                if(documentType === "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION_Url;
                } else if(documentType === "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION_Url;
                    currency = $('#negotiationCurrency').val();
                }
            } else {
                if(documentType === "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url;
                } else if(documentType === "DOMESTIC"){
                    recomputeChargesUrl = recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url;
                }
            }

            params = {
                chargeType: "DOCSTAMPS",
                tradeServiceId: $("#tradeServiceId").val(),
                amount: defaultValue.toString(),
                productAmount: defaultValue.toString(),
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
                currency: currency,
                settlementCurrency: $("#settlementCurrency").val(),
                centavos: $("#centavos").val(),
                forFirst: $("#documentaryStampForFirst").val(),
                forNext: $("#documentaryStampForNextPopup").val(),
                forFirstAmount: $("#documentaryStampForFirstAmountPopup").val(),
                forNextAmount: $("#documentaryStampAmountForNextAmountPopup").val()
            }
            console.log(params);
            break;
        case "BP":
        	if(serviceType =="NEGOTIATION"){
                if(documentType == "FOREIGN"){
                    recomputeChargesUrl = recomputeCurrency_BP_FOREIGN_NEGOTIATION_Url;
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
                    chargeType: "DOCSTAMPS",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: defaultValue.toString(),
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
                    currency: $("#currency").val(),
                    settlementCurrency: $("#settlementCurrency").val(),
                    centavos: $("#centavos").val()
                }
        	break;
        case "BC":
        	if(serviceType =="SETTLEMENT"){
        		if(documentType == "FOREIGN"){
        			recomputeChargesUrl = recomputeCurrency_BC_FOREIGN_SETTLEMENT_Url;
        		} else if(documentType == "DOMESTIC"){
        			recomputeChargesUrl = recomputeCurrency_BC_DOMESTIC_SETTLEMENT_Url;
        		}
        	}
        	params = {
                    chargeType: "DOCSTAMPS",
                    tradeServiceId: $("#tradeServiceId").val(),
                    amount: defaultValue.toString(),
                    productAmount: defaultValue.toString(),
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
                    currency: $("#currency").val(),
                    settlementCurrency: $("#settlementCurrency").val(),
                    centavos: $("#centavos").val()
                }
        	break;
	default:
		params = {
        chargeType: "DOCSTAMPS",
        tradeServiceId: $("#tradeServiceId").val(),
        amount: defaultValue.toString(),
        productAmount: $("#documentaryStampLCAmountPopup").val(),
    	centavos: $("#centavos").val(),
    	forEvery200: $("#forEvery200").val(),
        currency: $("#currency").val(),
        settlementCurrency: $("#settlementCurrency").val(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr
		}

        if (documentClass === 'INDEMNITY' && serviceType === 'Issuance') {
            recomputeChargesUrl = recomputeCurrency_LC_FOREIGN_INDEMNITY_ISSUANCE_Url;
        }
		break;
	}
	$.post(recomputeChargesUrl,params,function(data){
		console.log('SAHDHDB G BCXGF BXKJGZNBX  BX ZXJ CN ');
		console.log(data);
		$("#documentaryStampPhp").val(formatCurrency(data.DOCSTAMPSoriginal ? data.DOCSTAMPSoriginal : (data.convertedamount ? data.convertedamount : data.DOCSTAMPS)));
		$("#documentaryStampPopupField").val(formatCurrency(data.convertedamount ? data.convertedamount : data.DOCSTAMPS));
	})
}

function initializeDocumentaryStamp() {
    $("#edit_documentary_stamp").click(openDocumentaryStampPopup);
    $(".popupClose_documentaryStamp").click(closeDocumentaryStampPopup);

    $("#btnRecomputeDocumentaryStamp").click(recomputeDocumentaryStamp);
}

$(initializeDocumentaryStamp); //TODO: Update Formulas