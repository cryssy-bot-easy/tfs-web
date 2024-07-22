<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<span class="title_label">Actual Corres Charge Rates</span>
<g:if test="${currency}">
    <div class="grid_wrapper"> %{--JQGRID--}%
        <table class="foreign_exchange" id="forex_product">
            <tr>
                <th class="rates">Rates</th>
                <th class="rate_description">Rate Description</th>
                <th class="pass_on_rate">Pass-on Rate</th>
                <th class="special_rate">Special Rate</th>
            </tr>
            <g:each in="${exchange}" var="temp" status="i" >
                <tr>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="rates">${temp.rates}</td>
                    </g:if>
                    <g:else>
                        <td class="rates">${temp.rates}<g:hiddenField name="${temp.rates}" value="${temp.rates}" /></td>
                    </g:else>
                    <td>${temp.rate_description}</td>
                    <g:if test="${temp.rate_description.contains('BOOKING')}">
                        <td class="urr">${temp.pass_on_rate.toString()}</td>
                        <td class="urr">${temp.special_rate.toString()}<g:hiddenField name="${temp.rates+'_urr'}" value="${temp.special_rate.toString()}"/></td>
                    </g:if>
                    <g:else>
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}"/>
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}"/></td>
                        <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.text_special_rate ?: temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.text_special_rate ?: temp.special_rate}"/></td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>

<br/><br/>
<table class="charges_table">
    <tr>
        <td width="235">
            <span class="field_label"> Total Billing Amount (in PHP) </span>
        </td>
        <td>
            <span class="charges_currency"> PHP </span>
        </td>
        <td>
            <g:textField class="input_field_right numericCurrency" name="totalBillingAmountInPhp" readonly="readonly"/>
        </td>
    </tr>

    <tr>
        <td width="235">
            <span class="field_label"> O/S Advance Corres Charges (in PHP) </span>
        </td>
        <td>
            <span class="charges_currency"> PHP </span>
        </td>
        <td>
            <g:textField name="outstandingCorresCharge" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingCorresCharge}"/>
        </td>
    </tr>

    <tr>
        <td width="235">
            <span class="field_label"> Net Billing Amount (in PHP) </span>
        </td>
        <td>
            <span class="charges_currency"> PHP </span>
        </td>
        <td>
			<%-- remove the numericCurrency class, nawawala ang laman if the the textfield is clicked --%>
            <g:textField class="input_field_right" name="netBillingAmount" readonly="readonly"/>
        </td>
    </tr>
</table>
<br />

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmActualCorres" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmActualCorres" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    var convertCorresUrl = '${g.createLink(controller: "foreignExchange", action: "convertCorres")}';

    function getRatesForConversion(savedCurrency, settlementCurrency) {
        if (savedCurrency == settlementCurrency) {
            return 1
        } else if (settlementCurrency != "") {
            var currency = savedCurrency;
            var settlementCurrency = settlementCurrency;
            var usd_php = parseFloat(stripCommas($("#USD-PHP_special_rate_cash").val()));
            var usd_php_buying = parseFloat(stripCommas($("#USD-PHP_text_special_rate_buying").val()));

            if (!usd_php_buying && !usd_php) { //assume dmlc
                usd_php = parseFloat(stripCommas($("#USD-PHP_urr").val()))
                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
            }

            if (!usd_php_buying) { //assume dmlc
                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
            }

            var base_to_php;
            if (currency == 'PHP') {
                base_to_php = 1
            } else if (currency == 'USD') {
                base_to_php = usd_php;
            } else {
                base_to_php = parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val())) * usd_php
            }

            switch (settlementCurrency) {
                case 'PHP':
                    return base_to_php;
                    break;
                case 'USD':
                    return (currency == 'PHP') ? usd_php_buying : (currency == 'USD') ? (usd_php / base_to_php) : parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val()));
                    break;
                default:
                    return (currency == 'PHP') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php));
            }
        }
    }

    function convertBillingAmountInPhp() {
        var params = {
            amount: $("#amount").val(),
            conversion_rate: getRatesForConversion($("#currency").val(), $("#settlementCurrency").val()),
            base_ccy: $("#currency").val(),
            target_ccy: $("#settlementCurrency").val(),
            convertTo: "LC",
            outstandingCorresCharge: $("#outstandingCorresCharge").val(),
            php_rate: getRatesForConversion($("#settlementCurrency").val(), "PHP")
        }

        $.post(convertCorresUrl, params, function (data) {
            $("#totalBillingAmountInPhp").val(data.equivLc);
            $("#netBillingAmount").val(data.netBillingAmount);
        });
    }

    $(document).ready(function() {
        convertBillingAmountInPhp();

        $("#saveConfirmActualCorres").click(function() {
            if(validateExportTab("#actualCorresTabForm") > 0){
                $("#alertMessage").text("Please fill in all the required fields.");
                triggerAlert();
            } else {
                if ($("#documentNumber").length > 0 && $("#documentNumber").val() != "NON-REF") {
//                if ($("#outstandingCorresCharge").length > 0 && $("#outstandingCorresCharge").val() == "0.00") {
//                    if (parseFloat($("#netBillingAmount").val().replace(/,/g, "")) < 0) {
                    var netBillingAmount = parseFloat($("#netBillingAmount").val().replace(/,/g, ""));
                    var outstandingCorresCharge = parseFloat($("#outstandingCorresCharge").val());

                    if (netBillingAmount < 0) {
                    	mCenterPopup($("#loading_div"), $("#loading_bg"));
                    	mLoadPopup($("#loading_div"), $("#loading_bg"));
                        $(".saveAction").show();
                        $(".cancelAction").hide();
                        $("#actualCorresTabForm").submit();
                    } else {
                        if (outstandingCorresCharge > 0) {
                            triggerAlertMessage("Total Billing Amount (in PHP) should be less than <br/> O/S Advance Corres Charges (in PHP).");
                        } else {
                        	mCenterPopup($("#loading_div"), $("#loading_bg"));
                        	mLoadPopup($("#loading_div"), $("#loading_bg"));
                            $(".saveAction").show();
                            $(".cancelAction").hide();
                            $("#actualCorresTabForm").submit();
                        }
                    }
                } else {
                	mCenterPopup($("#loading_div"), $("#loading_bg"));
                	mLoadPopup($("#loading_div"), $("#loading_bg"));
                    $(".saveAction").show();
                    $(".cancelAction").hide();
                    $("#actualCorresTabForm").submit();
                }
            }
        });

        $("#cancelConfirmActualCorres").click(function() {
            $(".saveAction").hide();
            $(".cancelAction").show();
        });
    });
</script>