/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/26/13
 * Time: 9:19 PM
 * To change this template use File | Settings | File Templates.
 */

function onChangeOtherOption() {
    var postUrl = refundProductGridUrl;
    postUrl += "?documentNumber="+$("#documentNumber").val();
    postUrl += "&tradeServiceId="+$("#otherOption").val();

    $("#grid_list_refund_details_summary_cash_lc").jqGrid("setGridParam", {url: postUrl, page: 1, datatype: "json"}).trigger("reloadGrid");
}

function onChangeRefundOption() {
    var option = $("input[name=refundOption]:checked").val();

    $("#productTransaction").val("");
    $("#partialAmountForRefund").val("");

    if (option == "PARTIAL") {
        $("#update_cash").show();

        $("#productTransaction").attr("disabled", "disabled");
        $("#update_product_amount").hide();
    } else if (option == "OTHERS") {
        $("#productTransaction").attr("disabled", false);

        $("#update_cash").hide();
    }
}

function clearAll() {
    $.post(clearAllProductRefundUrl, function(data) {
        $("#grid_list_refund_details_summary_cash_lc").jqGrid('setGridParam', {url: savedNewRateProductPaymentUrl, page: 1}).trigger("reloadGrid");
    });
}

function openUpdateCashPopup() {
    var partialAmountForRefund = $("#partialAmountForRefund").val();

    if (!partialAmountForRefund) {
        triggerAlertMessage("Partial Amount for Refund cannot be blank.");
        return;
    }

    $("#amountForRefund").val(partialAmountForRefund);
    loadPopup("update_cash_popup", "update_cash_popup_bg");
    centerPopup("update_cash_popup", "update_cash_popup_bg");
}

function closeUpdateCashPopup() {
    disablePopup("update_cash_popup", "update_cash_popup_bg");
}

function recomputeNewCash() {
    var params = {currency: $("#amountForRefundCurrency").val(), amount: $("#amountForRefund").val()};

    $("#forex_product_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("_special_rate_charges") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    $.post(recomputeNewAmountUrl, params, function(data) {
        $("#amountForRefundInPhp").val(data.newAmount);
    });
}

function onProductTransactionChange() {
    var productTransaction = $("#productTransaction").val();

    $("#update_product_amount").hide();

    if (productTransaction) {
        $("#update_product_amount").show();
    }
}

function constructNewRatesPopup() {
    $.post(getBookedRatesUrl, {tradeServiceId: $("#productTransaction").val()}, function(data) {
        var ratesHeader = $('<tr>'+
            '<th class="rates">Rates</th>' +
            '<th class="rate_description">Rate Description</th>' +
            '<th class="pass_on_rate">Old Pass-on Rate</th>' +
            '<th class="pass_on_rate">New Pass-on Rate</th>' +
            '<th class="special_rate">Old Special Rate</th>' +
            '<th class="special_rate">New Special Rate</th>' +
            '</tr>');

        // clears all rows
        $("#forex_update_new_rate_product_amount_popup").empty();
        $("#forex_update_new_rate_product_amount_popup").append(ratesHeader);

        // add each retrieved rows
        $.each(data.rates, function(key, rate) {
            // build textfield on string
            var textField = "";
            var oldHiddenField = "<input type='hidden' id='" + rate.rates + "_special_rate' class='" + rate.rates + "_special_rate old' value='" + rate.specialRate + "'/>";

            var td;

            if (rate.description.indexOf("BOOKING") == -1) {
                textField = "<input type='text' id='" + rate.rates + "_special_rate' class='" + rate.rates + "_special_rate new' value='" + rate.specialRate + "'/>";

                td = '<td>' + textField;
            } else {
                td = '<td class="urr">' + rate.specialRate;
            }

            var rateRow = $('<tr>' +
                '<td>' + rate.rates + '</td>' +
                '<td>' + rate.description + '</td>' +
                '<td class="urr">' + rate.passOnRate + '</td>' +
                '<td class="urr">' +
                 rate.passOnRate +
                '</td>' +
                '<td class="urr">' + rate.specialRate + ' ' + oldHiddenField + '</td>' +
                 td +
                '</td>' +
                '</tr>');

            $("#forex_update_new_rate_product_amount_popup").append(rateRow);
        });

        $.post(getProductPaymentsMadeUrl, {tradeServiceId: $("#productTransaction").val()}, function(data) {
            $("#outstandingLcCurrency").val(data.outstandingLcCurrency);
            $("#outstandingLcAmount").val(data.outstandingLcAmount);

            $("#paymentsMade").empty();

            $.each(data.paymentDetail, function(key, paymentDetail) {
                var currencyField = '<input type="text" name="currency_' + key + '" class="input_field_short otherRefundInput" readonly="readonly" value="' + paymentDetail.settlementCurrency + '" />';
                var originalAmountField = '<input type="text" name="amount_' + key + '" class="input_field_right otherRefundInput" readonly="readonly" value="' + paymentDetail.amount + '" />';
                var originalAmountLcCurrency = '<input type="hidden" name="base_amount_' + key + '" class="input_field_right otherRefundInput" readonly="readonly" value="' + paymentDetail.amountInLcCurrency + '" />';
                var newAmountField = '<input type="text" id="newAmount_' + key + '" name="newAmount_' + key + '" class="input_field_right otherRefundInput" value="" />';

                var paymentRow = $('<tr>' +
                            '<td></td>' +
                            '<td>' +
                            currencyField +
                            '</td>' +
                            '<td>' +
                            originalAmountField + originalAmountLcCurrency +
                            '</td>' +
                            '<td class="editable">' +
                            newAmountField +
                            '</td>' +
                            '</tr>');

                $("#paymentsMade").append(paymentRow);
            });

            loadPopup("update_new_rate_cash_popup", "update_new_rate_cash_popup_bg");
            centerPopup("update_new_rate_cash_popup", "update_new_rate_cash_popup_bg");
        })
    });
}

function openNewRateProductAmountPopup() {
    constructNewRatesPopup();
}

function closeNewRateProductAmountPopup() {
    disablePopup("update_new_rate_cash_popup", "update_new_rate_cash_popup_bg");
}

function recomputeNewRateProductAmount() {
    var params = {currency: $("#amountForRefundCurrency").val(), amount: $("#amountForRefund").val()};

    $("#paymentsMade :input").each(function() {
            params[$(this).attr("name")] = $(this).val();
    });

    $("#forex_update_new_rate_product_amount_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("new") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    $.post(recomputeNewRateAmountUrl, params, function(data) {
        $.each(data.newAmountList, function(key, amountList) {
            $("#newAmount_" + key).val(amountList["newAmount_" + key]);
        });
    });
}

function applyNewRateProductAmountRefund() {
    var params = {tradeServiceId: $("#tradeServiceId").val(),
        settlementCurrency: $("#amountForRefundCurrency").val(),
        transactionType: $("#productTransaction option:selected").text()};

    $("#paymentsMade :input").each(function() {
        params[$(this).attr("name")] = $(this).val();
    });

    $("#forex_update_new_rate_product_amount_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("new") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    $.post(applyNewRateAmountUrl, params, function(data) {
        closeNewRateProductAmountPopup();
        $("#grid_list_refund_details_summary_cash_lc").jqGrid('setGridParam', {url: savedNewRateProductPaymentUrl, page: 1}).trigger("reloadGrid");
    });
}

function setTotalProductRefund() {
    var data = $("#grid_list_refund_details_summary_cash_lc").getGridParam("userData");
    $("#totalRefundProductAmount").val(data.totalAmountOfProductPayment);

    if (referenceType != "DATA_ENTRY") {
        reloadSettlementToBen();
    }

    $("#productTransaction, #partialAmountForRefund").val("");
    $("#update_cash").hide();
    onProductTransactionChange();
}

function applyUpdateProductAmount() {
    var params = {tradeServiceId: $("#tradeServiceId").val(),
        settlementCurrency: $("#amountForRefundCurrency").val(),
        transactionType: "",
        amountForRefund: $("#amountForRefund").val(),
        amountForRefundInPhp: $("#amountForRefundInPhp").val()};

    $("#forex_product_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("_special_rate_charges") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    $.post(applyPartialRefundUrl, params, function(data) {
        closeUpdateCashPopup();
        $("#grid_list_refund_details_summary_cash_lc").jqGrid('setGridParam', {url: savedNewRateProductPaymentUrl, page: 1}).trigger("reloadGrid");
    });
}