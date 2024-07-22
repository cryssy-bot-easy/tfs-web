<!-- Created by: Rafael Ski Poblete
	 Date: 9/10/18 
	 Description: new gsp file to support narrative popup element-->
<div id="narrative_popup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popup_close narrative_close">x</a>
		<h2 id="popupClose_bank" class="popup_title"> Narrative </h2>
	</div>
	<br/>
	<div><g:textArea maxlength="1750" name="narrativeComment" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
	<br />
	<table class="buttons">
		<tr>
			<td><input type="button" class="input_button narrative_save" value="Save" id="narrativePopupSave"/></td>
		</tr>
		<tr>
			<td><input type="button" class="input_button_negative narrative_close"value="Close" /></td>
		</tr>			
	</table>
</div>
<div id="narrative_bg" class="popup_bg_override"> </div>