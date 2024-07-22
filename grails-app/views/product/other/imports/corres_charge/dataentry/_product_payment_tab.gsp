%{--<g:javascript src="grids/cash_lc_payment_jqgrid.js" />--}%
<g:javascript src="new/import_advance/product_payment_grid.js" />
<g:javascript src="utilities/ets/commons/cash_lc_payment_tab_utility.js" />

<script type="text/javascript">
    var convertRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertCashRates')}';
    var convertCorresUrl = '${g.createLink(controller: "foreignExchange", action: "convertCorres")}';

    %{--var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';--}%
    var productChargeUrl = '${g.createLink(controller:'product', action:'displayProductPaymentsGrid')}';
    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    productChargeUrl += "&referenceType=" + $("#referenceType").val();
    productChargeUrl += "&serviceType="+$("#serviceType").val();
    var windowed = ${windowed ?: false};

    var recomputeCashPostUrl = '${g.createLink(controller:'foreignExchange', action:'updateExchangeRates')}';

</script>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="lcPayment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

    <span class="title_label">Actual Corres Charge Due</span>
    <table class="charges_table">
        <tr>
            <td><span class="field_label"> Total Billing Amount - Billing Currency</span></td>
            <td>
                <span class="charges_currency" id="totalAmountDueLcCurrency">${currency}</span>
            </td>
            <td><g:textField class="input_field_right numericCurrency" value="${totalAmountDueLc ?: cashAmount ?: amount}" name="totalAmountDueLc" readonly="readonly"/></td>
        </tr>
        %{--<tr>--}%
            %{--<td><span class="field_label"> Balance </span></td>--}%
            %{--<td>--}%
                %{--<span class="charges_currency" id="remainingBalancLcCurrency">${currency}</span>--}%
            %{--</td>--}%
            %{--<td><g:textField class="input_field_right" value="${remainingBalanceLc}" name="remainingBalanceLc" readonly="readonly"/></td>--}%
        %{--</tr>--}%
    </table>
<g:hiddenField value="${remainingBalanceLc}" name="remainingBalanceLc" />
<br />
<table>
    <tr>
        <td width="235"><span class="field_label">&nbsp;Settlement Currency <br /></span></td>
        <td>
            <%-- Auto Complete --%>
            <g:textField name="settlementCurrencyLc" value="${settlementCurrency}" class="input_field" readonly="readonly"/>
        </td>
    </tr>
</table>

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
                        <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}" readonly="readonly"/>
                            <g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/></td>
                        <td>
                            <g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.text_special_rate ?: temp.special_rate}"/>
                            <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.text_special_rate ?: temp.special_rate}"/>
                            <script>
                                $(document).ready(function() {
                                    var displayId = "${temp.rates+'_text_special_rate'}";

                                    $("#" + displayId).change(function() {
                                        var hiddenId = "${temp.rates+'_special_rate_cash'}";

                                        $("#" + hiddenId).val($("#" + displayId).val());
                                    });
                                });
                            </script>
                        </td>
                    </g:else>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>
<table class="popup_full_width">
    <tr>
        <td width="240">Pass-on rates confirmed by:</td>
        <td><g:textField name="passOnRateConfirmedByCash" class="input_field" value="${passOnRateConfirmedByCash}"/></td>
        %{--if foreign--}%
        <td>
            <input type="button" class="input_button_long" value="Recompute Charge" name="recomputeChargeBtnCashLc2" id="recomputeChargeBtnCashLc2"/>
        </td>
    </tr>
</table>
<br />
<table class="charges_table">
    <tr>
        <td width="235">
            <span class="field_label"> Total Billing Amount (in PHP) </span>
        </td>
        <td>
            <span class="charges_currency"> PHP </span>
        </td>
        <td>
            <g:textField class="input_field_right numericCurrency" name="totalBillingAmountInPhp2" readonly="readonly"/>
        </td>
    </tr>
    <g:if test="${session.dataEntryModel?.tsdInitiated && session.dataEntryModel?.withoutReference}">
        <g:hiddenField name="netBillingAmount2" />
    </g:if>
    <g:else>
        <tr>
            <td width="235">
                <span class="field_label"> Net Billing Amount (in PHP) </span>
            </td>
            <td>
                <span class="charges_currency"> PHP </span>
            </td>
            <td>
                <g:textField class="input_field_right numericCurrency" name="netBillingAmount" readonly="readonly"/>
            </td>
        </tr>

        <tr>
            <td width="235">
                <span class="field_label"> Net Billing Amount (in Settlement Currency) </span>
            </td>
            <td>
                <span class="charges_currency"> ${settlementCurrency} </span>
            </td>
            <td>
                <g:textField name="netBillingAmountInBillingCurrency" class="input_field_right numericCurrency" value="" readonly="readonly"/>
            </td>
        </tr>
    </g:else>
</table>
<br/><br/>
<table class="charges_table">
    <tr>
        <td width="235">
            <span class="field_label" id="paymentDescription"> Amount of Payment in Settlement Currency</span>
        </td>
        <td>
            <span class="charges_currency" id="cashAmountInSettlementCurrency"></span>
        </td>
        <td class="editable"><g:textField class="input_field_right numericCurrency" name="cashAmountInSettlement" /></td>
    </tr>

</table>
<g:hiddenField class="input_field_right numericCurrency" name="cashAmountInLc"/>
<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement" />
<br /><br/>


    <span class="title_label">Payment Summary for Charges</span>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_cash_payment_summary"> </table>
    <div id="grid_pager_cash_payment_summary"></div>
    <g:hiddenField name="documentPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
    <tr>
        <td width="235"><span class="field_label"> Total Amount of Payment - Net Billing Amount (in Settlement Currency) </span></td>
        <td><g:textField class="input_field_right" value="" name="totalAmountOfPaymentLc" readonly="readonly"/></td>
    </tr>
    <tr>
        <td width="180"><span class="field_label"> Excess Amount (in Settlement Currency) </span></td>
        <td><g:textField class="input_field_right" value="" name="excessAmountLc" readonly="readonly"/></td>
    </tr>
</table>
<br/>


<g:hiddenField name="savedCurrency" value="${currency}" />

<script>
//    function getRatesForConversion(savedCurrency, settlementCurrency) {
//        if (savedCurrency == settlementCurrency) {
//            return 1
//        } else if (settlementCurrency != "") {
//            var currency = savedCurrency;
//            var settlementCurrency = settlementCurrency;
//            var usd_php = parseFloat(stripCommas($("#USD-PHP_special_rate_cash").val()));
//            var usd_php_buying = parseFloat(stripCommas($("#USD-PHP_text_special_rate_buying").val()));
//
//            if (!usd_php_buying && !usd_php) { //assume dmlc
//                usd_php = parseFloat(stripCommas($("#USD-PHP_urr").val()))
//                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
//            }
//
//            if (!usd_php_buying) { //assume dmlc
//                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
//            }
//
//            var base_to_php;
//            if (currency == 'PHP') {
//                base_to_php = 1
//            } else if (currency == 'USD') {
//                base_to_php = usd_php;
//            } else {
//                base_to_php = parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val())) * usd_php
//            }
//
//            switch (settlementCurrency) {
//                case 'PHP':
//                    return base_to_php;
//                    break;
//                case 'USD':
//                    return (currency == 'PHP') ? usd_php_buying : (currency == 'USD') ? (usd_php / base_to_php) : parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val()));
//                    break;
//                default:
//                    return (currency == 'PHP') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php));
//            }
//        }
//    }
    function getRatesForConversion(savedCurrency, settlementCurrency) {
        if (savedCurrency == settlementCurrency) {
            return 1
        } else if (settlementCurrency != "") {
            var currency = savedCurrency;
            var settlementCurrency = settlementCurrency;
            var usd_php = parseFloat(stripCommas($(".USD-PHP_special_rate_cash").val()));
            var usd_php_buying = parseFloat(stripCommas($("#USD-PHP_text_special_rate_buying").val()));

            if (!usd_php_buying && !usd_php) { //assume dmlc
                usd_php = parseFloat(stripCommas($("#USD-PHP_urr").val()))
                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
            }

            if (!usd_php_buying) { //assume dmlc
                usd_php_buying = parseFloat(stripCommas($("#USD-PHP_urr").val()))
            }

            if (settlementCurrency == "USD") {
                usd_php = $("#USD-PHP_urr");
            }

            var base_to_php;
            if (currency == 'PHP') {
                base_to_php = 1
            } else if (currency == 'USD') {
                base_to_php = usd_php;
            } else { // specifically for corres
                base_to_php = parseFloat(stripCommas($("." + currency + "-USD_special_rate_cash").val())) * usd_php
            }

            switch (settlementCurrency) {
                case 'PHP':
                    return base_to_php;
                    break;
                case 'USD':
                    return (currency == 'PHP') ? usd_php_buying : (currency == 'USD') ? (usd_php / base_to_php) : parseFloat(stripCommas($("#" + currency + "-USD_special_rate_cash").val()));
                    break;
                default:
                    return (currency == 'PHP') ? (parseFloat(stripCommas($("." + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#" + settlementCurrency + "-USD_special_rate_cash").val())) * usd_php));
            }
        }
    }

    function convertBillingAmountInPhp() {
        var params = {
            amount: $("#totalAmountDueLc").val(),
            conversion_rate: getRatesForConversion($("#savedCurrency").val(), $("#settlementCurrencyLc").val()),
            base_ccy: $("#totalAmountDueLcCurrency").text(),
            target_ccy: $("#settlementCurrencyLc").val(),
            convertTo: "LC",
            outstandingCorresCharge: $("#outstandingCorresCharge").val(),
            php_rate: getRatesForConversion($("#settlementCurrencyLc").val(), "PHP")
        }

        $.post(convertCorresUrl, params, function (data) {
            $("#totalBillingAmountInPhp").val(data.equivLc);

            if($("#totalBillingAmountInPhp2").length > 0) {
                $("#totalBillingAmountInPhp2").val(data.equivLc);
            }

            if ($("#netBillingAmount2").length > 0) {
                $("#netBillingAmount2").val(data.netBillingAmount);
            }

            $("#netBillingAmount").val(data.netBillingAmount);
            $("#netBillingAmountInBillingCurrency").val(data.netBillingAmountInBillingCurrency);
        });
    }

    $(document).ready(function() {
        //$("#settlementCurrencyLc").setCurrencyDropdown($(this).attr("id"));
        hideUnrelatedExchangeRates();
        onSettlementCurrencyCashChange();
        loadRelatedExchangeRates();
        if ($.isFunction(window.checkForOtherCurrency)) {
            checkForOtherCurrency();
        }

        convertBillingAmountInPhp();

        $("#recomputeChargeBtnCashLc2").click(function() {
            var params = {
                amount: $("#totalAmountDueLc").val(),
                conversion_rate: getRatesForConversion($("#savedCurrency").val(), $("#settlementCurrencyLc").val()),
                base_ccy: $("#totalAmountDueLcCurrency").text(),
                target_ccy: $("#settlementCurrencyLc").val(),
                convertTo: "LC",
                outstandingCorresCharge: $("#outstandingCorresCharge").val(),
                php_rate: getRatesForConversion($("#settlementCurrencyLc").val(), "PHP")
            }

            $.post(convertCorresUrl, params, function (data) {
                $("#totalBillingAmountInPhp").val(data.equivLc);
                $("#netBillingAmount").val(data.netBillingAmount);
                $("#netBillingAmountInBillingCurrency").val(data.netBillingAmountInBillingCurrency);
            }).done(setCashAmountInSettlement);
        });
        
               

    });
</script>