<g:javascript src="utilities/commons/create_advise_on_export_transaction_utility.js" />
<div id="create_advise_on_export_transaction_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="create_advise_on_export_transaction_popup_close" class="popup_close"> x </a>
		<h2 id="create_advise_on_export_transaction_popup_header"> Create Transaction </h2>
	</div>
	<g:radioGroup values="${['a','c']}" labels="${['Amendment','Cancellation']}" name="createAdviseOnExportTransaction" >
		<label>${it.radio}&#160;${it.label}</label><br/>
	</g:radioGroup>
	<br/>
	<g:hiddenField name="documentTypeEts" value=""/>
	<g:hiddenField name="documentClassEts" value=""/>
	<g:hiddenField name="documentSubType1Ets" value=""/>
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createAdviseOnExportRedirect" value="Select" class="input_button" disabled="disabled"/></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createAdviseOnExportCancel" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_create_advise_on_export_transaction" class="popup_bg_override"> </div>