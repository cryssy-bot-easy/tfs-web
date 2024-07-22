<script type="text/javascript">
function validate(evt) {
	  var theEvent = evt || window.event;
	  var key = theEvent.keyCode || theEvent.which;
	  key = String.fromCharCode( key );
	  var regex = /[0-9]|\./;
	  if( !regex.test(key) ) {
	    theEvent.returnValue = false;
	    if(theEvent.preventDefault) theEvent.preventDefault();
	  }
	}
</script>

<div id="popup_additionalAmtCovered" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="close_additionalAmtCovered1" class="popup_close">x</a>
		<h2 id="popup_header_addAmtCovered"> Additional Amounts Covered </h2>
	</div>
	<div class="popup_divider">
	
		<div><g:textArea onkeypress="validate(event)" maxlength="70" name="additionalAmountCoveredComment" class="textarea_add_instructions"  disabled="disabled">${additionalAmountCovered}</g:textArea></div>
		<br />
		<table class="popup_buttons">
			<tr><td class="right_indent"><input type="button" class="input_button" value="Save" id="additionalAmountsCoveredPopupSave"/></td></tr>
			<tr><td class="right_indent"><input type="button" class="input_button_negative" id="close_additionalAmtCovered2" value="Close" /></td></tr>
		</table>
	</div>
</div>
<div id="addtional_amounts_covered_bg" class="popup_bg_override"> </div>