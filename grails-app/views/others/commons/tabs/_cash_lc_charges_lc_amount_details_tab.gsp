
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="refundDetailsLcTabForm" />



<table class="charges_table">
	<tr>
		<td><label><g:radio name="refundOption" value="refundPartialAmount" checked="checked"/>Partial Amount for Refund(in LC Currency)</label></td>
		<td colspan="2"><g:textField class="input_field_short" name="partialRefundCurrency" value="EUR" readonly="readonly"/></td>
		<td class="editable"><g:textField name="partialAmountForRefund" class="input_field"/></td>
		<td class="no-border editable refundPartial"><a href="javascript:void(0)" id="partialAmountPopup" class="popup_btn">Go</a></td>
	</tr>
	<tr>
		<td><label><g:radio name="refundOption" value="refundOsAmount"/>Refund All O/S LC Amount</label></td>
	</tr>
	<tr>
		<td><label><g:radio name="refundOption" value="refundOthers"/>Others</label></td>
		<td colspan="2" class="no-border editable"/>
		<td class="no-border editable"><g:select from="${['Opening','Amendment(July 11,2012)','Amendment(July 30,2012)','Adjust']}" name="otherOption" class="select_dropdown" noSelection="['':'Select One']"/></td>
		<td class="no-border editable refundOthers"><a href="javascript:void(0)" id="otherRefundPopup" class="popup_btn">Go</a></td>
	</tr>
</table>
<br/>
<h3 class="title_label">Refund Details Summary for Cash LC</h3><input type="button" name="clearButton" class="input_button" value="Clear"/>
<br/><br/>
<div class="grid_wrapper">
	<table id="grid_list_refund_details_summary_cash_lc"></table>
	<div id="grid_pager_refund_details_summary_cash_lc"></div>
</div>

<div class="right_indent">
	<table class="charges_table">
		<tr>
			<td><h3 class="title_label">Total LC Amount for Refund</h3></td>
			<td><g:textField class="input_field_short" name="partialRefundCurrency" value="PHP" readonly="readonly"/></td>
			<td><g:textField name="totalLcAmountForRefundPhp" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="partialRefundCurrency" value="USD" readonly="readonly"/></td>
			<td><g:textField name="totalLcAmountForRefundUsd" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField class="input_field_short" name="partialRefundCurrency" value="EUR" readonly="readonly"/></td>
			<td><g:textField name="totalLcAmountForRefundEur" class="input_field" readonly="readonly"/></td>
		</tr>
	</table>
</div>

<g:render template="../others/commons/popups/partial_amount_refund_popup"/>