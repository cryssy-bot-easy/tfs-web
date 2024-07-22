<%-- Other Local Bank Charges--%>
<div id="otherLocalBankChargesPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_other_local_bank_charges popup_close">x</a>
		<h2 class="popup_title">Other Local Bank Charges</h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label bold">Other Local Bank Charges</span></td>
			<td><g:textField class="input_field_short input_three trans_currency" name="otherLocalBankChargesPopupFieldCurrency" readonly="readonly"  disabled="disabled"/></td>
			<td><g:textField name="otherLocalBankChargesPopupField" class="input_field_right numericCurrency"  disabled="disabled"/></td>
		</tr>
		
	</table>
	<br/>
	<table class="buttons"> 
	<tr>
	  <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative popupClose_other_local_bank_charges" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_other_local_bank_charges" class="popup_bg_override"></div>