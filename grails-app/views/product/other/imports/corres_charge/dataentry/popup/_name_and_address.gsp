<script>
    $(document).ready(function() {
    	$("#" + '${nameAndAddressTextArea}').limitCharAndLines(35,4);
    });
</script>

<div id="${nameAndAddressDiv}" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" id="${nameAndAddressCloseX}" class="popup_close">x</a>
		
		<h2 id="popup_header_nameAndAddress" class="popup_title">${nameAndAddressHeader}</h2>
	</div>
	<div class="popup_divider">
	
		<div><g:textArea name="${nameAndAddressTextArea}" class="textarea_add_instructions" disabled="disabled"></g:textArea></div>
		<br /><br />
		<table class="popup_buttons">
			<tr>
                <td class="right_indent"><input type="button" class="input_button" value="Save" id="${nameAndAddressSave}"/></td>
            </tr>
			<tr>
                <td class="right_indent"><input type="button" class="input_button_negative" id="${nameAndAddressClose}" value="Close" /></td>
            </tr>
		</table>
	</div>
</div>
<div id="${nameAndAddressBg}" class="popup_bg_override"> </div>

