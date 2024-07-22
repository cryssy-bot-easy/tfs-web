<g:javascript src="grids/proceeds_summary.js" />

<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="proceedsToTeller" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<script>
	<%-- used by proceeds teller tab --%>
	var proceedsChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
</script>

<table class="charges_table">
	<tr>
		<td width="160"><span class="field_label"> DM Non-LC Proceeds Settlement Currency and Amount </span></td>
		<td><g:textField class="input_field_short trans_currency center" name="proceedsCurrency" value="PHP" readonly="readonly"/></td>
		<td class="editable"><g:textField class="input_field numeric_fifteen right" name="proceedsAmount"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
	</tr>
	<tr>
	<g:if test="${referenceType.equalsIgnoreCase('ETS')}">
		<td width="160"><span class="field_label">Amount of Payment - Charges (in Settlement Currency)</span></td>
	</g:if>
	<g:elseif test="${referenceType.equalsIgnoreCase('PAYMENT')}">
		<td width="160"><span class="field_label">Amount of Payment - Charges (in PHP)</span></td>
	</g:elseif>
		<td><g:textField value="PHP" name="amountOfPaymentCurrencyProceedBeneficiary" class="input_field_short" readonly="readonly" /></td>
		<td class="editable"><g:textField name="amountOfPaymentProceedBeneficiary" class="input_field right" /></td>
	</tr>
</table>
<br/>
<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_proceeds" value="Add Settlement Mode" />
<br /><br/>
<h3 id="tab_titles">Proceeds Summary for Charges</h3>
<div class="grid_wrapper fix"> <%-- JQGRID --%>
	  <table id="grid_list_proceeds_payment_summary"> </table>
	  <div id="grid_pager_proceeds_payment_summary"></div>
</div>
<br/>
<table class="tabs_forms_table">
	<tr>
		<td width="160"><span class="field_label"> Amount of Payment - DM Non-LC Proceeds </span> </td>
		<td><g:textField name="amountOfPaymentProceeds" value="1,000.00" class="input_field right" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Total Amount of Payment - DM Non-LC Proceeds </span> </td>
		<td><g:textField name="totalProceedsPayment" value="1,000.00" class="input_field right" readonly="readonly"/></td>
	</tr>
</table>
<br/>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />