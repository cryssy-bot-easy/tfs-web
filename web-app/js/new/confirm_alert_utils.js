/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/22/13
 * Time: 12:05 PM
 * To change this template use File | Settings | File Templates.
 */

function basicDetailsSaveQwerty() {
    $("#basicDetailsTabForm").submit();
}

function mtDetailsSave() {
    var postUrl = productTradeServiceSave;

    $("#mtDetailsTabForm").attr("method", "POST");
    $("#mtDetailsTabForm").attr("action", postUrl);

    $("#mtDetailsTabForm").submit();
}

function productPaymentSave() {
    var postUrl = productUpdate;

    var productSummaryData = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
    $("#documentPaymentSummary").val(JSON.stringify(productSummaryData));

    $("#productPaymentTabForm").attr("method", "POST");
    $("#productPaymentTabForm").attr("action", postUrl);

    $("#productPaymentTabForm").submit();
}

function chargesSave() {
    var postUrl = productUpdate;

    $("#chargesTabForm").attr("method", "POST");
    $("#chargesTabForm").attr("action", postUrl);

    $("#chargesTabForm").submit();
}

function chargesPaymentSave() {
    var postUrl = productUpdate;

    var serviceSummaryData = $("#grid_list_charges_payment").jqGrid("getRowData");
    $("#chargesPaymentSummary").val(JSON.stringify(serviceSummaryData));

    $("#chargesPaymentTabForm").attr("method", "POST");
    $("#chargesPaymentTabForm").attr("action", postUrl);

    $("#chargesPaymentTabForm").submit();
}
