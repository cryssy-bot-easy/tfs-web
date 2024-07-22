<div class="popup_div_override" id="popup_processing_unit_code">
    <div class="popup_header">
		<h2>Enter Processing Unitss Code</h2>
	</div>
	<div style="margin: auto; width: 70%;">
		<table class="popup_full_width center" id="batchProcessCode">
			<tr>
				<td><g:textField class="input_field" name="batchProcessingUnitCodeTxt" /></td>
			</tr>
		</table>
	</div>
	<br />
	<div class="popup_buttons">
		<table>
			<tr>
				<td />
				<td><input type="button" class="input_button buttonPopupGenDocument" onclick="enterBatchProcessingUnitCode()" value="OK" /></td>
			</tr>
			<tr>
				<td />
				<td><input type="button" class="input_button_negative" onclick="closePopUpProcessingCode()" value="Cancel" /></td>
			</tr>
		</table>
	</div>
</div>
<input type="hidden" name='reportName' id='reportName'/>
<div class="popup_bg_override" id="popupBackground_processing_unit_code"></div>
<%--	<g:javascript src="popups/popup_processing_unit_code.js"/>--%>