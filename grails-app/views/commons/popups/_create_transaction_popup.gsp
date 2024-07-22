<g:javascript src="utilities/commons/create_transaction_utility.js" />
<script type="text/javascript">
    var createTransactionUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewOpeningEts')}';
</script>
<div id="create_transaction_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="create_transaction_popup_close" class="popup_close"> x </a>
		<h2 id="create_transaction_popup_header"> Create Transaction </h2>
	</div>
	<g:radioGroup values="${['fxlcCash','fxlcRegular','fxlcStandby','dmlcCash','dmlcRegular','dmlcStandby']}" labels="${['FXLC Cash Opening','FXLC Regular Opening','FXLC Standby Opening',
							'DMLC Cash Opening','DMLC Regular Opening','DMLC Standby Opening']}" name="createTransaction" id="createTransaction">
		<label>${it.radio}&#160;${it.label}</label><br/>
	</g:radioGroup>
	<br/>
	<g:hiddenField name="documentTypeEts" value=""/>
	<g:hiddenField name="documentClassEts" value=""/>
	<g:hiddenField name="documentSubType1Ets" value=""/>
	<table class="popup_buttons">
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createEtsRedirect" value="Go" class="input_button" disabled="disabled"/></td>
		</tr>
		<tr>
			<%-- BUTTON --%>
			<td><input type="button" id="createEtsCancel" value="Cancel" class="input_button_negative" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_create_transaction" class="popup_bg_override"> </div>