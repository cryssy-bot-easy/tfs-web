/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 7/25/13
 * Time: 9:25 PM
 * To change this template use File | Settings | File Templates.
 */

function constructChargesAndRatesPopup() {
    $.post(getBookedRatesUrl, {tradeServiceId: $("#transaction").val()}, function(data) {

        if (data.settlementCurrency && $("#settlementCurrency").length > 0) {
            $("#settlementCurrency").val(data.settlementCurrency);
        }

        if (data.rates.length > 0) {
            var ratesHeader = $('<tr>'+
                '<th class="rates">Rates</th>' +
                '<th class="rate_description">Rate Description</th>' +
                '<th class="pass_on_rate">Old Pass-on Rate</th>' +
                '<th class="pass_on_rate">New Pass-on Rate</th>' +
                '<th class="special_rate">Old Special Rate</th>' +
                '<th class="special_rate">New Special Rate</th>' +
                '</tr>');

            // clears all rows
            $("#forex_update_charges_popup").empty();
            $("#forex_update_charges_popup").append(ratesHeader);
        }

        // add each retrieved rows
        $.each(data.rates, function(key, rate) {
            // build textfield on string
            var textField = "<input type='text' id='" + rate.rates + "_special_rate' class='" + rate.rates + "_special_rate new' value='" + rate.specialRate + "'/>";
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

            $("#forex_update_charges_popup").append(rateRow);
        });

        // basic charges
        var basicChargesHeader = $('<tr class="oi-charges">' +
            '<td><span class="field_label p_header">Charges<br />&#160;</span></td>' +
            '</tr>');

        $("#basic_charges_popup").empty();
        $("#basic_charges_popup").append(basicChargesHeader);

        $.each(data.charges, function(key, charge) {

            var textField = "<input type='text' id='" + charge.displayId + "' class='input_field_right' value='' readonly='readonly' />";
            var hiddenField = "<input type='hidden' id='" + charge.hiddenId + "' class='input_field_right' value='" + charge.displayValue + "' readonly='readonly' />";
            var newTextField = "<input type='text' id='" + charge.newId + "' class='input_field_right' name='number'/>";

            var chargeRow = $('<tr>' +
                '<td><span>' + charge.description + '</span></td> ' +
                '<td> ' +
                '<span class="charges_currency" id="' + charge.currencyId + '">' + charge.settlementCurrency + '</span>' +
                '</td> ' +
                '<td> ' +
                textField +
                hiddenField +
                '</td> ' +
                // '<td class="link"><a href="javascript:void(0)" id="edit_charge">edit</a></td> ' +
                '<td class="last_child editable">' +
                newTextField +
                '</td> ' +
                '</tr>');

            $("#basic_charges_popup").append(chargeRow);
        });
    	$("input[name=number]").each(function(){
    		$(this).autoNumeric();
    	});

        // corres charges
        if (data.corresCharges.length > 0) {
            var corresChargesHeader = $('<tr class="oi-charges">' +
                '<td><span class="field_label p_header">Corres Charges<br />&#160;</span></td>' +
                '</tr>');

            $("#corres_charge_popup").empty();
            $("#corres_charge_popup").append(corresChargesHeader);
        }

        $.each(data.corresCharges, function(key, corresCharges) {

            var textField = "<input type='text' id='" + corresCharges.displayId + "' class='input_field_right' value='' readonly='readonly' />";
            var hiddenField = "<input type='hidden' id='" + corresCharges.hiddenId + "' class='input_field_right' value='" + corresCharges.displayValue + "' readonly='readonly' />";
            var newTextField = "<input type='text' id='" + corresCharges.newId + "'class='input_field_medium_right numericCurrency' />";

            var chargeRow = $('<tr>' +
                '<td><span>' + corresCharges.description + '</span></td> ' +
                '<td> ' +
                '<span class="charges_currency" id="' + corresCharges.currencyId + '">' + corresCharges.settlementCurrency + '</span>' +
                '</td> ' +
                '<td> ' +
                textField +
                hiddenField +
                '</td> ' +
//                '<td class="link"><a href="javascript:void(0)" id="edit_charge">edit</a></td> ' +
                '<td class="last_child editable">' +
                newTextField +
                '</td> ' +
                '</tr>');

            $("#corres_charge_popup").append(chargeRow);
        });


        var params = {currency: $("#currency").val(), settlementCurrency: $("#settlementCurrency").val()};


        $("#forex_update_charges_popup :input").each(function() {
            if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("old") != -1) {
                params[$(this).attr("id")] = $(this).val();
            }
        });

        // basic charges
        $("#basic_charges_popup :input").each(function() {
            if ($(this).attr("id") != undefined && $(this).attr("id") != null && $(this).attr("id").indexOf("Base") != -1) {
                params[$(this).attr("id")] = $(this).val();
            }
        });

        // corres charges
        $("#corres_charge_popup :input").each(function() {
            if ($(this).attr("id") != undefined && $(this).attr("id") != null && $(this).attr("id").indexOf("Base") != -1) {
                params[$(this).attr("id")] = $(this).val();
            }
        });

        $.post(recomputeNewChargesUrl, params, function(data) {
            // basic charges
            $("#basic_charges_popup :input").each(function() {
                var fieldId = $(this).attr("id");

                if (fieldId != undefined && fieldId != null && (fieldId.indexOf("New") == -1 && fieldId.indexOf("Base") == -1)) {

                    $.each(data.convertedValues, function(key, value) {
                        if (fieldId == value["convertedKey"]) {
                            $("#"+fieldId).val(value["convertedValue"]);
                        }
                    });
                }
            });

            // corres charges
            $("#corres_charge_popup :input").each(function() {
                var fieldId = $(this).attr("id");

                if (fieldId != undefined && fieldId != null && (fieldId.indexOf("New") == -1 && fieldId.indexOf("Base") == -1)) {

                    $.each(data.convertedValues, function(key, value) {

                        if (fieldId == value["convertedKey"]) {
                            $("#"+fieldId).val(value["convertedValue"]);
                        }
                    });
                }
            });

            loadPopup("update_charges_popup", "update_charges_popup_bg");
            centerPopup("update_charges_popup", "update_charges_popup_bg");
        });
    });
}

function openUpdateChargesPopup() {
    constructChargesAndRatesPopup();
}

function closeUpdateChargesPopup() {
    $("#forex_update_charges_popup").empty();

    $("#basic_charges_popup").empty();
    $("#corres_charge_popup").empty();

    disablePopup("update_charges_popup", "update_charges_popup_bg");
}

function recomputeNewCharges() {
    var params = {currency: $("#currency").val() , settlementCurrency: $("#settlementCurrency").val(), transaction:$("#transaction").val()};

    $("#forex_update_charges_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("new") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    // basic charges
    $("#basic_charges_popup :input").each(function() {
        if ($(this).attr("id") != undefined && $(this).attr("id") != null && $(this).attr("id").indexOf("Base") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    // corres charges
    $("#corres_charge_popup :input").each(function() {
        if ($(this).attr("id") != undefined && $(this).attr("id") != null && $(this).attr("id").indexOf("Base") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    $.post(recomputeNewChargesUrl, params, function(data) {
        // basic charges
        $("#basic_charges_popup :input").each(function() {
            var fieldId = $(this).attr("id");

            if (fieldId != undefined && fieldId != null && fieldId.indexOf("New") != -1) {
                $.each(data.convertedValues, function(key, value) {

                    if (fieldId == value["convertedKey"] + "New") {
                        $("#"+fieldId).val(value["convertedValue"]);
                    }
                });
            }
        });

        // corres charges
        $("#corres_charge_popup :input").each(function() {
            var fieldId = $(this).attr("id");

            if (fieldId != undefined && fieldId != null && fieldId.indexOf("New") != -1) {
                $.each(data.convertedValues, function(key, value) {

                    if (fieldId == value["convertedKey"] + "New") {
                        $("#"+fieldId).val(value["convertedValue"]);
                    }
                });
            }
        });
    });
}

function applyUpdatedCharges() {
    var params = {tradeServiceId: $("#tradeServiceId").val(), settlementCurrency: $("#settlementCurrency").val(), transactionType: $("#transaction option:selected").text(), transaction:$("#transaction").val()};

    // rates
    $("#forex_update_charges_popup :input").each(function() {
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("new") != -1) {
            params[$(this).attr("id")] = $(this).val();
        }
    });

    // basic charges
    $("#basic_charges_popup :input").each(function() {
        var fieldId = $(this).attr("id");
        params[fieldId] = $("#"+fieldId).val();
    });

    // corres charge
    $("#corres_charge_popup :input").each(function() {
        var fieldId = $(this).attr("id");
        params[fieldId] = $("#"+fieldId).val();
    });

    $.post(applyUpdatedChargesUrl, params, function(data) {
        closeUpdateChargesPopup();
        $("#grid_payment_details_summary_for_charges").jqGrid('setGridParam', {url: savedNewChargesUrl, page: 1}).trigger("reloadGrid");
    });
}

function setTotalChargePaymentAmount() {
    var data = $("#grid_payment_details_summary_for_charges").getGridParam("userData");
    $("#totalAmountOfCharges").val(data.totalAmountOfCharges);
    $("#totalAmountOfChargesCurrency").val(data.currency);

    setupChargesPaymentTabValues(data);

    $("#transaction").val("");
    onTransactionChange();
}

function setupChargesPaymentTabValues(data) {
    $("#totalAmountDue").val(data.totalAmountOfCharges);
    $("#totalAmtDueCurrency, #remainingBalanceCurrency, #amountOfPaymentChargesSettlementCurrency").text(data.currency);
    $("#settlementCurrency").val(data.currency);

    $.post(computeTotalCollectibleUrl, function(data2) {
        $("#remainingBalance").val(data2.balance);
        
        // set default amount of payment charges
        $("#amountOfPaymentCharges").val(data2.balance);
        
    });
}

function onTransactionChange() {
    var transaction = $("#transaction").val();

    $("#update_charges").hide();

    if (transaction) {
        $("#update_charges").show();
    }
}

function numberWithCommas(x) {
//	alert(x.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
	return x.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");	
}
