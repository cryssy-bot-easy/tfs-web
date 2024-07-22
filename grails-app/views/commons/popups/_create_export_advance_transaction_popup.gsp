<g:javascript src="utilities/commons/create_export_advance_transaction_utility.js" />
<script type="text/javascript">
    var exportPaymentUrl = '${g.createLink(controller: "product", action: "viewExportAdvancePayment")}';
    var exportRefundUrl = '${g.createLink(controller: "product", action: "viewExportAdvanceRefund")}';
</script>
<div id="create_export_advance_transaction_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="create_export_advance_transaction_popup_close" class="popup_close"> x </a>
		<h2 id="create_export_advance_transaction_popup_header"> Create Transaction </h2>
	</div>
	<g:radioGroup values="${['eap','ear']}" labels="${['Export Advance Payment','Export Advance Refund']}" name="createExportAdvanceTransaction" >
		<label>${it.radio}&#160;${it.label}</label><br/>
	</g:radioGroup>
	<br/>
	<g:hiddenField name="documentTypeEts" value=""/>
	<g:hiddenField name="documentClassEts" value=""/>
	<g:hiddenField name="documentSubType1Ets" value=""/>
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createExportAdvanceRedirect" value="Go" class="input_button" disabled="disabled"/></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createExportAdvanceCancel" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_create_export_advance_transaction" class="popup_bg_override"> </div>