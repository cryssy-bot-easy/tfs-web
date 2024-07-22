/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/14/12
 * Time: 11:38 PM
 * To change this template use File | Settings | File Templates.
 */

function constructNegotiationPaymentTabPayment() {
    var overdrawnAmount = $("#overdrawnAmount").val();
    if(overdrawnAmount != "" && eval(parseFloat(overdrawnAmount) > 0.00)) {
        $(".display_negotiation_ua_loan").show();
        $("#totalAmountDueLc").val($("#overdrawnAmount").val());
        $("#totalAmountDueLcCurrency").val($("#negotiationCurrency").val());
    } else if(documentSubType1.toUpperCase() != "STANDBY") {
        $(".display_negotiation_ua_loan").hide();
    }
}

function computeNegotiationAmountInReimbursingCurrency() {
    if($("#reimbursingBankSpecialRate").val() != "") {
        var negotiationAmount = parseFloat(stripCommas($("#negotiationAmount").val()));
        var reimbursingBankSpecialRate = parseFloat(stripCommas($("#reimbursingBankSpecialRate").val()));

        $("#negotiationAmountInReimbursingCurrency").val(formatCurrency(negotiationAmount * reimbursingBankSpecialRate));
    }
}

function initializeNegotiationBusinessRulesPayment() {
    constructNegotiationPaymentTabPayment();
    
    $("#reimbursingBankSpecialRate").change(computeNegotiationAmountInReimbursingCurrency);
}

$(initializeNegotiationBusinessRulesPayment);
