<g:javascript src="grids/payment_summary_of_other_export_charges_jqgrid.js"/>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="refundDetailsForCharges" />

<table class="tabs_forms_table">
	<tr>
		<td width="160"><span class="field_label">Refund Transaction Type</span></td>
		<td><g:select name="transactionType" class="select_dropdown" from="['EBC Negotiation', 'EBC Settlement']" noSelection="['':'Select One...']" /></td>
		<td><input type="button" id="go" class="popup_btn"/></td>
	</tr>
</table>
<br/>
<br/>
<span class="field_label title_label">Refund Details Summary for Charges</span>
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
<br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>