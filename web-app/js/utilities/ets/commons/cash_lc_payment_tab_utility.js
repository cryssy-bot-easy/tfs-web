
/*
(revision)
SCR/ER Number: 
SCR/ER Description: After changing the special rates, then clicked Recompute Charge,
Pass-on and Special Rates got deleted. (Redmine# 3745)
[Revised by:] Robin C. Rafael
[Date deployed:] 
Program [Revision] Details: Recompute charges button is looking for the foreign exchange table found in
    "cashLcPaymentTabForm". However, these newer modules don't have said form. Instead, they have "productPaymentTabForm".
    Fix for this is to include both forms in lookup.
Member Type: JavaScript
Project: WEB
Project Name: cash_lc_payment_tab_utility.js
*/




function evaluateChargesPayment() {
    if (formId != "#chargesPaymentTabForm") return false;

    var grid_list_cp = $("#grid_list_charges_payment");

    if ($("#amountOfPaymentCharges").val().length == 0 || $("#settlementCurrency").val().length == 0) {
//		alert("Amount of Payment and Currency required.");
        $("#alertMessage").text("Amount of Payment and Currency required.");
        triggerAlert();
        return true;
    }

    if (grid_list_cp.jqGrid("getGridParam", "records") == 0) {
        return false;
    }

    var _data_ids = grid_list_cp.jqGrid("getDataIDs");
    if (grid_list_cp.jqGrid("getRowData", _data_ids[0]).settlementCurrency != $("#settlementCurrency").val()) {
//		alert("Different currency is not allowed.");
        $("#alertMessage").text("Different currency is not allowed.");
        triggerAlert();
        return true;
    }
    return false;
}

function onSettlementCurrencyCashChange() {
    if (documentClass == "DP" && documentType == "DOMESTIC") {
        $("#cashAmountInSettlementCurrency").text($("#totalAmountDueLcCurrency").text());
    } else if (documentClass == "LC" && $("#serviceType").val().toUpperCase() == "NEGOTIATION"
    	&& $("#documentSubType1").val().toUpperCase() == "REGULAR" && $("#documentSubType2").val().toUpperCase() == "USANCE") {
        $("#cashAmountInSettlementCurrency").text($("#totalAmountDueLcCurrency").text());
    } else {
        $("#cashAmountInSettlementCurrency").text($("#settlementCurrencyLc").val());
    }
}

function oncashAmountInSettlementCurrencyFocusOut() {
    if ($("#cashAmountInSettlement").val() == "" && $("#cashAmountInLc").val() == "" && documentClass != "CORRES_CHARGE") {
    	$("#popup_btn_mode_of_payment_cash").attr("disabled", "disabled");
    } else if($("#settlementCurrencyLc").val()){
    	$("#popup_btn_mode_of_payment_cash").removeAttr("disabled");
    }
}

function disableCashLc() {
//
//    if($("#cashAmountInLc").attr("readonly") == "readonly"){
//
//    }

    if ($("#cashAmountInSettlement").val().length > 0) {
        $("#cashAmountInLc").attr("readonly", "readonly").attr("disabled", "disabled");
    } else {
        $("#cashAmountInLc").removeAttr("readonly").removeAttr("disabled");
    }
}

function disableCashSettlement() {
    if ($("#cashAmountInLc").val().length > 0) {
        $("#cashAmountInSettlement").attr("readonly", "readonly").attr("disabled", "disabled");
    } else {
        $("#cashAmountInSettlement").removeAttr("readonly").removeAttr("disabled");
    }
}

function getConversionRates() {
    /*	var settlementCurrency = $("#settlementCurrencyLc").val();
     var lcCurrency = $("#savedCurrency").val();
     switch (settlementCurrency){
     case 'PHP':
     if (settlementCurrency == currency){
     return 1
     } else if (currency == 'USD'){
     //			return parseFloat(1/$("#special_rate17").val());
     return stripCommas($("#special_rate17").val());
     } else {
     //			return parseFloat(1/$("#special_rate2").val());
     return stripCommas($("#special_rate2").val());
     }
     break;
     case 'USD':
     if (settlementCurrency == currency){
     return 1
     } else if (currency == 'PHP'){
     return stripCommas($("#special_rate17").val());
     } else {
     //			return parseFloat(1/$("#special_rate1").val());
     return stripCommas($("#special_rate1").val());
     }
     break;
     default:
     return 1
     break;
     }*/
	var currency = $("#savedCurrency").val();
    if ("BC" == documentClass) {
    	currency = $("span#bookingCurrency").text();
    }
    if (currency == $("#settlementCurrencyLc").val()) {
        return 1
    } else if ($("#settlementCurrencyLc").val() != "") {
        var settlementCurrency = $("#settlementCurrencyLc").val();
        var usd_php = parseFloat(stripCommas($("#USD-PHP_special_rate_cash").val()));
//        alert(usd_php);
        var usd_php_buying = parseFloat(stripCommas($("#USD-PHP_text_special_rate_buying").val()));
//        alert(usd_php_buying);
        if (!usd_php_buying && !usd_php) { //assume dmlc
            usd_php = parseFloat(stripCommas($("#USD-PHP_special_rate_cash_urr").val()))
            usd_php_buying = parseFloat(stripCommas($("#USD-PHP_special_rate_cash_urr").val()))
        }
        if (!usd_php_buying) { //assume dmlc
            usd_php_buying = parseFloat(stripCommas($("#USD-PHP_special_rate_cash_urr").val()))
        }
        //var usd_php_buying = stripCommas($("#USD-PHP_text_special_rate_buying").val())
        var base_to_php;
        if (currency == 'PHP') {
            base_to_php = 1
        }
//        else if ($("#"+currency+"-PHP_special_rate_cash").length == 1){
//			base_to_php = parseFloat(stripCommas($("#"+currency+"-PHP_special_rate_cash").val()));
//		}
        else if (currency == 'USD') {
            base_to_php = usd_php;
        } else {
            base_to_php = parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val())) * usd_php
        }
        switch (settlementCurrency) {
            case 'PHP':
                return base_to_php;
                break;
            case 'USD':
//			return (currency == 'PHP') ? usd_php : (currency == 'USD') ? (usd_php / base_to_php) : (base_to_php / usd_php);
                return (currency == 'PHP') ? usd_php_buying : (currency == 'USD') ? (usd_php / base_to_php) : parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val()));
                break;
            default:
//			if ($("#"+settlementCurrency+"-PHP_special_rate_cash").length == 1){
////				return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val()))) : (currency == 'USD') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val())) / base_to_php) : (base_to_php / parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val())));
//				return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val()))) : (currency == 'USD') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val()))) : (base_to_php / parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val())));
//			} else {
////				return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? ((parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php) / base_to_php) : (base_to_php / (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php));
//				return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php));
//			}
                return (currency == 'PHP') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php));
        }
    }
}

function convertToCashLc() {
//var params = {
//		amount_settlement : $("#cashAmountInSettlement").val(),
//		readonly_lc : ($("#cashAmountInLc").attr("readonly") == "readonly"),
//		conversion_rate : getConversionRates()
//	}

    var params = {
        amount: $("#cashAmountInSettlement").val(),
        conversion_rate: getConversionRates(),
        base_ccy: $("#cashAmountInSettlementCurrency").text(),
        target_ccy: $("#cashAmountInLcCurrency").text(),
//        base_ccy: $("#cashAmountInLcCurrency").text(),
//        target_ccy: $("#cashAmountInSettlementCurrency").text(),
        convertTo: "LC"
    }

    $.post(convertRatesUrl, params, function (data) {
        $("#cashAmountInSettlement").val(data.equivSettlement);
        $("#cashAmountInLc").val(data.equivLc)
    });
}

function convertToSettlement() {
//	var params = {
//		amount_lc : $("#cashAmountInLc").val(),
//		readonly_settlement : ($("#cashAmountInSettlement").attr("readonly") == "readonly"),
//		conversion_rate : getConversionRates()
//	}
    var params = {
        amount: $("#cashAmountInLc").val(),
        conversion_rate: getConversionRates(),
        base_ccy: $("#cashAmountInLcCurrency").text(),
        target_ccy: $("#cashAmountInSettlementCurrency").text(),
        convertTo: "SET"
    }
    $.post(convertRatesUrl, params, function (data) {
        $("#cashAmountInSettlement").val(data.equivSettlement);
        $("#cashAmountInLc").val(data.equivLc);
    });
}

function converByRateChange() {
    var params = {
        amount_lc: $("#cashAmountInLc").val(),
        amount_settlement: $("#cashAmountInSettlement").val(),
        //readonly_lc : ($("#cashAmountInLc").attr("readonly") == "readonly"),
        //readonly_settlement : ($("#cashAmountInSettlement").attr("readonly") == "readonly"),
        conversion_rate: getConversionRates(),
        target_ccy: $("#cashAmountInLcCurrency").text()
    }
    $.post(convertRatesUrl, params, function (data) {
        $("#cashAmountInSettlement").val(data.equivSettlement);
        $("#cashAmountInLc").val(data.equivLc);
    });
}

// acts as submitToRemote
function onRecomputeChargeBtnClickCashLc() {


    //This is my preferred action clear the readonly property and values
//    $("#cashAmountInSettlement").removeAttr("readonly").removeAttr("disabled");
//    $("#cashAmountInLc").removeAttr("readonly").removeAttr("disabled");

    var params = {};
    //3745 by ROBIN
    var paymentTabForm = $("form#cashLcPaymentTabForm").length > 0 ? "form#cashLcPaymentTabForm" : "form#productPaymentTabForm";
    $(paymentTabForm + " .foreign_exchange :input").each(function () {
        if (
            ($(this).attr("name").indexOf($("#settlementCurrencyLc").val()) != -1 ||
                $(this).attr("name").indexOf($("#savedCurrency").val()) != -1 ||
                $(this).attr("name").indexOf("USD-PHP") != -1)
                && $(this).attr("name").indexOf("text") != -1) {
            params[$(this).attr("name")] = $(this).val();
        }
    })
    //3745 end

    params["passOnRateConfirmedBy"] = $("#passOnRateConfirmedBy").val();
//    var postUrl = recomputeChargesPostUrl;

    $.post(recomputeCashPostUrl, params, function (data) {
        var currency = $("#savedCurrency").val(),
            settlementCurrency = $("#settlementCurrencyLc").val();

        $("#" + currency + "-USD_pass_on_rate_cash").val(data["pass-on"][currency + "-USD_pass_on_rate"]);
        $("." + currency + "-USD_pass_on_rate_cash").val(data["pass-on"][currency + "-USD_pass_on_rate"]);
        $("#" + currency + "-USD_special_rate_cash").val(data["special"][currency + "-USD_special_rate"]);
        $("." + currency + "-USD_special_rate_cash").val(data["special"][currency + "-USD_special_rate"]);
        $("#" + currency + "-PHP_pass_on_rate_cash").val(data["pass-on"][currency + "-PHP_pass_on_rate"]);
        $("." + currency + "-PHP_pass_on_rate_cash").val(data["pass-on"][currency + "-PHP_pass_on_rate"]);
        $("#" + currency + "-PHP_special_rate_cash").val(data["special"][currency + "-PHP_special_rate"]);
        $("." + currency + "-PHP_special_rate_cash").val(data["special"][currency + "-PHP_special_rate"]);


        $("#" + currency + "-USD_pass_on_rate_cash_urr").val(data["pass-on"][currency + "-USD_pass_on_rate_urr"]);
        $("." + currency + "-USD_pass_on_rate_cash_urr").val(data["pass-on"][currency + "-USD_pass_on_rate_urr"]);
        $("#" + currency + "-USD_special_rate_cash_urr").val(data["special"][currency + "-USD_special_rate_urr"]);
        $("." + currency + "-USD_special_rate_cash_urr").val(data["special"][currency + "-USD_special_rate_urr"]);
        $("#" + currency + "-PHP_pass_on_rate_cash_urr").val(data["pass-on"][currency + "-PHP_pass_on_rate_urr"]);
        $("." + currency + "-PHP_pass_on_rate_cash_urr").val(data["pass-on"][currency + "-PHP_pass_on_rate_urr"]);
        $("#" + currency + "-PHP_special_rate_cash_urr").val(data["special"][currency + "-PHP_special_rate_urr"]);
        $("." + currency + "-PHP_special_rate_cash_urr").val(data["special"][currency + "-PHP_special_rate_urr"]);

        $("#" + settlementCurrency + "-USD_pass_on_rate_cash").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate"]);
        $("." + settlementCurrency + "-USD_pass_on_rate_cash").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate"]);
        $("#" + settlementCurrency + "-USD_special_rate_cash").val(data["special"][settlementCurrency + "-USD_special_rate"]);
        $("." + settlementCurrency + "-USD_special_rate_cash").val(data["special"][settlementCurrency + "-USD_special_rate"]);
        $("#" + settlementCurrency + "-PHP_pass_on_rate_cash").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate"]);
        $("." + settlementCurrency + "-PHP_pass_on_rate_cash").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate"]);
        $("#" + settlementCurrency + "-PHP_special_rate_cash").val(data["special"][settlementCurrency + "-PHP_special_rate"]);
        $("." + settlementCurrency + "-PHP_special_rate_cash").val(data["special"][settlementCurrency + "-PHP_special_rate"]);

        $("#" + settlementCurrency + "-USD_pass_on_rate_cash_urr").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate_urr"]);
        $("." + settlementCurrency + "-USD_pass_on_rate_cash_urr").val(data["pass-on"][settlementCurrency + "-USD_pass_on_rate_urr"]);
        $("#" + settlementCurrency + "-USD_special_rate_cash_urr").val(data["special"][settlementCurrency + "-USD_special_rate_urr"]);
        $("." + settlementCurrency + "-USD_special_rate_cash_urr").val(data["special"][settlementCurrency + "-USD_special_rate_urr"]);
        $("#" + settlementCurrency + "-PHP_pass_on_rate_cash_urr").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate_urr"]);
        $("." + settlementCurrency + "-PHP_pass_on_rate_cash_urr").val(data["pass-on"][settlementCurrency + "-PHP_pass_on_rate_urr"]);
        $("#" + settlementCurrency + "-PHP_special_rate_cash_urr").val(data["special"][settlementCurrency + "-PHP_special_rate_urr"]);
        $("." + settlementCurrency + "-PHP_special_rate_cash_urr").val(data["special"][settlementCurrency + "-PHP_special_rate_urr"]);
        $("#USD-PHP_pass_on_rate_cash").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
        $(".USD-PHP_pass_on_rate_cash").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
        $("#USD-PHP_special_rate_cash").val(data["special"]["USD-PHP_special_rate"]);
        $(".USD-PHP_special_rate_cash").val(data["special"]["USD-PHP_special_rate"]);

        $("#USD-PHP_pass_on_rate_cash_urr").val(data["pass-on"]["USD-PHP_pass_on_rate_urr"]);
        $(".USD-PHP_pass_on_rate_cash_urr").val(data["pass-on"]["USD-PHP_pass_on_rate_urr"]);
        $("#USD-PHP_special_rate_cash_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
        $(".USD-PHP_special_rate_cash_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
        $("#USD-PHP_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
        $(".USD-PHP_urr").val(data["special"]["USD-PHP_special_rate_urr"]);
        //converByRateChange();

        //Check which is disabled.
        //run that conversion
        cash_lc_convertAmount();
//        if($("#cashAmountInLc").attr("readonly") == "readonly"){
//            convertToCashLc();
//        } else if($("#cashAmountInSettlement").attr("readonly") == "readonly"){
//            convertToSettlement();
//        }
    });
}

function hideUnrelatedExchangeRates() {
    $("form#cashLcPaymentTabForm .foreign_exchange td.rates").each(function () {
        var check = ($("#savedCurrency").val() != 'PHP' && $("#savedCurrency").val() != 'USD') ? $("#savedCurrency").val() : null
        if ($(this).text() != 'USD-PHP' && $(this).text().indexOf(check) == -1) {
            $(this).parents("tr").hide();
            $(this).parents("tr").children("td").children("input").attr("disabled", "disabled");
        }
    })
}

function loadRelatedExchangeRates() {
    hideUnrelatedExchangeRates();
    var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    var check = ($("#savedCurrency").val() != 'PHP' && $("#savedCurrency").val() != 'USD') ? $("#savedCurrency").val() : null

    $.each(gridDataCashPayment, function (idx, data) {
        $("form#cashLcPaymentTabForm .foreign_exchange td.rates").each(function () {
            if (data.settlementCurrency != 'PHP' && data.settlementCurrency != 'USD' && data.settlementCurrency != "") {
                if ($(this).text() != 'USD-PHP' && $(this).text().indexOf(data.settlementCurrency) != -1) {
                    $(this).parents("tr").show();
                    $(this).parents("tr").children("td").children("input").removeAttr("disabled");
                }
            }
        });
    });
    if ($("#grid_list_cash_payment_summary").jqGrid('getGridParam', 'records') < 3) {
        if ($("#settlementCurrencyLc").val() != 'PHP' && $("#settlementCurrencyLc").val() != 'USD' && $("#settlementCurrencyLc").val() != "") {
            $("form#cashLcPaymentTabForm .foreign_exchange td.rates").each(function () {
                if ($(this).text() != 'USD-PHP' && $(this).text().indexOf($("#settlementCurrencyLc").val()) != -1) {
                    $(this).parents("tr").show();
                    $(this).parents("tr").children("td").children("input").removeAttr("disabled");
                }
            });
        } else { // if there is no settlement currency check the value of the currency
            $("form#cashLcPaymentTabForm .foreign_exchange td.rates").each(function () {
                if ($(this).text() != 'USD-PHP' && $(this).text().indexOf(check) != -1) {
                    $(this).parents("tr").show();
                    $(this).parents("tr").children("td").children("input").removeAttr("disabled");
                }
            });
        }
    }
}

function cash_lc_convertAmount() {
	if ($("#cashAmountInLc").attr("readonly") == "readonly" && $("#cashAmountInSettlement").attr("readonly") == "readonly") {
		convertToSettlement();
	} else if ($("#cashAmountInLc").attr("readonly") == "readonly") {
        convertToCashLc();
    } else if ($("#cashAmountInSettlement").attr("readonly") == "readonly") {
        convertToSettlement();
    }
}

function initializeCashLcPayment() {
    hideUnrelatedExchangeRates();
    $("#settlementCurrencyLc").change(function () {
        onSettlementCurrencyCashChange();
        //loadRelatedExchangeRates();
        cash_lc_convertAmount();

    });
//	$("#cashAmountInSettlement").keypress(disableCashLc).keyup(disableCashLc).keydown(disableCashLc);
//	$("#cashAmountInLc").keypress(disableCashSettlement).keyup(disableCashSettlement).keydown(disableCashSettlement);
//
//	$("#cashAmountInSettlement").blur(function(){
//		if ($(this).attr("readonly") != "readonly"){
//			convertToCashLc();
//		}
//	});
//	$("#cashAmountInLc").blur(function(){
//		if ($(this).attr("readonly") != "readonly"){
//			convertToSettlement();
//		}
//	})
    $("#cashAmountInSettlement").change(function () {
        disableCashLc();
        convertToCashLc();
    });

    $("#cashAmountInLc").change(function () {
        disableCashSettlement();
        convertToSettlement();
    });

    oncashAmountInSettlementCurrencyFocusOut();
    $("#cashAmountInSettlement").focusout(function () {
        oncashAmountInSettlementCurrencyFocusOut();
    });
    $("#cashAmountInLc").focusout(function () {
        oncashAmountInSettlementCurrencyFocusOut();
    });


    // alternative to submitToRemote since the submitToRemote is required to be inside a form and since cash_lc_payment_tab
    // is already in a form, the added settlement modes are disregarded thus the added settlement modes are not saved.
    $("#recomputeChargeBtnCashLc").click(onRecomputeChargeBtnClickCashLc);
}

$(initializeCashLcPayment);