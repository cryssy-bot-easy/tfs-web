<!-- Created by: Rafael Ski Poblete
	 Date: 9/11/18 
	 Description: new gsp file to support narrative popup element-->
<div id="charges_deducted_narrative_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close charges_deducted_narrative_popup_close">x</a>
		<h2 id="popupClose_bank" class="popup_title"> Charge Narrative </h2>
	</div>
	<br/>
	<div><g:textArea maxlength="215" name="chargesDeductedNarrativeComment" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
	<br />
	<table class="buttons">
		<tr>
			<td><input type="button" class="input_button charges_deducted_narrative_popup_save" value="Save" id="chargesDeductedNarrativePopupSave"/></td>
		</tr>
		<tr>
			<td><input type="button" class="input_button_negative charges_deducted_narrative_popup_close"value="Close" /></td>
		</tr>			
	</table>
</div>
<div id="charges_deducted_narrative_bg" class="popup_bg_override"> </div>