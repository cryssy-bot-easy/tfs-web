<%--USED BY ETS IMPORT ADVANCE PAYMENT--%>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="importAdvanceAmountDetailsTabForm" />

<table class="charges_table">
	<tr>
		<td width="160"><span class="field_label"> Total Amount Due </span></td>
		<td>
			<g:textField class="input_field_short iaChargesCurrency" name="totalAmtDueCurrency" value="PHP" readonly="readonly"/>
        </td>
		<td><g:textField class="input_field_right" value="" name="totalAmountDue" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> &#160; </td>
	</tr>
	<tr>
		<td><span class="field_label"> Remaining Balance </span></td>
		<td>
			<g:textField class="input_field_short iaChargesCurrency" name="remainingBalanceCurrency" value="PHP" readonly="readonly"/>
       </td>
		<td><g:textField class="input_field_right" value="" name="remainingBalance" readonly="readonly"/></td>
	</tr>
	<tr>
		<td> &#160; </td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of Payment - Charges <br/> (in Settlement Currency)</span></td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="importAdvanceAmountSettlementCurrency" value="PHP" readonly="readonly"/></td>
		<td class="editable"><g:textField class="input_field align_right" name="importAdvanceAmountSettlementCash" /></td>
	</tr>
</table>
<br/>

<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement Charges" />

<br/><br/>
<table class="full_width">
</table>
<span class="title_label">Payment Summary for Charges</span>
<div class="grid_wrapper">
	<table id="grid_list_charges_payment"></table>
	<div id="grid_pager_charges_payment"></div>
</div>
<table>
	<tr>
		<td><span class="field_label"> Total Amount of Payment - Import Advance Amount(in Import Advance Currency) </span></td>
		<td><g:textField class="input_field readonly align_right" value="0.00" name="totalPaymentChargesCashDMLC" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Excess Amount - Import Advance Amount (in Import Advance Currency) </span></td>
		<td><g:textField class="input_field readonly align_right" value="0.00" name="excessAmountCashDMLC" readonly="readonly"/></td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />