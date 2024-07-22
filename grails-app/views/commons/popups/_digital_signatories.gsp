<div class="popup_div_override" id="popup_digital_signatories">		
    <div class="popup_header">
		<h2> Select Document Signatories </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label">Authorized Signatory 1<span class="asterisk">*</span></span></td>
			<td><input name="authorizedSignatory1" id="authorizedSignatory1" class="select2_dropdown"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Position</span></td>
			<td><g:textField class="input_field" name="authorizedSignatory1Position" readonly="readonly" value=""/></td>
		</tr>
		<tr><td><br/></td></tr>
		<tr>
			<td><span class="field_label">Authorized Signatory 2<span class="asterisk">*</span></span></td>
			<td><input name="authorizedSignatory2" id="authorizedSignatory2" class="select2_dropdown"/></td>
		</tr>
		<tr>
			<td><span class="field_label">Position</span></td>
			<td><g:textField class="input_field" name="authorizedSignatory2Position" readonly="readonly" value=""/></td>
		</tr>
	</table>
	<br/>
	<div class="popup_buttons">
		<table>
			<tr>
				<td/>
				<td><input type="button" class="input_button_long buttonPopupGenDocument" value="Generate Document" /></td>
			</tr>
			<tr>
				<td/>
				<td><input type="button" class="input_button_negative" onclick="closeDigitalSignatories()" value="Cancel" /></td>
			</tr>
		</table>
	</div>		
</div>
<div class="popup_bg_override" id="popupBackground_digital_signatories"></div>
<g:javascript src="popups/digital_signatories_popup.js"/>

<script type="text/javascript">
$(document).ready(function() {
	$("#authorizedSignatory1").setDigitalSignatoriesDropdown($(this).attr("id")).select2('data',{id: '${authorizedSignatory1}'});
	$("#authorizedSignatory1").change(function(){
		if($(this).select2('data')){
			$("#authorizedSignatory1Position").val($(this).select2('data').position);
		} else {
			$("#authorizedSignatory1Position").val('');
		}
	});

	$("#authorizedSignatory2").setDigitalSignatoriesDropdown($(this).attr("id")).select2('data',{id: '${authorizedSignatory2}'});
	$("#authorizedSignatory2").change(function(){
		if($(this).select2('data')){
			$("#authorizedSignatory2Position").val($(this).select2('data').position);
		} else {
			$("#authorizedSignatory2Position").val('');
		}
	});
});
</script>