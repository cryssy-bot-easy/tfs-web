<div id="popup_page" class="popup_div_override">
	<div class="popup_container">
		<table>
			<tr>
				<td class="label_width"><span class="field_label">Document Type</span></td>
				<td><g:select name="documentType" noSelection="['':'SELECT ONE...']" class="select_dropdown"  from="${['FOREIGN','DOMESTIC']}" value="" /></td>
				<g:hiddenField name="id" class="input_field" maxlength="19" value="" readonly="readonly"/>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label">Document Code</span></td>
				<td><g:textField name="documentCode" class="input_field_normal_case" maxlength="21" value="" /></td>
			</tr>
			<tr>
				<td class="label_width"><span class="field_label">Document Description</span></td>
				<td><g:textArea name="description" class="textarea_required normal_case" maxlength="999" value="" /></td>
			</tr>
		</table>

		
		<table class="popup_buttons">
 		   	<tr><td><input type="button" class="input_button" id="popup_btnSaveNewDocument" value="Save" /> </td></tr>
    		<tr><td><input type="button" class="input_button_negative" id="popup_closeAddNewDocument" value="Close" />  </td></tr>
		</table>
	</div>
</div>
<div id="popup_bg" class="popup_bg_override"> </div>