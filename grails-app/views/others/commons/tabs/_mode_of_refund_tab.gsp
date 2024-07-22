

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="modeOfRefundTab" />

<table>
	<tr>
		<td><span class="field_label">Currency for Refund</span></td>
		<td><g:select name="refundCurrency" from="${['PHP','USD','EUR']}" class="select_dropdown" noSelection="['':'Select One']"/></td>
	</tr>
</table>
<br/>
<span class="title_label">Mode of Refund</span>
<table class="charges_table">
	<tr>
		<td>Total Amount for Refund(LC Amount + Charges)</td>
		<td><g:textField name="totalAmountRefundCurrency" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountRefund" class="input_field" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td>Remaining Balance</td>
		<td><g:textField name="remainingBalanceCurrency" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="remainingBalanceAmount" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br>
<table>
	<tr>
		<td width="220px"><span class="field_label">Refund Currency-LC Amount and Charges</span></td>
		<td><g:select name="refundCurrencyLcAmountCharges" from="${['PHP','USD','EUR']}" class="select_dropdown" noSelection="['':'Select One']"/></td>
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
    		<td><input type="button" class="input_button_long" value="Recompute Charge"/></td>
    </tr>
</table>
<br/>
<table class="charges_table">
	<tr>
		<td width="152px">Amount of Refund</td>
		<td><g:textField name="AmountOfRefundCurrency" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="AmountOfRefund" class="input_field" readonly="readonly"/></td>
	</tr>	
</table>
<br/>
<span class="buttons">
	<g:submitToRemote name="addRefundSettlement" class="input_button_long" value="Add Refund Settlement"/>
</span>
<br/>
<span class="title_label">Refund Summary for Charges</span>
<div class="grid_wrapper">
	<table id="grid_list_payment_refund"></table>
</div>
<br />
<table class="charges_table">
	<tr>
		<td><span class="field_label title_label">Total Amount of Charges Due</span></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency1" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue1" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency2" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue2" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td><g:textField name="totalAmountOfChargesDueCurrency3" class="input_field_short" readonly="readonly"/></td>
		<td><g:textField name="totalAmountOfChargesDue3" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>
