<div class="popup_div_override" id="popup_processing_unit_code2">
    <div class="popup_header">
		<h2>Enter Processing Unit Code</h2>
	</div>
	<div style="margin: auto; width: 70%;">
		<table class="popup_full_width center" id="batchProcessCode">
			<tr>
				<td>
					<g:select class="select_dropdown" name="batchProcessingUnitCodeTxt" from="${['102', '111', '125', '133', '134', '147',
						'151', '155', '160', '179', '188', '196',
						'201', '202', '205', '217', '220', '221',
						'244', '247', '251', '302', '314', '316',
						'317', '319', '402', '403', '404', '405',
						'406', '412', '413', '417', '900', '903',
						'909', '928', '929', '930', '931', '960'
						]}" noSelection="${['':'SELECT ONE...']}" />
				</td>
			</tr>
		</table>
	</div>
	<br />
	<div class="popup_buttons">
		<table>
			<tr>
				<td/>
				<td><input type="button" class="input_button buttonPopupGenDocument" onclick="enterBatchProcessingUnitCode()" value="OK" /></td>
			</tr>
			<tr>
				<td/>
				<td><input type="button" class="input_button_negative" onclick="closePopUpProcessingCode()" value="Cancel" /></td>
			</tr>
		</table>
	</div>
</div>
<input type="hidden" name='reportName' id='reportName'/>
<div class="popup_bg_override" id="popupBackground_processing_unit_code2"></div>
<%--<g:javascript src="popups/popup_processing_unit_code.js"/>--%>
	