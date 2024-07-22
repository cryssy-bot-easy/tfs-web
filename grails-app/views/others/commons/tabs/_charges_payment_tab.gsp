<g:javascript src="grids/charges_payment_summary_jqgrid.js" />
<g:javascript src="utilities/ets/commons/charges_payment_tab_utility.js"/>

<script type="text/javascript">
    var windowed = "${windowed}";
    var serviceChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findServiceChargesPayments')}';
    serviceChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    serviceChargeUrl += "&referenceType=" + $("#referenceType").val();
    serviceChargeUrl += "&documentClass=" + $("#documentClass").val();
</script>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="chargesPayment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:if test="${ serviceType != 'Adjustment' }">
    <table class="charges_table">
        <tr>
            <td width="160"><span class="field_label"> Total Amount Due </span></td>
            <td>
                <span class="charges_currency" id="totalAmtDueCurrency"></span>
            </td>
            <td><g:textField class="input_field_right" value="${totalAmountDue}" name="totalAmountDue" readonly="readonly"/></td>
        </tr>
        <tr>
            <td> &#160; </td>
        </tr>
        <tr>
            <td><span class="field_label"> Remaining Balance </span></td>
            <td>
                <span class="charges_currency" id="remainingBalanceCurrency"></span>
            </td>
            <td><g:textField class="input_field_right" value="${remainingBalance}" name="remainingBalance" readonly="readonly"/></td>
        </tr>
    </table>
</g:if>
<br/>

<table class="charges_table">
    <tr>
        <td width="160"><span class="field_label"> Amount of Payment - Charges <br/>(in Settlement Currency) </span> </td>
        <td>
            <span class="charges_currency" id="amountOfPaymentChargesSettlementCurrency"></span>
        </td>
        <td class="editable"><g:textField class="input_field_right numericCurrency" name="amountOfPaymentCharges" /></td>
    </tr>
</table>

<div class="chargesPaymentButtons">
    <table>
        <tr>
            <td><input type="button" class="input_button_long" value="Update Balances" id="recomputeBalanceBtn"/></td>
        </tr>
        <tr>
            <td><input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" /></td>
        </tr>
    </table>
</div>
<br/>
<br/>

<span class="title_label"> Payment Summary for Charges </span>
<div class="grid_wrapper fix">
    <table id="grid_list_charges_payment"></table>
    <g:hiddenField name="chargesPaymentSummary" value="" />
</div>
<br/>
<table class="charges_payment_table">
    <tr>
        <td width="195"> <span class="field_label"> Total Amount of Payment - Charges <br/>(in Settlement Currency)</span> </td>
        <td><g:textField name="totalAmountOfPaymentCharges" value="${totalAmountOfPaymentCharges}" class="input_field_right" readonly="readonly"/></td>
    </tr>
    <tr>
        <td> <span class="field_label"> Excess Amount - Charges <br/>(in Settlement Currency) </span> </td>
        <td><g:textField name="excessAmountCharges" value="${excessAmountCharges}" class="input_field_right" readonly="readonly"/></td>
    </tr>
</table>
<br />

<div id="domMessage" style="display:none;">
    <h1>We are processing your request.  Please be patient.</h1>
</div>

%{--buttons--}%
<g:if test="${!referenceType.equalsIgnoreCase("PAYMENT") && !(documentClass?.equalsIgnoreCase("MD") && referenceType.equalsIgnoreCase("DATA_ENTRY"))}">
    <g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>