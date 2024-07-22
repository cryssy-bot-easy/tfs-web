<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="importType" value="${importType}" />
<g:hiddenField name="form" value="modeOfRefundTabForm" />



<span class="field_label">Currency for Refund</span>
<g:select from="${['PHP','USD']}" noSelection="['':'Select One']" name="refundCurrency" class="select_dropdown"/>
<br/>
<br/>
<h3 class="title_label">Mode of Refund</h3>
<br/>
<table class="charges_table">
	<tr>
		<td><span class="field_label">Total Amount for Refund(LC Amount + Charges)</span></td>
		<td><g:textField name="totalRefundCurrency" value="PHP" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField class="input_field" name="totalRefundAmount" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Remaining Balance</span></td>
		<td><g:textField name="remainingBalanceCurrency" value="PHP" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField class="input_field" name="remainingBalance" readonly="readonly"/></td>
	</tr>
</table>	

<br/>
<br/>
<span class="field_label">Refund Currency-LC Amount and Charges</span>
<g:select from="${['PHP','USD']}" noSelection="['':'Select One']" name="refundCurrencyLcAndCharges" class="select_dropdown"/>
<br/>
<div class="grid_wrapper">
	<table id="grid_list_cash_forex"></table>
</div>
<br/>
<g:submitToRemote name="recomputeButtonModeOfRefund" value="Recompute" class="input_button_long"/>
<br/>
<br/>
<table class="charges_table">
	<tr>
		<td><span class="field_label">Amount of Refund</span></td>
		<td><g:textField name="refundAmountCurrency" class="input_field_short" value="PHP" readonly="readonly"/></td>
		<td class="editable"><g:textField name="refundAmount" class="input_field"/></td>
	</tr>
</table>
<br/>
<br/>
<g:submitToRemote id="popup_btn_mode_of_payment_charges" value="Add Refund Settlement" class="input_button_long"/>
<br/>
<br/>
<br/>
<br/>
<h3 class="title_label">Refund Summary for Charges</h3>
<div class="grid_wrapper">
	<table id="grid_list_refund_summary_charges"></table>
</div>
<div class="right_indent">
	<table class="charges_table">
		<tr>
			<td><h3 class="title_label">Total Amount of Refund</h3></td>
			<td><g:textField class="input_field_short" name="refundCurrencyPhp" value="PHP" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfRefundPhp" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="refundCurrencyUsd" value="USD" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfRefundUsd" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="refundCurrencyEur" value="EUR" readonly="readonly"/></td>
			<td><g:textField name="totalAmountOfRefundEur" class="input_field" readonly="readonly"/></td>
		</tr>
	</table>
</div>
<br/><br/>