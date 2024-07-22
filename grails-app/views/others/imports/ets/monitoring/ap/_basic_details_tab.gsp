<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />



<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> e-TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="etsNumber" /></td>
		<td class="label_width"><span class="field_label"> Document Number/ </span><br /><span class="field_label"> Reference Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> e-TS Date </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="etsDate" /></td>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="processingUnitCode"	/></td>
	</tr>
</table><br />
<span class="bold">Payment Details</span>

<table class="charges_table">
	<tr>
		<td><span class="field_label"> Nature of Transaction </span></td>
		<td colspan="2"><g:textField class="input_field" readonly="readonly" name="natureOfTransaction" /></td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td><span class="field_label"> AP Currency / Amount </span></td>
		<td><g:textField class="input_field_short input_three" readonly="readonly" name="apCurrency" value="PHP" /></td>
		<td><g:textField class="input_field_right numeric_fifteen" readonly="readonly" name="apAmount" value="1,000.00"/></td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td><span class="field_label"> Amount of Refund<span class="asterisk">* </span></span></td>
		<td><g:textField class="input_field_short input_three" readonly="readonly" name="refundCurrency" value="PHP" /></td>
		<td class="editable"><g:textField class="input_field_right" name="amountOfRefund" /></td>
	</tr>
<%--	<tr><td><br/></td></tr>--%>
<%--	<tr>--%>
<%--		<td><span class="field_label"> Mode/s of Refund<span class="asterisk">* </span></span></td>--%>
<%--		<td class="no-border editable" colspan="2"><g:select name="modeOfRefund" noSelection="['':'Select One...']" from="${['Credit CASA', 'MC']}" class="select_dropdown modeOfRefund" onChange="modeChange()"/></td>--%>
<%--	</tr>--%>
<%--	<tr class="casa">--%>
<%--		<td><span class="field_label">If Credit CASA,<br/>Account Number</span></td>--%>
<%--		<td colspan="2" class="no-border editable"><g:select name="accountNumber" from="${[]}" noSelection="['':'Select One...']" class="select_dropdown" /></td>--%>
<%--	</tr>--%>
<%--	<tr class="casa">--%>
<%--		<td><span class="field_label">Account Name</span></td>--%>
<%--		<td colspan="2"><g:textField name="accountName" readonly="readonly"  class="input_field textFormat-20" value="SAN FERNANDO TRANSPO"/></td>--%>
<%--	</tr>--%>
<%--	<tr class="casa">--%>
<%--		<td><span class="field_label">Account Balance</span></td>--%>
<%--		<td colspan="2"><g:textField name="accountBalance"  readonly="readonly" class="input_field numberFormat-15-2 right" value="1,000,000.00" /></td>--%>
<%--	</tr>--%>
</table>
<br/>
<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add AP Settlement"/>
<br/>
<table class="charges_table">	

</table><br />
<span class="bold">Running Balance of Amount of Refund</span>
<div class="grid_wrapper">
	<table id="grid_list_refund"></table>
<%--	<div id="grid_pager_refund"></div>--%>
</div>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> Total Amount of Refund </span></td>
		<td class="input_width"><g:textField class="input_field numeric_fifteen right" readonly="readonly" name="totalAmountOfRefund" value="200.00"/></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />