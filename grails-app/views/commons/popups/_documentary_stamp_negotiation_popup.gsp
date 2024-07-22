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
	Project Name: _documentary_stamp_negotiation_popup.gsp
	
(revision)
	SCR/ER Number: 
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/20/2018
	Program [Revision] Details: Modified values of documentaryStampForFirst and documentaryStampForNextPopup.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _documentary_stamp_negotiation_popup.gsp

(revision)
	SCR/ER Number: 
	SCR/ER Description:
	[Revised by:] Cedrick C. Nungay
	[Date revised:] 03/21/2018
	Program [Revision] Details: Added values for For First amount and For Next amount.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _documentary_stamp_negotiation_popup.gsp
--%>

<%-- DOCUMENTARY STAMP POPUP --%>
<div id="documentaryStampPopup" class="popup_div_override">	
    <div class="popup_header">
		<a href="javascript:void(0)" class="popupClose_documentaryStamp popup_close">x</a>
		<h2 class="popup_title"> Documentary Stamp </h2>
	</div>
	<span> Edit Documentary Stamp </span>
	<hr />
	<table class="popup_full_width">
		<tr>
			<td><span class="field_label bold">Documentary Stamp (Settlement Currency)</span></td>
			<td class="center">
                <%--<g:textField class="input_field_short input_three trans_currency" name="documentaryStampCurrency" readonly="readonly"/>--%>
                <span class="charges_currency"  id="documentaryStampPopupFieldCurrency"></span>
            </td>
			<td><g:textField class="input_field_right numericCurrency" name="documentaryStampPopupField" disabled="disabled" /></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Nego Amount (LC Currency)</span></td>
			<td class="center"><g:textField class="input_field_short input_three lc_currency" name="documentaryStampNegoAmountLcCurrency" readonly="readonly" disabled="disabled"/></td>
			<td><g:textField class="input_field_right numeric-fifteen numericCurrency" name="documentaryStampNegotiationAmountLcPopup" readonly="readonly" value="${negotiationAmount}"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Rate (LC Currency - PHP)</span></td>
			<td class="center"><g:textField class="input_field_medium input_ten rate_currency center" name="documentaryStampLcPhpCurrency" readonly="readonly" disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampRateLcPopup" readonly="readonly"  disabled="disabled"/></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Nego Amount (PHP)</span></td>
			<td class="center"><g:textField class="input_field_short input_three doc_currency" name="documentaryStampNegoAmountPhp" readonly="readonly" value="PHP" disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampNegotiationAmountPopup" readonly="readonly" /></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">For First</span>&#160;<g:textField class="input_field_medium center doc_currency" value="${ documentaryStampForFirst }" name="documentaryStampForFirst" disabled="disabled"/></td>
			<td class="center"><g:textField class="input_field_short input_three doc_currency" name="documentaryStampForFirstCurrency" readonly="readonly" value="PHP" disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampForFirstAmountPopup" value="${ documentaryStampForFirstAmountPopup }" data-orig="${documentaryStampForFirstAmountPopup ?: ''}" /></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">For Next</span>&#160;<g:textField class="input_field_medium center doc_currency" value="${ documentaryStampForNext }" name="documentaryStampForNextPopup" disabled="disabled"/></td>
			<td class="center"><g:textField class="input_field_short input_three doc_currency" name="documentaryStampForNextCurrency" readonly="readonly" value="PHP" disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampAmountForNextAmountPopup" value="${ documentaryStampAmountForNextAmountPopup }" data-orig="${documentaryStampAmountForNextAmountPopup ?: ''}" /></td>
		</tr>
		<tr>
			<td class="indent1"><span class="field_label">Documentary Stamp (PHP)</span></td>
			<td class="center"><g:textField class="input_field_short input_three doc_currency" name="docStampCurrency" value="PHP" readonly="readonly" disabled="disabled"/></td>
			<td><g:textField class="input_field_right" name="documentaryStampPopupField2" id="documentaryStampPhp" readonly="readonly"  disabled="disabled"/></td>
		</tr>
		%{--<tr>--}%
			%{--<td class="indent1"><span class="field_label">Rate (PHP - Settlement Currency)</span></td>--}%
			%{--<td class="center"><g:textField class="input_field_medium input_ten rate_currency center" name="documentaryStampPhpSettlementCurrency" readonly="readonly" disabled="disabled"/></td>--}%
			%{--<td><g:textField class="input_field_right" name="documentaryStampRatePopup" readonly="readonly"  disabled="disabled"/></td>--}%
		%{--</tr>--}%
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
