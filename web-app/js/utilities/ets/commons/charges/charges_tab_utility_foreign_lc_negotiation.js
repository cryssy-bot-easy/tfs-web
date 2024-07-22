var currency = $("#currency").val();
var settlementCurrency = $("#settlementCurrency").val();

function getRateCurrency() {
    if (settlementCurrency != "") {
        if (currency == settlementCurrency) {
            return settlementCurrency;
        } else {
            return settlementCurrency + " TO " + 'PHP';
        }
    } else {
        return "";
    }
}

function setupCashLcCurrencies() {
    $("#totalAmountDueLcCurrency").val(currency);
}

//for special rates THIRD-USD
function getThirdToUSDSpecialConversionRate(settlementCurrency) {

    if (settlementCurrency == 'PHP') {
        return "0";
    } else if (settlementCurrency == 'USD') {
        return "0";
    } else {
        return stripCommas($("#" + settlementCurrency + "-USD_special_rate_charges").val());
    }
}


//for pass on rate
function getThirdToUsdPassOnConversionRate(currency) {
    if (currency == 'PHP') {
        return "0";
    } else if (currency == 'USD') {
        return "0";

    } else {
        return $("#" + currency + "-USD_pass_on_rate_charges").val()
    }
}


//for special rate
function getUsdToPhpSpecialConversionRate() {
    return $("#USD-PHP_special_rate_charges").val()
}

//for pass on rate
function getUsdToPhpPassOnConversionRate() {
    return $("#USD-PHP_pass_on_rate_charges").val()
}

//for pass on rate
function getUrr(currency) {
    if (currency == 'PHP') {
        return 1;
    } else if (currency == 'USD') {
        return $("#USD-PHP_urr").val();
    } else {
        return $("#USD-PHP_urr").val();
    }
}


// setup values of charges fee in popup
function setupCharges(settlementCurrency) {

    $("#DOCSTAMPS").val("");
    $("#CABLE").val("");
    $("#NOTARIAL").val("");
    $("#CF").val("");
    $("#CILEX").val("");

    var negotiationCurrency = $("#negotiationCurrency").val();
    var thirdToUsdSpecialConversionRateCurrency = stripCommas($("#" + negotiationCurrency + "-USD_special_rate_charges").val());
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();
    var usdToPhpUrr = getUrr("USD");


    var tradeServiceId = $("#tradeServiceId").val();
    var usancePeriod = $("#usancePeriod").val();
    if (!usancePeriod) {
        usancePeriod = "0";
    }

    $.post(recomputeCurrency_LC_FOREIGN_NEGOTIATION_Url, {
        tradeServiceId: tradeServiceId,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: negotiationCurrency,
        productCurrency: negotiationCurrency,
        chargeSettlementCurrency: settlementCurrency,
        settlementCurrency: settlementCurrency}, function (data) {
        $("#DOCSTAMPS").val(formatCurrency(data.DOCSTAMPS));
        $("#CABLE").val(formatCurrency(data.CABLE));
        $("#NOTARIAL").val(formatCurrency(data.NOTARIAL));
        $("#CILEX").val(formatCurrency(data.CILEX));
        $("#CF").val(formatCurrency(data.CF));

        $("#totalAmountCharges, #totalAmountDue").val(formatCurrency(data.TOTAL));

        $("#DOCSTAMPSoriginal").val(formatCurrency(data.DOCSTAMPSoriginal));
        $("#CABLEoriginal").val(formatCurrency(data.CABLEoriginal));
        $("#NOTARIALoriginal").val(formatCurrency(data.NOTARIALoriginal));
        $("#CILEXoriginal").val(formatCurrency(data.CILEXoriginal));
        $("#CForiginal").val(formatCurrency(data.CForiginal));

        $("#CFnocwtAmount").val(formatCurrency(data.CFnocwtAmount));
        $("#CILEXnocwtAmount").val(formatCurrency(data.CILEXnocwtAmount));


        // compute balance and excess
        $.post(computeBalanceUrl, {totalAmountDue: $("#totalAmountDue").val(), totalAmount: 0}, function (data2) {
            $("#remainingBalance").val(formatCurrency(data2.balance));
            $("#excessAmountCharges").val(formatCurrency(data2.excess));
            updateRemainingBalance();
        })
    });


    $("#CILEXCurrency").val(settlementCurrency);
    $("#NOTARIALCurrency").val(settlementCurrency);
    $("#DOCSTAMPSCurrency, #documentaryStampPopupFieldCurrency").val(settlementCurrency);
    $("#CILEXCurrency, #cilexPopupFieldCurrency").val(settlementCurrency);

    $("#NOTARIALCurrency, #notarialPopupFieldCurrency").val(settlementCurrency);
    $("#CFCurrency").val(settlementCurrency);

    $("#CABLECurrency, #cablePopupFieldCurrency").val(settlementCurrency);
    $("#cilexFeePopupFieldCurrency, #cilexNetBankComCurrency, #cilexCWTCurrency, #cilexGrossBankComCurrency").val(settlementCurrency);
    $("#notarialFeePopupFieldCurrency").val(settlementCurrency);


    $("#CABLECurrency").text(settlementCurrency);
    $("#DOCSTAMPSCurrency").text(settlementCurrency);
    $("#NOTARIALCurrency").text(settlementCurrency);
    $("#CILEXCurrency").text(settlementCurrency);
    $("#CFCurrency").text(settlementCurrency);



}

// setup values in charges payment tab
function setupChargesPaymentCurrency(settlementCurrency) {
    if ($("#totalAmtDueCurrency").length > 0) {
        $("#totalAmtDueCurrency").text(settlementCurrency);
    }
    if ($("#remainingBalanceCurrency").length > 0) {
        $("#remainingBalanceCurrency").text(settlementCurrency);
    }
    if ($("#amountOfPaymentChargesSettlementCurrency").length > 0) {
        $("#amountOfPaymentChargesSettlementCurrency").text(settlementCurrency);
    }
    updateTotals();

//    $("#totalAmtDueCurrency, #remainingBalanceCurrency, #amountOfPaymentChargesSettlementCurrency").text(settlementCurrency);
}

// setup charges popup
function setupChargesPopup() {
    var input = $(activePopup);

    var parameters = new Object();
    // obtains all inputs inside active popup
    for (var idx = 0; idx < input.length; idx++) {
        if (input[idx].id.indexOf("Currency") == -1 && $(input[idx]).attr("type") != "button") {
            parameters[input[idx].id] = $("#" + input[idx].id).val();
        }
    }

    // used for charges popups
    var jsonString = JSON.stringify(parameters);

    // sets value of hidden for popup parameters
    $("#" + activePopupDiv + "Params").val(jsonString);

    var fieldId = activePopupDiv.substring(0, activePopupDiv.indexOf("Popup"));
    $("#" + fieldId + "PopupParamsHidden").val(jsonString);
    var translatedFieldId = convertToFieldId(fieldId);

    // sets value in textfields of active popup
//    $("#" + fieldId).val($("#" + activePopupDiv + "Field").val());
    $("#" + translatedFieldId).val($("#" + activePopupDiv + "Field").val());
    $("#" + translatedFieldId+"overridenFlag").val("Y");
    // closes active popup
    disablePopup(activePopupDiv, activePopupBg);

    //get charges amounts
    var amounts = constructAmountList();
    var timeoutID = window.setTimeout(updateTotals, 2000);


}

function constructAmountList() {
    var amounts = [];

    if ($("#BC").val() != undefined) {
        amounts.push($("#BC").val().replace(/,/g, "*"));
    }
    if ($("#CF").val() != undefined) {
        amounts.push($("#CF").val().replace(/,/g, "*"));
    }
    if ($("#CILEX").val() != undefined) {
        amounts.push($("#CILEX").val().replace(/,/g, "*"));
    }
    if ($("#NOTARIAL").val() != undefined) {
        amounts.push($("#NOTARIAL").val().replace(/,/g, "*"));
    }
    if ($("#CABLE").val() != undefined) {
        amounts.push($("#CABLE").val().replace(/,/g, "*"));
    }
    if ($("#CORRES-ADVISING").val() != undefined) {
        amounts.push($("#CORRES-ADVISING").val().replace(/,/g, "*"));
    }
    if ($("#CORRES-CONFIRMING").val() != undefined) {
        amounts.push($("#CORRES-CONFIRMING").val().replace(/,/g, "*"));
    }
    return amounts;
}

function getDefaultValues(chargeId) {
    var defaultAmount = 0;

    var chargesList = stringToListHashMap(chargesString);

    for (var i in chargesList) {
        if (chargesList[i]["CHARGEID"] == chargeId/* && chargesList[i]["CURRENCY"] == currency*/) {
            defaultAmount = chargesList[i]["DEFAULTAMOUNT"];
        }
    }

    return formatCurrency(defaultAmount);
}

function setCurrency(settlementCurrency) {
    if ($("#BCCurrency").length > 0) {
        $("#BCCurrency").text(settlementCurrency);
    }

    if ($("#CABLECurrency").length > 0) {
        $("#CABLECurrency").text(settlementCurrency);
    }

    if ($("#DOCSTAMPSCurrency").length > 0) {
        $("#DOCSTAMPSCurrency").text(settlementCurrency);
    }

    if ($("#CFCurrency").length > 0) {
        $("#CFCurrency").text(settlementCurrency);
    }

    if ($("#SUPCurrency").length > 0) {
        $("#SUPCurrency").text(settlementCurrency);
    }

    if ($("#CILEXCurrency").length > 0) {
        $("#CILEXCurrency").text(settlementCurrency);
    }

    if ($("#NOTARIALCurrency").length > 0) {
        $("#NOTARIALCurrency").text(settlementCurrency);
    }

    if ($("#CORRES-ADVISINGCurrency").length > 0) {
        $("#CORRES-ADVISINGCurrency").text(settlementCurrency);
    }

    if ($("#CORRES-CONFIRMINGCurrency").length > 0) {
        $("#CORRES-CONFIRMINGCurrency").text(settlementCurrency);
    }

    if ($("#totalAmountChargesCurrency").length > 0) {
        $("#totalAmountChargesCurrency").text(settlementCurrency);
    }

}

function resetCurrencyField() {
    if ($("#BC").length > 0) {
        $("#BC").val("");
    }

    if ($("#CF").length > 0) {
        $("#CF").val("");
    }

    if ($("#NOTARIAL").length > 0) {
        $("#NOTARIAL").val("");
    }

    if ($("#CILEX").length > 0) {
        $("#CILEX").val("");
    }

    if ($("#CABLE").length > 0) {
        $("#CABLE").val("");
    }

    if ($("#CORRES-CONFIRMING").length > 0) {
        $("#CORRES-CONFIRMING").val("");
    }

    if ($("#CORRES-ADVISING").length > 0) {
        $("#CORRES-ADVISING").val("");
    }


    if ($("#SUP").length > 0) {
        $("#SUP").val("");
    }

    if ($("#totalAmountCharges").length > 0) {
        $("#totalAmountCharges").val("");
    }

}

function onSettlementCurrencyChange() {
    settlementCurrency = $("#settlementCurrency").val();
    currency = $("#savedCurrency").val();

    // clears values of charges tab amounts if settlement currency is blank
    if (settlementCurrency == "") {
        resetCurrencyField();
    } else {

        // setup values in charges tab currency
        setCurrency(settlementCurrency);

        // setup popup values
        setupCharges(settlementCurrency)
        setupChargesPaymentCurrency(settlementCurrency);
    }

    var withFXinCASHLC = checkForOtherCurrency();
    var totalAmount = 0;
    var chargesList = stringToListHashMap(chargesString);

    // compute total charges
    $("#totalAmountCharges, #totalAmountDue").val("0.00");
}


function updateTotals() {
    //get charges amounts
    var amounts = constructAmountList();

    $.post(computeTotalUrl, {amounts: amounts.toString()}, function (data) {
        $("#totalAmountCharges, #totalAmountDue").val(formatCurrency(data.totalAmount));

        // compute balance and excess
        $.post(computeBalanceUrl, {totalAmountDue: $("#totalAmountDue").val(), totalAmount: 0}, function (data2) {
            $("#remainingBalance").val(formatCurrency(data2.balance));
            $("#excessAmountCharges").val(formatCurrency(data2.excess));
            updateRemainingBalance();
        })
    })
}

//show / hide corres charges
function onChangeCorresCharges() {
    var advanceCorresCharges = $("input[name=advanceCorresChargesFlag]:checked").val();

    if (advanceCorresCharges == "Y") {
        $(".corres_hide").show();
        $("#CORRES-ADVISING, #advisingFeePopupParams, #CORRES-CONFIRMING, #confirmingFeePopupParams").attr("disabled", false);
    } else {
        $(".corres_hide").hide();
        $("#CORRES-ADVISING, #advisingFeePopupParams, #CORRES-CONFIRMING, #confirmingFeePopupParams").attr("disabled", "disabled");
    }
}

function onRecoumputeCharge() {
    var special_rate = new Array();
    for (var i = 0; i < 30; i++) {
        if ($("#special_rate" + i).length > 0) {
            special_rate[i] = $("#special_rate" + i).val()
        }
    }

    $.post(chargeRecomputeUrl, {special_rate: special_rate}, function (data) {
    });
}

function hideForeignExchangeRates() {
    $(".foreign_exchange td.rates").each(function () {
        if ($(this).text() != 'USD-PHP') {
            $(this).parents("tr").hide();
            $(this).parents("tr").children("td").children("input").attr("disabled", "disabled");
        }
    });

    $("form#chargesTabForm .foreign_exchange td.rates").each(function () {
        if ($(this).text() != 'USD-PHP') {
            $(this).parents("tr").hide();
            $(this).parents("tr").children("td").children("input").attr("disabled", "disabled");
        }
    })
}

function loadForeignExchangeRates() {
    hideForeignExchangeRates();

    if ($("#settlementCurrency").val() != 'PHP' && $("#settlementCurrency").val() != 'USD' && $("#settlementCurrency").val() != "") {

        $("form#chargesTabForm .foreign_exchange td.rates").each(function () {
            if ($(this).text() != 'USD-PHP' && $(this).text().indexOf($("#settlementCurrency").val()) != -1) {
                $(this).parents("tr").show();
                $(this).parents("tr").children("td").children("input").removeAttr("disabled");
            }
        });
    } else if (( $("#settlementCurrency").val() == 'USD' ) && ($("#currency").val() != 'PHP' && $("#currency").val() != 'USD'  )) {

        if ($("#currency").val() != "USD") {
            $("form#chargesTabForm .foreign_exchange td.rates").each(function () {
                if ($(this).text() != 'USD-PHP' && $(this).text().indexOf($("#currency").val()) != -1) {
                    $(this).parents("tr").show();
                    $(this).parents("tr").children("td").children("input").removeAttr("disabled");
                }
            });
        }
    } else if (( $("#settlementCurrency").val() == 'PHP' ) && ($("#currency").val() != 'PHP' && $("#currency").val() != 'USD'  )) {

        if ($("#currency").val() != "USD" && $("#currency").val() != "PHP") {
            $("form#chargesTabForm .foreign_exchange td.rates").each(function () {
                if ($(this).text() != 'USD-PHP' && $(this).text().indexOf($("#currency").val()) != -1) {
                    $(this).parents("tr").show();
                    $(this).parents("tr").children("td").children("input").removeAttr("disabled");
                }
            });
        }
    }


}

// init function
function initializeChargesTabUtility() {
    // hideZeroCharges();

    if (documentType == 'DOMESTIC') {
        onSettlementCurrencyChange(); // this must be called to assign currency on load for domestic
    }
    $("#settlementCurrency").change(function () {
//    	loadForeignExchangeRates();
        onSettlementCurrencyChange();
    });
    //hideForeignExchangeRates();
//    loadForeignExchangeRates();

    $(".chargesPopupBtn").click(setupChargesPopup);
    $(".recompute_charge").click(onRecoumputeCharge)

    $("input[name^=text_special_rate], input[name^=text_pass_on_rate]").each(function () {
        $(this).autoNumeric({mDec: 6});
    });

    // alternative to submitToRemote since the submitToRemote is required to be inside a form and since cash_lc_payment_tab
    // is already in a form, the added settlement modes are disregarded thus the added settlement modes are not saved.
    $("#recomputeChargeBtn").click(onRecomputeChargeBtnClick);
    $("#recomputeSumBtn").click(onRecomputeSumBtnClick);
    //var timeoutID = window.setTimeout(updateTotals, 600);//onRecomputeChargeBtnClick(); // must be called to compute total payments made


}

function onRecomputeSumBtnClick() {
    var timeoutID = window.setTimeout(updateTotals, 200);
}

function onRecomputeChargeBtnClick() {
    var params = {};
    $("form#chargesTabForm .foreign_exchange :input").each(function () {
        if (($(this).attr("name").indexOf($("#settlementCurrency").val()) != -1 || $(this).attr("name").indexOf("USD-PHP") != -1) && $(this).attr("name").indexOf("text") != -1) {
            params[$(this).attr("name")] = $(this).val();
        }
    })

    params["passOnRateConfirmedBy"] = $("#passOnRateConfirmedBy").val();
    var postUrl = recomputeChargesPostUrl;

    $.post(postUrl, params, function (data) {
        assignData(data);
        onSettlementCurrencyChange();
    });
}

function assignData(data) {
    var settlementCurrency = $("#settlementCurrency").val();
    $("#" + settlementCurrency + "-USD_pass_on_rate_charges").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate"]);
    $("." + settlementCurrency + "-USD_pass_on_rate_charges").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate"]);
    $("#" + settlementCurrency + "-USD_special_rate_charges").val(data["special"][settlementCurrency + "-USD_special_rate"]);
    $("." + settlementCurrency + "-USD_special_rate_charges").val(data["special"][settlementCurrency + "-USD_special_rate"]);
    $("#" + settlementCurrency + "-PHP_pass_on_rate_charges").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate"]);
    $("." + settlementCurrency + "-PHP_pass_on_rate_charges").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate"]);
    $("#" + settlementCurrency + "-PHP_special_rate_charges").val(data["special"][settlementCurrency + "-PHP_special_rate"]);
    $("." + settlementCurrency + "-PHP_special_rate_charges").val(data["special"][settlementCurrency + "-PHP_special_rate"]);

    $("#" + settlementCurrency + "-USD_pass_on_rate_charges_urr").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate_urr"]);
    $("." + settlementCurrency + "-USD_pass_on_rate_charges_urr").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate_urr"]);
    $("#" + settlementCurrency + "-USD_special_rate_charges_urr").val(data["special"][settlementCurrency + "-USD_special_rate_urr"]);
    $("." + settlementCurrency + "-USD_special_rate_charges_urr").val(data["special"][settlementCurrency + "-USD_special_rate_urr"]);
    $("#" + settlementCurrency + "-PHP_pass_on_rate_charges_urr").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate_urr"]);
    $("." + settlementCurrency + "-PHP_pass_on_rate_charges_urr").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate_urr"]);
    $("#" + settlementCurrency + "-PHP_special_rate_charges_urr").val(data["special"][settlementCurrency + "-PHP_special_rate_urr"]);
    $("." + settlementCurrency + "-PHP_special_rate_charges_urr").val(data["special"][settlementCurrency + "-PHP_special_rate_urr"]);
    $("#USD-PHP_pass_on_rate_charges").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
    $(".USD-PHP_pass_on_rate_charges").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
    $("#USD-PHP_special_rate_charges").val(data["special"]["USD-PHP_special_rate"]);
    $(".USD-PHP_special_rate_charges").val(data["special"]["USD-PHP_special_rate"]);

    $("#USD-PHP_pass_on_rate_charges_urr").val(data["pass-on"]["USD-PHP_pass_on_rate_urr"]);
    $(".USD-PHP_pass_on_rate_charges_urr").val(data["pass-on"]["USD-PHP_pass_on_rate_urr"]);
    $("#USD-PHP_special_rate_charges_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
    $(".USD-PHP_special_rate_charges_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
    $("#USD-PHP_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
    $(".USD-PHP_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
}


// for charges payment only
function updateRemainingBalance() {
    //insertToChargesPaymentGrid();
    // updates total amount of payment charges
    if (formId != "#paymentDetailsTabForm") {
        updateTotalAmountOfPaymentCharges(formId);
    }
    //for data entry ua loan settlement mt103 and pddts tabs
    if (serviceType.toLowerCase() == "ua loan settlement" || serviceType.toLowerCase() == "ua_loan_settlement") {

//		if($("#modeOfPaymentCharges").val().toLowerCase() == "remittance via swift"){
        if ($("#modeOfPaymentCharges").val() == "SWIFT") {

            $(".mt103Tab_data_entry").show();

//		}else if($("#modeOfPaymentCharges").val().toLowerCase() == "remittance via pddts"){
        } else if ($("#modeOfPaymentCharges").val() == "PDDTS") {

            $(".pddtsTab_data_entry").show();

        }
    }

    //for negotiation and ua loan settlement accordion
    if ($("#modeOfPaymentCharges").val() == "CASA") {
        $(".credit_memo").show();
    }
    $("#modeOfPaymentCharges").val("");
//    onChangeApDocumentNumber();
    disablePopup(activePopupDiv, activePopupBg);
}


function checkForOtherCurrency() {
    var withOtherCurrency = "false";


    if ($("#cilexFlag").val() == "true") {
        $("#cilexFee").parents("tr").show();
    }

}

function otherSettlementCurrencyUsed() {
    var withOtherCurrency = "false";

    if ($("#cilexFlag").val() == "true") {
        $("#CILEX").parents("tr").show();
        withOtherCurrency = "true";
    }

    return withOtherCurrency;
}

function hideZeroCharges() {
    $("table.charges_table td[width=160] :input").each(function () {
        if ($(this).val() == 0.00) {
            $(this).parents("tr").hide();
        }
    })
}


$(initializeChargesTabUtility);
