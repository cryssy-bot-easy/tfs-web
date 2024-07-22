<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="lcPayment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="reverseDE" value="${reverseDE}"/>
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="chargeType" value="SETTLEMENT" />

<g:javascript src="grids/ap_refund_jqgrid.js" />
<script type="text/javascript">
	var paymentStatusUrl = '${g.createLink(controller:'otherCharges', action:'getPaymentStatus')}';
    var refundChargesUrl = '${g.createLink(controller:'chargesPayment', action:'findProceedsPayments')}';
    refundChargesUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    refundChargesUrl += "&referenceType=" + $("#referenceType").val();

    refundChargesUrl += "&serviceType="+$("#serviceType").val();
    refundChargesUrl += "&form="+"basicDetails";
</script>

<g:hiddenField name="bookingDate" value="${bookingDate}" />
<g:hiddenField name="excessAmount" value="${excessAmount}" />

<table class="charges_table">
	<g:if test="${serviceType?.equalsIgnoreCase('Application') && documentType?.equalsIgnoreCase('Refund')}">
		<tr>
			<td><span class="field_label"> Amount of MD to Refund</span></td>
			<td><g:textField class="input_field_short input_three" readonly="readonly" name="currency" value="${mdCurrency}" /></td>
			<td><g:textField class="input_field_right numericCurrency" name="amountOfMdToRefund" value="${amountOfMdToRefund ?: amountOfMdToApply}" readonly='readonly'/></td>
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td><span class="field_label"> Amount of Refund<span class="asterisk">* </span></span></td>
			<td><g:textField class="input_field_short input_three" readonly="readonly" name="currency" value="${mdCurrency}" /></td>
			<td class="editable"><g:textField class="input_field_right numericCurrency" name="amountOfRefund" value="${amountOfRefund ?: amountOfMdToApply}" /></td>
		</tr>
	</g:if>
	<g:else>
		<tr>
			<td><span class="field_label"> Nature of Transaction </span></td>
			<td colspan="2"><g:textField class="input_field" readonly="readonly" name="natureOfTransaction" value="${natureOfTransaction}" /></td>
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td><span class="field_label"> AP Currency / Amount </span></td>
			<td><g:textField class="input_field_short input_three" readonly="readonly" name="apCurrency" value="${apCurrency ?: currency}" />
				<g:hiddenField name="settlementCurrencyLc" value="${settlementCurrencyLc ?: currency}"/></td>
			<td><g:textField class="input_field_right numeric_fifteen numericCurrency" readonly="readonly" name="amountDue" value="${amountDue ?: outstandingAmount ?: apOutstandingBalance}"/>
				<g:hiddenField name="amountBalance" value="${amountBalance}"/></td>
			
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td><span class="field_label"> Amount of Refund <br />(in Refund Currency)<span class="asterisk">* </span></span></td>
			<td><g:textField class="input_field_short input_three" readonly="readonly" name="currency" value="${currency}" /></td>
			<td class="editable"><g:textField class="input_field_right numericCurrency" name="apAmount" value="${amountDue ?: outstandingAmount ?: apOutstandingBalance}" /></td>
		</tr>
	</g:else>
</table>

<br/>

<g:if test="${serviceType?.equalsIgnoreCase('Application') && documentType?.equalsIgnoreCase('Refund')}">
	<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Mode of Refund" />
</g:if>
<g:else>
	<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="${serviceType?.equalsIgnoreCase('Refund') ? 'Add AP Refund' : 'Add AP Settlement'}" />
</g:else>

<br/>

<table class="charges_table">	

</table><br />

<g:if test="${serviceType?.equalsIgnoreCase('Application') && documentType?.equalsIgnoreCase('Refund')}">
	<span class="title_label"> Payment Summary for MD Refund </span>
</g:if>
<g:else>
	<span class="title_label"> Payment Summary for AP Refund </span>
</g:else>
<div class="grid_wrapper">
    <g:if test="${referenceType.equalsIgnoreCase("ETS")}">
	    <table id="grid_list_refund_branch"></table>
    </g:if>

    <g:if test="${referenceType.equalsIgnoreCase("DATA_ENTRY")}">
        <table id="grid_list_refund_main"></table>
    </g:if>

    <g:hiddenField name="proceedsPaymentSummary" value="" />
</div>
<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label"> Total Amount of Refund</span></td>
        <td class="input_width"><g:textField class="input_field_right numericCurrency" readonly="readonly" name="totalAmountOfRefund" value="${totalAmountOfPayment ?: 0.00}"/></td>
    </tr>
</table>
<br />
<g:if test="${!session['group']?.equalsIgnoreCase('TSD')}">
<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:if>
<script>
	function validateBasicDetailsTab(buttonParentId){
		if (serviceType != "Application" && documentType != "REFUND" && serviceType != 'REFUND'){
			if(buttonParentId == 'cashLcPaymentTabForm'){
				if(parseFloat($("#amountDue").val().replace(/,/g, "")) > parseFloat($("#totalAmountOfRefund").val().replace(/,/g, ""))){
					triggerAlertMessage("Total Amount of Payment must be equal or greater than AP Amount.");
					_pageHasErrors = true;
				} else {
					_pageHasErrors = false;
				}
			}
		}
	}
</script>