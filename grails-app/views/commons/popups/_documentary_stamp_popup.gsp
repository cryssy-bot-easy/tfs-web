<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _documentary_stamp_popup.gsp
--%>

<%-- DOCUMENTARY STAMP POPUP --%>
<div id="documentaryStampPopup" class="popup_div_override">
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_documentaryStamp popup_close">x</a>
		<h2 class="popup_title"> Documentary Stamp </h2>
	</div>
	<table class="popup_full_width">
		<tr>
			<td><span class="field_label bold">Documentary Stamp</span></td>
			<td class="center"><g:textField class="input_field_short input_three trans_currency" name="documentaryStampPopupFieldCurrency" readonly="readonly"  disabled="disabled"/></td>
			<td><g:textField class="input_field_right numericCurrency" name="documentaryStampPopupField" disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Centavos to</span></td>
			<td rowspan="2"></td>
			<td><g:textField class="input_field_right numericCurrency" name="centavos"  value="${centavos?:0.30}" data-orig="${centavos?:0.30}"/></td>
		</tr>
		<tr><td></td></tr>
		<tr>
			<td class="indent1"><span class="field_label">Documentary Stamp</span></td>
			<td class="center"><g:textField class="input_field_short input_three doc_currency" name="docStampCurrency" value="PHP" readonly="readonly"  disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampPhp" readonly="readonly" disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">${documentClass} Amount</span></td>
			<td class="center"><g:textField class="input_field_short input_three lc_currency" name="documentaryStampLCAmountCurrency" readonly="readonly" value="${originalCurrency ?: currency}"  disabled="disabled"/></td>
			<td><g:textField class="input_field_right numericCurrency" name="documentaryStampLCAmountPopup" value="${originalAmount ?: amount}" readonly="readonly"  disabled="disabled"/></td>
		</tr>
	</table>
	<br />
	<table class="buttons"> 
	<tr>
		<td><input type="button" class="input_button2" value="Re-Compute" id="btnRecomputeDocumentaryStamp"/></td>
	</tr>
	<tr>
		<td><input type="button" class="input_button chargesPopupBtn" value="Save" /></td>
	</tr>
	<tr>
		<td><input type="button" class="input_button_negative popupClose_documentaryStamp" value="Cancel" /></td>
	</tr>
	</table>
</div>
<div id="popupBackground_doc_stamp" class="popup_bg_override"></div>
<%-- DOCUMENTARY STAMP POPUP END --%>
