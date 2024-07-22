<%--USED BY ETS IMPORT ADVANCE PAYMENT--%>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="importAdvanceAmountDetailsTabForm" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Currency</span></td>
		<td class="input_width"><g:textField name="importAdvanceCurrency" class="input_field" readonly="readonly" value="PHP"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Amount</span></td>
		<td><g:textField name="importAdvanceAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Settlement Currency - Import Advance Amount</span></td>
		<td class="input_width"><g:select name="settlementCurrency" from="${['PHP','USD','OTH']}" class="select_dropdown iaAmount" noSelection="['PHP':'Select One...']" /></td>
	</tr>
</table>

<div class="grid_wrapper"> <%-- JQGRID --%>
	  <table id="grid_list_cash_forex"> </table>
</div>

<table class="popup_full_width">
    <tr>
    		<td class="label_width">Pass-on rates confirmed by:</td>
    		<td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
    	<%-- if foreign --%>
    		<td><input type="button" class="input_button2" value="Recompute"/></td>
    </tr>
</table>

<br/><br/>

<table class="charges_table">
	<tr>
		<td><span class="field_label"> Amount of Payment - Import Advance Amount <br/>(in Settlement Currency)</span></td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="importAdvancePaymentSettlementCurrency1" value="PHP" readonly="readonly"/></td>
		<td class="editable"><g:textField class="input_field align_right" name="importAdvancePaymentSettlementAmount1" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Amount of Payment - Import Advance Amount <br/>(in Import Advance Currency)</span></td>
		<td><g:textField class="input_field_short iaAmountCurrency" name="importAdvancePaymentAdvanceCurrency1" value="PHP" readonly="readonly"/></td>
		<td class="editable"><g:textField class="input_field align_right" name="importAdvancePaymentAdvanceAmount1"/></td>
	</tr>
</table>

<br/>

<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement Mode"/>

<br/><br/>
<span class="title_label">Payment Summary for Import Advance Payment</span>
<div class="grid_wrapper"> <%-- JQGRID --%>
	  <table id="grid_list_import_advance_payment"> </table>
<%--	  <div id="grid_pager_import_advance_payment"></div>--%>
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