<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="paymentDetailsTsdInitiatedTab" />
<g:javascript src="grids/transaction_jqgrid.js" />
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Transaction Type</span></td>
		<td class="input_width"><g:select name="transactionType" class="select_dropdown" from="" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Charge Type</span></td>
		<td><g:select name="chargesType" class="select_dropdown" from="" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Charge Amount</span></td>
		<td><g:textField name="chargesAmount" class="input_field" /><input type="button" name="btnAdd" class="input_button left_indent" value="Add"></td>
	</tr>
</table>
<table>
	<tr>
		<td class="label_width"></td>
		<td colspan="2">
			<div class="grid_wrapper_apply_ap">
				<table id="grid_list_transaction"></table>
			</div>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Total Amount Due</span></td>
		<td><g:textField name="totalAmountDue" class="input_field" /></td>
	</tr>
</table>
<br/>
<span class="title_label">Mode of Payment</span>
<table class="charges_table">
	<tr>
		<td>Amount of Payment - Charges<br/>(in Additional Charges Currency)</td>
		<td><g:textField name="amountOfPaymentCurrency" class="input_field_short" readonly="readonly" value="PHP"/></td>
		<td class="editable"><g:textField name="amountOfPaymentCash" class="input_field_right" /></td>
	</tr>
</table>
<br/>

<span><g:submitToRemote id="popup_btn_mode_of_payment_charges" class="input_button_long" value="Add Settlement Charges"/></span>
<br/>
<span class="title_label">Payment Summary for Additional LC and Charges</span>
<div class="grid_wrapper">
	<table id="grid_list_payment_tsd"></table>
</div>
<table>
	<tr>
		<td><span class="field_label">Total Amount Payment</span></td>
		<td><g:textField name="totalAmountPayment" class="input_field_right" readonly="readonly"/></td>
	</tr>
</table>
