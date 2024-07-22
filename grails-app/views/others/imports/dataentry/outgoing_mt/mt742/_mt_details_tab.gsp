
<%@ page import="net.ipc.utils.DateUtils" %>
<%-- (Revision)
	[Modified by:] Rafael Ski Poblete
	Date: 8/01/18
	Description: Changed field71B to field71D and field72 to field72Z. --%>
	
<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

<g:render template="/grails-app/views/commons/popups/charges_narative_popup_for_MT742"/>
<g:javascript src="popups/charges_narative_popup_for_MT742.js" />


<g:hiddenField name="messageType" value="742"/>
<g:hiddenField name="chainName" value="viewMT742"/><%--Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for disabling tab/s in basic_details_utility--%>
<%--Needed by select2 utility:--%>
<g:hiddenField name="issuingBankPartyIdentifierValue" value="${details?.issuingBankPartyIdentifier}"/>
<g:hiddenField name="accountWithBankPartyIdentifierValue" value="${details?.accountWithBankPartyIdentifier}"/>
<g:hiddenField name="beneficiaryBankPartyIdentifierValue" value="${details?.beneficiaryBankPartyIdentifier}"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label">Reimbursing Bank <span class="asterisk">*</span></span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop required" name="reimbursingBank" id="reimbursingBank" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">20: Document Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumber" class="input_field documentNumber" value="${details?.documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">21: LC Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="lcNumber" class="input_field" value="${details?.lcNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">31C: Date of Issue<span class="asterisk">*</span></span></td>
		<td><g:textField name="lcIssueDate" class="datepicker_field" value="${details?.lcIssueDate}"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td><span class="field_label title_label">Negotiation Currency<span class="asterisk">*</span></span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" value="${details?.currency}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">32B: Negotiation Amount<span class="asterisk">*</span></span></td>
		<td>
			<g:textField name="amount" class="input_field_right numericCurrency" value="${details?.amount ?: details?.principalAmountClaimed}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">33B: Additional Amount Claimed</span></td>
		<td>
			<g:textField name="additionalAmountClaimed" class="input_field_right numericCurrency" value="${details?.additionalAmountClaimed}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">34a: Total Amount Claimed</span><span class="asterisk">*</span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="totalAmountCurrency" id="totalAmountCurrency" value="${details?.totalAmountCurrency}"/>
			<g:textField name="totalAmountClaimed" class="input_field_right numericCurrency" value="${details?.totalAmountClaimed}"/>
		</td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
		<td> <span class="title_label">52A: Issuing Bank </span></td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="issuingBankCode" id="issuingBankCode" value="${details?.issuingBankCode}"/></td>
	</tr>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				Party Identifier--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><input class="tags_bank select2_dropdown bigdrop" name="issuingBankCode" id="issuingBankCode" value="${details?.issuingBankCode}"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td class="valign_top">--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				Name and Address--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td>--%>
<%--			<g:textArea class="textarea" name="issuingBankAddress" value="${details?.issuingBankAddress}" rows="4" readonly="readonly"/>--%>
<%--			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt742_popup_btn_issuing_bank">...</a>--%>
<%--		</td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td colspan="2"> <span class="title_label">52<span class="issuingBankOptionLetter title_label"></span>: Issuing Bank </span></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				<g:radio name="issuingBankFlag" class="issuingBankFlag" value="A" checked="${'A'.equals(details?.issuingBankFlag)}" />--%>
<%--				&#160;&#160;Party Identifier--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><input class="tags_bank select2_dropdown bigdrop" name="issuingBankIdentifierCode" id="issuingBankIdentifierCode" value="${details?.issuingBankIdentifierCode}"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td class="valign_top">--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				<g:radio name="issuingBankFlag" class="issuingBankFlag" value="D" checked="${'D'.equals(details?.issuingBankFlag)}" />--%>
<%--				&#160;&#160;Name and Address--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td>--%>
<%--			<g:textArea class="textarea" name="issuingBankNameAndAddress" value="${details?.issuingBankNameAndAddress}" rows="4" readonly="readonly"/>--%>
<%--			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt742_popup_btn_issuing_bank">...</a>--%>
<%--		</td>--%>
<%--	</tr>--%>
	
	
	<tr>
		<td colspan="2"> <span class="title_label">57<span class="accountWithInstitutionOptionLetter title_label"></span>: Account with Bank </span></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="corresBankFlag" class="corresBankFlag" value="A" checked="${'A'.equals(details?.corresBankFlag)}" />
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="corresBankCode" id="corresBankCode" value="${details?.corresBankCode}"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="corresBankFlag" class="corresBankFlag" value="B" checked="${'B'.equals(details?.corresBankFlag)}" />
				&#160;&#160;Location
			</span>
		</td>
		<td><g:textArea class="textarea" name="corresBankLocation" value="${details?.corresBankLocation}" rows="2"/></td>	
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="corresBankFlag" class="corresBankFlag" value="D" checked="${'D'.equals(details?.corresBankFlag)}" />
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="corresBankNameAndAddress" value="${details?.corresBankNameAndAddress}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt742_popup_btn_account_with_bank">...</a>
		</td>
	</tr>
	
	<tr>
		<td><span class="title_label">58<span class="beneficiaryInstitutionOptionLetter title_label">A</span>: Beneficiary Bank</span></td>
		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCode" id="beneficiaryIdentifierCode" value="${details?.beneficiaryIdentifierCode}"/></td>
	</tr>
<%--	<tr>--%>
<%--		<td valign="top">--%>
<%--			<g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag mt-radio beneficiaryInstitutionOptionA" value="A" checked="${details?.beneficiaryBankFlag == 'A' ? true : false}"/>--%>
<%--			&#160;<span class="field_label">Identifier Code</span>--%>
<%--		</td>--%>
<%--		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCode" id="beneficiaryIdentifierCode" value="${details?.beneficiaryIdentifierCode}"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td valign="top">--%>
<%--			<g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag mt-radio beneficiaryInstitutionOptionD" value="D" checked="${details?.beneficiaryBankFlag == 'D' ? true : false}"/>--%>
<%--			&#160;<span class="field_label">Name and Address</span>--%>
<%--		</td>--%>
<%--		<td valign="top">--%>
<%--			<g:textArea class="fields-textarea textarea" rows="4" name="beneficiaryNameAndAddress" value="${details?.beneficiaryNameAndAddress}" readonly="readonly"></g:textArea>--%>
<%--			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt742_popup_btn_beneficiary_bank">...</a>--%>
<%--		</td>--%>
<%--	</tr>
	<tr>
		<td><span class="field_label title_label">71D: Charges</span></td>
		<td>
			<g:textArea class="textarea" name="chargeNarrative" value="${details?.chargeNarrative}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="742_popup_btn_envelopeContents"> Search/Look-up Button </a>
		</td>
	</tr>  --%>
		
	<tr>
    	<td><span class="field_label title_label">71D: Charges</span></td>
        <td class="input_width"> <g:textArea maxlength="50" class="textarea" name="chargeNarrative" value="${details?.chargeNarrative}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_charge_narrative_mt742">...</a>
		</td>
    </tr>
	<tr>
		<td valign="top"><span class="field_label bold">72Z: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiver" class="newSenderToReceiver" value="${details?.senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformation" readonly="readonly" value="${details?.senderToReceiverInformation}" rows="6"></g:textArea>			
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
	</tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 742" onclick="viewOutgoingMt(742)"/>
			</td>
		</tr>	
	</g:if>
	<tr>
		<td><input type="button" id="saveOutgoingMt" class="input_button" value="Save" /></td>
	</tr>
	<tr>
		<td><input type="button" id="cancelOutgoingMtPopup" class="input_button_negative" value="Cancel" /></td>
	</tr>
</table>

<script>
$(document).ready(function(){
	$("input#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#currency").val()});
	$("input#principalAmountCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#principalAmountCurrency").val()});
	$("input#additionalAmountCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#additionalAmountCurrency").val()});
	$("input#totalAmountCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#totalAmountCurrency").val()});
	$("#issuingBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.issuingBankCode}'});
	$("#corresBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.corresBankCode}'});
	$("#beneficiaryIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.beneficiaryIdentifierCode}'});
	$("#reimbursingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.reimbursingBank}'});
});
</script>