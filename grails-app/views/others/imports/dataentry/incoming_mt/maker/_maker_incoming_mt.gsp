
<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">LC Number</span></td>
		<td><g:textField name="lcNumber" maxlength="16" class="input_field"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">MT Message</span></td>
		<td class="space"><g:textArea name="mtMessage" class="textarea_mt_message" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Instruction</span></td>
		<td class="space"><g:textArea name="instruction" class="textarea_mt_instruction" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Reference Number</span></td>
		<td>
			<g:textField name="referenceNumber" class="input_field"/>
		</td>
	</tr>
</table>
<table class="buttons tabs_forms_table">
	<tr>
		<td><g:submitToRemote name="print" class="input_button" value="Print"/></td>
	</tr>
	<tr>
		<td><g:submitToRemote name="done" class="input_button" value="Done"/></td>
	</tr>
</table>
<script>

$(function(){
	$("#lcNumber").keypress(function(e){
	    var charCheck = true;
	    if (e.charCode == 45){
	        charCheck = false;
	    }
	    return charCheck
	});
});
</script>
