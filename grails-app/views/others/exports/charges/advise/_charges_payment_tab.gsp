<g:hiddenField name="form" value="chargesTabForm" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> Settlement Currency - Charges</td>
<%--		<td><g:select class="select_dropdown" name="settlementCurrency" from="${['PHP','USD','EUR']}" noSelection="['':'SELECT ONE']" /></td>--%>
		<td><g:textField class="input_field" name="settlementCurrency" value="PHP" readonly="readonly"/> </td>
	</tr>
</table>
<br/>
<table class="charges_table">
	<tr >
		<td width="150"> <span class="field_label">Export FXLC - Advising Fee</span> </td>
		<td> <span class="charges_currency" id="advisingFeeCurrency"> </span> </td>
		<td> <g:textField class="input_field_right" name="advisingFee" readonly="readonly"/> </td>
	</tr>
	<tr >
		<td> <span class="field_label">Cable Fee</span> </td>
		<td> <span class="charges_currency" id="cableFeeCurency"> </span> </td>
		<td class="editable"> <g:textField class="input_field_right" name="cableFee" /> </td>
	</tr>
	<tr class="commitment_fee">
		<td> <span class="field_label">Other Bank Charges</span> </td>
		<td> <span class="charges_currency" id="otherBankChargesCurrency"> </span> </td>
		<td> <g:textField class="input_field_right2" name="otherBankCharges" readonly="readonly"/> </td>
	</tr>
</table>	
<br/>
<table class="charges_table">
	<tr>
		<td width="150"> <span class="field_label">Total Amount Charges Due <br/> (in Settlement Currency)</span> </td>
		<td> <span class="charges_currency" id="totalAmountChargesCurrency"> </span> </td>
		<td> <g:textField class="input_field_right" name="totalAmountCharges" readonly="readonly"/> </td>
	</tr>
</table>
<br/>
<table class="charges_table">
  	<tr>
		<td width="150"><span class="field_label"> Amount of Payment - Charges <br/>(in Settlement Currency) </span> </td>
		<td>
            <span class="charges_currency" id="amountOfPaymentChargesSettlementCurrency"></span>
        </td>
		<td class="editable"><g:textField class="input_field_right" name="amountOfPaymentCharges" /></td>
  	</tr>
</table>

<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Charges" />
<br /><br/>

<span class="title_label"> Payment Summary for Charges </span>
<div class="grid_wrapper fix">
	<table class="grid_list_payment_edit"></table>
    <g:hiddenField name="chargesPaymentSummary" value="" />
</div>
<br/>
<table class="charges_payment_table">
	<tr>
		<td width="170"> <span class="field_label"> Total Amount of Payment - Charges <br/>(in Settlement Currency)</span> </td>
		<td><g:textField name="totalAmountOfPaymentCharges" value="" class="input_field_right" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> <span class="field_label"> Excess Amount - Charges <br/>(in Settlement Currency) </span> </td>
		<td><g:textField name="excessAmountCharges" value="" class="input_field_right" readonly="readonly"/></td>
	</tr>
</table>
<br />

<g:render template="../layouts/buttons_for_grid_wrapper" />
