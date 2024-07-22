<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="chargesTabForm" />


<g:render template="../commons/popups/bank_commission_popup" />
<g:render template="../commons/popups/documentary_stamp_popup" />
<g:render template="../commons/popups/cable_fee_popup" />
<g:render template="../commons/popups/cilex_popup" />
<g:javascript src="popups/bank_commission_utility.js" />
<g:javascript src="popups/documentary_stamp_utility.js" />
<g:javascript src="popups/cable_fee_utility.js" />
<g:javascript src="popups/cilex_fee_utility.js" />

<table>
	<tr>
		<td class="label_width"><span class="field_label"> Settlement Currency - Charges</span></td>
		<td><g:textField name="settlementCurrencyCharges" class="input_field" readonly="readonly" value="PHP"/></td>
<%--		<td><g:select class="select_dropdown" name="settlementCurrencyCharges" from="${['PHP','USD','EUR']}" noSelection="['':'SELECT ONE...']" disabled="true"/></td>--%>
	</tr>
</table>
<div class="grid_wrapper"> <%-- JQGRID --%>
	  <table id="grid_list_forex"> </table>
</div>
<table class="popup_full_width">
    <tr>
    		<td class="label_width">Pass-on rates confirmed by:</td>
    		<td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
    </tr>
</table>

<br />

<span class="title_label">Charges</span>
<br />
<table class="charges_table">
	<tr>
		<td><span class="field_label">Bank Commission</span></td>
		<td><span class="charges_currency"></span></td>
		<td><g:textField class="input_field right_indent numberFormat-15-2" name="bankCommission" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_bank_commission">edit</a></td>
	</tr>
	<tr>
		<td><span class="field_label">Cable Fee</span></td>
		<td><span class="charges_currency"></span></td>
		<td><g:textField class="input_field right_indent numberFormat-15-2" name="cableFee" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_cable_fee">edit</a></td>
	</tr>
	<tr>
		<td><span class="field_label">CILEX</span></td>
		<td><span class="charges_currency"></span></td>
		<td><g:textField class="input_field right_indent numberFormat-15-2" name="cilex" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_cilex_fee">edit</a></td>
	</tr>
	<tr>
		<td><span class="field_label">Documentary Stamp</span></td>
		<td><span class="charges_currency"></span></td>
		<td><g:textField class="input_field right_indent numberFormat-15-2" name="documentaryStamp" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_documentary_stamp">edit</a></td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td><span class="field_label">Total Amount Charges Due <br/>(in Settlement Currency)</span></td>
		<td><g:textField class="input_field_short textFormat-3" name="totalAmountChargesDueInSettlementCurrency" value="USD" readonly="readonly"/></td>
		<td><g:textField class="input_field right_indent numberFormat-15-2" name="totalAmountCharges" readonly="readonly"  /></td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />