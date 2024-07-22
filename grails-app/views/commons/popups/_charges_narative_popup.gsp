<!-- Created by: Rafael Ski Poblete
	 Date: 7/26/18 
	 Description: new gsp file to support charges narrative popup element-->
<div id="charge_narrative_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close charge_narrative_close">x</a>
		<h2 id="popupClose_bank" class="popup_title"> Charge Narrative </h2>
	</div>
	<br/>
	<div><g:textArea maxlength="215" name="chargeNarrativeComment" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
	<br />
	<table class="buttons">
		<tr>
			<td><input type="button" class="input_button charge_narrative_save" value="Save" id="chargeNarrativePopupSave"/></td>
		</tr>
		<tr>
			<td><input type="button" class="input_button_negative charge_narrative_close"value="Close" /></td>
		</tr>			
	</table>
</div>
<div id="charge_narrative_bg" class="popup_bg_override"> </div>