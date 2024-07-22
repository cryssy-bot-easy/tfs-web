<div id="authorizedSignatoryPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close" onclick="closeAuthorizedSignatoryPopUp()">x</a>
		<h2 class="popup_title"> Authorized Signatory </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label">Authorized Signatory<span class="asterisk">*</span></span></td>
<%--			<td><g:select class="select_dropdown" name="authorizedSign" from="['Leticia Mejos', 'Justiniano Babate']" keys="${['Leticia Mejos', 'Justiniano Babate', 'OPTION3']}" noSelection="${['':'SELECT ONE...']}"/></td>--%>
			<td><input class="select2_dropdown bigdrop" name="authorizedSign" id="authorizedSign" /></td>
		</tr>
		<tr>
			<td><span class="field_label">Position</span></td>
			<td><g:textField name="authorizedSignPosition" class="input_field" readonly="readonly" /></td>
		</tr>
	</table>
	<br/>
	<table class="buttons"> 
		<tr>
		  <td><input type="button" class="input_button_long buttonPopupGenDocument" value="Generate Document" /></td>
		</tr>
		<tr>
		  <td><input type="button" class="input_button_negative" onclick="closeAuthorizedSignatoryPopUp()" value="Cancel" /></td>
		</tr>
	</table>
</div>
<div id="popupBackground_authorized_signatory" class="popup_bg_override"></div>

<g:javascript src="popups/authorized_signatory_popup.js"/>
<script type="text/javascript">
$(function(){
	$("#authorizedSign").setDigitalSignatoriesDropdown($(this).attr("id")).select2('data',{id: '${authorizedSign}'});
	$("#authorizedSign").change(function(){
		if($(this).select2('data')){
			$("#authorizedSignPosition").val($(this).select2('data').position);
		} else {
			$("#authorizedSignPosition").val('');
		}
	});
});
</script>