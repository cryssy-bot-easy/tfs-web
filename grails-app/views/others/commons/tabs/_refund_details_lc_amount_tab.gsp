<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="refundDetailsLcAmountTab" />

<table class="charges_table">
	<tr>
		<td><label><g:radio name="refundOption" value="refundPartialAmount"/>Partial Amount for Refund(in LC Currency)</label></td>
		<td colspan="2"><g:textField class="input_field_short" name="partialRefundCurrency" value="" readonly="readonly"/></td>
		<td class="editable"><g:textField name="partialAmountForRefund" class="input_field"/></td>
		<td class="no-border editable refundPartial"><input type="button" id="partialAmountPopup" class="popup_btn"/></td>
	</tr>
	<tr>
		<td><label><g:radio name="refundOption" value="refundOsAmount"/>Refund All O/S LC Amount</label></td>
	</tr>
	<tr>
		<td><label><g:radio name="refundOption" value="refundOthers"/>Others</label></td>
		<td colspan="2" class="no-border editable"/>
		<td class="no-border editable"><g:select from="${['Opening','Amendment(July 11,2012)','Amendment(July 30,2012)','Adjust']}" name="otherOption" class="select_dropdown" noSelection="['':'Select One']"/></td>
		<td class="no-border editable refundOthers"><input type="button" id="otherRefundPopup" class="popup_btn"/></td>
	</tr>
</table>
<br/>
<span class="buttons">
<input type="button" name="clearButton" class="input_button" value="Clear"/>
</span>
<span class="title_label">Refund Details Summary for Cash LC</span>
<br/>
<br/>
<div class="grid_wrapper">
	<table id="grid_list_refund_details_summary_cash_lc"></table>
	<div id="grid_pager_refund_details_summary_cash_lc"></div>
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

