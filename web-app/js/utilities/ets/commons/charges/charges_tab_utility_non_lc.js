/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/20/2018
	Program [Revision] Details: Updated variable currency to settlementCurrency on setupCharges method.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: charges_tab_utility_non_lc.js
 
 */
/**
 	PROLOGUE:
 	(revision)
	SCR/ER Number:
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 04/20/2018
	Program [Revision] Details: Updated passed currency value on setupCharges.
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: charges_tab_utility_non_lc.js
 
 */

var currency = $("#currency").val();
var settlementCurrency = $("#settlementCurrency").val();

function getRateCurrency() {
    if (settlementCurrency != "") {
        if (currency == settlementCurrency) {
            return settlementCurrency;
        } else {
            return settlementCurrency;
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
	console.log('IM HERE MOFOOOSSS');
	console.log(settlementCurrency);
	console.log(parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_charges").val())));
    if (settlementCurrency == 'PHP') {
        return "0";

    } else if (settlementCurrency == 'USD') {
        return "0";

    } else {
        return parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_charges").val()))
    }
}


//for special rates
function getSpecialConversionRate(settlementCurrency) {

    if (settlementCurrency == 'PHP') {
        return 1;

    } else if (settlementCurrency == 'USD') {
        return $("#USD-PHP_special_rate_charges").val();

    } else {
        return parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_charges").val()) * stripCommas($("#USD-PHP_special_rate_charges").val()))
    }
}

//for pass on rate
function getPassOnConversionRate(currency) {
    if (currency == 'PHP') {
        return 1;
    } else if (currency == 'USD') {
        return $("#USD-PHP_pass_on_rate_charges").val();

    } else {
        return parseFloat(stripCommas($("#" + currency + "-USD_pass_on_rate_charges").val()) * stripCommas($("#USD-PHP_pass_on_rate_charges").val()))
    }
}


//for pass on rate
function getThirdToUsdPassOnConversionRate(currency) {
    if (currency == 'PHP') {
        return "0";
    } else if (currency == 'USD') {
        return "0";

    } else {
        return parseFloat(stripCommas($("#" + currency + "-USD_pass_on_rate_charges").val()))
    }
}


//for special rate
function getUsdToPhpSpecialConversionRate() {
    if ($("#USD-PHP_special_rate_charges").val() == undefined) {
        return parseFloat(stripCommas($("#USD-PHP_urr").val()))
    }
    return parseFloat(stripCommas($("#USD-PHP_special_rate_charges").val()))
}

//for pass on rate
function getUsdToPhpPassOnConversionRate() {
    if ($("#USD-PHP_pass_on_rate_charges").val() == undefined) {
        return parseFloat(stripCommas($("#USD-PHP_urr").val()))
    }
    return parseFloat(stripCommas($("#USD-PHP_pass_on_rate_charges").val()))
}

//for pass on rate
function getUrr(currency) {
    if (currency == 'PHP') {
        return 1;
    } else if (currency == 'USD') {
        return $("#USD-PHP_urr").val();
    } else {
        return parseFloat(stripCommas($("#" + currency + "-PHP_urr").val()))
    }
}

function setupCharges(settlementCurrency) {


    $("#BC").val("");
    $("#CABLE").val("");
    $("#CILEX").val("");
    $("#DOCSTAMPS").val("");
    $("#SUP").val("");
    $("#NOTARIAL").val("");
    $("#BOOKING").val("");
    $("#REMITTANCE").val("");
    $("#BSP").val("");
    var defaultValue = getDefaultValues("BC");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var documentType = $("#documentType").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyNON_LC_Url, {
        tradeServiceId: tradeServiceId,
        amount: defaultValue.toString(),
        productAmount: productamount.toString(),
        cwtFlag: cwtflag,
        documentType: documentType,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency}, function (data) {
        $("#BC").val(formatCurrency(data.BC));
        $("#CILEX").val(formatCurrency(data.CILEX));
        $("#DOCSTAMPS").val(formatCurrency(data.DOCSTAMPS));
        $("#CABLE").val(formatCurrency(data.CABLE));
        $("#SUP").val(formatCurrency(data.SUP));
        $("#NOTARIAL").val(formatCurrency(data.NOTARIAL));
        $("#BOOKING").val(formatCurrency(data.BOOKING));
        $("#BSP").val(formatCurrency(data.BSP));
        $("#REMITTANCE").val(formatCurrency(data.REMITTANCE));

        $("#BCoriginal").val(formatCurrency(data.BCoriginal));
        $("#CILEXoriginal").val(formatCurrency(data.CILEXoriginal));
        $("#DOCSTAMPSoriginal").val(formatCurrency(data.DOCSTAMPSoriginal));
        $("#CABLEoriginal").val(formatCurrency(data.CABLEoriginal));
        $("#SUPoriginal").val(formatCurrency(data.SUPoriginal));
        $("#NOTARIALoriginal").val(formatCurrency(data.NOTARIALoriginal));
        $("#BOOKINGoriginal").val(formatCurrency(data.BOOKINGoriginal));
        $("#BSPoriginal").val(formatCurrency(data.BSPoriginal));
        $("#REMITTANCEoriginal").val(formatCurrency(data.REMITTANCEoriginal));

        $("#BCnocwtAmount").val(formatCurrency(data.BCnocwtAmount));
        $("#CILEXnocwtAmount").val(formatCurrency(data.CILEXnocwtAmount));


        updateTotals();
    });


    $("#bankCommissionPopupFieldCurrency, #bankCommissionNetBankComCurrency, #bankCommissionCWTCurrency, #bankCommissionGrossBankComCurrency").val(settlementCurrency);
    $("#bankCommissionRateCurrency").val(getRateCurrency());
    $("#BCCurrency").val(getRateCurrency());

    $("#commitmentFeePopupFieldCurrency, #commitmentFeeNetBankComCurrency, #commitmentFeeCWTCurrency, #commitmentFeeGrossBankComCurrency").val(settlementCurrency);
    $("#commitmentFeeRateCurrency").val(getRateCurrency());
    $("#CFCurrency").val(getRateCurrency());

    $("#cilexFeePopupFieldCurrency, #cilexNetBankComCurrency, #cilexCWTCurrency, #cilexGrossBankComCurrency").val(settlementCurrency);
    $("#cilexRateCurrency").val(getRateCurrency());
    $("#CILEXCurrency").val(getRateCurrency());

    $("#documentaryStampPopupFieldCurrency").val(settlementCurrency);
    $("#documentaryStampRateCurrency").val(getRateCurrency());
    $("#DOCSTAMPSCurrency").val(getRateCurrency());

    $("#cableFeePopupFieldCurrency").val(settlementCurrency);
    $("#CABLECurrency").val(settlementCurrency);

    $("#suppliesFeePopupFieldCurrency").val(settlementCurrency);
    $("#SUPCurrency").val(settlementCurrency);

    $("#notarialFeePopupFieldCurrency").val(settlementCurrency);
    $("#NOTARIALCurrency").val(settlementCurrency);

    $("#bookingCommissionPopupFieldCurrency").val(settlementCurrency);
    $("#BOOKINGCurrency").val(settlementCurrency);

    $("#remittanceFeePopupFieldCurrency").val(settlementCurrency);
    $("#REMITTANCECurrency").val(settlementCurrency);

    $("#bspFeePopupFieldCurrency").val(settlementCurrency);
    $("#BSPCurrency").val(settlementCurrency);

    updateTotals();
}



// setup values of currency in popup
function setupBankCommission(settlementCurrency) {


    $("#BC").val("");
    var defaultValue = getDefaultValues("BC");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var documentType = $("#documentType").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "BC",
        tradeServiceId: tradeServiceId,
        amount: defaultValue.toString(),
        productAmount: productamount.toString(),
        cwtFlag: cwtflag,
        documentType: documentType,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency}, function (data) {
        $("#BC").val(formatCurrency(data.convertedamount));
        updateTotals();
    });


    $("#bankCommissionPopupFieldCurrency, #bankCommissionNetBankComCurrency, #bankCommissionCWTCurrency, #bankCommissionGrossBankComCurrency").val(settlementCurrency);
    $("#bankCommissionRateCurrency").val(getRateCurrency());
    $("#BCCurrency").val(getRateCurrency());
    updateTotals();
}

// setup values of commitment fee in popup
function setupCommitmentFee(settlementCurrency) {

    $("#CF").val("");

    var defaultValue = getDefaultValues("CF");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "CF",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        cwtFlag: cwtflag,
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#CF").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#commitmentFeePopupFieldCurrency, #commitmentFeeNetBankComCurrency, #commitmentFeeCWTCurrency, #commitmentFeeGrossBankComCurrency").val(settlementCurrency);

    $("#commitmentFeeRateCurrency").val(getRateCurrency());
    $("#CFCurrency").val(getRateCurrency());
    updateTotals();
}

// setup values of cilex fee in popup
function setupCilexFee(settlementCurrency) {
    $("#CILEX").val("");
    var defaultValue = getDefaultValues("CILEX");
    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "CILEX",
        tradeServiceId: tradeServiceId,
        amount: defaultValue.toString(),
        productAmount: productamount.toString(),
        cwtFlag: cwtflag,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#CILEX").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#cilexFeePopupFieldCurrency, #cilexNetBankComCurrency, #cilexCWTCurrency, #cilexGrossBankComCurrency").val(settlementCurrency);

    $("#cilexRateCurrency").val(getRateCurrency());
    $("#CILEXCurrency").val(getRateCurrency());
    updateTotals();
}

// setup values of documentary stamp in popup
function setupDocumentaryStamp(settlementCurrency) {
    $("#DOCSTAMPS").val("");
    var defaultValue = getDefaultValues("DOCSTAMPS");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var usdToPhpUrr = getUrr("USD");

    var productamount = $("#productAmount").val();
    var documentType = $("#documentType").val();
    var cwtflag = $("#cwtFlag").val();
    var TR_LOAN_FLAG = $("#TR_LOAN_FLAG").val();
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "DOCSTAMPS",
        tradeServiceId: tradeServiceId,
        amount: defaultValue.toString(),
        productAmount: productamount,
        documentType: documentType,
        TR_LOAN_FLAG: TR_LOAN_FLAG,
        cwtFlag: cwtflag,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency}, function (data) {
        $("#DOCSTAMPS").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#documentaryStampPopupFieldCurrency").val(settlementCurrency);

    $("#documentaryStampRateCurrency").val(getRateCurrency());
    $("#DOCSTAMPS").val(getRateCurrency());
    updateTotals();

}

// setup values of cable fee in popup
function setupCableFee(settlementCurrency) {
    $("#CABLE").val("");

    var defaultValue = getDefaultValues("CABLE");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var documentType = $("#documentType").val();

    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "CABLE",
        tradeServiceId: tradeServiceId,
        documentType: documentType,
        amount: defaultValue.toString(),
        productAmount: productamount.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#CABLE").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#cableFeePopupFieldCurrency").val(settlementCurrency);
    $("#CABLECurrency").val(settlementCurrency);
    updateTotals();
}

// setup values of supplies fee in popup
function setupSuppliesFee(settlementCurrency) {
    $("#SUP").val("");
    var defaultValue = getDefaultValues("SUP");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "SUP",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#SUP").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#suppliesFeePopupFieldCurrency").val(settlementCurrency);
    $("#SUPCurrency").val(settlementCurrency);
    updateTotals();
}

//setup values of remittancee fee in popup
function setupRemittanceFee(settlementCurrency) {

    $("#REMITTANCE").val("");
    var defaultValue = getDefaultValues("REMITTANCE");
    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "REMITTANCE",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#REMITTANCE").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#remittanceFeePopupFieldCurrency").val(settlementCurrency);
    $("#REMITTANCECurrency").val(settlementCurrency);
    updateTotals();
}

// setup values of advising fee in popup
function setupAdvisingFee(settlementCurrency) {
    $("#CORRES-ADVISING").val("");

    var defaultValue = getDefaultValues("CORRES-ADVISING");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "CORRES-ADVISING",
        tradeServiceId: tradeServiceId,
        amount: defaultValue.toString(),
        productAmount: productamount.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#CORRES-ADVISING").val(formatCurrency(data.convertedamount));
        updateTotals();
    });


    $("#advisingFeePopupFieldCurrency").val(settlementCurrency);
    $("#CORRES-ADVISINGCurrency").val(settlementCurrency);
    updateTotals();
}

// setup values of confirming fee in popup
function setupConfirmingFee(settlementCurrency) {
    $("#CORRES-CONFIRMING").val("");

    var defaultValue = getDefaultValues("CORRES-CONFIRMING");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "CORRES-CONFIRMING",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#CORRES-CONFIRMING").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#confirmingFeePopupFieldCurrency").val(settlementCurrency);
    $("#confirmingFeeRateCurrency").val(getRateCurrency());
    $("#CORRES-CONFIRMINGCurrency").val(getRateCurrency());
//    $("#confirmFeeRate").val(settlementconversionrateSPECIAL);
    updateTotals();
}

// setup values of confirming fee in popup
function setupNotarialFee(settlementCurrency) {

    $("#NOTARIAL").val("");

    var defaultValue = getDefaultValues("NOTARIAL");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");

    var tradeServiceId = $("#tradeServiceId").val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "NOTARIAL",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#NOTARIAL").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#notarialFeePopupFieldCurrency").val(settlementCurrency);

    $("#notarialFeeRateCurrency").val(getRateCurrency());
    $("#NOTARIALCurrency").val(getRateCurrency());
    updateTotals();

}

function setupBspFee(settlementCurrency) {
    $("#BSP").val("");

    var defaultValue = getDefaultValues("BSP");


    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "BSP",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        cwtFlag: cwtflag,
        amount: defaultValue.toString(),
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#BSP").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#bspFeePopupFieldCurrency").val(settlementCurrency);
    $("#BSPCurrency").val(settlementCurrency);
    updateTotals();

}

function setupBookingCommission(settlementCurrency) {
    $("#BOOKING").val("");

    var defaultValue = getDefaultValues("BOOKING");

    var thirdToUsdSpecialConversionRateCurrency = getThirdToUSDSpecialConversionRate(currency);
    var thirdToUsdSpecialConversionRateSettlementCurrency = getThirdToUSDSpecialConversionRate(settlementCurrency);

    var thirdToUsdPassOnConversionRateCurrency = getThirdToUsdPassOnConversionRate(currency);
    var thirdToUsdPassOnConversionRateSettlementCurrency = getThirdToUsdPassOnConversionRate(settlementCurrency);

    var usdToPhpPassOnConversionRate = getUsdToPhpPassOnConversionRate();
    var usdToPhpSpecialConversionRate = getUsdToPhpSpecialConversionRate();

    var productamount = $("#productAmount").val();
    var usdToPhpUrr = getUrr("USD");
    var tradeServiceId = $("#tradeServiceId").val();
    var cwtflag = $('form input[name=cwtFlag]:checked').val();


    $.post(recomputeCurrencyComplicatedUrl, {
        chargeType: "BOOKING",
        tradeServiceId: tradeServiceId,
        productAmount: productamount.toString(),
        amount: defaultValue.toString(),
        cwtFlag: cwtflag,
        thirdToUsdSpecialConversionRateCurrency: thirdToUsdSpecialConversionRateCurrency,
        thirdToUsdSpecialConversionRateSettlementCurrency: thirdToUsdSpecialConversionRateSettlementCurrency,
        thirdToUsdPassOnConversionRateCurrency: thirdToUsdPassOnConversionRateCurrency,
        thirdToUsdPassOnConversionRateSettlementCurrency: thirdToUsdPassOnConversionRateSettlementCurrency,
        usdToPhpSpecialConversionRate: usdToPhpSpecialConversionRate,
        usdToPhpPassOnConversionRate: usdToPhpPassOnConversionRate,
        usdToPhpUrr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        urr: usdToPhpUrr ? usdToPhpUrr.toString() : usdToPhpUrr,
        currency: currency,
        settlementCurrency: settlementCurrency
    }, function (data) {
        $("#BOOKING").val(formatCurrency(data.convertedamount));
        updateTotals();
    });

    $("#bookingCommissionPopupFieldCurrency").val(settlementCurrency);
    $("#BOOKINGCurrency").val(settlementCurrency);
    updateTotals();

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
//    if ($("#CF").val() != undefined) {
//        amounts.push($("#CF").val().replace(/,/g, "*"));
//    }
    if ($("#CILEX").val() != undefined && otherSettlementCurrencyUsed() != "false") {
        amounts.push($("#CILEX").val().replace(/,/g, "*"));
    }
    if ($("#DOCSTAMPS").val() != undefined) {
        amounts.push($("#DOCSTAMPS").val().replace(/,/g, "*"));
    }
    if ($("#CABLE").val() != undefined) {
        amounts.push($("#CABLE").val().replace(/,/g, "*"));
    }
//    if ($("#SUP").val() != undefined) {
//        amounts.push($("#SUP").val().replace(/,/g, "*"));
//    }
    if ($("#NOTARIAL").val() != undefined) {
        amounts.push($("#NOTARIAL").val().replace(/,/g, "*"));
    }
    if ($("#REMITTANCE").val() != undefined) {
        amounts.push($("#REMITTANCE").val().replace(/,/g, "*"));
    }
//    if ($("#CORRES-ADVISING").val() != undefined) {
//        amounts.push($("#CORRES-ADVISING").val().replace(/,/g, "*"));
//    }
//    if ($("#CORRES-CONFIRMING").val() != undefined) {
//        amounts.push($("#CORRES-CONFIRMING").val().replace(/,/g, "*"));
//    }
    if ($("#BOOKING").val() != undefined) {
        amounts.push($("#BOOKING").val().replace(/,/g, "*"));
    }
    if ($("#BSP").val() != undefined) {
        amounts.push($("#BSP").val().replace(/,/g, "*"));
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

//    if ($("#CFCurrency").length > 0) {
//        $("#CFCurrency").text(settlementCurrency);
//    }

    if ($("#CILEXCurrency").length > 0) {
        $("#CILEXCurrency").text(settlementCurrency);
    }

    if ($("#DOCSTAMPSCurrency").length > 0) {
        $("#DOCSTAMPSCurrency").text(settlementCurrency);
    }

    if ($("#CABLECurrency").length > 0) {
        $("#CABLECurrency").text(settlementCurrency);
    }

//    if ($("#SUPCurrency").length > 0) {
//        $("#SUPCurrency").text(settlementCurrency);
//    }
//
//    if ($("#CORRES-ADVISINGCurrency").length > 0) {
//        $("#CORRES-ADVISINGCurrency").text(settlementCurrency);
//    }
//
//    if ($("#CORRES-CONFIRMINGCurrency").length > 0) {
//        $("#CORRES-CONFIRMINGCurrency").text(settlementCurrency);
//    }

    if ($("#totalAmountChargesCurrency").length > 0) {
        $("#totalAmountChargesCurrency").text(settlementCurrency);
    }

    if ($("#NOTARIALCurrency").length > 0) {
        $("#NOTARIALCurrency").text(settlementCurrency);
    }

    if ($("#REMITTANCECurrency").length > 0) {
        $("#REMITTANCECurrency").text(settlementCurrency);
    }

    if ($("#BOOKINGCurrency").length > 0) {
        $("#BOOKINGCurrency").text(settlementCurrency);
    }

    if ($("#BSPCurrency").length > 0) {
        $("#BSPCurrency").text(settlementCurrency);
    }
}

function resetCurrencyField() {
    if ($("#BC").length > 0) {
        $("#BC").val("");
    }

//    if ($("#CF").length > 0) {
//        $("#CF").val("");
//    }

    if ($("#CILEX").length > 0) {
        $("#CILEX").val("");
    }

    if ($("#DOCSTAMPS").length > 0) {
        $("#DOCSTAMPS").val("");
    }

    if ($("#CABLE").length > 0) {
        $("#CABLE").val("");
    }

//    if ($("#SUP").length > 0) {
//        $("#SUP").val("");
//    }
//
//    if ($("#CORRES-ADVISING").length > 0) {
//        $("#CORRES-ADVISING").val("");
//    }
//
//    if ($("#CORRES-CONFIRMING").length > 0) {
//        $("#CORRES-CONFIRMING").val("");
//    }

    if ($("#totalAmountCharges").length > 0) {
        $("#totalAmountCharges").val("");
    }

    if ($("#NOTARIAL").length > 0) {
        $("#NOTARIAL").val("");
    }

//    if ($("#interestDue").length > 0) {
//        $("#interestDue").val("");
//    }

//    if ($("#REMITTANCE").length > 0) {
//        $("#REMITTANCE").val("");
//    }

    if ($("#BOOKING").length > 0) {
        $("#BOOKING").val("");
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
//        setupBankCommission(settlementCurrency);
//        setupCommitmentFee(settlementCurrency);
//        setupCilexFee(settlementCurrency);
//        setupDocumentaryStamp(settlementCurrency);
//        setupCableFee(settlementCurrency);
//        setupSuppliesFee(settlementCurrency);
//        setupNotarialFee(settlementCurrency);
//        setupRemittanceFee(settlementCurrency);
//        setupAdvisingFee(settlementCurrency);
//        setupConfirmingFee(settlementCurrency);
//        setupBspFee(settlementCurrency);
//        setupBookingCommission(settlementCurrency);
        setupCharges(settlementCurrency);
        setupChargesPaymentCurrency(settlementCurrency);
    }

    var withFXinCASHLC = checkForOtherCurrency();
    var totalAmount = 0;
    var chargesList = stringToListHashMap(chargesString);

    // compute total charges
    $("#totalAmountCharges, #totalAmountDue").val("0.00");
    updateTotals();
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
        $(this).autoNumeric({mDec: 4});
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
    $("#USD-PHP_pass_on_rate_charges").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
    $(".USD-PHP_pass_on_rate_charges").val(data["pass-on"]["USD-PHP_pass_on_rate"]);
    $("#USD-PHP_special_rate_charges").val(data["special"]["USD-PHP_special_rate"]);
    $(".USD-PHP_special_rate_charges").val(data["special"]["USD-PHP_special_rate"]);
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
        $("#CILEX").parents("tr").show();
    }


}

function otherSettlementCurrencyUsed() {
    var withOtherCurrency = "false";

    if ($("#cilexFlag").val() == "true") {
        $("#CILEX").parents("tr").show();
        withOtherCurrency = "true";
    } else {
        $("#CILEX").parents("tr").hide();
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
