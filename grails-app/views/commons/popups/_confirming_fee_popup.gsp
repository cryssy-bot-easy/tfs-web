<%-- Confirming fee --%>
<div id="confirmingFeePopup" class="popup_div_override">
<%--<div id="confirmingFeePopup" class="popup_div_override <g:if test="${serviceType == 'Amendment' && lcAmountFlag == 'INC'}">amendment</g:if>">--%>
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_confirming_fee popup_close">x</a>
		<h2 class="popup_title"> Confirming Fee </h2>
	</div>
	<table class="popup_full_width">	
		<tr>
			<td class="indent1"><span class="field_label">Percentage</span></td>
			<td />
			<td><g:textField class="center input_field_short numericWholeQuantity" name="confirmFeePercentageNumerator" value="${confirmFeePercentageNumerator?:1}"/>
				&#160;&#47;&#160;
				<g:textField class="center input_field_short numericWholeQuantity" name="confirmFeePercentageDenominator" value="${confirmFeePercentageDenominator?:8}"/>
				&#160; of &#160;
				<g:textField class="center input_field_short percentage numericWholeQuantity" name="confirmFeePercentage" value="${confirmFeePercentage?:1}"/>
				&#160;&#37;&#160;
			</td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Number of Days</span></td>
			<td />
			<td><g:textField class="center input_field numericWholeQuantity" name="confirmFeeNumberOfMonths" disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Confirming Fee</span></td>
			<td class="center"><g:textField class="input_field_short input_three trans_currency" name="confirmingFeePopupFieldCurrency" readonly="readonly" disabled="disabled"/></td>
			<td><g:textField class="input_field_right numericCurrency" name="confirmingFeePopupField" disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">LC Amount</span></td>
			<td class="center"><g:textField class="input_field_short input_three lc_currency" name="confirmFeeLCAmountCurrency" value="${originalCurrency ?: currency}" readonly="readonly" disabled="disabled" /></td>
			<td><g:textField class="right input_field numericCurrency" name="confirmingFeeLCAmountPopup" value="${originalAmount ?: amount}" readonly="readonly" disabled="disabled"/></td>
		</tr>
	</table>
	<br />
	<table class="buttons"> 
	<tr>
		<td><input type="button" class="input_button2" value="Re-Compute" id="btnRecomputeConfirmingFee"/></td>
	</tr>
	<tr>
		<td><input type="button" class="input_button chargesPopupBtn" value="Save"/></td>
	</tr>
	<tr>
		<td><input type="button" class="input_button_negative popupClose_confirming_fee" value="Cancel"/></td>
	</tr>
	</table>
</div>
<div id="popupBackground_confirming_fee" class="popup_bg_override"></div>