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

<g:hiddenField name="chargeType" value="SETTLEMENT" />
<g:javascript src="utilities/ets/commons/cash_lc_payment_tab_utility.js" />

<table class="charges_table">
    <tr>
        <td width="165">
            <span class="field_label"> Export Advance Due Currency/Amount </span>
        </td>
        <td>
            <g:textField name="importAdvanceDueCurrency" id="importAdvanceDueCurrency" value="${currency}" class="input_field_short trans_currency center" readonly="readonly"/>
        </td>
        <td>
            <g:textField class="input_field_right numericCurrency" value="${amount}" name="importAdvanceDueAmount" id="importAdvanceDueAmount" readonly = "readonly"/>
        </td>
    </tr>
    <tr>
        <td width="165">
            <span class="field_label"> Export Advance Currency/Amount </span>
        </td>
        <td>
            <g:textField name="importAdvanceCurrency" id="importAdvanceCurrency" value="${currency}" class="input_field_short trans_currency center" readonly="readonly"/>
        </td>
        <td class="editable">
            <g:textField name="importAdvanceAmount" id="importAdvanceAmount" value="${amount}"  class="input_field_right numericCurrency"/>
        </td>
    </tr>
</table>
<table class="tabs_forms_table">
    <tr>
        <td width="170"><span class="field_label"> Refund Currency </span></td>
        <td><input class="tags_currency select2_dropdown bigdrop" name="newRefundCurrency" id="newRefundCurrency" /></td>
    </tr>
</table>
<div class="grid_wrapper"> %{--JQGRID--}%
    <table class="foreign_exchange">
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
                    <td class="urr">
                        <g:textField name="${temp.rates+'_text_pass_on_rate_urr'}" id="${temp.rates+'_text_pass_on_rate_urr'}" class="${temp.rates+'_pass_on_rate'} numericRates product_rates" value="${temp.text_pass_on_rate ?: temp.pass_on_rate}" />
                         <g:hiddenField name="${temp.rates+'_pass_on_rate_cash_urr'}" id="${temp.rates+'_pass_on_rate_cash_urr'}" class="${temp.rates+'_pass_on_rate'}" value="${temp.pass_on_rate_cash ?: temp.pass_on_rate}"/></td>
                    </td>
                    <td class="urr">
                        <g:textField name="${temp.rates+'_text_special_rate_urr'}" id="${temp.rates+'_text_special_rate_urr'}" class="${temp.rates+'_special_rate'} numericRates product_rates" value="${temp.text_special_rate ?: temp.special_rate}" />
                        <g:hiddenField name="${temp.rates+'_special_rate_cash_urr'}" id="${temp.rates+'_special_rate_cash_urr'}" class="${temp.rates+'_special_rate'} " value="${temp.special_rate_cash ?: temp.special_rate}"/>
                        <g:hiddenField name="${temp.rates+'_urr'}" class="${temp.rates+'_urr'}" value="${temp.special_rate_cash ?: temp.special_rate}"/>
                    </td>
                </g:if>
                <g:else>
                    <td><g:textField name="${temp.rates+'_text_pass_on_rate'}" class="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/>
                        <g:hiddenField name="${temp.rates+'_pass_on_rate_cash'}" value="${temp.pass_on_rate}"/></td>
                    <td><g:textField name="${temp.rates+'_text_special_rate'}" class="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/>
                        <g:hiddenField name="${temp.rates+'_special_rate_cash'}" value="${temp.special_rate}"/></td>
                </g:else>
            </tr>
        </g:each>
    </table>
</div>
<table class="popup_full_width">
    <tr>
        <td width="240">Pass-on rates confirmed by:</td>
        <td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
        <td>
            <input type="button" class="input_button_long" value="Recompute Charge" name="recomputeChargeBtnCashLc" id="recomputeChargeBtnCashLc"/>
        </td>
    </tr>
</table>
<table class="charges_table">    
    <tr>
        <td width="195">
            <span class="field_label"> Refund Currency/Amount </span>
        </td>
        <td><g:textField name="refundCurrency" class="input_field_short trans_currency center" readonly="readonly" value="PHP"/></td>
        <td>
            <g:textField class="input_field_right numericCurrency" id="amountInDefCurrency" name="amountInDefCurrency" readonly="readonly"/>
        </td>
    </tr>
</table>

<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_proceeds" value="Add Settlement Mode" />

<br /><br/>

<div class="grid_wrapper fix"> <%-- JQGRID --%>
    <table id="grid_list_proceeds_payment_summary"> </table>
    <g:hiddenField name="proceedsPaymentSummary" value="" />
</div>
<table class="charges_payment_table">
	<tr>
		<td width="235"><span class="field_label"> Total Amount of Refund <br />(in Refund currency) </span></td>
		<td><g:textField class="input_field_right" value="" name="totalRefundAmount" readonly="readonly"/></td>
	</tr>
</table>
<br/>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="saveConfirmProductPayment" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <%-- BUTTON --%>
        <td><input type="button" id="cancelConfirmProductPayment" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>


<script type="text/javascript">
    var settlementToBenGridUrl = '${g.createLink(controller: "importAdvance", action: "displayRefundEtsGrid")}';
    var convertRatesUrl = '${g.createLink(controller:'foreignExchange', action:'convertCashRates')}';

    function setupSettlementToBenEtsGrid() {
        var url = settlementToBenGridUrl;
        url += "?tradeServiceId="+$("#tradeServiceId").val();

        setupJqGridWidthNoPagerHidden("grid_list_proceeds_payment_summary", {width : 780, height: 90, scrollOffset : 0, gridComplete: setupChargesRefund},
                [["modeOfPayment", "Mode of Refund", 14],
                    ["settlementCurrency", "Refund Currency", 14],
                    ["amountSettlement", "Amount", 20, "right"],
                    ["amountInRefundCurrency", "Amount in (Refund Currency)", 20, "right"],
                    ["deletePaymentSummary","Delete", 4, "center"],
                    ["paymentMode", "Payment Mode", 4, "left", "hidden"],
                    ["referenceId", "referenceId", 4, "left", "hidden"],
                    ["rates", "Rates", 4, "left", "hidden"],
                    ["tradeSuspenseAccount", "Trade Suspense Account", 4, "left", "hidden"],
                    ["accountNumber", "Account Number", 4, "left", "hidden"]], url);
    }

    function getConversionRate() {
        if($("#savedCurrency").val() == $("#refundCurrency").val()){
            return 1
        } else if($("#refundCurrency").val() != "") {
            var currency = $("#savedCurrency").val();
            var settlementCurrency = $("#refundCurrency").val();
            var usd_php = parseFloat(stripCommas($("#USD-PHP_special_rate_cash").val()))
            var base_to_php;
            if (currency == 'PHP') {
                base_to_php = 1
            } else if ($("#"+currency+"-PHP_special_rate_cash").length == 1){
                base_to_php = parseFloat(stripCommas($("#"+currency+"-PHP_special_rate_cash").val()));
            } else {
                base_to_php = parseFloat(stripCommas($("#"+currency+"-USD_special_rate_cash").val())) * usd_php
            }
            switch(settlementCurrency){
                case 'PHP':
                    return base_to_php;
                    break;
                case 'USD':
                    return (currency == 'PHP') ? usd_php : (currency == 'USD') ? (usd_php / base_to_php) : parseFloat(stripCommas($("#"+currency+"-USD_special_rate_cash").val()));
                    break;
                default:
                    if ($("#"+settlementCurrency+"-PHP_special_rate_cash").length == 1){
                        return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val()))) : (currency == 'USD') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val()))) : (base_to_php / parseFloat(stripCommas($("#"+settlementCurrency+"-PHP_special_rate_cash").val())));
                    } else {
                        return (currency == 'PHP') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php) : (currency == 'USD') ? (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val()))) : (base_to_php / (parseFloat(stripCommas($("#"+settlementCurrency+"-USD_special_rate_cash").val())) * usd_php));
                    }
            }
        }
    }

    function setupChargesRefund(){
    	var grid;

    	grid = $("#grid_list_proceeds_payment_summary")
    	
    	var ids = grid.jqGrid("getDataIDs");
        var totalPayments = 0;
        for(i in ids) {
            var data = grid.jqGrid("getRowData",ids[i]);
            var amount;
            if(data.amount != undefined) {
                amount = stripCommas(data.amount);
            }else{
                amount = stripCommas(data.amountSettlement);
            }
            totalPayments += parseFloat(amount);
        }
        $("#totalRefundAmount").val(formatCurrency(totalPayments));
        $("#importAdvanceAmount").val(formatCurrency(parseFloat($("#importAdvanceDueAmount").val().replace(",","")) - parseFloat(totalPayments)));
		convertToDefaultCurrency();
    }
    
    function convertToDefaultCurrency() {
        var params = {
            amount: $("#importAdvanceAmount").val(),
            conversion_rate: getConversionRate(),
            base_ccy: $("#importAdvanceCurrency").val(),
            target_ccy: $("#refundCurrency").val(),
            convertTo : "LC"
        }

        $.post(convertRatesUrl,params,function(data){
            $("#importAdvanceAmount").val(data.equivSettlement);
            $("#amountInDefCurrency").val(data.equivLc)
        });
    }

    $(document).ready(function() {
    	$("#newRefundCurrency").setSettlementCurrencyDropdown($(this).attr("id")).select2('data',{id: '${newRefundCurrency ?: 'PHP'}'});
        setupSettlementToBenEtsGrid();
        setupChargesRefund();
        $("#settlementCurrencyLc").setCurrencyDropdown($(this).attr("id"));
        hideUnrelatedExchangeRates();
//        onSettlementCurrencyCashChange();
        loadRelatedExchangeRates();
//        if ($.isFunction(window.checkForOtherCurrency)) {
//            checkForOtherCurrency();
//        }

        $("#importAdvanceAmount").change(function() {
            convertToDefaultCurrency();
        });
        
        if ($("#saveConfirmProductPayment").length > 0) {
            $("#saveConfirmProductPayment").click(function() {
                var productSummaryData = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
                $("#proceedsPaymentSummary").val(JSON.stringify(productSummaryData));
                mCenterPopup($("#loading_div"), $("#loading_bg"));
            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                $("#productPaymentTabForm").submit();
            })
        }

        if ($("#cancelConfirmProductPayment").length > 0) {
            $("#cancelConfirmProductPayment").click(function() {
                mDisablePopup($("#productPaymentDiv"), $("#productPaymentBg"));
                location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            })
        }
        $("#newRefundCurrency").change(function(){
            $("#refundCurrency").val($(this).val());
            convertToDefaultCurrency();
        });
        $("#newRefundCurrency").change();
    });
</script>