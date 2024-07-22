<div id="popup_interest_due" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_interest_due popup_close">x</a>
		<h2 class="popup_title"> Interest Due </h2>
	</div>
	<table class="popup_full_width">
		<tr>
			<td><span class="field_label bold">Interest Due</span></td>
			<td><g:textField name="interestDueNegotiationAmountPopup" class="right input_field" disabled="disabled"/></td>
			<td><span class="field_label">X</span></td>
			<td><g:textField name="interestDueInterestRatePopup" class="input_field_short input_three"  disabled="disabled"/></td>
			<td><span class="field_label">X</span></td>
			<td><g:textField name="interestDueNumberOfDaysPopup" class="input_field_short"  disabled="disabled"/></td>
			<td><span class="field_label">/</span> <span class="field_label">360</span></td>
		</tr>
	</table>
	<br/>
	<table class="buttons">
	<tr>
	  <td><input type="button" class="input_button popupConfirm_interest_due" value="Save" onclick="pendingInterestDue()"/></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative popupClose_interest_due" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_interest_due" class="popup_bg_override"></div>