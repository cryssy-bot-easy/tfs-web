<g:javascript src="grids/cash_lc_payment_jqgrid.js"/>
<g:if test="${serviceType?.equalsIgnoreCase('export advance payment') }">
	<g:javascript src="grids/export_advance_payment_jqgrid.js" />
</g:if>
<g:if test="${serviceType?.equalsIgnoreCase('export advance refund') }">
	<g:javascript src="grids/export_advance_refund_jqgrid.js" />
</g:if>
<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') }">
	<g:javascript src="grids/refund_of_other_export_charges_jqgrid.js" />
</g:if>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="" />
<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') }">
	<table>
		<tr>
			<td width="175"><span class="field_label">Currency for Refund</span></td>
			<td><g:select name="currencyForRefund" class="select_dropdown" from="${[]}" noSelection="['':'Select One...']" /></td>
		</tr>
	</table>
</g:if>
<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges')}">
	<table class="charges_table">
		<tr>
			<td width="160"><span class="field_label"><g:if test="${ serviceType?.equalsIgnoreCase('export advance payment') }">Export Advance Proceeds Amount</g:if> <g:if test="${ serviceType?.equalsIgnoreCase('export advance refund') }"> Export Advance Refund Amount </g:if></span></td>
			<td>
				<span class="charges_currency" id="exportCurrency"></span>
			</td>
			<td><g:textField class="input_field_right" value="" name="exportAmount" readonly="readonly"/></td>
		</tr>
	</table>
</g:if>
<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
	<span class="title_label">Mode of Refund</span>
	<table class="charges_table">
		<tr>
			<td width="160"><span class="field_label">Total Amount for Refund</span></td>
			<td><span class="charges_currency" id="exportCurrency"></span></td>
			<td><g:textField name="totalAmountRefund" class="input_field" readonly="readonly" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Remaining Balance</span></td>
			<td><span class="charges_currency" id="exportCurrency"></span></td>
			<td><g:textField name="remainingBalance" class="input_field" readonly="readonly" /></td>
		</tr>
	</table>
</g:if>
<br/>
<table>
	<tr>
		<td width="165"><span class="field_label"><g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}"> Proceeds Currency </g:if> <g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}"> Export Advance Refund <br/> (in Settlement Currency)</g:if> <g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}"> Refund Currency </g:if> </span></td>
		<td><g:select class="select_dropdown" name="settlementCurrency" from="${['PHP','USD','EUR']}" noSelection="['':'SELECT ONE...']" /></td>
	</tr>
</table>

<div class="grid_wrapper"> <%-- JQGRID --%>
	  <table id="grid_list_cash_forex"> </table>
	  <g:hiddenField name="foreignExchangeRatesLc" value="" />
</div>

<table class="popup_full_width">
	<tr>
		<td width="165">Pass-on rates confirmed by:</td>
		<td><g:textField name="passOnRateConfirmedByLc" class="input_field"/></td>
		<td><input type="button" class="input_button_long cash_recompute" value="Recompute" /></td>
	</tr>
</table>

<br/>

<table class="charges_table">
	<tr>
		<td width="160px"><g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}">Proceeds Amount <br/> (in Proceeds Currency)</g:if><g:if test="${serviceType?.equalsIgnoreCase('export advance refund') }"> Export Advance Refund Amount (in Settlement Currency) </g:if><g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') }">Amount of Refund</g:if></td>
		<td><span class="charges_currency" id="exportCurrency2" ></span></td>
		<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges')}">
			<td><g:textField name="exportAmount2" class="input_field" readonly="readonly" /></td>
		</g:if>
		<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
			<td class="editable"><g:textField name="exportAmount2" class="input_field" /></td>
		</g:if>
	</tr>
</table>

<br />

<input type="button" class="input_button_long" id="popup_btn_mode_of_payment_cash" value="Add Settlement" />

<br /><br/>

<g:if test = "${serviceType?.equalsIgnoreCase('export advance payment') }">
	<span class="title_label">Payment Summary for Proceeds to Seller</span>
	<div class="grid_wrapper"> <%-- JQGRID --%>
		<table id="grid_list_export_advance_payment"> </table>
		<g:hiddenField name="documentPaymentSummary" value="" />
	</div>
</g:if>
<g:if test = "${serviceType?.equalsIgnoreCase('export advance refund') }">
	<span class="title_label">Payment Summary for Export Advance Refund</span>
	<div class="grid_wrapper"> <%-- JQGRID --%>
		<table id="grid_list_export_advance_refund"> </table>
		<g:hiddenField name="documentPaymentSummary" value="" />
	</div>
</g:if>
<g:if test = "${serviceType?.equalsIgnoreCase('refund of other export charges') }">
	<span class="title_label">Refund Summary for Charges</span>
	<div class="grid_wrapper"> <%-- JQGRID --%>
		<table id="grid_list_refund_other_export_charges"> </table>
		<g:hiddenField name="documentPaymentSummary" value="" />
	</div>
	<table class="buttons charges_table">
		<tr>
			<td>Total Amount of Refund</td>
			<td><span class="charges_currency "></span></td>
			<td><g:textField name="currency1" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td/>
			<td><span class="charges_currency "></span></td>
			<td><g:textField name="currency2" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td/>
			<td><span class="charges_currency "></span></td>
			<td><g:textField name="currency3" class="input_field" readonly="readonly"/></td>
		</tr>
	</table>
</g:if>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />