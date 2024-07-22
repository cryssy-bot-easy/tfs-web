<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="chargesTabForm" />

<g:render template="../commons/popups/bank_commission_popup" />
<g:render template="../commons/popups/cilex_popup" />
<g:render template="../commons/popups/documentary_stamp_popup" />
<g:render template="../commons/popups/cable_fee_popup" />
<g:javascript src="popups/bank_commission_utility.js" />
<g:javascript src="popups/cable_fee_utility.js" />
<g:javascript src="popups/cilex_fee_utility.js" />
<g:javascript src="popups/documentary_stamp_utility.js" />

<table>
	<tr>
		<td class="label_width"><span class="field_label">Settlement Currency - Charges</span></td>
		<td class="input_width"><g:select name="settlementCurrency" from="${['PHP','USD','OTH']}" class="select_dropdown iaCharges" noSelection="['PHP':'Select One...']"/></td>
	</tr>
</table>
	<br/>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<table id="grid_list_forex"> </table>
</div>
<table class="popup_full_width">
    <tr>
   		<td class="label_width">Pass-on rates confirmed by:</td>
   		<td><g:textField name="passOnRateConfirmedBy" class="input_field"/></td>
   		<%-- if foreign --%>
   		<td><input type="button" class="input_button2" value="Recompute"/></td>
    </tr>
</table>
<br/>
<span class="title_label">Charges</span>
<table class="charges_table">
	<tr>
		<td>Bank Commission</td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="bankCommissionCurrency" value="PHP" readonly="readonly"/></td>
		<td><g:textField class="input_field no_border numeric_fifteen right" name="bankCommissionCash" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_bank_commission">edit</a></td>
	</tr>
	<tr>
		<td>CILEX</td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="cilexCurrency" value="PHP" readonly="readonly"/></td>
		<td><g:textField class="input_field no_border numeric_fifteen right" name="cilexCash" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_cilex_fee">edit</a></td>
	</tr>
	<tr>
		<td>Documentary Stamp</td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="documentaryStampCurrency" value="PHP" readonly="readonly"/></td>
		<td><g:textField class="input_field no_border input_twenty" name="documentaryStampCash" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_documentary_stamp">edit</a></td>
	</tr>
	<tr>
		<td>Cable Fee</td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="cableFeeCurrency" value="PHP" readonly="readonly"/></td>
		<td><g:textField class="input_field no_border numeric_fifteen right" name="cableFeeCash" readonly="readonly"/></td>
		<td class="link"><a href="javascript:void(0)" id="edit_cable_fee">edit</a></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td>Total Amount Charges Due <br/>(in Settlement Currency)</td>
		<td><g:textField class="input_field_short iaChargesCurrency" name="totalAmountChargesDueCurrency" value="PHP" readonly="readonly"/></td>
		<td><g:textField class="input_field no_border numeric_fifteen right" name="totalAmountChargesDueCash" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper"/>