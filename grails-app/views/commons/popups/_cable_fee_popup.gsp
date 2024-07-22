<%-- Cable fee --%>
<div id="cableFeePopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_cable_fee popup_close">x</a>
		<h2 class="popup_title"> Cable Fee </h2>
	</div>
	<table class="popup_table_short_center">
		<tr>
			<td><span class="field_label bold">Cable Fee</span></td>
			<td><g:textField class="input_field_short input_three trans_currency" name="cableFeePopupFieldCurrency" readonly="readonly"  disabled="disabled"/></td>
			<td><g:textField name="cableFeePopupField" class="input_field_right numericCurrency"  disabled="disabled"/></td>
		</tr>
		
	</table>
	<br/>
	<table class="buttons"> 
	<tr>
	  <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative popupClose_cable_fee" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_cable_fee" class="popup_bg_override"></div>