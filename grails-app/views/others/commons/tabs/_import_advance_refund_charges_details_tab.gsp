<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="chargesDetailsTab" />


<table class="charges_table">
	<tr>
		<td><span class="field_label">Amount of Payment - Charges</span></td>
		<td><g:textField class="input_field_short" name="amountOfPaymentCurrency" readonly="readonly"/></td>
		<td class="editable"> <g:textField name="amountOfPayment" class="input_field"/></td>
	</tr>	
</table>

<br /><br/>

<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges"/>

<br /><br/>

<span class="title_label">Payment Summary for Charges</span>
<div class="grid_wrapper"> 
	  <table id="grid_list_charges_payment"> </table>
</div>
<table>
	<tr>
		<td><span class="field_label ">Total Amount of Payment - Charges </span></td>
		<td><g:textField class="input_field right" value="0.00" name="totalAmountOfPaymentCharges" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Excess Amount - Charges</span></td>
		<td><g:textField class="input_field right" value="0.00" name="excessAmountCharges" readonly="readonly"/></td>
	</tr>
</table>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />