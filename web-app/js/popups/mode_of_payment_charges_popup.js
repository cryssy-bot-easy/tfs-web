function documentReferenceNumberAp() {
    var apBalDisplay2Charges = $(".display-ap-balance2_charges");
    var apBalDisplay1Charges = $(".display-ap-balance1_charges");

    apBalDisplay2Charges.css("display", "none");
    apBalDisplay1Charges.css("display", "none");

    var settlementCurrency = $("#settlementCurrency").val();

    if (formId == "#proceedsDetailsTabForm") {
//    	settlementCurrency = $("#amountOfPaymentCurrencyProceedBeneficiary").val();
        settlementCurrency = $("#proceedsCurrency").val();
    }
    else if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        settlementCurrency = $("#settlementCurrencyLc").val();

        if ($("#documentClass").val() == "MD") {
            settlementCurrency = $("#mdCurrency").val();
        }
    }

    var params = {cifNumber: cifNumber,
        currency: settlementCurrency,
        id: $("#documentReferenceNumberAp").val()
    }

    $.post(findAllApByIdUrl, params, function (data) {
//        if(data.length == 1) {
        $('.mode_of_payment_buttons').css("display", "block");
        apBalDisplay2Charges.css("display", "block");
//            apBalDisplay1Charges.css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
        $("#apOutstandingBalance").val(formatCurrency(data.APOUTSTANDINGBALANCE));
        $("#apReferenceId").val($("#documentReferenceNumberAp").val());

        //$.post(findAllApByIdUrl, params, function(data) {

        //})
//        }else if(data.length > 1){
//            $('.mode_of_payment_buttons').css("display", "block");
//            apBalDisplay2Charges.css("display", "none");
//            apBalDisplay1Charges.css("display", "block");
//            centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//
//            var reloadUrl = findAllMultipleApUrl;
//            reloadUrl += "?cifNumber="+cifNumber;
//            reloadUrl += "&currency="+settlementCurrency;
//            reloadUrl += "&settlementAccountNumber="+$("#documentReferenceNumberAp").val();
//
//            $("#grid_list_ap_balance_charges").jqGrid('setGridParam', {datatype: 'json', url: reloadUrl, page: 1}).trigger("reloadGrid");
//        }
    });
}

function setupAps() {
    $("#documentReferenceNumberAp").empty();
    $('#documentReferenceNumberAp').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
    var settlementCurrency = $("#settlementCurrency").val();

    if (formId == "#proceedsDetailsTabForm") {
//    	settlementCurrency = $("#amountOfPaymentCurrencyProceedBeneficiary").val();
        settlementCurrency = $("#proceedsCurrency").val();
    }
    else if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        settlementCurrency = $("#settlementCurrencyLc").val();

        if ($("#documentClass").val() == "MD") {
            settlementCurrency = $("#mdCurrency").val();
        } else if ($("#documentClass").val() in {AP:1, AR:1}) {
        	settlementCurrency = $("#apCurrency").val();
        }
    }
//    else if (formId == "#basicDetailsTabForm") {
//    	settlementCurrency = $("#apCurrency").val();
//    }

    $.post(findAllApByCifNumberAndCurrencyUrl, {cifNumber: cifNumber, currency: settlementCurrency}, function (data) {
        for (var ctr = 0; ctr < data.length; ctr++) {
            var val = data[ctr].SETTLEMENTACCOUNTNUMBER;
            var key = data[ctr].ID;
            var servType = data[ctr].SERVICETYPE;

            var option = "<option value=" + key + ">" + val + " (" + servType + ")</option>";

            $("#documentReferenceNumberAp").append(option);
        }

        $("#documentReferenceNumberAp").change(documentReferenceNumberAp);
    });
}

function evaluateChargesPayment() {
    if (formId != "#chargesPaymentTabForm") return false;

    var grid_list_cp = $("#grid_list_charges_payment");

    if ($("#amountOfPaymentCharges").val().length == 0 || $("#settlementCurrency").val().length == 0) {
        $("#alertMessage").text("Amount of Payment and Currency required.");
        triggerAlert();
        return true;
    }

    if (grid_list_cp.jqGrid("getGridParam", "records") == 0) {
        return false;
    }

    var _data_ids = grid_list_cp.jqGrid("getDataIDs");
    if (grid_list_cp.jqGrid("getRowData", _data_ids[0]).settlementCurrency != $("#settlementCurrency").val()) {
        $("#alertMessage").text("Different currency is not allowed.");
        triggerAlert();
        return true;
    }

    return false;
}

function constructRates(type) {
    if (type == 'cash') {
        return constructRatesCashPayment();
        ;
    } else {
        return contructRatesChargePayment();
    }
}

function constructRatesCashPayment() {
    var rates = new Array();
    var currency = $("#currency").val();

    if (currency == undefined) {
        currency = $("#totalAmountDueLcCurrency").text();
    }

//    if($("#currency").val() && $("#currency").val() !="PHP" && $("#currency").val() !="USD"){
    if (currency && currency != "PHP" && currency != "USD") {
        //Pass on
        if ($("#USD-PHP_text_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
//        if($("#" + $("#currency").val() + "-USD_pass_on_rate_cash").length > 0){
        if ($("#" + currency + "-USD_pass_on_rate_cash").length > 0) {
//            rates.push("passOnRateThirdToUsd="+$("#" + $("#currency").val() + "-USD_special_rate_cash").val());
            rates.push("passOnRateThirdToUsd=" + $("#" + currency + "-USD_special_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
//        if($("#" + $("#currency").val() + "-PHP_pass_on_rate_cash").length > 0){
        if ($("#" + currency + "-PHP_pass_on_rate_cash").length > 0) {
//            rates.push("passOnRateThirdToPhp="+$("#" + $("#currency").val() + "-PHP_pass_on_rate_cash").val());
            rates.push("passOnRateThirdToPhp=" + $("#" + currency + "-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
//        if($("#" + $("#currency").val() + "-USD_special_rate_cash").length > 0){
        if ($("#" + currency + "-USD_special_rate_cash").length > 0) {
//            rates.push("specialRateThirdToUsd="+$("#" + $("#currency").val() + "-USD_special_rate_cash").val());
            rates.push("specialRateThirdToUsd=" + $("#" + currency + "-USD_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
//        if($("#" + $("#currency").val() + "-PHP_special_rate_cash").length > 0){
        if ($("#" + currency + "-PHP_special_rate_cash").length > 0) {
//            rates.push("specialRateThirdToPhp="+$("#" + $("#currency").val() + "-PHP_special_rate_cash").val());
            rates.push("specialRateThirdToPhp=" + $("#" + currency + "-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }

    } else if ($("#settlementCurrencyLc").val() && $("#settlementCurrencyLc").val() != "PHP" && $("#settlementCurrencyLc").val() != "USD") {
        //Pass On
        if ($("#USD-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-USD_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $("#settlementCurrencyLc").val() + "-USD_special_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $("#settlementCurrencyLc").val() + "-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-USD_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $("#settlementCurrencyLc").val() + "-USD_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $("#settlementCurrencyLc").val() + "-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }

        if ($("#USD-PHP_text_pass_on_rate_buying").length > 0) {
            rates.push("usdToPhpPassOnBuyRate=" + $("#USD-PHP_text_pass_on_rate_buying").val());
        } else {
            rates.push("usdToPhpPassOnBuyRate=");
        }

        if ($("#USD-PHP_text_special_rate_buying").length > 0) {
            rates.push("usdToPhpSpecialBuyRate=" + $("#USD-PHP_text_special_rate_buying").val());
        } else {
            rates.push("usdToPhpSpecialBuyRate=");
        }


    } else if ($("#settlementCurrency").val() && $("#settlementCurrency").val() != "PHP" && $("#settlementCurrency").val() != "USD") {
        //Pass on
        if ($("#USD-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-USD_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $("#settlementCurrency").val() + "-USD_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $("#settlementCurrency").val() + "-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-USD_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $("#settlementCurrency").val() + "-USD_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $("#settlementCurrency").val() + "-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }


        if ($("#USD-PHP_text_pass_on_rate_buying").length > 0) {
            rates.push("usdToPhpPassOnBuyRate=" + $("#USD-PHP_text_pass_on_rate_buying").val());
        } else {
            rates.push("usdToPhpPassOnBuyRate=");
        }

        if ($("#USD-PHP_text_special_rate_buying").length > 0) {
            rates.push("usdToPhpSpecialBuyRate=" + $("#USD-PHP_text_special_rate_buying").val());
        } else {
            rates.push("usdToPhpSpecialBuyRate=");
        }

    } else {
        //Pass on
        if ($("#USD-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $("#currency").val() + "-USD_special_rate_cash").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $("#currency").val() + "-USD_special_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $("#currency").val() + "-PHP_pass_on_rate_cash").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $("#currency").val() + "-PHP_pass_on_rate_cash").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $("#currency").val() + "-USD_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $("#currency").val() + "-USD_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $("#currency").val() + "-PHP_special_rate_cash").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $("#currency").val() + "-PHP_special_rate_cash").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }


        if ($("#USD-PHP_text_pass_on_rate_buying").length > 0) {
            rates.push("usdToPhpPassOnBuyRate=" + $("#USD-PHP_text_pass_on_rate_buying").val());
        } else {
            rates.push("usdToPhpPassOnBuyRate=");
        }

        if ($("#USD-PHP_text_special_rate_buying").length > 0) {
            rates.push("usdToPhpSpecialBuyRate=" + $("#USD-PHP_text_special_rate_buying").val());
        } else {
            rates.push("usdToPhpSpecialBuyRate=");
        }

    }

    return rates.join(",");
}

function contructRatesChargePayment() {
    var rates = new Array();
    
    var $currency = $("#originalCurrency").length > 0 ? $("#originalCurrency") : $("#currency")

    if ($currency.val() && $currency.val() != "PHP" && $currency.val() != "USD") {
        //Pass on
        if ($("#USD-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }

        if ($("#" + $currency.val() + "-USD_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $currency.val() + "-USD_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $currency.val() + "-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $currency.val() + "-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $currency.val() + "-USD_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $currency.val() + "-USD_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $currency.val() + "-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $currency.val() + "-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }

    } else if ($("#settlementCurrencyLc").val() && $("#settlementCurrencyLc").val() != "PHP" && $("#settlementCurrencyLc").val() != "USD") {
        //Pass On
        if ($("#USD-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-USD_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $("#settlementCurrencyLc").val() + "-USD_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $("#settlementCurrencyLc").val() + "-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-USD_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $("#settlementCurrencyLc").val() + "-USD_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrencyLc").val() + "-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $("#settlementCurrencyLc").val() + "-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }

    } else if ($("#settlementCurrency").val() && $("#settlementCurrency").val() != "PHP" && $("#settlementCurrency").val() != "USD") {
//        //Pass on
        if ($("#USD-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-USD_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $("#settlementCurrency").val() + "-USD_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $("#settlementCurrency").val() + "-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-USD_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $("#settlementCurrency").val() + "-USD_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $("#settlementCurrency").val() + "-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $("#settlementCurrency").val() + "-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }
    } else {
        //Pass on
        if ($("#USD-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateUsdToPhp=" + $("#USD-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateUsdToPhp=");
        }
        if ($("#" + $currency.val() + "-USD_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToUsd=" + $("#" + $currency.val() + "-USD_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToUsd=");
        }
        if ($("#" + $currency.val() + "-PHP_pass_on_rate_charges").length > 0) {
            rates.push("passOnRateThirdToPhp=" + $("#" + $currency.val() + "-PHP_pass_on_rate_charges").val());
        } else {
            rates.push("passOnRateThirdToPhp=");
        }

        //Special
        if ($("#USD-PHP_special_rate_charges").val() > 0) {
            rates.push("specialRateUsdToPhp=" + $("#USD-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateUsdToPhp=");
        }
        if ($("#" + $currency.val() + "-USD_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToUsd=" + $("#" + $currency.val() + "-USD_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToUsd=");
        }
        if ($("#" + $currency.val() + "-PHP_special_rate_charges").length > 0) {
            rates.push("specialRateThirdToPhp=" + $("#" + $currency.val() + "-PHP_special_rate_charges").val());
        } else {
            rates.push("specialRateThirdToPhp=");
        }
        if ($("#USD-PHP_urr").length > 0) {
            rates.push("urr=" + $("#USD-PHP_urr").val());
        } else {
            rates.push("urr=");
        }
    }

    return rates.join(",");
}


function validateInsertValues(gridToInsert, modeOfPayment) {
    var result = "true";

   	if (modeOfPayment != "CASA") {
		var dataIds = gridToInsert.jqGrid("getRowData");
    	var existCount = 0;

    	for (i in dataIds) {
    		console.log(dataIds[i]);
    		if (dataIds[i].paymentMode == modeOfPayment) {
    	    	existCount++;
    	    }
        }

        if (existCount > 0) {
            result = "false";
        }
    }else{
	    if(evaluateAccountNumber(gridToInsert,$("#accountNumber"))){
	    	result = "false";
	    }
    }

    return result;
}

function validateInsertValuesWithCurrency(gridToInsert, modeOfPayment, currency) {
	var result = "true";
	
	if (modeOfPayment != "CASA") {
		var dataIds = gridToInsert.jqGrid("getRowData");
		var existCount = 0;
		
		for (i in dataIds) {
			console.log(dataIds[i]);
			if (dataIds[i].paymentMode == modeOfPayment && dataIds[i].settlementCurrency == currency) {
				existCount++;
			}
		}
		
		if (existCount > 0) {
			result = "false";
		}
	}else{
		if(evaluateAccountNumber(gridToInsert,$("#accountNumber"))){
			result = "false";
		}
	}
	
	return result;
}

function constructUaLoanForm() {
    var bookingCurrencyUsance = $("input[type=radio][name=bookingCurrencyIbTr]:checked").val();

    var loanMaturityDate = $("#loanMaturityDate").val();
    var interestRate = $("#interestRate").val();
    var interestTerm = $("#interestTermNegotiation").val("30");
    var interestTermCode = $("input[type=radio][name=interestCodeFlagNegotiation]:checked").val();
    var repricingTerm = $("#repricingTermNegotiation").val("30");
    var repricingTermCode = $("input[type=radio][name=repricingCodeFlagNegotiation]:checked").val();
    var loanTerm = $("#loanTermNegotiation").val("30");
    var loanTermCode = $("input[type=radio][name=loanCodeFlagNegotiation]:checked").val();
    var loanPaymentCode = $("#loanPaymentCode").val();
    var withCramApproval = $("input[name=cramApprovalFlag]:checked").val();

    var setupStringList = new Array();

    setupStringList.push("bookingCurrency=" + $("#settlementCurrencyLc").val());
    setupStringList.push("interestRate=0");
    setupStringList.push("interestTerm=" + $("#interestTermNegotiation").val());
    setupStringList.push("interestTermCode=D" + interestTermCode);
    setupStringList.push("repricingTerm=" + $("#repricingTermNegotiation").val());
    setupStringList.push("repricingTermCode=" + repricingTermCode);
    setupStringList.push("loanTerm=" + $("#loanTermNegotiation").val());
    setupStringList.push("loanTermCode=D" + loanTermCode);
    setupStringList.push("loanMaturityDate=" + loanMaturityDate);
    setupStringList.push("loanPaymentCode=" + loanPaymentCode);
    setupStringList.push("withCramApproval=" + withCramApproval);

    return setupStringList.join("&");
}

function constructIbTrLoanForm() {
    var bookingCurrencyIbTr;
    if (documentClass == 'DA' || documentClass == 'DP' || documentClass == 'OA' || documentClass == 'DR') {
        bookingCurrencyIbTr = $("#settlementCurrencyLc").val();
    } else {
        bookingCurrencyIbTr = $("input[type=radio][name=bookingCurrencyIbTr]:checked").val();
    }
    var interestRate = $("#interestRate").val();
	var interestRate2 = $("#interestRate2").val();
    var interestTermCode = $("input[type=radio][name=interestCodeFlagNegotiation]:checked").val();
    var repricingTermCode = $("input[type=radio][name=repricingCodeFlagNegotiation]:checked").val();
    var loanTermCode = $("input[type=radio][name=loanCodeFlagNegotiation]:checked").val();
    var loanMaturityDate = $("#loanMaturityDate").val();
    var loanPaymentCode = $("#loanPaymentCode").val();
    var withCramApproval = $("input[name=cramApprovalFlag]:checked").val() ? $("input[name=cramApprovalFlag]:checked").val() : $("input[name=cramApprovalFlagNegotiation]:checked").val();

    var setupStringList = new Array();

    setupStringList.push("bookingCurrency=" + bookingCurrencyIbTr);
    setupStringList.push("interestRate=" + interestRate2);
    setupStringList.push("interestTerm=" + $("#interestTermNegotiation").val());
    setupStringList.push("interestTermCode=" + interestTermCode);
    setupStringList.push("repricingTerm=" + $("#repricingTermNegotiation").val());
    setupStringList.push("repricingTermCode=" + repricingTermCode);
    setupStringList.push("loanTerm=" + $("#loanTermNegotiation").val());
    setupStringList.push("loanTermCode=" + loanTermCode);
    setupStringList.push("loanMaturityDate=" + loanMaturityDate);
    setupStringList.push("loanPaymentCode=" + loanPaymentCode);
    setupStringList.push("withCramApproval=" + withCramApproval);

    return setupStringList.join("&");
}

function getPopupFieldParameters(typeOfLoan) {
    if (typeOfLoan == "IB_LOAN" || typeOfLoan == "TR_LOAN" || typeOfLoan == "DBP") {
        return constructIbTrLoanForm();
    } else if (typeOfLoan == "UA_LOAN") {
        return constructUaLoanForm();
    }
}

// delete charges payment entry
function onDeletePayment(id) {
	if(formId == "#proceedsDetailsTabForm" && $("#grid_list_charges_payment").length > 0) {
		if(parseInt($("#grid_list_charges_payment").jqGrid('getGridParam', 'records')) > 0) {
			triggerAlertMessage("Please delete all Service Payments first.")
		}else {
		var postUrl = validateSavedChargesPaymentsUrl;
    	var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData");
    	$.post(postUrl, {tradeServiceId: $("#tradeServiceId").val(), chargesPaymentSummary: JSON.stringify(paymentsummarydata)}, function(data){
    		if(data.success == false) {
    			triggerAlertMessage("Please delete all Service Payments first.")
    		} else {
    			continueDeletePayment(id)
    		}
    	});
		}
    } else {
    	continueDeletePayment(id)
    }
}

function continueDeletePayment(id) {
	
	var gridId;
    if (formId.indexOf("cash") == -1 && formId != "#productPaymentTabForm") {
//    	if (formId == "#basicDetailsTabForm" && ((documentClass == "AP" && serviceType.toUpperCase() == "REFUND") || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE"))) {
        if (documentClass != "CDT") {
            if (formId == "#paymentDetailsTabForm") {
                gridId = $("#grid_list_cash_payment_summary");
            } else if (formId == "#proceedsDetailsTabForm") {
                gridId = $("#grid_list_proceeds_payment_summary");
            } else {
                gridId = $("#grid_list_charges_payment");
            }
        } else {
            gridId = $("#grid_list_payment_cdt");
        }
    } else if (formId.indexOf("cash") != -1 || formId == "#productPaymentTabForm") {
    	if ((documentClass == "AP" && serviceType.toUpperCase() == "REFUND") || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE") || (serviceType == "Application" && documentType == "REFUND")){
    		if (referenceType == "ETS") {
        		gridId = $("#grid_list_refund_branch");
        	} else if (referenceType == "DATA_ENTRY") {
        		gridId = $("#grid_list_refund_main");
        	}
    	} else {
    		gridId = $("#grid_list_cash_payment_summary");
    	}
    }
    var data = gridId.jqGrid("getRowData", id);
    var status = "";
    if (data.status) {
        status = data.status;
    } else {
        status = "Not Paid"
    }

    var modeOfPayment = data.paymentMode;
    
    if ((status == "Not Paid" || status == "Rejected") ||
        (status == "Paid" && (modeOfPayment == "PDDTS" || modeOfPayment == "SWIFT" || modeOfPayment == "MC_ISSUANCE"))
        ) {

        var params = dispatchDeleteCommand(id);

        var count = 0
        for (var key in params) {
            count++
        }

        if (count > 0) {
            var postUrl = addDeleteSettlementUrl;
            $.post(postUrl, params, function (data) {
                if (data.success == "true") {
                	
                    if (formId == "#proceedsDetailsTabForm" && referenceType == "PAYMENT") {
                        var paymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData", id);

                        if (paymentsummarydata.paymentMode == "PDDTS") {
                            $("#pddtsTabLi").hide();
                            $(".viewPddtsLi").hide();

                            if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                                $("#chargesLi").hide();
                                $("#chargesPaymentLi").hide();
                            }
                        }

                        if (paymentsummarydata.paymentMode == "SWIFT") {
                            $("#mt103TabLi").hide();
                            $(".viewMt103Li").hide();
                            $(".hiddenViewMt").hide();

                            if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                                $("#chargesLi").hide();
                                $("#chargesPaymentLi").hide();
                            }
                        }
                    }
                    gridId.jqGrid('delRowData', id);

                    if (gridId.attr("id") == "grid_list_cash_payment_summary") {
                        var gridCount = gridId.jqGrid("getRowData");

                        if (gridCount.length == 0) {
                            enableRatesTable();
                        }
                    } else if (gridId.attr("id") == "grid_list_charges_payment") {

                        if ($("#grid_list_cash_payment_summary").length == 0) {
                            var gridCount = gridId.jqGrid("getRowData");

                            if (gridCount.length == 0) {
                                enableChargesRatesTable();
                            }
                        }
                    }

                    if (formId != "#paymentDetailsTabForm") {
                        updateTotalAmountOfPaymentCharges(formId);
                    }
                }
            }).done(function(){
            	if(documentClass == "AP" && serviceType.toUpperCase() == "REFUND"){
            		$.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {
            			if (data2.paymentStatus == "PAID") {
            				$("#btnPrepare").removeAttr("disabled");
            			} else {
            				$("#btnPrepare").attr("disabled", "disabled");
            			}
            		});
            	}
            });
        } else {

            gridId.jqGrid('delRowData', id);

            if (gridId.attr("id") == "grid_list_cash_payment_summary") {
                var gridCount = gridId.jqGrid("getRowData");

                if (gridCount.length == 0) {
                    enableRatesTable();
                }
            } else if (gridId.attr("id") == "grid_list_charges_payment") {

                if ($("#grid_list_cash_payment_summary").length == 0) {
                    var gridCount = gridId.jqGrid("getRowData");

                    if (gridCount.length == 0) {
                        enableChargesRatesTable();
                    }
                }
            }

            if (formId != "#paymentDetailsTabForm") {
                updateTotalAmountOfPaymentCharges(formId);
            }
        }

        //Disable/Enable settlement currency depending on grid count 
        if (parseInt(gridId.jqGrid("getGridParam", "reccount")) <= 1) {
            $("#settlementCurrency").select2("enable");
        } else {
            $("#settlementCurrency").select2("disable");
        }

    } else {
        if (modeOfPayment == "CASA") {
            $("#alertMessage").text("Payment should be error corrected first before deleting.");
        } else {
            $("#alertMessage").text("Payment should be reversed first before deleting.");
        }

        triggerAlert();
    }
}

// DISPATCHER
function dispatchCommand(id) {
    var postUrl = addDeleteSettlementUrl;
//(formId == "#paymentDetailsTabForm" && referenceType == "DATA_ENTRY")

    if ((referenceType == "PAYMENT" && formId == "#chargesPaymentTabForm")) {

        var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData", id);

        var params = {
            chargesPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "addSettlement",
            form: "chargesPayment",
            chargeType: "SERVICE"
        }

        if (paymentsummarydata.paymentMode == "AP") {
            params.referenceId = paymentsummarydata.referenceId;
        }

        $.post(postUrl, params, function (data) {
            if (data.success == "false") {
                $("#grid_list_charges_payment").jqGrid('delRowData', id);
            }
            $("#grid_list_charges_payment").trigger("reloadGrid")
        });

    } else if ((referenceType == "DATA_ENTRY" && formId == "#productPaymentTabForm") || (referenceType == "PAYMENT" && (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm")) || (formId == "#paymentDetailsTabForm" && referenceType == "DATA_ENTRY")) {

        var paymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData", id);

        var params = {
            documentPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "addSettlement",
            form: "lcPayment",
            chargeType: "PRODUCT"
        }

        $.post(postUrl, params, function (data) {
            if (data.success == "false") {
                $("#grid_list_cash_payment_summary").jqGrid('delRowData', id);
            }
            $("#grid_list_cash_payment_summary").trigger("reloadGrid")

        });
//    } else if ((referenceType == "DATA_ENTRY" && formId == "#basicDetailsTabForm" && ((serviceType.toUpperCase() == "REFUND" && documentClass == "AP") || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE")))) {
    } else if ((referenceType == "DATA_ENTRY" && formId == "#cashLcPaymentTabForm" && ((serviceType == "Application" && documentType == "REFUND") || (serviceType.toUpperCase() == "REFUND" && documentClass == "AP") || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE")))) {
        var paymentsummarydata = $("#grid_list_refund_main").jqGrid("getRowData", id);

        var params = {
    		documentPaymentSummary: JSON.stringify(paymentsummarydata),
        	proceedsPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "addSettlement",
            form: "lcPayment",
            chargeType: (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE") ? "PRODUCT" : "SETTLEMENT"
        }
        
        if (paymentsummarydata.paymentMode == "AP") {
            params.referenceId = paymentsummarydata.referenceId;
        }

        $.post(postUrl, params, function (data) {
            if (data.success == "false") {
            	$("#grid_list_refund_main").jqGrid('delRowData', id);
            }
            $("#grid_list_refund_main").trigger('reloadGrid');
        }).done(function(){
        	if(documentClass == "AP" && serviceType.toUpperCase() == "REFUND"){
        		$.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {
        			if (data2.paymentStatus in {"PAID":1,"NO_PAYMENT_REQUIRED":1}) {
        				$("#btnPrepare").removeAttr("disabled");
        			} else {
        				$("#btnPrepare").attr("disabled", "disabled");
        			}
        		});
        	}
        });
    } else if (referenceType == "PAYMENT" && formId == "#proceedsDetailsTabForm") {

        var paymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData", id);

        var params = {
            documentPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "addSettlement",
            form: "proceeds",
            chargeType: "SETTLEMENT",
            containsProductPayment: $("#containsProductPayment").val()
        }

        if (paymentsummarydata.paymentMode == "PDDTS") {
            $("#fundingReferenceNumber").val("");
            $("#swift").val("");
            $("#bank").val("");
            if(documentClass == "DP" && serviceType.toUpperCase() == "SETTLEMENT"){
            	$("#beneficiary").val($("#sellerName").val());
            } else {
            	$("#beneficiary").val("");
            }
            $("#pddtsAccountNumber").val("");
            $("#byOrder").val("");
            $("#pddtsAccountNumber").select2('data', {id: ''});

            $("#pddtsTabLi").show();
            $(".viewPddtsLi").show();

            if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                $("#chargesLi").show();
                $("#chargesPaymentLi").show();
            }
        }

        if (paymentsummarydata.paymentMode == "SWIFT") {
            $("#receivingBank").select2('data', {id: ''});

            $("#senderReference").val("");
            $("#bankOperationCode").val("");
            $("#currency").val("");
            $("#productAmount").val("");

            $("#orderingAccountNumber").select2('data', {id: ''});
            $("#bankNameAndAddress").val("");

            $("#accountWithInstitution").val("");
            $("#accountNameAndAddress").val("");

            if(documentClass == "DP" && serviceType.toUpperCase() == "SETTLEMENT"){
            	$("#beneficiaryName").val($("#sellerName").val());
            	$("#beneficiaryAddress").val($("#sellerAddress").val());
            } else {
	            $("#beneficiaryName").val("");
	            $("#beneficiaryAddress").val("");
            }
            $("#beneficiaryAccountNumber").select2('data', {id: ''});

            $("#detailsOfCharges").val("");
            $("#senderToReceiverInformation").val("");

            $("#mt103TabLi").show();
            $(".viewMt103Li").show();
            $(".hiddenViewMt").show();
            //$("#pddtsAmount").val();

            if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                $("#chargesLi").show();
                $("#chargesPaymentLi").show();
            }

        }

        $.post(postUrl, params, function (data) {
            if (data.success == "false") {
                $("#grid_list_proceeds_payment_summary").jqGrid('delRowData', id);
            }

            setupProceedsPayment();
            $("#grid_list_proceeds_payment_summary").trigger('reloadGrid');
        });
    } else if (referenceType == "PAYMENT" && serviceType == "PAYMENT") {

        var paymentsummarydata = $("#grid_list_payment_cdt").jqGrid("getRowData", id);

        var params = {
            documentPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "addSettlement",
            form: "lcPayment",
            chargeType: "PRODUCT"
        }

        $.post(postUrl, params, function (data) {
            if (data.success == "false") {
                $("#grid_list_payment_cdt").jqGrid('delRowData', id);
            }
            $("#grid_list_payment_cdt").trigger('reloadGrid');
        });
    }
}

// DISPATCHER
function dispatchDeleteCommand(id) {
    var params;

    if ((referenceType == "PAYMENT" && formId == "#chargesPaymentTabForm")) {

        var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData", id);

        params = {
            chargesPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "deleteSettlement",
            form: "chargesPayment",
            chargeType: "SERVICE",
            paymentMode: $("#grid_list_charges_payment").jqGrid("getRowData", id).paymentMode
        }

//        $.post(postUrl, params, function(data) {
//            //
//        });
    } else if ((referenceType == "DATA_ENTRY" && formId == "#productPaymentTabForm") || (referenceType == "PAYMENT" && (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm")) || (formId == "#paymentDetailsTabForm" && referenceType == "DATA_ENTRY")) {

        var paymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData", id);

        params = {
            documentPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "deleteSettlement",
            form: "lcPayment",
            chargeType: "PRODUCT",
            paymentMode: $("#grid_list_cash_payment_summary").jqGrid("getRowData", id).paymentMode
        }

//        $.post(postUrl, params, function(data) {
//            //
//        });
    } else if (referenceType == "PAYMENT" && formId == "#proceedsDetailsTabForm") {

        var paymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData", id);

        params = {
            documentPaymentSummary: JSON.stringify(paymentsummarydata),
            tradeServiceId: $("#tradeServiceId").val(),
            serviceType: $("#serviceType").val(),
            documentClass: $("#documentClass").val(),
            statusAction: "deleteSettlement",
            form: "proceeds",
            chargeType: "SETTLEMENT",
            paymentMode: $("#grid_list_proceeds_payment_summary").jqGrid("getRowData", id).paymentMode,
            containsProductPayment: $("#containsProductPayment").val()
        }
//    } else if ((formId == "#basicDetailsTabForm" && ((serviceType.toUpperCase() == "REFUND" && documentClass == "AP")) || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE")) || (formId == "#productPaymentTab")) {
    } else if ((formId == "#cashLcPaymentTabForm" && ((serviceType.toUpperCase() == "REFUND" && documentClass == "AP")) || (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE") || (serviceType == "Application" && documentClass == "MD")) || (formId == "#productPaymentTab")) {

        if (referenceType == "DATA_ENTRY") {
            var paymentsummarydata = $("#grid_list_refund_main").jqGrid("getRowData", id);
            params = {
        		documentPaymentSummary: JSON.stringify(paymentsummarydata),
        		proceedsPaymentSummary: JSON.stringify(paymentsummarydata),
                tradeServiceId: $("#tradeServiceId").val(),
                serviceType: $("#serviceType").val(),
                documentClass: $("#documentClass").val(),
                statusAction: "deleteSettlement",
                form: "lcPayment",
                chargeType: (documentClass == "AR" && serviceType.toUpperCase() == "SETTLE") ? "PRODUCT" : "SETTLEMENT",
                paymentMode: $("#grid_list_refund_main").jqGrid("getRowData", id).paymentMode
            }
            if (paymentsummarydata.paymentMode == "AP") {
                params.referenceId = paymentsummarydata.referenceId;
            }
            
        } else {
            params = {};
        }
    } else {
        params = {};
    }
    
    return params
}

function validateApAr(amount) {
    var apOutstandingBalance = parseFloat($("#apOutstandingBalance").val().replace(/,/g, ""));

    if (amount > apOutstandingBalance) {
        return "fail";
    }
}

// for charges payment only
function initializeInsert() {
    insertToChargesPaymentGrid();

    // updates total amount of payment charges
    // TODO: refactor this. this is a temporary quick fix for updating balances
//    alert(formId + "\n" + referenceType)
    if ((formId != "#paymentDetailsTabForm" && referenceType == "ETS") || (formId == "#chargesPaymentTabForm") && referenceType == "PAYMENT") {
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
//    commented out since javascript for this function is also commented out
//    onChangeApDocumentNumber();

    disableSettlementCurrency();

    disablePopup(activePopupDiv, activePopupBg);
}

function disableSettlementCurrency() {
    //Disable settlement currency if grid has one or more row/s
    var gr_row_count;

    if (formId.indexOf("cash") == -1 && formId != "#productPaymentTabForm") {
        gr_row_count = parseInt($("#grid_list_charges_payment").jqGrid("getGridParam", "reccount"));
        /*} else if(formId.indexOf("cash") != -1 || formId == "#productPaymentTabForm") {
         gr_row_count = parseInt($("#grid_list_cash_payment_summary").jqGrid("getGridParam","reccount"));*/
    }

    if ('undefined' !== typeof $("#settlementCurrency") &&
        $("#settlementCurrency").hasClass("select2_dropdown") && gr_row_count > 0) {
        $("#settlementCurrency").select2("disable");
    }
}


function insertToMd() {
    var modeOfPayment = $("#modeOfPaymentCharges").val();

    var gridToInsert = $("#grid_list_cash_payment_summary");
    var rates = constructRates('cash');

    var id = generateGuid(); //gridToInsert.jqGrid("getGridParam", "records");

    var modeOfPaymentText = $("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text();

    var accountNumber = "";
    var tradeSuspenseAccount = "";

    var referenceId = "";
    var apBalance = "";
    var accountName = "";

    if (modeOfPayment == "CASA") {
        accountNumber = ($("#accountNumber").val()).trim();
        accountName =  $("#popup_modeOfPaymentCharges #accountName").val();
    } else if ((modeOfPayment == "AP")) {
        accountNumber = $("#documentReferenceNumberAp").val();
        referenceId = $("#grid_list_ap_balance_charges").jqGrid("getGridParam", "selrow");
        if (referenceId == null) {
            referenceId = $("#apReferenceId").val();
            apBalance = $("#apOutstandingBalance").val();
        } else {
            apBalance = $("#grid_list_ap_balance_charges").jqGrid("getRowData", referenceId).apAmountCharges;
        }
    } else if (modeOfPayment == "CASH") {
        tradeSuspenseAccount = $("#cashTradeSuspenseAccount").val();
    } else if (modeOfPayment == "CHECK") {
        tradeSuspenseAccount = $("#checkTradeSuspenseAccount").val();
    } else if (modeOfPayment == "REMITTANCE") {
        tradeSuspenseAccount = $("#apRemittanceAccount").val();
    } else if (modeOfPayment == "IBT_BRANCH") {
        tradeSuspenseAccount = $("#ibtAccountNumber").val();
    }


    var addData;

    var deletePaymentSummary = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>"

    if (referenceType == "ETS") {
        addData = {
            amountSettlement: $("#mdCollectionAmount").val(),
            amount: $("#mdCollectionAmount").val(),
            modeOfPayment: modeOfPaymentText,
            settlementCurrency: $("#mdCurrency").val(),
            deletePaymentSummary: deletePaymentSummary,
            paymentMode: modeOfPayment,
            tradeSuspenseAccount: tradeSuspenseAccount,
            accountNumber: accountNumber,
            rates: rates,
            accountName : accountName
        }
    } else if (referenceType == "PAYMENT" || (referenceType == "DATA_ENTRY" && documentClass == "MD")) {
        var payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"

        addData = {
            accountNumber: accountNumber,
            modeOfPayment: modeOfPaymentText,
            settlementCurrency: $("#mdCurrency").val(),
            amountSettlement: $("#mdCollectionAmount").val(),
            deletePaymentSummary: deletePaymentSummary,
            status: "Not Paid",
            pay: payString,
            paymentMode: modeOfPayment,
            tradeSuspenseAccount: tradeSuspenseAccount,
            amount: $("#mdCollectionAmount").val(),
            rates: rates,
            accountName : accountName
        }
    }

    var validateAp = "success";

    if (modeOfPayment == "AP") {
        validateAp = validateApBalance($("#mdCollectionAmount").val(), apBalance);
    }

    if (validateAp == "success") {
        var validationResult = validateInsertValuesWithCurrency(gridToInsert, modeOfPayment, $("#mdCurrency").val());

        if (validationResult == "true") {
            gridToInsert.addRowData(id, addData);

            dispatchCommand(id);

            $("#mdCollectionAmount").val("");


        } else {
            $("#alertMessage").text("Cannot add mode of payment of the same type and currency.");

            triggerAlert();
        }
    }
}

function insertToProceeds() {

    var gridToInsert = $("#grid_list_proceeds_payment_summary");

    var modeOfPayment = $("#modeOfPaymentCharges").val();
    var modeOfPaymentText = $("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text();

    var accountNumber = "";
    var tradeSuspenseAccount = "";

    var referenceId = "";
    var apBalance = "";
    
    var accountName = "";

    if (modeOfPayment == "CASA") {
        accountNumber = ($("#accountNumber").val()).trim();
        accountName = $("#popup_modeOfPaymentCharges #accountName").val();
    }
    else if (modeOfPayment == "CASH") {
        tradeSuspenseAccount = $("#cashTradeSuspenseAccount").val();
    } else if ((modeOfPayment == "CHECK" || modeOfPayment == "MC_ISSUANCE" || modeOfPayment == "SWIFT")) {
        tradeSuspenseAccount = $("#checkTradeSuspenseAccount").val();
    } else if (modeOfPayment == "REMITTANCE" || modeOfPayment == "PDDTS") {
        tradeSuspenseAccount = $("#apRemittanceAccount").val();
    }

    var id = generateGuid(); //gridToInsert.jqGrid("getGridParam", "records");

    var payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"

    if (modeOfPayment == "MC_ISSUANCE" || modeOfPayment == "SWIFT" || modeOfPayment == "PDDTS") {
        payString = "";
    }

    var addData;

    var deletePaymentSummary = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>";

    if (referenceType == "ETS" || referenceType == "DATA_ENTRY") {
        addData = {
            modeOfPayment: modeOfPaymentText,
//                settlementCurrency: $("#amountOfPaymentCurrencyProceedBeneficiary").val(),
            settlementCurrency: $("#proceedsCurrency").val(),
//                amountSettlement: $("#amountOfPaymentProceedBeneficiary").val(),
            amountSettlement: $("#proceedsAmount").val(),
            deletePaymentSummary: deletePaymentSummary,
            paymentMode: modeOfPayment,
            tradeSuspenseAccount: tradeSuspenseAccount,
            accountNumber: accountNumber,
            accountName: accountName
        }
    } else if (referenceType == "PAYMENT") {
        addData = {
            modeOfPayment: modeOfPaymentText,
//                settlementCurrency: $("#amountOfPaymentCurrencyProceedBeneficiary").val(),
            settlementCurrency: $("#proceedsCurrency").val(),
//                amountSettlement: $("#amountOfPaymentProceedBeneficiary").val(),
            amountSettlement: $("#proceedsAmount").val(),
            deletePaymentSummary: deletePaymentSummary,
            paymentMode: modeOfPayment,
            tradeSuspenseAccount: tradeSuspenseAccount,
            accountNumber: accountNumber,
            referenceId: referenceId,
            status: "Not Paid",
            pay: payString,
            tradeSuspenseAccount: tradeSuspenseAccount,
            accountName: accountName
        }
    }


    var validateAp = "success";

    if (modeOfPayment == "AP") {
//    	validateAp = validateApBalance($("#amountOfPaymentCurrencyProceedBeneficiary").val(), apBalance)
        validateAp = validateApBalance($("#proceedsCurrency").val(), apBalance)
    }

    if (validateAp == "success") {

        var validationResult = validateInsertValues(gridToInsert, modeOfPayment);

        if (validationResult == "true") {
            gridToInsert.addRowData(id, addData);

            if (referenceType == "PAYMENT") {
                dispatchCommand(id);
            }

//            $("#amountOfPaymentProceedBeneficiary").val("");
        } else {
            $("#alertMessage").text("Cannot add mode of payment of the same type.");

            triggerAlert();
        }
    }
}

function insertToApRefund() {
    var gridToInsert;

    if (referenceType.toUpperCase() == "ETS") {
        gridToInsert = $("#grid_list_refund_branch");
    } else if (referenceType.toUpperCase() == "DATA_ENTRY") {
        gridToInsert = $("#grid_list_refund_main");
    }

    var accountNumber = "";
    var tradeSuspenseAccount = "";

    var setupString = "";

    var modeOfPayment = $("#modeOfPaymentCharges").val();
    var modeOfPaymentText = $("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text();

    var referenceId = "";
    
    var accountName = "";

    if (modeOfPayment == "CASA") {
    	accountNumber = ($("#accountNumber").val()).trim();
        accountName = $("#popup_modeOfPaymentCharges #accountName").val();
    } else if (modeOfPayment == "MC_ISSUANCE") {
        tradeSuspenseAccount = $("#checkTradeSuspenseAccount").val();
    } else if ((modeOfPayment == "AP")) {
        accountNumber = $("#documentReferenceNumberAp").val();
        referenceId = $("#grid_list_ap_balance_charges").jqGrid("getGridParam", "selrow");
        if (referenceId == null) {
            referenceId = $("#apReferenceId").val();
        }
    }

    var id = generateGuid(); //gridToInsert.jqGrid("getGridParam", "records");

   

    var addData;

    var payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"

    var deletePaymentSummary = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>";
    
    var tempCurrency = $("#apCurrency").val()
    var tempAmountOfPaymentCharges = $("#apAmount").val();
    var temptotalAmountOfRefund = $("#totalAmountOfRefund").val() ? $("#totalAmountOfRefund").val() : $("#totalAmountOfPayment").val();
    var tempAmountToBeRefunded = $("#amountDue").val();
    
    if (serviceType == 'Application' && documentType == 'REFUND'){
    	tempCurrency = $("#currency").val();
    	tempAmountOfPaymentCharges = $("#amountOfRefund").val();
    	tempAmountToBeRefunded = $("#amountOfMdToRefund").val();
    }

    addData = {
        accountNumber: accountNumber,
        amount: tempAmountOfPaymentCharges,
        modeOfPayment: modeOfPaymentText,
        currency: tempCurrency,
        deletePaymentSummary: deletePaymentSummary,
        paymentMode: modeOfPayment,
        tradeSuspenseAccount: tradeSuspenseAccount,
        pay: payString,
        accountName: accountName,
        referenceId: referenceId
    }

    var validationResult = validateInsertValues(gridToInsert, modeOfPayment);

    if (serviceType == "SETTLE" && documentClass == "AR"){
    	if (validationResult == "true") {
            gridToInsert.addRowData(id, addData);
            dispatchCommand(id);
            $("#apAmount").val("");
        } else {
            $("#alertMessage").text("Cannot add mode of payment of the same type.");
            triggerAlert();
        }	
    }else{
    	if ((parseFloat(tempAmountOfPaymentCharges.replace(",","")) + parseFloat(temptotalAmountOfRefund.replace(",",""))) > parseFloat(tempAmountToBeRefunded.replace(",",""))) {
        	triggerAlertMessage("Amount of Refund cannot be greater than Amount to be Refunded.")
    	}else if (validationResult == "true") {
            gridToInsert.addRowData(id, addData);
            dispatchCommand(id);
            $("#apAmount").val("");
        } else {
            $("#alertMessage").text("Cannot add mode of payment of the same type.");
            triggerAlert();
        }	
    }
}

function insertToNonMd() {
// insert to charges payment grid
    var gridToInsert;
    var rates;
    var modeOfPayment = $("#modeOfPaymentCharges").val();

    var modeOfPaymentText = $("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text();

    if (formId.indexOf("cash") != -1 || formId == "#productPaymentTabForm") {
        gridToInsert = $("#grid_list_cash_payment_summary");
        rates = constructRates('cash');
    } else {
        gridToInsert = $("#grid_list_charges_payment");
        rates = constructRates('charge');
    }
    
    var accountNumber = "";
    var tradeSuspenseAccount = "";
    var id = generateGuid(); //gridToInsert.jqGrid("getGridParam", "records");
    var setupString = "";
    var apBalance = "";
    var referenceId = "";
    var payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>";
    var accountName = "";
    if (modeOfPayment == "CASA") {
    	accountNumber = ($("#accountNumber").val()).trim();
        accountName = $("#popup_modeOfPaymentCharges #accountName").val();
    } else if ((modeOfPayment == "AP")) {
        //accountNumber = $("#documentReferenceNumberAp").text()//$("#documentReferenceNumberAp").val();
        var accNumVal = $("#documentReferenceNumberAp option[value='" + $("#documentReferenceNumberAp").val() + "']").text();
        accountNumber = accNumVal.substr(0, accNumVal.indexOf(" "));

        referenceId = $("#grid_list_ap_balance_charges").jqGrid("getGridParam", "selrow");
        if (referenceId == null) {
            referenceId = $("#apReferenceId").val();
            apBalance = $("#apOutstandingBalance").val();
        } else {
            apBalance = $("#grid_list_ap_balance_charges").jqGrid("getRowData", referenceId).apAmountCharges;
        }
    } else if (modeOfPayment == "CASH") {
        tradeSuspenseAccount = $("#cashTradeSuspenseAccount").val();
    } else if (modeOfPayment == "CHECK") {
        tradeSuspenseAccount = $("#checkTradeSuspenseAccount").val();
    } else if (modeOfPayment == "REMITTANCE") {
        tradeSuspenseAccount = $("#apRemittanceAccount").val();
    } else if (modeOfPayment == "IB_LOAN") { // specifically for negotiation
        setupString = getPopupFieldParameters("IB_LOAN");
        payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>";
    } else if (modeOfPayment == "TR_LOAN" || modeOfPayment == "DTR_LOAN") {
        setupString = getPopupFieldParameters("TR_LOAN");
        payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>";
    } else if (modeOfPayment == "UA_LOAN" || modeOfPayment == "DUA_LOAN") {
        setupString = getPopupFieldParameters("UA_LOAN");
        payString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>";
    } else if (modeOfPayment == "DBP") { // specifically for negotiation
        setupString = getPopupFieldParameters("DBP");
        payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>";
    }

    var tempAmountOfPaymentCharges = $("#amountOfPaymentCharges").val();

    var addData;

    var deletePaymentSummary = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>";

    var amountSettlement;
    if (formId.indexOf("cash") == -1 && formId != "#productPaymentTabForm") {
        if (referenceType == "ETS") {
            amountSettlement = tempAmountOfPaymentCharges;

            addData = {
                accountNumber: accountNumber,
                amount: tempAmountOfPaymentCharges,
                modeOfPayment: modeOfPaymentText,
                settlementCurrency: $("#settlementCurrency").val(),
                deletePaymentSummary: deletePaymentSummary,
                paymentMode: modeOfPayment,
                referenceId: referenceId,
                rates: rates,
                tradeSuspenseAccount: tradeSuspenseAccount,
                accountName : accountName
            }
        } else if (referenceType == "PAYMENT") {
            if (serviceType.toUpperCase() == "NEGOTIATION") {
                amountSettlement = tempAmountOfPaymentCharges;

                addData = {
                    accountNumber: accountNumber,
                    modeOfPayment: modeOfPaymentText,
                    settlementCurrency: $("#settlementCurrency").val(),
                    amount: tempAmountOfPaymentCharges,
                    amountSettlement: tempAmountOfPaymentCharges,
                    deletePaymentSummary: deletePaymentSummary,
                    status: "Not Paid",
                    pay: payString,
                    paymentMode: modeOfPayment,
                    referenceId: referenceId,
                    rates: rates,
                    tradeSuspenseAccount: tradeSuspenseAccount,
                    setupString: setupString,
                    accountName : accountName
                }
            } else {
                amountSettlement = tempAmountOfPaymentCharges;

                addData = {
                    accountNumber: accountNumber,
                    modeOfPayment: modeOfPaymentText,
                    settlementCurrency: $("#settlementCurrency").val(),
                    amount: tempAmountOfPaymentCharges,
                    amountSettlement: tempAmountOfPaymentCharges,
                    deletePaymentSummary: deletePaymentSummary,
                    status: "Not Paid",
                    pay: payString,
                    paymentMode: modeOfPayment,
                    referenceId: referenceId,
                    rates: rates,
                    tradeSuspenseAccount: tradeSuspenseAccount,
                    setupString: setupString,
                    accountName : accountName
                }
            }
        }
    } else {
        if (referenceType == "ETS") {
            if (serviceType.toUpperCase() == "NEGOTIATION") {
                if (documentType == "DOMESTIC") {
                    amountSettlement = $("#amountOfPaymentCharges").val();

                    addData = {
                        amountSettlement: $("#cashAmountInSettlement").val(),
                        modeOfPayment: modeOfPaymentText,
                        settlementCurrency: $("#settlementCurrencyLc").val(),
                        deletePaymentSummary: deletePaymentSummary,
                        paymentMode: modeOfPayment,
                        referenceId: referenceId,
                        rates: rates,
                        tradeSuspenseAccount: tradeSuspenseAccount,
                        accountNumber: accountNumber,
                        setupString: setupString,
                        amount: $("#cashAmountInLc").val(),
                        accountName : accountName
                    }
                } else {
                	amountSettlement = $("#cashAmountInSettlement").val();

                    addData = {
                        amountSettlement: $("#cashAmountInSettlement").val(),
                        amount: $("#cashAmountInLc").val(),
                        modeOfPayment: modeOfPaymentText,
                        settlementCurrency: $("#settlementCurrencyLc").val(),
                        deletePaymentSummary: deletePaymentSummary,
                        paymentMode: modeOfPayment,
                        referenceId: referenceId,
                        rates: rates,
                        tradeSuspenseAccount: tradeSuspenseAccount,
                        accountNumber: accountNumber,
                        setupString: setupString,
                        accountName : accountName
                    }
                }
            } else {
                amountSettlement = $("#cashAmountInSettlement").val();

                addData = {
                    amountSettlement: $("#cashAmountInSettlement").val(),
                    amount: $("#cashAmountInLc").val(),
                    modeOfPayment: modeOfPaymentText,
                    settlementCurrency: $("#settlementCurrencyLc").val(),
                    deletePaymentSummary: deletePaymentSummary,
                    paymentMode: modeOfPayment,
                    referenceId: referenceId,
                    rates: rates,
                    tradeSuspenseAccount: tradeSuspenseAccount,
                    accountNumber: accountNumber,
                    setupString: setupString,
                    accountName : accountName
                }
            }
        } else if (referenceType == "PAYMENT") {
            if (serviceType.toUpperCase() == "NEGOTIATION") {
                amountSettlement = $("#cashAmountInSettlement").val();

                addData = {
                    accountNumber: accountNumber,
                    modeOfPayment: modeOfPaymentText,
                    settlementCurrency: $("#settlementCurrencyLc").val(),
                    amountSettlement: $("#cashAmountInSettlement").val(),
                    deletePaymentSummary: deletePaymentSummary,
                    status: "Not Paid",
                    pay: payString,
                    paymentMode: modeOfPayment,
                    referenceId: referenceId,
                    rates: rates,
                    tradeSuspenseAccount: tradeSuspenseAccount,
                    amount: $("#cashAmountInLc").val(),
                    setupString: setupString,
                    accountName : accountName
                }
            } else {
                amountSettlement = $("#cashAmountInSettlement").val();
                addData = {
                    accountNumber: accountNumber,
                    modeOfPayment: modeOfPaymentText,
                    settlementCurrency: $("#settlementCurrencyLc").val(),
                    amountSettlement: $("#cashAmountInSettlement").val(),
                    deletePaymentSummary: deletePaymentSummary,
                    status: "Not Paid",
                    pay: payString,
                    paymentMode: modeOfPayment,
                    referenceId: referenceId,
                    rates: rates,
                    tradeSuspenseAccount: tradeSuspenseAccount,
                    amount: $("#cashAmountInLc").val(),
                    setupString: setupString,
                    accountName : accountName
                }
            }
        } else if (referenceType == "DATA_ENTRY") {
            amountSettlement = $("#cashAmountInSettlement").val();

            addData = {
                amountSettlement: $("#cashAmountInSettlement").val(),
                amount: $("#cashAmountInLc").val(),
                modeOfPayment: modeOfPaymentText,
                settlementCurrency: $("#settlementCurrencyLc").val(),
                status: "Not Paid",
                deletePaymentSummary: deletePaymentSummary,
                paymentMode: modeOfPayment,
                referenceId: referenceId,
                rates: rates,
                tradeSuspenseAccount: tradeSuspenseAccount,
                accountNumber: accountNumber,
                setupString: setupString,
                pay: payString,
                accountName : accountName
            }
        }
    }

    var validateAp = "success";

    if (modeOfPayment == "AP") {
        validateAp = validateApBalance(amountSettlement, apBalance)
    }

    if (modeOfPayment == "CASA") {
        if (!$("#accountNumber").val()) {
            $("#alertMessage").text("Please enter CASA Account Number.");
            triggerAlert();
            $("#cashAmountInSettlement, #cashAmountInLc").val("");
            return;
        }
    }


    if (validateAp == "success") {
        var validationResult = validateInsertValues(gridToInsert, modeOfPayment);


//        $.post(computeTotalUrl,{addData: addData},function(data) {
//
//        });


        if (validationResult == "true") {
            gridToInsert.addRowData(id, addData);


            dispatchCommand(id);
            $("#amountOfPaymentCharges").val("");
            $("#cashAmountInSettlement, #cashAmountInLc").val("").removeAttr("disabled").removeAttr("readonly");
            $("#popup_btn_mode_of_payment_cash").attr("disabled", "disabled");
        } else {
            $("#popup_btn_mode_of_payment_cash").removeAttr("disabled");
            $("#alertMessage").text("Cannot add mode of payment of the same type.");
            triggerAlert();
        }
    }

    if ((referenceType == "DATA_ENTRY" && formId == "#productPaymentTabForm")) {
        dispatchCommand(id);
    }
}

// inserts to charges payment grid
function insertToChargesPaymentGrid() {
    if (formId == "#paymentDetailsTabForm") {

        insertToMd();
    } else if (formId == "#proceedsDetailsTabForm") {
        insertToProceeds();
    } else {
        if (formId == "#basicDetailsTabForm") {
            if (documentClass == "CDT") {
                insertToCdt();
//            } else {
            }
        } else if (documentClass in {AP:1, AR:1} || (serviceType == "Application" && documentType == "REFUND")) {
        	insertToApRefund();
        } else {
            insertToNonMd();
        }
    }

}

function insertToCdt() {
    var gridToInsert = $("#grid_list_payment_cdt");

    var accountNumber = "";
    var tradeSuspenseAccount = "";

    var setupString = "";

    var modeOfPayment = $("#modeOfPaymentCharges").val();
    var modeOfPaymentText = $("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text();

    var referenceId = "";
    
    var accountName = "";

    if (modeOfPayment == "CASA") {
    	accountNumber = ($("#accountNumber").val()).trim();
        accountName = $("#popup_modeOfPaymentCharges #accountName").val();
    } else if (modeOfPayment == "MC_ISSUANCE") {
        tradeSuspenseAccount = $("#checkTradeSuspenseAccount").val();
    } else if ((modeOfPayment == "AP")) {
        accountNumber = $("#documentReferenceNumberAp").val();
        referenceId = $("#grid_list_ap_balance_charges").jqGrid("getGridParam", "selrow");
        if (referenceId == null) {
            referenceId = $("#apReferenceId").val();
        }
    }

    var id = generateGuid(); //gridToInsert.jqGrid("getGridParam", "records");

    var tempAmountOfPaymentCharges = $("#amountOfPayment").val();

    var addData;

    var payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"

    var deletePaymentSummary = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>";

    addData = {
        accountNumber: accountNumber,
        amountSettlement: tempAmountOfPaymentCharges,
        modeOfPayment: modeOfPaymentText,
        settlementCurrency: "PHP",
        deletePaymentSummary: deletePaymentSummary,
        paymentMode: modeOfPayment,
        tradeSuspenseAccount: tradeSuspenseAccount,
        pay: payString,
        status: "Not Paid",
        accountName: accountName
    }

    var validationResult = validateInsertValues(gridToInsert, modeOfPayment);

    if (validationResult == "true") {
        gridToInsert.addRowData(id, addData);


        dispatchCommand(id);

        $("#amountOfPayment").val("");
    } else {
        $("#alertMessage").text("Cannot add mode of payment of the same type.");

        triggerAlert();
    }
}

function updateTotalsCdt() {
    var gridData = $("#grid_list_payment_cdt").jqGrid("getRowData");

    var amounts = [];

    $.each(gridData, function (idx, data) {
        amounts.push(data.amountSettlement.replace(/,/g, "*"));
    });

    $.post(computeTotalUrl, {amounts: amounts.toString()}, function (data) {
        $("#totalAmountOfPayment").val(data.totalAmount).change();
    });
}

function updateTotalProceeds() {
    var gridData = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");

    var amounts = [];

    $.each(gridData, function (idx, data) {
        amounts.push(data.amountSettlement.replace(/,/g, "*"));
    });

    $.post(computeTotalUrl, {amounts: amounts.toString()}, function (data) {
        var due = parseFloat($("#proceedsAmount").val().replace(/,/g, ""));
        var balance = due - parseFloat(data.totalAmount.replace(/,/g, ""));
        $("#remainingAmountBalance").val(formatCurrency(balance));
        $("#totalProceedsPayment").val(formatCurrency(data.totalAmount));
    });
}

// update total amount of payment charges
function updateTotalAmountOfPaymentCharges(form) {
    if ((documentClass == "LC" && documentType == "DOMESTIC" && serviceType.toUpperCase() == "NEGOTIATION" && form == "#proceedsDetailsTabForm") || form == "#proceedsDetailsTabForm") {
        updateTotalProceeds();
    } else if (documentClass == "CDT") {
        updateTotalsCdt();
    } else {
        var gridData;
        var total;
        var balance;
        var excess;
        var due;
        var amounts = [];

        if ((form.indexOf("cash") == -1 && form != "#productPaymentTabForm") && form.indexOf("negotiationPayment") == -1) {
                gridData = $("#grid_list_charges_payment").jqGrid("getRowData");

                due = $("#totalAmountDue");
                total = $("#totalAmountOfPaymentCharges");
                balance = $("#remainingBalance");
                excess = $("#excessAmountCharges");
                
                $.each(gridData, function (idx, data) {
                    if (referenceType == "ETS") {
                        amounts.push(data.amount.replace(/,/g, "*"));
                    } else if (referenceType == "PAYMENT") {
                        amounts.push(data.amountSettlement.replace(/,/g, "*"));
                    }
                })

        } else if (form.indexOf('cash') != -1 || form == "#productPaymentTabForm") {

            if (form == "#cashLcPaymentTabForm" && documentClass == "AP") {
                if (referenceType == "ETS") {
                    gridData = $("#grid_list_refund_branch").jqGrid("getRowData");
                } else {
                    gridData = $("#grid_list_refund_main").jqGrid("getRowData");
                }

                due = $("#amountDue");
                total = $("#totalAmountOfRefund");
                balance = $("#apAmount");
                excess = $("#excessAmount");
                $.each(gridData, function (idx, data) {
                    if (referenceType == "ETS") {
                        amounts.push(data.amount.replace(/,/g, "*"));
                    } else if (referenceType == "DATA_ENTRY") {
                        amounts.push(data.amount.replace(/,/g, "*"));
                    }

                })
            } else if (form == "#cashLcPaymentTabForm" && documentClass == "AR") {
                if (referenceType == "ETS") {
                    gridData = $("#grid_list_refund_branch").jqGrid("getRowData");
                } else {
                    gridData = $("#grid_list_refund_main").jqGrid("getRowData");
                }

                total = $("#totalAmountOfPayment");
                due = $("#amountDue");
                balance = $("#amountBalance");
                excess = $("#excessAmount");
                $.each(gridData, function (idx, data) {
                    if (referenceType == "ETS") {
                        amounts.push(data.amount.replace(/,/g, "*"));
                    } else if (referenceType == "DATA_ENTRY") {
                        amounts.push(data.amount.replace(/,/g, "*"));
                    }

                })
            } else {

	            gridData = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	            
	            due = $("#totalAmountDueLc");
	            total = $("#totalAmountOfPaymentLc");
	            balance = $("#remainingBalanceLc");
	
	
	            if ($("#totalAmountDueLc").val() == "") {
	                due = $("#totalAmountDueLcDisplay")
	                //balance = $("#remainingBalanceLcDisplay")
	            }
	
	            excess = $("#excessAmountLc");
	
	            $.each(gridData, function (idx, data) {
	
	                //if (documentType == "DOMESTIC" && ) {
	                if (((serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT") && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY" || referenceType == "PAYMENT"))) {
	                    //amounts.push(data.amountSettlement.replace(/,/g, "*"));
	                    amounts.push(data.amount.replace(/,/g, "*"));
	                } /*else if (serviceType.toUpperCase() == "SETTLEMENT" && documentClass == "DP") {
	                    amounts.push(data.amountSettlement.replace(/,/g, "*"));
	                } */else {
	//                    if(serviceType.toUpperCase() == "NEGOTIATION" && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY"))
	                    amounts.push(data.amount.replace(/,/g, "*"));
	                }
	
	                return true;
	            })
	        }
        }

        if (computeTotalUrl != "") {
            // compute total payment charges
            var allAmount = 0;
            if (amounts.toString() != "") {
                allAmount = amounts.toString();
            }
            $.post(computeTotalUrl, {amounts: allAmount}, function (data) {
            	if(data.totalAmount){
	                var computedTotalAmount = data.totalAmount;
	                total.val(computedTotalAmount.substr(0, computedTotalAmount.length - 2));
            	}

                if ($("#proceedsDetailsTabForm").length > 0) { // if proceeds is available
                    if (documentSubType1 != null && documentSubType1.toUpperCase() == "CASH") {
                        $("#proceedsAmount").val($("#negotiationAmount").val());
                    } else {
                        //$("#proceedsAmount").val($("#totalAmountOfPaymentLc").val());
                        if ($("#productAmount").length > 0 && (documentClass == 'DR' ||
                            documentClass == 'DA' ||
                            documentClass == 'DP' ||
                            documentClass == 'OA')) {
                            //$("#proceedsAmount").val(formatCurrency($("#productAmount").val()));
                            var productAmount = $("#productAmount").val();

                            if (productAmount.indexOf(",") == -1) {
                                $("#proceedsAmount").val(formatCurrency(productAmount));
                            } else {
                                $("#proceedsAmount").val(productAmount);
                            }
                        }

                        if (serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT") {
                            $("#proceedsAmount").val($("#amount").val());
                        }

                        if (serviceType == "NEGOTIATION" && documentClass == "LC") {
                            $("#proceedsAmount").val($("#negotiationAmount").val());
                        }
                    }
                    setupProceedsPayment();
                }

                    // compute balance and excess
                    $.post(computeBalanceUrl, {totalAmountDue: due.val(), totalAmount: data.totalAmount}, function (data2) {
                    	if(data2.balance){
	                        var computedBalanceAmount = data2.balance;
	                        var computedExcessAmount = data2.excess;
	                        balance.val(computedBalanceAmount.substr(0, computedBalanceAmount.length - 2));
	
	                        excess.val(computedExcessAmount.substr(0, computedExcessAmount.length - 2));
	                        balance.change();
	//                        var caller = arguments.callee.caller.toString();
	//                        if (caller.indexOf("setupLcPayment") != -1) {
	//                                $("#remainingBalanceLc").val(computedBalanceAmount.substr(0,computedBalanceAmount.length - 2));
	//                                $("#excessAmountLc").val(computedExcessAmount.substr(0,computedExcessAmount.length - 2));
	//                        }
	                        
	                        if ('undefined' != typeof documentSubType1 && documentSubType1 == "CASH") {
	                        	disableChargesLc();
	                            disableChargesSettlement();
                        }
                    	}
                    })
            });
        }
        if ((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm") && !(documentClass in {AR:1, AP:1}) ) {	// displays all related currencies for cash lc grid
            if (serviceType != "Application" && documentType != "REFUND"){
            	loadRelatedExchangeRates();
            }
        }
    }
}


function disableChargesLc() {
	//
//	    if($("#cashAmountInLc").attr("readonly") == "readonly"){
	//
//	    }

	    if ('undefined' !== typeof $("#cashAmountInSettlement").val()){
	    	if($("#cashAmountInSettlement").val().length > 0){
	    		$("#cashAmountInLc").attr("readonly", "readonly").attr("disabled", "disabled");
	    	}
	    } else {
	        $("#cashAmountInLc").removeAttr("readonly").removeAttr("disabled");
	    }
}

function disableChargesSettlement() {
	if ('undefined' !== typeof $("#cashAmountInLc").val()){
		if ($("#cashAmountInLc").val().length > 0 && 'undefined' !== typeof $("#cashAmountInSettlement")) {
			$("#cashAmountInSettlement").attr("readonly", "readonly").attr("disabled", "disabled");					
		}
	}else{
		$("#cashAmountInSettlement").removeAttr("readonly").removeAttr("disabled");
	}
}

function validateGridValues() {
    var success = true;
    var rowCount = 0;

    if (formId == "#proceedsDetailsTabForm") {
        rowCount = $("#grid_list_proceeds_payment_summary").getGridParam("records");
    } else if (formId.indexOf("cash") == -1 && formId != "#productPaymentTabForm") {
        rowCount = $("#grid_list_charges_payment").getGridParam("records");
    } else if (formId.indexOf("cash") != -1 || formId == "#productPaymentTabForm") {
        rowCount = $("#grid_list_cash_payment_summary").getGridParam("records");
    }

    if (rowCount == 1 && formId == "#proceedsDetailsTabForm") {
        $("#alertMessage").text("Only One proceeds settlement is allowed.");
        success = false;
    } else if (rowCount == 3) {
        $("#alertMessage").text("Settlement charges cannot be more than 3.");
        success = false;
    }

    return success;
}

function onConstructModesOfPayment() {
	
//	alert("LC Mode of Pay")
	
    $("#md_balance").css("display", "none");
    $('#modeOfPaymentCharges').empty();
    $('#modeOfPaymentCharges').append(
        $('<option></option>').val("").html("SELECT ONE...")
    );
    $("#accountNumber").select2('data', {id: ""}); // clears account number selected

    //return if there is error in charges payment tab
    if ($.isFunction(evaluateChargesPayment)) {
        if (evaluateChargesPayment()) return;//function in charges_payment_tab_utility
    }
    //return if there is error in basic_details_collection_md.js
    if (typeof evaluateMdPaymentDetails === 'function') {
        if (evaluateMdPaymentDetails()) return;//function in charges_payment_tab_utility
    }
    var thisid = this.id;

    var ajaxPostUrl = modeOfPaymentUrl;

    var cifNumber = $("#cifNumber").val();
    var form = formId;
    var serviceType = $("#serviceType").val();
    var settlementCurrency = $("#settlementCurrency").val();

    if (formId == "#proceedsDetailsTabForm") {
//    	settlementCurrency = $("#amountOfPaymentCurrencyProceedBeneficiary").val();
        settlementCurrency = $("#proceedsCurrency").val();
    }
    else if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        if ("" == $("#settlementCurrencyLc").val()) {
            $("#alertMessage").text("Please select a Settlement Currency.");
            triggerAlert();
            return;
        }

        settlementCurrency = $("#settlementCurrencyLc").val();

        if ($("#documentClass").val() == "MD") {
            settlementCurrency = $("#mdCurrency").val();
        }
    }
//    else if (formId == "#basicDetailsTabForm"){
    else if (formId == "#cashLcPaymentTabForm"){
    	if($("#documentClass").val() in {AR:1, AP:1}) {
    		settlementCurrency = $("#apCurrency").val();
    	}
    }
    var referenceType = $("#referenceType").val();
    var documentClass = $("#documentClass").val();
    var documentType = $("#documentType").val();
    var documentSubType1 = $("#documentSubType1").val();
    var documentSubType2 = $("#documentSubType2").val();
    var settlementMode = $("#settlementModeNonLc").val();

    var tradeServiceId = $("#tradeServiceId").val();

    var params = {
        cifNumber: cifNumber,
        form: form,
        serviceType: serviceType,
        settlementCurrency: settlementCurrency,
        referenceType: referenceType,
        documentClass: documentClass,
        documentType: documentType,
        documentSubType1: documentSubType1,
        documentSubType2: documentSubType2,
        settlementMode: settlementMode,
        documentNumber: $("#documentNumber").val()
    }

    $.post(ajaxPostUrl, params, function (data) {
        $('#modeOfPaymentCharges').empty();
        $('#modeOfPaymentCharges').append(
            $('<option></option>').val("").html("SELECT ONE...")
        );

        $.each(data, function (key, value) {
            if (key == "CASA") {
                $("#accountNumberCheck").val("C");
                $("#accountNumber").queryCasaAccountNumbersByCurrency((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") ? "#settlementCurrencyLc" : "#settlementCurrency");
            }
            $('#modeOfPaymentCharges').append(
                $('<option></option>').val(key).html(value)
            );
        });

        onAddSettlementCharges(thisid);
    });
}


function onAddSettlementCharges(thisid) {
    // set parent id to determine what triggers mode of payment
//	parent_id = this.id;

    var success = validateGridValues();

    if (success == false) {
        triggerAlert();
        return true;
    }

    // clear fields
    $("#modeOfPaymentCharges").val("");
    $(".display-casa-charges :input").val("");
    $(".display-check-charges :input").val("");
    $(".display-cash-charges :input").val("");
    $(".display-remittance-cash :input").val("");
    $(".display-apply-ap-charges :input").val("");
    $(".display-ap-balance2_charges :input").val("");
    $(".display-ap-balance1_charges :input").val("");

    $(".display-ib-tr-loan :input[type=text]").val("");
    $(".display-ua-loan :input[type=text]").val("");
    $(".display_ibt_branch :input[type=text]").val("");

    $(".display-ib-tr-loan :input[type=radio]").attr("checked", false);
    $(".display-ua-loan :input[type=radio]").attr("checked", false);
    $(".display_ibt_branch :input[type=radio]").attr("checked", false);

    $(".display-casa-charges").css("display", "none");
    $(".display-check-charges").css("display", "none");
    $(".display-cash-charges").css("display", "none");
    $(".display-remittance-cash").css("display", "none");
    $(".display-apply-ap-charges").css("display", "none");
    $(".display-ap-balance2_charges").css("display", "none");
    $(".display-ap-balance1_charges").css("display", "none");
    $('.display-ib-tr-loan').css("display", "none");
    $('.display-ua-loan').css("display", "none");
    $('.mode_of_payment_buttons').css("display", "none");
    $(".display_ibt_branch").css("display", "none");

    //initiate default values for ib/tr loan
    $(".display-ib-tr-loan :input[id=interestTermNegotiation]").val("30");
    $(".display-ib-tr-loan :input[id=repricingTermNegotiation]").val("30");
    $(".display-ib-tr-loan :input[id=loanTermNegotiation]").val("30");
    computeNegotiationMaturityDate()

    if (thisid.indexOf("cash") != -1) {
        if ($("#serviceType").val().toLowerCase() != "negotiation" && ($("#serviceType").val().toLowerCase() != "ua loan settlement" || $("#serviceType").val().toLowerCase() != "ua_loan_settlement")) {
            $('#popup_header_modeOfPaymentCharges').text("Mode of Payment");
        } else if ($("#serviceType").val().toLowerCase() == "negotiation") {
            $('#popup_header_modeOfPaymentCharges').text("Mode of Payment - Negotiation Amount");
        } else {
            $('#popup_header_modeOfPaymentCharges').text("Mode of Payment - UA Loan Amount");
        }
    } else if (thisid.indexOf("proceeds") == 26) {
        $('#popup_header_modeOfPaymentCharges').text("Mode of Settlement to Beneficiary");
    } else {
        $('#popup_header_modeOfPaymentCharges').text("Mode of Payment");
    }

    loadPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg")
    centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
}

// closes mode of payment popup
function onCloseSettlementCharges() {
    $("#modeOfPaymentCharges").val("");
    $(".display-casa-charges").css("display", "none");
    $(".display-check-charges").css("display", "none");
    $(".display-cash-charges").css("display", "none");
    $(".display-remittance-cash").css("display", "none");
    $(".display-apply-ap-charges").css("display", "none");
    $(".display-ap-balance2_charges").css("display", "none");
    $(".display-ap-balance1_charges").css("display", "none");
    $('.display-ib-tr-loan').css("display", "none");
    $('.display-ua-loan').css("display", "none");
    $('.mode_of_payment_buttons').css("display", "none");
    $(".display_ibt_branch").css("display", "none");
    disablePopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
}

// event triggered on change mode of payment
var ibDbpTrDtr;
var uaDua;
function changeModeOfPayment() {
    $("#apReferenceId").val("");
//    $("#arReferenceId").val("");
    $("#cashTradeSuspenseAccount").val("");
    $("#checkTradeSuspenseAccount").val("");

    var pCharges = $("#modeOfPaymentCharges");
    var dNCharges = $("#documentReferenceNumberAp");
//	var dNCharges2 = $("#documentReferenceNumberAr")
    var casaDisplayCharges = $(".display-casa-charges");
    var checkDisplayCharges = $(".display-check-charges");
    var cashDisplayCharges = $(".display-cash-charges");
    var remittanceDisplayCharges = $(".display-remittance-cash");
    var applyDisplayCharges = $(".display-apply-ap-charges");
    var apBalDisplay2Charges = $(".display-ap-balance2_charges");
    var apBalDisplay1Charges = $(".display-ap-balance1_charges");
    ibDbpTrDtr = $('.display-ib-tr-loan').length != 0 ? $('.display-ib-tr-loan').detach() : ibDbpTrDtr;
    uaDua = $('.display-ua-loan').length != 0 ? $('.display-ua-loan').detach() : uaDua;
    $(".display_ibt_branch").css("display", "none");

    $("#md_balance").css("display", "none");
    $("#loanTermNegotiation").removeAttr("readonly");
    $("#loanCodeFlagNegotiation").removeAttr("readonly");

//    if(pCharges.val().toLowerCase()=="debit from casa"){
    if ($("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text().toLowerCase() == "debit from casa") {
        $(".label_debit_casa").show();
        $(".label_credit_casa").hide();
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
        casaDisplayCharges.css("display", "block");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        if (serviceType == "MD") {
            $(".md_casa").css("display", "block");
        }

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");

        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("enable");
        }
        $("#accountNumberCheck").show();
        $("#accountNameCheck").hide();

        var currency = (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") ? "#settlementCurrencyLc" : "#settlementCurrency";

        if (documentClass == "MD") {
            currency = "#mdCurrency";
        }

        $("#accountNumber").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").queryCasaAccountNumbersByCurrency(currency);
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="credit to casa" ){
    } else if ($("#modeOfPaymentCharges option[value='" + $("#modeOfPaymentCharges").val() + "']").text().toLowerCase() == "credit to casa") {
        $(".label_debit_casa").hide();
        $(".label_credit_casa").show();
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
        casaDisplayCharges.css("display", "block");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        if (serviceType == "MD") {
            $(".md_casa").css("display", "block");
        }

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");

        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("enable");
        }

        $("#accountNumberCheck").hide();
        $("#accountNameCheck").show();
        $("#accountNumber").toggleClass("select2_dropdown", false).toggleClass("input_field", true).select2('destroy');
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="check" ||pCharges.val().toLowerCase()== "issuance to mc" ||pCharges.val().toLowerCase()== "remittance via swift" ){
    } else if (pCharges.val() == "CHECK" || pCharges.val() == "MC_ISSUANCE" || pCharges.val() == "SWIFT") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "block");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");
        $(".display_ibt_branch").css("display", "none");

        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="cash"){
    } else if (pCharges.val() == "CASH") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "block");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="remittance" || pCharges.val().toLowerCase()=="remittance via pddts"){
    } else if (pCharges.val() == "REMITTANCE" || pCharges.val() == "PDDTS") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "block");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="apply ap"){
    } else if (pCharges.val() == "AR") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "none");
        dNCharges.val("");
//        dNCharges2.val("");
//        dNCharges.hide();
//        dNCharges2.show();
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
//        applyDisplayCharges.css("display", "block");
        applyDisplayCharges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
    } else if (pCharges.val() == "AP") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "none");
        dNCharges.val("");
//        dNCharges2.val("");
        dNCharges.show();
//        dNCharges2.hide();
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "block");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");

        // setup ap
        setupAps();

        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//	}else if(pCharges.val().toLowerCase()=="set-up ar" || pCharges.val().toLowerCase()=="cash lc"){
//    }else if(pCharges.val() == "AR" || pCharges.val() == "CASH_LC"){
    } else if (pCharges.val() == "CASH_LC") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");

//	}else if(pCharges.val().toLowerCase()=="ib loan" || pCharges.val().toLowerCase()=="dbp loan" || pCharges.val().toLowerCase() == "tr loan" || pCharges.val().toLowerCase() == "dtr loan"){
    } else if (pCharges.val() == "IB_LOAN" || pCharges.val() == "DBP" || pCharges.val() == "TR_LOAN" || pCharges.val() == "DTR_LOAN") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        if ($("#modeOfPaymentTitleTable").siblings().filter(".display-ib-tr-loan").length == 0) {
            uaDua.remove();
            $("#modeOfPaymentTitleTable").parent().append(ibDbpTrDtr);
        }
        ibDbpTrDtr.css("display", "block");
        uaDua.css("display", "none");

        $(".display_ibt_branch").css("display", "none");
        /*else if (pCharges.val() == "UA_LOAN") {  // fix for issue#851
            $.post(getLoanMaturityDateUrl, {}, function (data) {
                $("#loanMaturityDate").val(data.maturityDate);
            });
        }*/
        $("#md_balance").css("display", "none");

        $('input:radio[name=loanCodeFlagNegotiation]').filter('[value=D]').prop('checked', true);
        $('input:radio[name=interestCodeFlagNegotiation]').filter('[value=D]').prop('checked', true);
        if (pCharges.val() == "IB_LOAN" || pCharges.val() == "DBP") {
            $("#loanTermNegotiation").val(30).attr('readonly', 'readonly');
            $("#interestTermNegotiation").val(30).attr('readonly', 'readonly');
//            $("#loanCodeFlagNegotiation input:radio").attr('readonly', 'readonly');
//            $("input:radio[name=loanCodeFlagNegotiation]").attr('disabled', 'disabled');
//            $("input:radio[name=interestCodeFlagNegotiation]").attr('disabled', 'disabled');
            $("input:radio[name=loanCodeFlagNegotiation]").filter('[value=M]').prop('disabled', 'disabled');
            $("input:radio[name=interestCodeFlagNegotiation]").filter('[value=M]').prop('disabled', 'disabled');
            $("#loanMaturityDate").datepicker("disable");
            computeNegotiationMaturityDate();
        } else {
        	$("#loanTermNegotiation").removeAttr('readonly');
        	$("#interestTermNegotiation").removeAttr('readonly');
        	$("input:radio[name=loanCodeFlagNegotiation]").filter('[value=M]').removeProp('disabled');
        	$("input:radio[name=interestCodeFlagNegotiation]").filter('[value=M]').removeProp('disabled');
        	$("#loanMaturityDate").datepicker("enable");
        }
        if (pCharges.val() in {IB_LOAN:1, TR_LOAN:1, DTR_LOAN:1}) {
            computeNegotiationMaturityDate();
        }
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//	}else if(pCharges.val().toLowerCase()=="ua loan" || pCharges.val().toLowerCase()=="dua loan"){
    } else if (pCharges.val() == "UA_LOAN" || pCharges.val() == "DUA_LOAN") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        if ($("#modeOfPaymentTitleTable").siblings().filter(".display-ua-loan").length == 0) {
            ibDbpTrDtr.remove();
            $("#modeOfPaymentTitleTable").parent().append(uaDua);
        }
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "block");

        $(".display_ibt_branch").css("display", "none");

        // fix for issue#851
//        if (pCharges.val() == "UA_LOAN") {
//            $.post(getLoanMaturityDateUrl, {}, function (data) {
//                $("#loanMaturityDate").val(data.maturityDate);
//            });
//        }
        $("#md_balance").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
    }
//    else if(pCharges.val() == "UA_LOAN" || pCharges.val() == "DUA_LOAN"){
//        var maturityDateUrl = getLoanMaturityDateUrl;
//
//        // compute loan maturity date
//        $.post(maturityDateUrl,{},function(data) {
//            $("#loanMaturityDateUsance").val(data.maturityDate);
//        });
//
//		$('.mode_of_payment_buttons').css("display", "block");
//		dNCharges.val("");
////        dNCharges2.val("");
//		casaDisplayCharges.css("display", "none");
//		checkDisplayCharges.css("display", "none");
//		cashDisplayCharges.css("display", "none");
//		remittanceDisplayCharges.css("display", "none");
//		applyDisplayCharges.css("display", "none");
//		apBalDisplay2Charges.css("display", "none");
//		apBalDisplay1Charges.css("display", "none");
//		ibDbpTrDtr.css("display","none");
//		uaDua.css("display","block");
//        $(".display_ibt_branch").css("display","none");
//		centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//	}
    else if (pCharges.val() == "IBT_BRANCH") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $(".display_ibt_branch").css("display", "block");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");
        dNCharges.val("");

//        dNCharges2.val("");
        $('.mode_of_payment_buttons').css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
        $("#md_balance").css("display", "none");
    } else if (pCharges.val() == "MD") {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $(".label_debit_casa").show();
        $(".label_credit_casa").hide();
        $('.mode_of_payment_buttons').css("display", "block");
        dNCharges.val("");
//        dNCharges2.val("");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");

        $("#md_balance").css("display", "block");
        $.post(getMdBalanceUrl, {currency: $("#settlementCurrencyLc").val(), documentNumber: $("#documentNumber").val()}, function (data) {
            $("#mdBalance").val(data.totalBalance);
        });
//        $(".md_casa").css("display", "block");

        $(".display_ibt_branch").css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
    } else {
        if ($("#accountNumber").length > 0) {
            $("#accountNumber").select2("disable");
        }
        $(".display_ibt_branch").css("display", "none");
        casaDisplayCharges.css("display", "none");
        checkDisplayCharges.css("display", "none");
        cashDisplayCharges.css("display", "none");
        remittanceDisplayCharges.css("display", "none");
        applyDisplayCharges.css("display", "none");
        apBalDisplay2Charges.css("display", "none");
        apBalDisplay1Charges.css("display", "none");
        ibDbpTrDtr.css("display", "none");
        uaDua.css("display", "none");
        dNCharges.val("");
//        dNCharges2.val("");
        $('.mode_of_payment_buttons').css("display", "none");
        centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
    }
}

// event triggered on change document number
//function changeDocumentNumber() {
//	var dNCharges=$("#documentReferenceNumber");
//	var apBalDisplay2Charges=$(".display-ap-balance2_charges");
//	var apBalDisplay1Charges=$(".display-ap-balance1_charges");
//
//	if(dNCharges.val().toLowerCase()=="document number 1"){
//		$('.mode_of_payment_buttons').css("display", "block");
//		apBalDisplay2Charges.css("display", "block");
//		apBalDisplay1Charges.css("display", "none");
//		centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//
//	}else if(dNCharges.val().toLowerCase()=="document number 2"){
//		$('.mode_of_payment_buttons').css("display", "block");
//		apBalDisplay2Charges.css("display", "none");
//		apBalDisplay1Charges.css("display", "block");
//		centerPopup("popup_modeOfPaymentCharges", "mode_of_payment_charges_bg");
//	}
//	else{
//		apBalDisplay2Charges.css("display", "none");
//		apBalDisplay1Charges.css("display", "none");
//	}
//}

function onErrorCorrectClick(id) {
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");

    var grid;
    var gridData;
    var form;
    var params;

    if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
        form = "chargesPayment"

        gridData = grid.jqGrid("getRowData", id);

        var amount = gridData.amountSettlement

        if (amount == undefined) {
            amount = gridData.amount
        }

        params = {
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.paymentMode,
            settlementCurrency: gridData.settlementCurrency,
//            amount: gridData.amount,
//            amount: gridData.amountSettlement,
            amount: amount,
            status: gridData.status,
            statusAction: "errorCorrect",
            form: form,
            tradeServiceId: $("#tradeServiceId").val(),
            chargeType: "SERVICE",
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            accountName: gridData.accountName
        }
    } else if ((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm") || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_cash_payment_summary");
        form = "lcPayment";

        gridData = grid.jqGrid("getRowData", id);

        params = {
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.paymentMode,
            settlementCurrency: gridData.settlementCurrency,
//            amount: gridData.amount,
            amount: gridData.amountSettlement,
            status: gridData.status,
            statusAction: "errorCorrect",
            form: form,
            tradeServiceId: $("#tradeServiceId").val(),
            chargeType: "PRODUCT",
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            setupString: gridData.setupString,
            pnNumber: gridData.pnNumber,
            accountName: gridData.accountName
        }
    } else if (formId == "#basicDetailsTabForm" && documentClass == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
        form = "lcPayment";

        gridData = grid.jqGrid("getRowData", id);

        params = {
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.paymentMode,
            settlementCurrency: gridData.settlementCurrency,
//            amount: gridData.amount,
            amount: gridData.amountSettlement,
            status: gridData.status,
            statusAction: "errorCorrect",
            form: form,
            tradeServiceId: $("#tradeServiceId").val(),
            chargeType: "PRODUCT",
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            setupString: gridData.setupString,
            pnNumber: gridData.pnNumber,
            accountName: gridData.accountName
        }
    }

    $.post(errorCorrectUrl, params, function (data) {
        loadPopup("loading_div", "loading_bg");
        centerPopup("loading_div", "loading_bg");

        if (data.success == true) {
            updateGrid(id, "unpay");

            if (documentClass == "MD" || documentClass == "IMPORT_ADVANCE") {
                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {
                    if (data2.paymentStatus.toUpperCase() == "PAID") {
                        $("#btnPrepare").removeAttr("disabled");
                    } else {
                        $("#btnPrepare").attr("disabled", "disabled");
                    }

                    disablePopup("loading_div", "loading_bg");
                });
            } else {
                disablePopup("loading_div", "loading_bg");
            }
        }
    });
}

function reverseLoan(id) {
    var grid = $("#grid_list_cash_payment_summary");
    var gridData = grid.jqGrid("getRowData", id);

    var params = {
        accountNumber: gridData.accountNumber,
        modeOfPayment: gridData.paymentMode,
        settlementCurrency: gridData.settlementCurrency,
//            amount: gridData.amount,
        amount: gridData.amountSettlement,
        status: gridData.status,
        statusAction: "inquireLoanStatus",
        tradeServiceId: $("#tradeServiceId").val(),
        chargeType: "PRODUCT",
        tradeSuspenseAccount: gridData.tradeSuspenseAccount,
        setupString: gridData.setupString,
        pnNumber: gridData.pnNumber,
        accountName: gridData.accountName
    }

    $.post(reverseLoanUrl, params, function (data) {
        if (data.success == true) {
            gridData.status = "Processing";
            gridData.pay = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + id + "\'; inquireLoanStatus(id);\"/>";
//            $.post(updateLoanUrl, params, function(data) {
//                gridData.pay = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'"+id+"\'; onPayClick(id);\"/>";
//            });
        }
        grid.jqGrid('setRowData', id, gridData);
    });

}

function getLoanErrors(id) {
    var grid = $("#grid_list_cash_payment_summary");
    var gridData = grid.jqGrid("getRowData", id);
    var params = {
        sequenceNumber: gridData.sequenceNumber
    }
    $.post(getLoanErrorsUrl, params, function (data) {
        $("#loan_popup_wrapper").html(data);
        loadPopup("loan_error_popup", "view_loan_error_popup_bg");
        centerPopup("loan_error_popup", "view_loan_error_popup_bg");

    });
}

//function inquireLoanStatus(id){
//    mLoadPopup($("#loading_div"), $("#loading_bg"));
//    mCenterPopup($("#loading_div"), $("#loading_bg"));
//
//    var grid = $("#grid_list_cash_payment_summary");
//    var gridData = grid.jqGrid("getRowData", id);
//
//    var params = {
//        accountNumber: gridData.accountNumber,
//        modeOfPayment: gridData.paymentMode,
//        settlementCurrency: gridData.settlementCurrency,
////            amount: gridData.amount,
//        amount: gridData.amountSettlement,
//        status: gridData.status,
//        statusAction: "inquireLoanStatus",
//        tradeServiceId: $("#tradeServiceId").val(),
//        chargeType: "PRODUCT",
//        tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//        setupString: gridData.setupString,
//        pnNumber : gridData.pnNumber,
//        reversalDENumber:  $("#reversalDENumber").val()
//    }
//    doInquireLoanStatus(id,params,0);
//}


function inquireLoanStatus(id) {
    mLoadPopup($("#loading_div"), $("#loading_bg"));
    mCenterPopup($("#loading_div"), $("#loading_bg"));

    var grid = $("#grid_list_cash_payment_summary");
    var gridData = grid.jqGrid("getRowData", id);

    var params = {
        paymentDetailId: id,
        reversalDENumber: $("#reversalDENumber").val()
    }

    mLoadPopup($("#loading_div"), $("#loading_bg"));
    mCenterPopup($("#loading_div"), $("#loading_bg"));

    doInquireLoanStatus(id, params, 0);
}

//function doInquireLoanStatus(id,params,pollLimit){
//    var grid = $("#grid_list_cash_payment_summary");
//
//    var gridData = grid.jqGrid("getRowData", id);
//
//    $.post(inquireLoanStatusUrl, params, function(data) {
//        var gridData = grid.jqGrid("getRowData", id);
//        if(data.success == 'APPROVED'){
//            mDisablePopup($("#loading_div"), $("#loading_bg"));
//            if(data.status == 'REVERSED'){
//                gridData.status = "Not Paid";
//                gridData.pay = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'"+id+"\'; showLoanDetails(id);\"/>";
//            }else{
//                gridData.status = "Paid";
//                gridData.pay = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'"+id+"\'; reverseLoan(id);\"/>";
//            }
//
//            gridData.pnNumber = data.pnNumber;
//            mDisablePopup($("#loading_div"), $("#loading_bg"));
//        }else if(data.success == 'REJECTED'){
//            gridData.status = "Rejected";
//            gridData.pay = "<input type=\"button\" class=\"input_button_negative\" value=\"Rejected\" onclick=\"var id=\'"+id+"\'; getLoanErrors(id);\"/>";
//            gridData.sequenceNumber = data.sequenceNumber;
//            mDisablePopup($("#loading_div"), $("#loading_bg"));
//        }else if(data.success == 'PROCESSING'){
//            gridData.status = "Processing";
//            gridData.pay = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'"+id+"\'; inquireLoanStatus(id);\"/>";
//            if (pollLimit < 5) {
//                pollLimit++;
//                setTimeout(function() { doInquireLoanStatus(id,params,pollLimit); }, 10000); // wait 10 seconds then retry
////                    wait(10000); doBalanceCheck(pollLimit,transactionSequenceNumber); //this is a "blocking" version of the function above
//            }else{
//                mDisablePopup($("#loading_div"), $("#loading_bg"));
//                triggerAlertMessage("No response received from Silverlake.");
//            }
//        }
//        grid.jqGrid('setRowData', id, gridData);
//    });
//
//}

function doInquireLoanStatus(id, params, pollLimit) {

    $.post(inquireLoanStatusUrl, params,function (data) {
        if (data.success == true) {
            if (data.isProcessing == true) {
                if (pollLimit < 5) {
                    pollLimit++;
                    setTimeout(function () {
                        doInquireLoanStatus(id, params, pollLimit);
                    }, 10000); // wait 10 seconds then retry
                } else {
                    mDisablePopup($("#loading_div"), $("#loading_bg"));
                    triggerAlertMessage("No response received from Silverlake.");
                }
            } else {
                // this is used to display PN Number upon paying by loan
                location.reload();
                //$("#grid_list_cash_payment_summary").trigger("reloadGrid");
                //mDisablePopup($("#loading_div"), $("#loading_bg"));
            }
        } else {
            $("#loan_popup_wrapper").html(data);
            mDisablePopup($("#loading_div"), $("#loading_bg"));
            $("#grid_list_cash_payment_summary").trigger("reloadGrid");
            loadPopup("loan_error_popup", "view_loan_error_popup_bg");
            centerPopup("loan_error_popup", "view_loan_error_popup_bg");
        }
    }).error(function () {
        mDisablePopup($("#loading_div"), $("#loading_bg"));
    });

}


function payViaCasa(id) {
    $("#casaPaymentId").val("");
    var grid;
    if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        grid = $("#grid_list_cash_payment_summary");
    } else if (formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    }

    var gridData = grid.jqGrid("getRowData", id);

    //why are there two amount fields? because someone did not name the columns consistently.
    //a patch on a patch. sigh.
    var params = {
        amount: gridData.amount,
        currency: gridData.settlementCurrency,
        amountSettlement: gridData.amountSettlement
    }

    $.post(checkCasaBalanceUrl, params, function (data) {
        if (data.success == true) {
            onPayClick(id);
        } else {
            if (data.requiresValidation == true) {
                loadPopup("overrideConfirmation", "override_confirmation_bg");
                centerPopup("overrideConfirmation", "override_confirmation_bg");

                $("#casaPaymentId").val(id);
            } else {
                triggerAlertMessage(data.errorMessage);
            }
        }
    }, 'json');
}

function verifyOfficerPassword() {

    var params = {
        username: $("#usernameConfirm").val(),
        password: $("#passwordConfirm").val()
    }

    $.post(verifyOfficerPasswordUrl, params, function (data) {
        if (data.success == true) {
            onPayClick($("#casaPaymentId").val());
        } else {
            triggerAlertMessage("Invalid username/password.");
        }
    }, 'json');
}

function verifyOfficerPasswordOnErrorCorrect() {

    var params = {
        username: $("#usernameConfirm").val(),
        password: $("#passwordConfirm").val()
    }

    $.post(verifyOfficerPasswordUrl, params, function (data) {
        if (data.success == true) {
            onReversePaymentClick($("#casaPaymentId").val());
        } else {
            triggerAlertMessage("Invalid username/password.");
        }
    }, 'json');
}


function onPayClick(id) {
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");
    checkAccountingError();
    if(($("#documentClass").val() == 'LC' && $("#serviceType").val().toUpperCase() == 'UA LOAN SETTLEMENT') || ($("#documentClass").val() in {DA:1, DP:1, DR:1, OA:1} && $("#serviceType").val().toUpperCase() == 'SETTLEMENT') && $("#documentType").val() == 'FOREIGN'){
    	if($("#reimbursingBank").val() == ''){
    		triggerAlertMessage("Reimbursement details not yet completed.");
    	}
    }
    
    var grid;
    if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
    	if($("#grid_list_refund_main").length > 0){
    		grid = $("#grid_list_refund_main");
	    }else{
	    	grid = $("#grid_list_cash_payment_summary");
	    }
    } else if (formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        var grid = $("#grid_list_charges_payment");
    }

    var params = {
        paymentDetailId: id,
        supervisorId : $("#usernameConfirm").val()
    }

    var gridData = grid.jqGrid("getRowData", id);
    if (gridData.paymentMode in {'IB_LOAN':1,'TR_LOAN':1,'UA_LOAN':1}) {
        params['facilityId'] = $("#selectionId").val();
        params['facilityType'] = $("#facilityType").val();
        params['facilityReferenceNumber'] = $("#facilityReferenceNumber").val();
        params['paymentCode'] = $("#loanPaymentCode").val();
        params['paymentTerm'] = $("#paymentTerm").val();
        params['withCramApproval'] = $("input[type=radio][name=cramApprovalFlag]:checked").val() ? $("input[type=radio][name=cramApprovalFlag]:checked").val() : $("input[type=radio][name=cramApprovalFlagNegotiation]:checked").val();
        params.push($.makeArray(gridData.setupString));
    } else if (gridData.paymentMode in {'AP':1,'AR':1}){
    	params['referenceId'] = gridData.referenceId;
    }


    $.post(payUrl, params,function (data) {
        loadPopup("loading_div", "loading_bg");
        centerPopup("loading_div", "loading_bg");
        if (data.success == true) {
            if (documentClass in {MD:1, IMPORT_ADVANCE:1, AR:1, AP:1}) {
                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {

                    if (data2.paymentStatus.toUpperCase() == "PAID") {
                        $("#btnPrepare").removeAttr("disabled");
                    } else {
                        $("#btnPrepare").attr("disabled", "disabled");
                    }
                });
            }
        } else {
            triggerAlertMessage(data.errorMessage);
        }
    }, 'json').always(function () {
            disablePopup("loading_div", "loading_bg");
            grid.trigger("reloadGrid");
        });
}


//function onPayClick(id) {
//
//    loadPopup("loading_div", "loading_bg");
//    centerPopup("loading_div", "loading_bg");
//    var form;
//    var params;
//    var gridData;
//    var grailsUrl = payUrl;
//    //var rates = constructRates();
//
//    if(formId == "#chargesPaymentTabForm") {
//        var grid = $("#grid_list_charges_payment");
//        form = "chargesPayment";
//
//        gridData = grid.jqGrid("getRowData", id);
//
//        var amount = gridData.amountSettlement;
//        if(amount == undefined) {
//            amount = gridData.amount;
//        }
//
//        params = {
//            accountNumber: gridData.accountNumber,
//            modeOfPayment: gridData.paymentMode,
//            settlementCurrency: gridData.settlementCurrency,
//            rates:gridData.rates,
//            amount: amount,
//            status: gridData.status,
//            statusAction: "payCharges",
//            form: form,
//            tradeServiceId: $("#tradeServiceId").val(),
//            chargeType: "SERVICE",
//            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//            referenceId: gridData.referenceId,
//            pnNumber: gridData.pnNumber
//        }
//    }else if(formId == "#cashLcPaymentTabForm" || formId == "productPaymentTabForm" || formId == "#proceedsDetailsTabForm") {
//        var chargeType = "PRODUCT";
//        grid = $("#grid_list_cash_payment_summary");
//        if (formId == "#proceedsDetailsTabForm") {
//            grid = $("#grid_list_proceeds_payment_summary");
//            chargeType = "SETTLEMENT";
//        }
//
//        form = "lcPayment";
//
//        gridData = grid.jqGrid("getRowData", id);
//
//
//        params = {
//            accountNumber: gridData.accountNumber,
//            modeOfPayment: gridData.paymentMode,
//            settlementCurrency: gridData.settlementCurrency,
//            rates:gridData.rates,
//            amount: gridData.amountSettlement,
//            status: gridData.status,
//            statusAction: "payCharges",
//            form: form,
//            tradeServiceId: $("#tradeServiceId").val(),
//            chargeType: chargeType, //"PRODUCT",
//            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//            setupString: gridData.setupString,
//            referenceId: gridData.referenceId,
//            pnNumber: gridData.pnNumber
//        }
//    } else if(formId == "#paymentDetailsTabForm") {
//        grid = $("#grid_list_cash_payment_summary");
//        form = "lcPayment"
//
//        gridData = grid.jqGrid("getRowData", id);
//
//        params = {
//            accountNumber: gridData.accountNumber,
//            modeOfPayment: gridData.paymentMode,
//            settlementCurrency: gridData.settlementCurrency,
//            rates:gridData.rates,
////            amount: gridData.amount,
//            amount: gridData.amountSettlement,
//            status: gridData.status,
//            statusAction: "payCharges",
//            form: form,
//            tradeServiceId: $("#tradeServiceId").val(),
//            chargeType: "PRODUCT",
//            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//            setupString: gridData.setupString,
//            referenceId: gridData.referenceId,
//            pnNumber: gridData.pnNumber
//        }
////            alert(gridData.amount)
//    } else if(formId == "#basicDetailsTabForm") {
//        form = "lcPayment";
//
//        if (documentClass == "CDT" && serviceType == "PAYMENT") {
//            grid = $("#grid_list_payment_cdt");
//
//            gridData = grid.jqGrid("getRowData", id);
//
//            params = {
//                accountNumber: gridData.accountNumber,
//                modeOfPayment: gridData.paymentMode,
//                settlementCurrency: gridData.settlementCurrency,
//                rates:gridData.rates,
////            amount: gridData.amount,
//                amount: gridData.amountSettlement,
//                status: gridData.status,
//                statusAction: "payCharges",
//                form: form,
//                tradeServiceId: $("#tradeServiceId").val(),
//                chargeType: "PRODUCT",
//                tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//                referenceId: gridData.referenceId,
//                setupString: gridData.setupString
//            }
//        } else {
//
//            grid = $("#grid_list_refund_main");
//
//            gridData = grid.jqGrid("getRowData", id);
//
//            params = {
//                accountNumber: gridData.accountNumber,
//                modeOfPayment: gridData.paymentMode,
//                settlementCurrency: gridData.currency,
//                rates:gridData.rates,
////            amount: gridData.amount,
//                amount: gridData.amount,
//                status: gridData.status,
//                statusAction: "payCharges",
//                form: form,
//                tradeServiceId: $("#tradeServiceId").val(),
//                chargeType: "PRODUCT",
//                tradeSuspenseAccount: gridData.tradeSuspenseAccount,
//                referenceId: gridData.referenceId,
//                setupString: gridData.setupString
//
//
//            }
//        }
//    }
//
//    if(gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN' || gridData.paymentMode == 'UA_LOAN'){
//        grailsUrl = createLoanUrl;
//    }
//
//    $.post(grailsUrl, params, function(data) {
////        grid.block({message: "hello", fadeIn: 1});
//        loadPopup("loading_div", "loading_bg");
//        centerPopup("loading_div", "loading_bg");
//
//        if(data.success == true) {
////            alert(true)
//            updateGrid(id, "pay");
//
//            if(documentClass == "MD") {
//                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function(data2) {
//
//                    if (data2.paymentStatus.toUpperCase() == "PAID") {
//                        $("#btnPrepare").removeAttr("disabled");
//                    } else {
//                        $("#btnPrepare").attr("disabled", "disabled");
//                    }
//
//                    disablePopup("loading_div", "loading_bg")
//                });
//            } else {
//                disablePopup("loading_div", "loading_bg")
//            }
//        }
//    });
//}


function closeLoanPopup() {
    mDisablePopup($("#loan_details_popup"), $("#loan_details_bg"))
}

function validateRequiredFields(inputForm, cssClass) {
    var errorCount = 0;
    $("#" + inputForm + " :input").each(function () {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf(cssClass) != -1) {
            if ($(this).val() == "") {
                errorCount++;
            }
        }
    });
    return errorCount == 0;
}


function processLoan() {
    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");
    var gridId = $("#selectionId").val();
    var grid;
    var gridData;
    if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") {
        gridData = $("#grid_list_cash_payment_summary").jqGrid("getRowData", gridId);
        grid = $("#grid_list_cash_payment_summary");
    } else if (formId == "#proceedsDetailsTabForm") {
        gridData = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData", gridId);
        grid = $("#grid_list_proceeds_payment_summary");
    } else if (formId == "#chargesPaymentTabForm") {
        gridData = $("#grid_list_charges_payment").jqGrid("getRowData", gridId);
        grid = $("#grid_list_charges_payment");
    }

    var params = {
            id: gridId,
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.paymentMode,
            settlementCurrency: gridData.settlementCurrency,
            rates: gridData.rates,
            amount: gridData.amount,
            status: gridData.status,
            tradeServiceId: $("#tradeServiceId").val(),
            chargeType: "PRODUCT",
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            setupString: gridData.setupString,
            referenceId: gridData.referenceId,
            pnNumber: gridData.pnNumber,
            facilityId: $("#facilityId").val(),
            facilityReferenceNumber: $("#facilityReferenceNumber").val(),
            facilityType: $("#facilityType").val(),
            paymentTerm: $("#paymentTerm").val(),
            paymentCode: $("#loanPaymentCode").val(),
            withCramApproval: $("#withCramApproval").val() ? $("#withCramApproval").val() : $("input[type=radio][name=cramApprovalFlag]:checked").val() ? $("input[type=radio][name=cramApprovalFlag]:checked").val() : $("input[type=radio][name=cramApprovalFlagNegotiation]:checked").val(),
            paymentTermCode: $("input[type=radio][name=paymentTermCodeGroup]:checked").val(),
            agriAgraTagging: $("#agriAgra").val(),
            etsDate: $("#etsDate").val()
        }
//    console.log(params);
    closeLoanPopup();
    $.post(createLoanUrl, params,function (data) {
        if (data.success == true) {
            updateGrid(gridId, "pay");
        }
        grid.trigger("reloadGrid");
    }).always(
        function () {
            disablePopup("loading_div", "loading_bg");
        }
    );
    $("#selectionId").val(null);
}

function createLoan() {
    if (!validateRequiredFields('loan_details_popup', 'loanField')) {
        triggerAlertMessage("Please fill out all the required fields hihi mod of payment charges.");
        return false;
    }
    $("#btnAlertOk").click(function() {
        processLoan();
    });
    triggerAlertMessage("Please process the loan  transaction in SYMBOLS.");
}

function showLoanDetails(id) {
    $("#selectionId").val(id);
    $(".facilityId.loanField").val("");
    var paymentMode = $("#grid_list_cash_payment_summary").jqGrid("getRowData", id).paymentMode;
    $("#paymentTerm").val(function(){
    	if(paymentMode == 'UA_LOAN'){
    		if(new Date($("#loanDetailsMaturityDate").val()).getTime() > new Date().getTime()){
    			return Math.ceil(Math.abs(new Date($("#loanDetailsMaturityDate").val()).getTime() - new Date($("#valueDate").val()).getTime()) / (1000 * 3600 * 24));
    		} else {
    			return 0;
    		}
    	} else {
    		return $("#loanTerm").val();
    	}
    });
    mLoadPopup($("#loan_details_popup"), $("#loan_details_bg"));
    mCenterPopup($("#loan_details_popup"), $("#loan_details_bg"));

}

function updateGrid(id, action) {
    var gridData;
    var editData;

    var grid;

    var status;

    var payString = "<input type=\"button\" class=\"input_button_negative\" value=\"Reverse\" onclick=\"var id=\'" + id + "\'; onReversePaymentClick(id);\"/>"

    var deleteString = "<a href=\"javascript:void(0)\" style=\"color: red\" onclick=\"var id=\'" + id + "\'; onDeletePayment(id);\">delete</a>"
    if (formId == "#chargesPaymentTabForm") {

        grid = $("#grid_list_charges_payment");

        gridData = grid.jqGrid("getRowData", id);

        if (action == "pay") {
            status = "Paid";
            if (gridData.paymentMode == "CASA") {
                payString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + id + "\'; onReversePaymentClick(id);\"/>"
            }
        } else if (action == "unpay") {
            payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"
            status = "Not Paid";
        }

        if ($("#reverseDE").val() == "true") {
            payString = '';
            deleteString = '';
        }

        editData = {
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.modeOfPayment,
            settlementCurrency: gridData.settlementCurrency,
            amount: gridData.amount,
            deletePaymentSummary: deleteString,
            status: status,
            pay: payString,
            paymentMode: gridData.paymentMode,
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            accountName: gridData.accountName
        }
    } else if ((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm") || formId == "#paymentDetailsTabForm" || formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_cash_payment_summary");

        if (formId == "#proceedsDetailsTabForm") {
            grid = $("#grid_list_proceeds_payment_summary");
        }

        gridData = grid.jqGrid("getRowData", id);

        if (action == "pay") {
            status = "Paid";
            if (gridData.paymentMode == "CASA") {
                payString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + id + "\'; onReversePaymentClick(id);\"/>"
            } else if (gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN' || gridData.paymentMode == 'UA_LOAN' || gridData.paymentMode == 'DBP') {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + id + "\'; inquireLoanStatus(id);\"/>"
                status = "Processing"
            }
        } else if (action == "unpay") {
            if (gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN') {
            	payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>"
            } else if (gridData.paymentMode == 'UA_LOAN') {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>"
            } else {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"
            }

            status = "Not Paid";
        }

        if ($("#reverseDE").val() == "true") {
            payString = '';
            deleteString = '';
        }

        editData = {
            accountNumber: gridData.accountNumber,
            modeOfPayment: gridData.modeOfPayment,
            settlementCurrency: gridData.settlementCurrency,
            amountSettlement: gridData.amountSettlement,
            deletePaymentSummary: deleteString,
            status: status,
            pay: payString,
            paymentMode: gridData.paymentMode,
            tradeSuspenseAccount: gridData.tradeSuspenseAccount,
            amount: gridData.amount,
            accountName: gridData.accountName
        }
    } else if ((formId == "#basicDetailsTabForm" || formId == "#cashLcPaymentTabForm") && ($("#grid_list_refund_main").length > 0 || $("#grid_list_payment_cdt").length > 0)) {
        if ($("#grid_list_refund_main").length > 0) {
            grid = $("#grid_list_refund_main");
        } else if ($("#grid_list_payment_cdt").length > 0) {
            grid = $("#grid_list_payment_cdt");
        }

        gridData = grid.jqGrid("getRowData", id);

        if (action == "pay") {
            status = "Paid";
            if (gridData.paymentMode == "CASA") {
                payString = "<input type=\"button\" class=\"input_button_negative\" value=\"EC\" onclick=\"var id=\'" + id + "\'; onReversePaymentClick(id);\"/>"
            } else if (gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN' || gridData.paymentMode == 'UA_LOAN') {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Check\" onclick=\"var id=\'" + id + "\'; onErrorCorrectClick(id);\"/>"
                status = "Processing"
            }
        } else if (action == "unpay") {
            if (gridData.paymentMode == 'IB_LOAN' || gridData.paymentMode == 'TR_LOAN') {
            	payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>"
            } else if (gridData.paymentMode == 'UA_LOAN') {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Accept\" onclick=\"var id=\'" + id + "\'; showLoanDetails(id);\"/>"
            } else {
                payString = "<input type=\"button\" class=\"input_button\" value=\"Pay\" onclick=\"var id=\'" + id + "\'; onPayClick(id);\"/>"
            }

            status = "Not Paid";
        }

        if ($("#reverseDE").val() == "true") {
            deleteString = '';
        }

        if ($("#grid_list_refund_main").length > 0) {
            editData = {
                accountNumber: gridData.accountNumber,
                modeOfPayment: gridData.modeOfPayment,
                currency: gridData.currency,
                amount: gridData.amount,
                deletePaymentSummary: deleteString,
                status: status,
                pay: payString,
                paymentMode: gridData.paymentMode,
                tradeSuspenseAccount: gridData.tradeSuspenseAccount,
                amount: gridData.amount,
                accountName: gridData.accountName
            }
        } else if ($("#grid_list_payment_cdt").length > 0) {
            editData = {
                accountNumber: gridData.accountNumber,
                modeOfPayment: gridData.modeOfPayment,
                settlementCurrency: gridData.settlementCurrency,
                amount: gridData.amount,
                deletePaymentSummary: deleteString,
                status: status,
                pay: payString,
                paymentMode: gridData.paymentMode,
                tradeSuspenseAccount: gridData.tradeSuspenseAccount,
                amountSettlement: gridData.amountSettlement
            }
        }
    }
    grid.jqGrid('setRowData', id, editData);
}

function reversePayment(id) {
    var grid;

    loadPopup("loading_div", "loading_bg");
    centerPopup("loading_div", "loading_bg");

    if (formId == "#chargesPaymentTabForm") {
        grid = $("#grid_list_charges_payment");
    } else if ((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm") || formId == "#paymentDetailsTabForm") {
        if($("#grid_list_refund_main").length > 0){
            grid = $("#grid_list_refund_main");
        }else{
            grid = $("#grid_list_cash_payment_summary");
        }
    } else if (formId == "#basicDetailsTabForm" && documentClass == "CDT" && serviceType == "PAYMENT") {
        grid = $("#grid_list_payment_cdt");
    } else if (formId == "#proceedsDetailsTabForm") {
        grid = $("#grid_list_proceeds_payment_summary");
    }

    var params = {
        paymentDetailId: id,
        reverseDE: $("#reverseDE").val(),
        reversalDENumber: $("#reversalDENumber").val()
    }

    $.post(reversePaymentUrl, params, function (data) {
        popupStatus = 1;

        if (data.success == true) {
            updateGrid(id, "unpay");

            if (documentClass in {MD:1, IMPORT_ADVANCE:1, AR:1, AP:1}) {
                $.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {
                    if (data2.paymentStatus.toUpperCase() == "PAID") {
                        $("#btnPrepare").removeAttr("disabled");
                    } else {
                        $("#btnPrepare").attr("disabled", "disabled");
                    }
                });
            }
        } else {
            if (data.errorMessage != null && data.errorMessage != "") {
                triggerAlertMessage(data.errorMessage);
            }
        }
    }).always(function () {
        disablePopup("loading_div", "loading_bg");
        grid.trigger("reloadGrid");
    });
}

function onReversePaymentClick(id) {
    var paymentMode = $("#grid_list_cash_payment_summary").jqGrid("getRowData", id).paymentMode;

    if (paymentMode == 'UA_LOAN') {
        $("#btnAlertOk").click(function() {
            reversePayment(id);
        });
        triggerAlertMessage("Please dont forget to also cancel the loan in SYMBOLS.");
    } else {
        reversePayment(id);
    }

}

function validateApBalance(amountSettlement, apBalance) {
    amountSettlement = parseFloat(amountSettlement.replace(/,/g, ""));
    var apBalanceAmount = parseFloat(stripCommas(apBalance));

    if (amountSettlement > apBalanceAmount) {
        $("#alertMessage").text("Insufficient balance.");
        triggerAlert();
        return "fail";
    }

    return "success";
}

function computeNegotiationMaturityDate() {
    var loanTermNegotiation = null; //parseInt($("#loanTermNegotiation").val());

    if ($("#loanTermNegotiation").length > 0) {
        loanTermNegotiation = parseInt($("#loanTermNegotiation").val());
    } else {
        loanTermNegotiation = parseInt($("#loanTerm").val());
    }
    if (loanTermNegotiation != null && $("input[name=loanCodeFlagNegotiation]:checked").length > 0) {
        $("#loanMaturityDate").val("");
        var loanCodeFlagNegotiation = $("input[name=loanCodeFlagNegotiation]:checked").val();


        /* if(loanCodeFlagNegotiation == 'D'){
         if(loanTermNegotiation < 30) {
         triggerAlertMessage("Loan term must be greater than 30.");
         $("#loanTermNegotiation").val("30");
         return true;
         }

         }*/

//        var dateNow = new Date();
//        if(loanCodeFlagNegotiation == 'M'){
//            dateNow.setMonth(dateNow.getMonth() + loanTermNegotiation);
//            $("#loanMaturityDate").val($.datepicker.formatDate("mm/dd/yy", dateNow));
//        } else {
//            dateNow.setDate(dateNow.getDate() + loanTermNegotiation);
//            $("#loanMaturityDate").val($.datepicker.formatDate("mm/dd/yy", dateNow));
//        }
        var params = {
            loanTermCode: loanCodeFlagNegotiation,
            loanTerm: loanTermNegotiation,
            valueDate: $("#negotiationValueDate").val() ? $("#negotiationValueDate").val() : $("#valueDate").val()
        }
        $.post(getIbTrLoanMaturityDateUrl, params, function (data) {
            $("#loanMaturityDate").val(data.maturityDate);
        });


    }

}

function computeLoanTerm() {
	var loanMaturityDate = $("#loanMaturityDate").datepicker("getDate");
	var currentDate = new Date();
	if($("#negotiationValueDate").val()){
		currentDate = $.datepicker.parseDate('mm/dd/yy', $("#negotiationValueDate").val());
	} else if($("#valueDate").val()){
		currentDate = $.datepicker.parseDate('mm/dd/yy', $("#valueDate").val());
	}
	var loanTerm = parseInt((loanMaturityDate - currentDate)/(60*60*24*1000));
	if (loanTerm < 
    		convertMonthsToDays($("#interestTermNegotiation").val(),$("input[name=interestCodeFlagNegotiation]:checked").val())){
		$("#alertMessage").text("Interest Term cannot be greater than Loan Term.")
	    triggerAlert();
		computeNegotiationMaturityDate();
	} else {
		$("input[name=loanCodeFlagNegotiation][value=D]").attr("checked", "checked");
		$("#loanTermNegotiation").val(loanTerm);
	}
}

function onFacilityOnModeClick() {
    var mPopupDiv = $("#facility_popup");
    var mPopupBg = $("#facility_search_bg");

    mLoadPopup(mPopupDiv, mPopupBg);
    mCenterPopup(mPopupDiv, mPopupBg);
}

function onRecomputeBalanceBtnClick() {
    var timeoutID = window.setTimeout(updateTotals, 200);
}

function checkHoliday(data) {
	if(data["isHoliday"] == null){
        $("#alertMessage").text("There is  no holiday record in SIBS with the current unit code.  Please refer to ITD");
        triggerAlert();
        return;
	} else if (data["isHoliday"]) {
		if ($("#modeOfPaymentCharges").val() == 'UA_LOAN') {
			var dateToAdjust = $.datepicker.parseDate('mm/dd/yy', $("#loanMaturityDate").val());
			dateToAdjust.setDate(dateToAdjust.getDate() + 1);
			$("#loanMaturityDate").val($.datepicker.formatDate('mm/dd/yy', dateToAdjust));
			var holidayUrl = checkIfHolidayUrl;
            var params = {
                loanMaturityDate: $("#loanMaturityDate").val(),
                branchUnitCode: $("#branchUnitcode").val()
            };
            $.post(holidayUrl, params, checkHoliday);
		} else if ($("#modeOfPaymentCharges").val() in {DBP:1, IB_LOAN:1}) {
			var dateToAdjust = $.datepicker.parseDate('mm/dd/yy', $("#loanMaturityDate").val());
			dateToAdjust.setDate(dateToAdjust.getDate() - 1);
			$("#loanMaturityDate").val($.datepicker.formatDate('mm/dd/yy', dateToAdjust));
			$("#loanTermNegotiation").val(parseInt($("#loanTermNegotiation").val() - 1));
			var holidayUrl = checkIfHolidayUrl;
            var params = {
                loanMaturityDate: $("#loanMaturityDate").val(),
                branchUnitCode: $("#branchUnitcode").val()
            };
            $.post(holidayUrl, params, checkHoliday);
		} else {
	        $("#alertMessage").text("Maturity Date falls on a Weekend or a Holiday. Please Change.");
	        triggerAlert();
	        return;
		}
    } else {
        $("#popup_btn_mode_of_payment_cash").attr("disabled", "disabled");
        initializeInsert();
    }
}

function convertMonthsToDays(input,duration){
	switch(duration){
	case "M":
		return parseInt(input) * 30;
		break;
	case "D":
		return parseInt(input);
		break;
	}
}

$(document).ready(function () {
	var accountNumber;
	
	
    $('.mode_of_payment_buttons').css("display", "none");
    $("#modeOfPaymentCharges").change(changeModeOfPayment);
    $("#save_modeOfPaymentCharges").click(function () {
    	
        switch ($("#modeOfPaymentCharges").val()) {
            case "":
                $("#alertMessage").text("Please select mode of payment.");
                triggerAlert();
                break;
            case "CASA":
            	if($("#popup_modeOfPaymentCharges #accountName").val() == ""){
            		triggerAlertMessage("Account Name needs to be identified.");
                    return;
            	} else if((accountNumber) && $("#accountNumber").val() && ($("#accountNumber").val()).trim() != accountNumber){
            		triggerAlertMessage("Account Number was altered after checking. Either recheck new Account Number or revert to previous Account Number.");
            	}else if($("#accountNumberCheck").val().toUpperCase() == "O" && $("#accountNumber").val().trim() != accountNumber){
            		triggerAlertMessage("Account Number was altered after checking. Either validate again the  Account Number or revert to previous Account Number.");
				}else if($("#accountNumber").val() == ""){
            		triggerAlertMessage("Account Number is required.");
            		return;
            	} else {
            		var no_match = true;
            		var grid;
            		if(formId == "#chargesPaymentTabForm"){
            			grid = $("#grid_list_charges_payment");
    				} else if (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm"){
    					if($("#grid_list_refund_main").length > 0){
    			    		grid = $("#grid_list_refund_main");
    				    }else{
    				    	grid = $("#grid_list_cash_payment_summary");
    				    }
    				} else if (formId == "#proceedsDetailsTabForm") {
    			        grid = $("#grid_list_proceeds_payment_summary");
    			    }
            		
            		var gridIds = grid.jqGrid("getDataIDs")
            		
            		for(i in gridIds){
            			var data = grid.jqGrid("getRowData",gridIds[i]);
            			if(data.paymentMode == "CASA"){
            				if (data.accountNumber == $("#accountNumber").val()){
            					triggerAlertMessage("There is already a payment for casa with the same account number.")
            					no_match = false;
            				}
            			}
            		}
            		
            		if(no_match){
            			$("#popup_btn_mode_of_payment_cash").attr("disabled", "disabled");
            			initializeInsert();
            			accountNumber = null;
            		} else {
            			return;
            		}
                }
            	break;
            case "MD":
                if (($("#cashAmountInSettlement").val().replace(/,/g, "") * 100) > ($("#mdBalance").val().replace(/,/g, "") * 100)) {
                    $("#alertMessage").text("MD Balance is less than entered Amount.");
                    triggerAlert();
                } else {
                    $("#popup_btn_mode_of_payment_cash").attr("disabled", "disabled");
                    initializeInsert();
                }
                break;
            case "DBP":
            case "TR_LOAN":
            case "IB_LOAN":
            case "DTR_LOAN":
            	if (!validateRequiredFields('ib_tr_table', 'loanField')) {
                    triggerAlertMessage("Please fill out all the required fields.");
                    return;
                }
            case "UA_LOAN":
            	if (!validateRequiredFields('ua_table', 'loanField')) {
                    triggerAlertMessage("Please fill out Loan Maturity Date.");
                    return;
                }
                var holidayUrl = checkIfHolidayUrl;
                var params = {
                    loanMaturityDate: $("#loanMaturityDate").val(),
                    branchUnitCode: $("#branchUnitcode").val()
                };
                $.post(holidayUrl, params, checkHoliday);

                break;
            default:
                initializeInsert();
                break;
        }
    });
    if('function' === typeof onRecomputeChargeBtnClick){
    	$("#recomputeBalanceBtn").click(onRecomputeChargeBtnClick);
    }
    $("#popup_btn_mode_of_payment_charges, #popup_btn_mode_of_payment_cash, #popup_btn_mode_of_payment_proceeds, .add_mode_of_payment").click(onConstructModesOfPayment);

    $("#close_modeOfPaymentCharges1, #close_modeOfPaymentCharges2").click(onCloseSettlementCharges);

    $(".credit_memo").hide();

    $("#md_balance").css("display", "none");

    $("#loanTermNegotiation,#repricingTermNegotiation,#interestTermNegotiation").blur(function () {
        var codeFlag = $(this).attr("id").replace("Term", "CodeFlag");
        if ($("input[name=" + codeFlag + "]:checked").val() == 'D' && $(this).attr("id") == "repricingTermNegotiation") {
            if (parseInt($(this).val()) < 30) {
                $("#alertMessage").text("Minimum allowed is 30 Days.")
                triggerAlert();
                $(this).val("30");
                $(this).focus();
            }
        } else if ($("input[name=" + codeFlag + "]:checked").length == 0) {
            $("#alertMessage").text("Please Select Between Months and Days.")
            triggerAlert();
            $("input[name=" + codeFlag + "]").focus();
        } else if ($(this).attr("id") == "interestTermNegotiation") {
        	
        	if(convertMonthsToDays($(this).val(),$("input[name=" + codeFlag + "]:checked").val()) > 
        		convertMonthsToDays($("#loanTermNegotiation").val(),$("input[name=loanCodeFlagNegotiation]:checked").val())){
        		$("#alertMessage").text("Interest Term cannot be greater than Loan Term.")
                triggerAlert();
                $(this).val("");
                $(this).focus();
        	}

            if($("#modeOfPaymentCharges").val() in {DBP:1, IB_LOAN:1} && parseInt($(this).val()) > 30){
            	$("#alertMessage").text("Interest Term cannot be greater than 30 days.")
                triggerAlert();
            }
        } else if ($(this).attr("id") == "loanTermNegotiation") {
        	if(convertMonthsToDays($(this).val(),$("input[name=" + codeFlag + "]:checked").val()) < 
    		convertMonthsToDays($("#interestTermNegotiation").val(),$("input[name=interestCodeFlagNegotiation]:checked").val())){
	    		$("#alertMessage").text("Interest Term cannot be greater than Loan Term.")
	            triggerAlert();
	            $(this).val("");
	            $(this).focus();
        	}	

            if ($("#modeOfPaymentCharges").val() in {DBP:1, IB_LOAN:1} && parseInt($(this).val()) > 30){
            	$("#alertMessage").text("Loan Term cannot be greater than 30 days.")
                triggerAlert();
            }
        }
    });
    
    $("#loanTermNegotiation, #loanTerm").change(computeNegotiationMaturityDate);
    $("input[name=loanCodeFlagNegotiation], input[name=interestCodeFlagNegotiation]").live("change", function(){
    	var termFlag = $(this).attr("name").replace("CodeFlag", "Term");
    	switch($(this).val()){
	    	case "M":
	    		$("#" + termFlag).val(parseInt($("#" + termFlag).val()/30));
	    		break;
	    	case "D":
	    		$("#" + termFlag).val(parseInt($("#" + termFlag).val()*30));
	    		break;
    	}
    	if($(this).attr("name") == "interestCodeFlagNegotiation"){
    		if(convertMonthsToDays($("#" + termFlag).val(),$(this).val()) > 
    			convertMonthsToDays($("#loanTermNegotiation").val(),$("input[name=loanCodeFlagNegotiation]:checked").val())){
	    		$("#alertMessage").text("Interest Term cannot be greater than Loan Term.")
	            triggerAlert();
	            $(this).val("D");
	    	}
    	} else if ($(this).attr("name") == "loanCodeFlagNegotiation"){
    		if(convertMonthsToDays($("#interestTermNegotiation").val(),$("input[name=interestCodeFlagNegotiation]:checked").val()) >
    			convertMonthsToDays($("#" + termFlag).val(),$(this).val())){
	    		$("#alertMessage").text("Interest Term cannot be greater than Loan Term.")
	            triggerAlert();
	            $(this).val("D");
	    	} else {
	    		computeNegotiationMaturityDate();
	    	}
		}
    });
    computeNegotiationMaturityDate();
    $("#loanMaturityDate").change(computeLoanTerm)
    $("#facilityLookupBtn").click(onFacilityOnModeClick);
    $("#save_loanDetails").click(createLoan);
    $("#close_loanDetails").click(closeLoanPopup);

    $("#close_loan_error_popup").live("click", function () {
        disablePopup('loan_error_popup', 'view_loan_error_popup_bg');
    });

    disableSettlementCurrency();

    $("#overrideYes").click(verifyOfficerPassword);
    $("#overrideYes").live("click", function () {
        disablePopup('overrideConfirmation', 'override_confirmation_bg');
    });
    $("#overrideNo").live("click", function () {
        disablePopup('overrideConfirmation', 'override_confirmation_bg');
    });


    $("#accountNumberCheck").change(function () {
        if ($(this).val() == 'O') {
            $("#accountNumber").toggleClass("select2_dropdown", false).toggleClass("input_field", true).val("").select2('destroy');
            $("#accountNameCheck").show();
        } else {
            $("#accountNumber").toggleClass("select2_dropdown", true).toggleClass("input_field", false).val("").queryCasaAccountNumbersByCurrency((formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || formId == "#paymentDetailsTabForm") ? "#settlementCurrencyLc" : "#settlementCurrency");
            $("#accountNameCheck").hide();
        }
        $("#popup_modeOfPaymentCharges #accountName").val("");
    });

    $("#accountNameCheck").click(function () {
    	accountNumber = $("#accountNumber").val().trim();
//    	console.log(accountNumber);
        var settlementCurrency = (formId == "#cashLcPaymentTabForm" || formId == "#productPaymentTabForm" || (formId == "#paymentDetailsTabForm" && (documentClass.toUpperCase() != 'MD'))) ? $("#settlementCurrencyLc").val() : (formId == "#paymentDetailsTabForm" && (documentClass.toUpperCase() == 'MD')) ? $("#mdCurrency").val() : $("#settlementCurrency").val();
        if (formId == "#proceedsDetailsTabForm") {
        	settlementCurrency = $("#proceedsCurrency").val();            
        }
        if($("#documentClass").val() in {AR:1, AP:1} || (serviceType == 'Application' && documentType == 'REFUND')) {
        	settlementCurrency = $("#currency").val();
        }
        if($("#documentClass").val() == 'MD' && $("#serviceType").val() == 'Application' && $("#documentType").val() == 'REFUND'){
        	settlementCurrency = $("#currency").val();
        }
        $.post(casaUserSearchUrl, {accountNumber: $("#accountNumber").val(), currency: settlementCurrency}, function (data) {
            if (data["status"] != "error") {
                if (data['currency'] != settlementCurrency) {
                    triggerAlertMessage('Currency of account did not match Settlement Currency.');
                    $("#accountNumber").val("");
                } else {
                    $("#popup_modeOfPaymentCharges #accountName").val(data['accountName']);
                    accountNumber = ($("#accountNumber").val()).trim();
                }
            } else {
                triggerAlertMessage(data["error"]);
                $("#accountNumber").val("");
            }
        });
    });
    $("input[name=cramApprovalFlagNegotiation]").click(function(){
    	if($(this).val() != ""){
    		$("#cramApprovalCheck.loanField").val("true");
    	}
    });
});


/**
 * If account number in grid == account number entered, return true
 * @param gridData
 */
function evaluateAccountNumber(gridData,fieldAccountNumber){
	if('undefined' === typeof fieldAccountNumber || fieldAccountNumber == null){
		return false;
	}
	var result = false;
	$.each(gridData.jqGrid("getRowData"),function(idx,val){
		if('undefined' !== typeof val.accountNumber && val.accountNumber != null){
			if(val.accountNumber.trim() == fieldAccountNumber.val().trim()){
				result = true;
			}
		}
	});
	return result;
}