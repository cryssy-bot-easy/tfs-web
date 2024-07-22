<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/dataentry/incoming_mt/mt202/mt_202_utility.js" />
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/ordering_institution.js" />--%>
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/sender_correspondent.js" />--%>
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/receiver_correspondent.js" />--%>
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/intermediary.js" />--%>
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/account_institution.js" />--%>
<%--<g:javascript src="utilities/dataentry/incoming_mt/202/beneficiary_institution.js" />--%>

<g:javascript src="utilities/dataentry/incoming_mt/mt202/mt202_popup.js" />
<%-- Auto Complete --%>
<%--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--%>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="mt752mt202" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:hiddenField name="discrepancyAmount" value="${discrepancyAmount}"/>

<table class="tabs_forms_table">
	<g:if test="${documentClass != 'CORRES_CHARGE'}">
		<tr>
			<td><span class="field_label">Negotiating Bank <span class="asterisk">*</span></span></td>
			<td>
				<g:if test="${serviceType.equalsIgnoreCase('UA LOAN SETTLEMENT')}">
					<input class="tags_bank select2_dropdown bigdrop required" name="negotiatingBankMt202" id="negotiatingBankMt202" />
				</g:if>
				<g:else>
		            <g:textField class="input_field required" name="negotiatingBankMt202" value="${negotiatingBankMt202 ?: negotiatingBank}" readonly="readonly" />
				</g:else>
	        </td>
		</tr>
	</g:if>
	<tr>
		<td><span class="field_label">Reimbursing Bank <span class="asterisk">*</span></span></td>
		<td>
			<g:textField class="input_field required" name="reimbursingBankMt202" value="${reimbursingBankMt202 ?: (reimbursingBank ?: corresBankCode)}" readonly="readonly" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumberMT202" value="${documentNumberMT202 ?: (lcNumber ?: documentNumber)}" readonly="readonly"/></td>
	</tr>
	<tr>
		<g:if test="${referenceType == 'DATA_ENTRY' && documentClass == 'CORRES_CHARGE' && remitCorresCharges == 'Y'}">
			<td><span class="field_label">21: Remitting Bank's <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reference Number <span class="asterisk">*</span> </span></td>
		</g:if>
		<g:else>
			<td><span class="field_label">21: Negotiating Bank's <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reference Number <span class="asterisk">*</span> </span></td>
		</g:else>
		<td>
            <g:textField class="input_field required" id="negotiatingBanksReferenceNumberMt202" name="negotiatingBanksReferenceNumberMt202" value="${negotiatingBanksReferenceNumberMt202 ?: 
				(negotiatingBanksReferenceNumber?.toString()?.size() > 16 ? negotiatingBanksReferenceNumber.toString().substring(0, 16) : 
				(negotiatingBanksReferenceNumber ?: depositoryAccountNumber))}" maxlength="16"/>
        </td>
	</tr>
	<tr>
		<g:if test="${referenceType == 'DATA_ENTRY' && documentClass == 'CORRES_CHARGE' && remitCorresCharges == 'Y'}">
			<td class="input_width"><span class="field_label">32A: TS Date/Settlement Currency/ <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Settlement Amount</span></td>
		</g:if>
		<g:else>
			<td class="input_width"><span class="field_label">32A: Value Date/LC Currency/ <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Net Amount</span></td>
		</g:else>
		<td>
			<g:textField name="valueDateMt202" class="input_field" readonly="readonly" value="${valueDateMt202 ?: (etsDate ?: DateUtils.shortDateFormat(new Date()))}"/>
			<g:textField name="lcCurrencyMt202" class="input_field_short" readonly="readonly" value="${lcCurrencyMt202 ?: (negotiationCurrency ?: currency)}"/>
			<g:textField name="netAmountMt202" class="input_field_right numericCurrency" readonly="readonly" value="${netAmountMt202 ?: (negotiationAmount ?: amount)}"/>
		</td>
	</tr>
	<tr>
		<td class="spacer" colspan="4">&#160;</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">52<span class="orderingBankFlagMt202Mt752202OptionLetter title_label">a</span>: Ordering Institution <span class="asterisk">*</span></span></td>
	</tr>
	<!-- <tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="orderingBankPartyIdentifierMt202" value="${orderingBankPartyIdentifierMt202}"/></td>
	</tr> -->
	<tr>
		<td>
			<g:radio name="orderingBankFlagMt202" class="mt-radio orderInstitutionOptionA" value="A" checked="${orderingBankFlagMt202 != null ? (orderingBankFlagMt202 == 'A' ? true : false) : 'true'}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt202" id="bankIdentifierCodeMt202" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="orderingBankFlagMt202" class="mt-radio orderInstitutionOptionD" value="D" checked="${orderingBankFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>	
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" rows="4" name="bankNameAndAddressMt202" value="${bankNameAndAddressMt202}" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_ordering_bank">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">53<span class="sendersCorrespondentFlagMt202Mt752202OptionLetter title_label">a</span>: Sender's Correspondent</span></td>
	</tr>
	<!-- <tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="senderPartyIdentifierMt202" value="${senderPartyIdentifierMt202}"/></td>
	</tr> -->
	<tr>
		<td class="label_width">
			<g:radio name="sendersCorrespondentFlagMt202" class="mt-radio senderCorrespondentOptionA" value="A"  checked="${(sendersCorrespondentFlagMt202 == 'A' || ((sendersCorrespondentFlagMt202 == null || sendersCorrespondentFlagMt202 == '') && reimbursingBank != null)) ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3" class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt202" id="senderIdentifierCodeMt202"/></td>
	</tr>
	<tr>
		<td>
			<g:radio name="sendersCorrespondentFlagMt202" class="mt-radio senderCorrespondentOptionB" value="B"  checked="${sendersCorrespondentFlagMt202 == 'B' ? true : false}" />
			&#160;<span class="field_label">Location</span>
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="senderLocationMt202" value="${senderLocationMt202}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="sendersCorrespondentFlagMt202" class="mt-radio senderCorrespondentOptionD" value="D" checked="${sendersCorrespondentFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="senderNameAndAddressMt202" value="${senderNameAndAddressMt202}" rows="4" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">54<span class="receiversCorrespondentFlagMt202Mt752202OptionLetter title_label">a</span>: Receiver's Correspondent</span></td>
	</tr>
	<!--<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="fields-textarea input_field" name="receiverPartyIdentifierMt202" value="${receiverPartyIdentifierMt202}"/></td>
	</tr>-->
	<tr>	
		<td class="label_width">
			<g:radio name="receiversCorrespondentFlagMt202" class="mt-radio receiverCorrespondentOptionA" value="A" checked="${receiversCorrespondentFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt202" id="receiverIdentifierCodeMt202" /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="receiversCorrespondentFlagMt202" class="mt-radio receiverCorrespondentOptionB" value="B"  checked="${receiversCorrespondentFlagMt202 == 'B' ? true : false}" />
			&#160;<span class="field_label">Location</span>
		</td>
		<td><g:textField class="fields-textarea input_field" name="receiverLocationMt202" value="${receiverLocationMt202}"/></td>
	</tr>
	<tr>	
		<td valign="top">
			<g:radio name="receiversCorrespondentFlagMt202" class="mt-radio receiverCorrespondentOptionD" value="D" checked="${receiversCorrespondentFlagMt202 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="receiverNameAndAddressMt202" value="${receiverNameAndAddressMt202}" rows="4" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">56<span class="intermediaryMt202OptionLetter title_label">a</span>: Intermediary</span></td>
	</tr>
	<!-- <tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="intermediaryPartyIdentifierMt202" value="${intermediaryPartyIdentifierMt202}"/></td>
	</tr> -->
	<tr>
		<td valign="top">
			<g:radio name="intermediaryFlagMt202" class="mt-radio intermediaryOptionA" value="A" checked="${intermediaryFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCodeMt202" id="intermediaryIdentifierCodeMt202"  /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="intermediaryFlagMt202" class="mt-radio intermediaryOptionD" value="D" checked="${intermediaryFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
			<td valign="top"><g:textArea class="fields-textarea textarea" rows="4" name="intermediaryNameAndAddressMt202" value="${intermediaryNameAndAddressMt202}" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_intermediary">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label"> 57<span class="accountWithInstitutionMt202OptionLetter title_label">a</span>: Account with Institution</span></td>
	</tr>
	<!-- <tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="accountPartyIdentifierMt202" value="${accountPartyIdentifierMt202}"/></td>
	</tr> -->
	<tr>
		<td>
			<g:radio name="accountWithBankFlagMt202" class="mt-radio acctInstitutionOptionA" value="A" checked="${accountWithBankFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt202" id="accountIdentifierCodeMt202"  /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="accountWithBankFlagMt202" class="mt-radio acctInstitutionOptionB" value="B"  checked="${accountWithBankFlagMt202 == 'B' ? true : false}"/>
			&#160;<span class="field_label">Location</span>	
		</td>
		<td><g:textField class="fields-textarea input_field" name="accountWithBankLocationMt202" value="${accountWithBankLocationMt202}" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="accountWithBankFlagMt202" class="mt-radio acctInstitutionOptionD" value="D" checked="${accountWithBankFlagMt202 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
			<td><g:textArea class="fields-textarea textarea" rows="4" name="accountNameAndAddressMt202"  value="${accountNameAndAddressMt202}" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_account_with_bank">...</a>
		</td>	
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">58<span class="beneficiaryInstitutionMt202OptionLetter title_label">a</span>: Beneficiary Bank<span class="asterisk">*</span></span></td>
	</tr>
	<!-- <tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="beneficiaryPartyIdentifierMt202" value="${beneficiaryPartyIdentifierMt202}"/></td>
	</tr> -->
	<tr>
		<td valign="top">
			<g:radio name="beneficiaryBankFlagMt202" class="mt-radio beneficiaryInstitutionOptionA" value="A" checked="${beneficiaryBankFlagMt202 != null ? (beneficiaryBankFlagMt202 == 'A' ? true : false) : 'true'}"/>
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt202" id="beneficiaryIdentifierCodeMt202" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="beneficiaryBankFlagMt202" class="mt-radio beneficiaryInstitutionOptionD" value="D" checked="${beneficiaryBankFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td valign="top">
			<g:textArea class="fields-textarea textarea" rows="4" name="beneficiaryNameAndAddressMt202" value="${beneficiaryNameAndAddressMt202}" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_beneficiary_bank">...</a>
		</td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label bold">72: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiverMt202" value="${senderToReceiverMt202}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformationMt202" readonly="readonly" value="${senderToReceiverInformationMt202}" rows="6"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id=mt202_popup_btn_sender_receiver_information>...</a>
		</td>
	</tr>
</table>
<br />

<g:if test="${referenceType == 'DATA_ENTRY' && documentClass == 'CORRES_CHARGE' && remitCorresCharges == 'Y'}">
	<table class="buttons_for_grid_wrapper">
	    <tr>
	        <td>
	            <input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
	        </td>
	    </tr>
	
	    <tr>
	        <td><input type="button" id="saveConfirmMt202" class="input_button" value="Save" /></td>
	    </tr>
	    <tr>
	        <td><input type="button" id="cancelConfirmMt202" class="input_button_negative" value="Cancel" /></td>
	    </tr>
	</table>
</g:if>
<g:else>
	<table class="buttons_for_grid_wrapper">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
			</td>
		</tr>	
	</table>
	<g:render template="../layouts/buttons_for_grid_wrapper" />
</g:else>
<g:render template="../commons/popups/mt202_popup" />

		 
<script>
	$(document).ready(function() {
	    $("#bankIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCodeMt202 ?: "${grailsApplication.config.tfs.constants.sender.address + grailsApplication.config.tfs.constants.sender.suffix}"}'});
		$("#senderIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt202 ?: reimbursingBank}'});
        $("#receiverIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt202}'});
        $("#intermediaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCodeMt202}'});
        $("#accountIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCodeMt202}'});
        $("#beneficiaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCodeMt202 ?: negotiatingBank}'});

    	if(typeof serviceType !== 'undefined' && serviceType.toUpperCase() == 'UA LOAN SETTLEMENT'){
    		$("#negotiatingBanksReferenceNumberMt202").removeAttr("readonly");
    		$("#negotiatingBanksReferenceNumberMt202").attr("maxlength","16");

    		$("#negotiatingBankMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiatingBankMt202 ?: negotiatingBank}'});
    	}
	});
</script>

