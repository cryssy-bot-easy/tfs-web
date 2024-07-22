<g:form>
<div id="add_instructions_popup" class="popup_div_override">
	<div class="popup_header">
	    <a href="javascript:void(0)" class="add_instructions_close popup_close">x</a>
	   
	    <h2 id="header_add_instruction" class="popup_title"> Add Instructions </h2>
	</div>
        <g:hiddenField name="instructionAction" value="" />
        <div><g:textArea name="message" class="textarea_add_instructions" disabled="disabled"></g:textArea></div><br />
<%--            <span><span id="remainingCharacters_instructions"></span>&#160;Characters Left</span>--%>
            <br />
            <table class="popup_buttons_short2" id="add_instruction_buttons">
                <tr><td><input type="button" class="input_button openSaveConfirmation" value="Save" /></td></tr>
                <tr><td><input type="button" class="input_button_negative add_instructions_close" value="Close" /></td></tr>   
            </table>
</div>
</g:form>
<div id="add_instructions_bg" class="popup_bg_override"> </div>
<div class="popup_bg_override"> </div>