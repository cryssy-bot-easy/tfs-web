/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/29/12
 * Time: 1:16 PM
 * To change this template use File | Settings | File Templates.
 */

// computes overdrawn amount on change of negotiation amount
function computeOverDrawnAmount() {
    var negotiationAmount = $("#negotiationAmount").val();
    var apCashAmountInNegotiationCurrency = $("#cashAmount").val();

    if(negotiationAmount != "") {
        computeNegotiationAmountInReimbursingCurrency();
    }

    var apCashAmount = 0;

    if(apCashAmountInNegotiationCurrency && apCashAmountInNegotiationCurrency != "") {
        apCashAmount = parseFloat(stripCommas(apCashAmountInNegotiationCurrency));
    }
    
    var overdrawnAmount = $("#overdrawnAmount").val();
    
    if ($("#icNumber").val() == "") {
    	overdrawnAmount = parseFloat(stripCommas(negotiationAmount) - apCashAmount);
    }

    if(overdrawnAmount < 0) {
        overdrawnAmount = 0;
    }

    $("#overdrawnAmount").val(formatCurrency(overdrawnAmount));
}

function computeNegotiationAmountInReimbursingCurrency() {
    $("#negotiationAmountInReimbursingCurrency").val("");

    if($("#reimbursingBankSpecialRate").val() != "") {
        var negotiationAmount = parseFloat(stripCommas($("#negotiationAmount").val()));
        var reimbursingBankSpecialRate = parseFloat(stripCommas($("#reimbursingBankSpecialRate").val()));

        $("#negotiationAmountInReimbursingCurrency").val(formatCurrency(negotiationAmount * reimbursingBankSpecialRate));
    }
}

// display / hide negotiation payment based on cash flag
function constructNegotiationPaymentTab() {
    var overdrawnAmount = $("#overdrawnAmount").val();    
    
    if(overdrawnAmount != "0.00") { // shows negotiation payment
        $(".display_negotiation_ua_loan").show();
    } else { // hides negotiation payment
        $(".display_negotiation_ua_loan").hide();
    }
}

function initializeNegotiationEtsBusinessRules() {
    $("#negotiationAmount").change(computeOverDrawnAmount);
    computeOverDrawnAmount();

    $("#reimbursingBankSpecialRate").change(computeNegotiationAmountInReimbursingCurrency);

    // applies hiding and displaying nego payment tab if there is cash amount
    if($("#cashAmount").val() != "") {
        constructNegotiationPaymentTab();
    }

    $("#totalAmountDueLc").val($("#overdrawnAmount").val()); // sets amount due to overdrawn amount
}

$(initializeNegotiationEtsBusinessRules);
