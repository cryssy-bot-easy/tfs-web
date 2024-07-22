<div id="update_new_rate_cash_popup" class="popup_div_update_charges">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_update_new_rate_cash_popup_x" class="popup_close">x</a>
		
		<%-- for partial amount refund --%>
		<h2 id="popup_header_partialAmountRefund1" class="popup_title otherRefundTitle">Update Cash LC</h2>
	</div>
	<br />
	
    <%-- for other refunds --%>
	<span class="title_label otherRefundTitle">Total O/S Cash LC Amount in LC Currency</span>
	<br/>
	<table class="charges_table other_refund_table">
		<tr>
			<td></td>
			<td><g:textField name="outstandingLcCurrency" class="input_field_short otherRefundInput" readonly="readonly"/></td>
			<td><g:textField name="outstandingLcAmount" class="input_field_right otherRefundInput" readonly="readonly"/></td>
		</tr>
	</table>
	<br/>
	<span class="title_label otherRefundTitle">Cash LC Amount in Settlement Currencies</span>
	<br/>
	<table class="charges_table other_refund_table" id="paymentsMade">
	</table>
	<br/>
	<div class="grid_wrapper_full other_refund_table"> <%-- JQGRID --%>
		<table class="grid_list_transaction_type"> </table>
	</div>

    <div class="grid_wrapper">
        <table class="foreign_exchange" id="forex_update_new_rate_product_amount_popup">
        </table>
    </div>

    <br />
    <input type="button" id="recomputeNewRateProductPayment" class="input_button_long" value="Recompute" />
    <br /><br />
    <ul class="popup_buttons_center">
        <li>
            <input type="button" class="input_button_alert confirmYes" value="Yes" id="applyNewRateProductAmountRefund"/>
            <input type="button" class="input_button_negative_alert confirmNo" value="No" id="cancel_newRateProductAmount"/>
        </li>
    </ul>
</div>
<div id="update_new_rate_cash_popup_bg" class="popup_bg"> </div>