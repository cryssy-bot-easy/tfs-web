<%--USED BY ETS IMPORT ADVANCE REFUND--%>


<%--<g:javascript src="popups/mode_of_payment_to_importer_popup.js" />--%>
<script type="text/javascript">
<%--Used by cash_lc_payment_jqgrid.js--%>
    var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
    productChargeUrl += "&referenceType=" + $("#referenceType").val();
</script>
<g:javascript src="grids/cash_lc_payment_jqgrid.js" />
<g:javascript src="grids/import_advance_refund_jqgrid.js" />
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%


<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="importAdvanceRefundPaymentDetails" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Currency</span></td>
		<td>
			<%-- <g:select name="importAdvanceRefundCurrency" class="select_dropdown" from="${['PHP']}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_currency select2_dropdown bigdrop" name="importAdvanceRefundCurrency" id="importAdvanceRefundCurrency" />	 
		</td>
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
<br/>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Amount</span></td>
		<td class="input_width"><g:textField name="importAdvanceRefundAmount" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br />
<g:submitToRemote class="input_button_long" id="popup_btn_mode_of_payment_charges" value="Add Settlement"/>
<br /><br/>
<span class="title_label">Payment Summary for Import Advanced Payment</span>
<div class="grid_wrapper">
	<table id="grid_list_import_advance_refund"></table>
</div>
<%--<g:render template="../popups/mode_of_payment/mode_of_payment_to_importer_popup"/>--%>

<script>
    $(document).ready(function() {
        %{--$("#importAdvanceRefundCurrency").select2('data',{id: '${importAdvanceRefundCurrency}'});--}%
        $("#importAdvanceRefundCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${importAdvanceRefundCurrency}'});
    });
</script>
