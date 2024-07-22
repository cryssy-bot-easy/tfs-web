<div id="popup_partialAmountRefund" class="popup_div">
    <div class="popup_header">
	<a href="javascript:void(0)" id="close_partialAmountRefund1" class="popup_close">x</a>
		<%-- for partial amount refund --%>
		<h2 id="popup_header_partialAmountRefund1" class="popup_title partialAmountRefundTitle">Foreign Exchange Rate</h2>
		
		<%-- for partial amount refund --%>
		<h2 id="popup_header_partialAmountRefund1" class="popup_title otherRefundTitle">Update Cash LC</h2>
	</div>
	<br />
	
	<%-- for partial amount refund --%>
	<table class="charges_table partial_amount_table">
		<tr>
			<td><span class="field_label">Amount for Refund(in LC Currency)</span></td>
			<td><g:textField name="amountRefundLcCurrency" class="input_field_short partialRefundInput" readonly="readonly"/></td>
			<td><g:textField name="amountRefundLcCash" class="input_field_right partialRefundInput" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Amount for Refund (in Settlement Currency)</span></td>
			<td><g:textField name="amountRefundSettlementCurrency" class="input_field_short partialRefundInput" readonly="readonly"/></td>
			<td><g:textField name="amountRefundSettlementCash" class="input_field_right partialRefundInput" readonly="readonly"/></td>
		</tr>
	</table>
	<div class="grid_wrapper partial_amount_table"> <%-- JQGRID --%>
		<table id="grid_list_forex"> </table>
	</div>
	<%-- for other refunds --%>
	<span class="title_label otherRefundTitle">Total O/S Cash LC Amount in LC Currency</span>
	<br/>
	<table class="charges_table other_refund_table">
		<tr>
			<td></td>
			<td><g:textField name="totalOsAmountLcCurrency" class="input_field_short otherRefundInput" readonly="readonly"/></td>
			<td><g:textField name="totalOsamountLcCash" class="input_field_right otherRefundInput" readonly="readonly"/></td>
		</tr>
	</table>
	<br/>
	<span class="title_label otherRefundTitle">Cash LC Amount in Settlement Currencies</span>
	<br/>
	<table class="charges_table other_refund_table">
		<tr>
			<td></td>
			<td><g:textField name="cashLcAmountSettlementCurrency1" class="input_field_short otherRefundInput" readonly="readonly"/></td>
			<td><g:textField name="cashLcAmountSettlement1" class="input_field_right otherRefundInput" readonly="readonly"/></td>
			<td class="editable"><g:textField name="cashLcAmountSettlementEnabled1" class="input_field_right otherRefundInput"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField name="cashLcAmountSettlementCurrency2" class="input_field_short otherRefundInput" readonly="readonly"/></td>
			<td><g:textField name="cashLcAmountSettlement2" class="input_field_right otherRefundInput" readonly="readonly"/></td>
			<td class="editable"><g:textField name="cashLcAmountSettlementEnabled2" class="input_field_right otherRefundInput"/></td>
		</tr>
		<tr>
			<td></td>
			<td><g:textField name="cashLcAmountSettlementCurrency3" class="input_field_short otherRefundInput" readonly="readonly"/></td>
			<td><g:textField name="cashLcAmountSettlement3" class="input_field_right otherRefundInput" readonly="readonly"/></td>
			<td class="editable"><g:textField name="cashLcAmountSettlementEnabled3" class="input_field_right otherRefundInput"/></td>
		</tr>
	</table>
	<br/>
	<div class="grid_wrapper_full other_refund_table"> <%-- JQGRID --%>
		<table class="grid_list_transaction_type"> </table>
	</div>
	<table class="popup_full_width">
	    <tr>
	    	<%-- if foreign --%>
	    		<td><input type="button" class="input_button_long" value="Recompute"/></td>
	    </tr>
	</table>
	
	<br /><br />
	<input type="button" class="input_button_negative" id="close_partialAmountRefund2" value="Cancel" />
	<input type="button" class="input_button" id="confirm_partial_amount_refund" value="OK" />
</div>
<div id="popup_bg_partialAmountRefund" class="popup_bg"> </div>