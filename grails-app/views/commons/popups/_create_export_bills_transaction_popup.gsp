<g:javascript src="utilities/commons/create_export_bills_transaction_utility.js" />
<script type="text/javascript">
    var createEtsExportBillsTransactionUrl = '${g.createLink(controller:'etsExportCore', action:'viewExportCoreEts')}';
    var createDataEntryExportBillsTransactionUrl = '${g.createLink(controller:'dataentryExportCore', action:'viewExportCoreDataentry')}';
</script>
<div id="create_export_bills_transaction_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="create_export_bills_transaction_popup_close" class="popup_close"> x </a>
		<h2 id="create_export_bills_transaction_popup_header"> Create Transaction </h2>
	</div>
	<g:radioGroup values="${(username && username.equalsIgnoreCase('main'))?['dbcNegotiation','ebcNegotiation']:['dbpNegotiation','ebpNegotiation']}"
	 labels="${(username && username.equalsIgnoreCase('main'))?['Domestic Bills for Collection -  Negotiation','Export Bills for Collection - Negotiation']:['Domestic Bills for Purchase - Negotiation','Export Bills for Purchase - Negotiation']}" name="createExportBillsTransaction" >
		<label>${it.radio}&#160;${it.label}</label><br/>
	</g:radioGroup>
	<br/>
	<g:hiddenField name="documentTypeEts" value=""/>
	<g:hiddenField name="documentClassEts" value=""/>
	<g:hiddenField name="documentSubType1Ets" value=""/>
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createExportBillsRedirect" value="Go" class="input_button" disabled="disabled"/></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createExportBillsCancel" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_create_export_bills_transaction" class="popup_bg_override"> </div>