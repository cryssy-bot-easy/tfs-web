<div id="popup_page" class="popup_div_override">
	<span id="firmLibPopupLabel" class="popup_title"> </span>
	<hr><br/>
	<div class="popup_container">
		<div id="firmLibAddEdit">
			<table>
				<tr>
					<td class="label_width"><span class="field_label">Firm Code </span></td>
					<td><g:textField name="firmCode" class="input_field numericWholeQuantity" value="" /></td>
				</tr>
				<tr>
					<td class="label_width"><span class="field_label">Firm Description </span></td>
					<td><g:textArea name="firmDescription" class="textarea_required" maxlength="150" value="" /></td>
				</tr>
			</table>
				
			<table class="popup_buttons">
				<tr><td><input type="button" class="input_button" id="save_firmLib" value="Save" /></td></tr>
				<tr><td><input type="button" class="input_button_negative close_firmLib" value="Close" /></td></tr>
			</table>
		</div>
		<div id="firmLibConfirmation">
			<table>
				<tr>
					<td class="label_width"><span class="field_label">Delete Record?</span></td>
				</tr>
			</table>
				
			<table class="popup_buttons">
				<tr><td><input type="button" class="input_button" id="delete_firmLib" value="Delete" /></td></tr>
				<tr><td><input type="button" class="input_button_negative close_firmLib" value="Cancel" /></td></tr>
			</table>
		</div>
	</div>
</div>
<div id="popup_bg" class="popup_bg_override"></div>