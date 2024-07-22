<g:javascript src="grids/payment_summary_of_other_export_charges_jqgrid.js"/>
<g:javascript src="grids/charges_payment_summary_jqgrid.js"/>
<%--<g:javascript src="popups/other_export_charges_payment_popup.js"/>--%>
<%--<g:render template="../others/commons/popups/other_export_charges_payment_popup" />--%>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="paymentDetailsTabForm" />

<span class="field_label">Payment Transaction Type</span>
<g:select name="paymentTransactionType" class="select_dropdown" from="['Advise on Opening', 
'Advise on Amendment', 'Advise on Cancellation', 'Export Bills for Collection - Settlement', 
'Export Bills for Purchase - Negotiation', 'Export Bills for Purchase - Settlement', 
'Domestic Bills for Collection - Settlement', 'Domestic Bills for Purchase - Negotiation', 
'Domestic Bills for Purchase - Settlement', 'Export Advance - Payment', 'Export Advance - Refund']" 
 noSelection="['':'Select One...']" />
<input type="button" id="go" class="popup_btn"/>
<br/>
<br/>
<span class="field_label title_label">Payment Summary of Other Charges Due</span>
<br/>
<div class="grid_wrapper">
	<table id="grid_list_payment_details_for_charges"></table>
	<div id="grid_pager_payment_details_for_charges"></div>
</div>
<br/>
<div class="right_indent">
	<table class="charges_table">
		<tr>
			<td><span class="field_label p_header">Total Amount of Charges Due</span></td>
			<td><g:textField name="totalAmountOfChargesDueCurrency1" class="input_field_short" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfChargesDue1" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td />
			<td><g:textField name="totalAmountOfChargesDueCurrency2" class="input_field_short" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfChargesDue2" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td />
			<td><g:textField name="totalAmountOfChargesDueCurrency3" class="input_field_short" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfChargesDue3" class="input_field" readonly="readonly"/></td>
		</tr>
	</table>
</div>
<br />
<table class=" clear-float">
	<tr>
		<td class="label_width"><span class="field_label">Additional Charges Currency</span></td>
		<td><g:select name="additionalChargesCurrency" class="select_dropdown"	from="${['PHP', 'USD', 'WON', 'YEN']}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label p_header"><br/>Mode of Payment</span><br/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of Payment-Charges <br/> (in Additional Charges Currency)</span></td>
		<td><g:textField name="amountOfPaymentChargesInAdditionalChargesCurrency" class="input_field"/></td>
	</tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<tr><td><g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges"/></td></tr>
</table>
<br /><br />
<span class="field_label p_header">Payment Summary for Additional LC and Charges</span>
<div class="grid_wrapper">
	<table id="grid_list_charges_payment"></table>
</div>
<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Total Amount of Payment - Charges (in Settlement Currency)</span></td>
		<td><g:textField name="totalAmountOfPaymentChargesInSettlementCurrrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Excess Amount - Charges (in Settlement Currency)</span></td>
		<td><g:textField name="excessAmountChargesInSettlementCurrrency" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>