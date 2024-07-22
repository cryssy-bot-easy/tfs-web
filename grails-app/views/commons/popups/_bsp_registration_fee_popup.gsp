<%-- BSP Registration Fee --%>
<div id="bspFeePopup" class="popup_div_override">
    <div class="popup_header">
		<a href="#" class="popupClose_bsp_registration_fee popup_close">x</a>
		<h2 class="popup_title"> BSP Registration Fee </h2>
	</div>
	<table class="popup_full_width">
		<tr>
			<td class="label_width"><span class="field_label bold">BSP Registration Fee</span></td>
			<td><g:textField class="input_field_short input_three trans_currency" name="bspFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
			<td><g:textField name="bspFeePopupField" class="right input_field"  disabled="disabled"/></td>
		</tr>
	</table>
	
	<br/>
	
	<table class="buttons"> 
	<tr>
	  <td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
	</tr>
	<tr>
	  <td><input type="button" class="input_button_negative popupClose_bsp_registration_fee" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_bsp_registration_fee" class="popup_bg_override"></div>
