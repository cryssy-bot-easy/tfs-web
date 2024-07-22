<div id="letterOfTransferPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close" onclick="closeLetterOfTransferPopUp()">x</a>
		<h2 class="popup_title"> Generate Letter of Transfer </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td class="label_width"><span class="field_label">Receiving Bank<span class="asterisk">*</span></span></td>
			<td><g:textField name="recevingBank" class="input_field"/></td>
		</tr>
		<tr>
			<td class="label_width valign_top"><span class="field_label">Receiving Bank Address<span class="asterisk">*</span></span></td>
			<td><g:textArea name="receivingBankAddress" class="textarea" rows="4"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Recipient<span class="asterisk">*</span></span></td>
			<td><g:textField name="recipient" class="input_field"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Position<span class="asterisk">*</span></span></td>
			<td><g:textField name="recipientPosition" class="input_field"/></td>
		</tr>
		<tr>
			<td class="label_width valign_top"><span class="field_label">List of Documents to be Forwarded<span class="asterisk">*</span></span></td>
			<td><g:textArea name="documentsLists" class="textarea_documents_list" rows="10"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Authorized Signatory<span class="asterisk">*</span></span></td>
			<td><input name="authorizedSignatory" id="authorizedSignatory" class="select2_dropdown"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Position</span></td>
			<td><g:textField name="authorizedSignatoryPosition" class="input_field" readonly="readonly" value=""/></td>
		</tr>
	</table>
	<br/>
	<table class="buttons"> 
	<tr>
	  <td><input type="button" class="input_button buttonPopupGenDocument" value="Generate" /></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative" onclick="closeLetterOfTransferPopUp()" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_letter_of_transfer" class="popup_bg_override"></div>

<g:javascript src="popups/letter_of_transfer_popup.js"/>

<script type="text/javascript">
$(function(){
	$("#authorizedSignatory").setDigitalSignatoriesDropdown($(this).attr("id")).select2('data',{id: '${authorizedSignatory1}'});
	$("#authorizedSignatory").change(function(){
		if($(this).select2('data')){
			$("#authorizedSignatoryPosition").val($(this).select2('data').position);
		} else {
			$("#authorizedSignatoryPosition").val('');
		}
	});
});
</script>