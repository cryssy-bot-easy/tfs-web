<g:javascript src="utilities/exports/modify_export_bills_transaction_utility.js" />
<script type="text/javascript">
    var modifyEtsExportBillsTransactionUrl = '${g.createLink(controller:'etsExportCore', action:'viewExportCoreEts')}';
    var modifyDataEntryExportBillsTransactionUrl = '${g.createLink(controller:'dataentryExportCore', action:'viewExportCoreDataentry')}';
</script>
<div id="modify_export_bills_transaction_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="modify_export_bills_transaction_popup_close" class="popup_close"> x </a>
		<h2 id="modify_export_bills_transaction_popup_header"> Create Transaction </h2>
	</div>
	<g:radioGroup values="${['ebpSettlement','ebcCancellation']}"
	 labels="${['Export Bills for Purchase - Settlement','Export Bills for Collection - Cancellation']}" name="modifyExportBillsTransaction" >
		<label>${it.radio}&#160;${it.label}</label><br/>
	</g:radioGroup>
	<br/>
	<g:hiddenField name="documentTypeEts" value=""/>
	<g:hiddenField name="documentClassEts" value=""/>
	<g:hiddenField name="documentSubType1Ets" value=""/>
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="modifyExportBillsRedirect" value="Go" class="input_button"/></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="modifyExportBillsCancel" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_modify_export_bills_transaction" class="popup_bg_override"> </div>