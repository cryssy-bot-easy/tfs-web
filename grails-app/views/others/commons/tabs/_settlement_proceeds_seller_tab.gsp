<g:javascript src="grids/settlement_proceeds_seller_tab_jqgrids.js" />

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="subType1" value="${subType1}" />
<g:hiddenField name="subType2" value="${subType2}" />
<g:hiddenField name="form" value="proceeds" />

	<table>
		<tr>
			<td class="label_width"><span class="field_label"> Proceeds Amount </span></td>
			<td><g:textField class="input_field_short center" name="proceedsAmountCurrency" readonly="readonly"/></td>
			<td><g:textField class="input_field numeric_fifteen right" name="proceedsAmount" readonly="readonly"/></td>
		</tr>
		<tr>
			<td class="label_width"> Proceeds Currency <span class="asterisk"> * </span> </td>
			<td colspan="2"> <g:select class="select_dropdown" name="proceedsCurrency" from="${['PHP','USD','EUR']}" noSelection="['':'SELECT ONE']" /> </td>
		</tr>
	</table>
	<div class="grid_wrapper"> <%-- JQGRID --%>
		  <table id="grid_list_settlement_proceeds_seller"> </table>
	</div>
	<g:hiddenField name="SettlementProceedsSellerRates" value="" />
	<table class="popup_full_width">
	    <tr>
	    		<td class="label_width">Pass-on rates confirmed by:</td>
	    		<td> <g:textField name="passOnRateConfirmedBy" class="input_field"/> </td>
	    		<td> <input type="button" class="input_button2" value="Recompute"/> </td>
	    </tr>
	</table>
<br/>

<table class="charges_table">
  	<tr>
		<td width="160"><span class="field_label"> Proceeds Amount (in Proceeds Currency) </span> </td>
		<td>
            <span class="charges_currency" id="proceedsAmountProceedsCurrency"></span>
        </td>
		<td class="editable"><g:textField class="input_field_right" name="proceedsAmount" /></td>
  	</tr>
</table>
<br/>
<input type="button" class="input_button3" id="popup_btn_mode_of_payment_proceeds_seller" value="Add Settlement" />
<br /><br/>
<h3 id="tab_titles">Payment Summary for Settlement to Seller</h3>
<div class="grid_wrapper"> <%-- JQGRID --%>
	<g:if test="${title.contains('e-TS') || title.contains('eTS') }">
		<table id="grid_list_settlement_proceeds_seller_payment_summary_ets"> </table>
	</g:if>
	<g:elseif test="${title.contains('Data Entry')}">	
		<table id="grid_list_settlement_proceeds_seller_payment_summary_dataentry"> </table>
	</g:elseif>
</div>
<g:hiddenField name="SettlementProceedsSellerSummary" value="" />
<br/>
<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />