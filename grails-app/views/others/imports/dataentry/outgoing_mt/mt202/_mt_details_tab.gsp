<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="messageType" value="202"/>
<g:hiddenField name="chainName" value="viewMT202"/><%--Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for disabling tab/s in basic_details_utility--%>
<%--Needed by select2 utility:--%>
<g:hiddenField name="currencyValue" value="${details?.currency}"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label">Reimbursing Bank <span class="asterisk">*</span></span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop required" name="reimbursingBank" id="reimbursingBank" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${details?.documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">21: Negotiating Bank's <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reference Number <span class="asterisk">*</span> </span></td>
		<td>
            <g:textField class="input_field required" id="negotiatingBanksReferenceNumber" name="negotiatingBanksReferenceNumber" value="${details?.negotiatingBanksReferenceNumber}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label title_label">32A:<span class="asterisk">*</span></span></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Value Date</span></td>
		<td><g:textField name="valueDateMt202" class="datepicker_field" readonly="readonly" value="${details?.valueDateMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Currency</span></td>
		<td><input class="tags_currency select2_dropdown bigdrop" name="lcCurrencyMt202" id="lcCurrencyMt202" value="${details?.lcCurrencyMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Net Amount</span></td>
		<td><g:textField name="netAmountMt202" class="input_field_right numericCurrency"  value="${details?.netAmountMt202}"/></td>
	</tr>
	<tr>
		<td class="spacer" colspan="4">&#160;</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">52<span class="orderingBankFlagMt202Mt752202OptionLetter title_label">a</span>: Ordering Institution <span class="asterisk">*</span></span></td>
	</tr>
	<tr>
		<td>
			<g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202 mt-radio orderInstitutionOptionA" value="A" checked="${details?.orderingBankFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt202" id="bankIdentifierCodeMt202" value="${details?.bankIdentifierCodeMt202}" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202 mt-radio orderInstitutionOptionD" value="D" checked="${details?.orderingBankFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>	
		</td>
		<td><g:textArea class="fields-textarea textarea" rows="4" name="bankNameAndAddressMt202" value="${details?.bankNameAndAddressMt202}" readonly="readonly"></g:textArea><%--</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
		<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_ordering_bank">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">53<span class="sendersCorrespondentFlagMt202Mt752202OptionLetter title_label">a</span>: Sender's Correspondent</span></td>
	</tr>
	<tr>
		<td class="label_width">
			<g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202 mt-radio senderCorrespondentOptionA" value="A"  checked="${details?.sendersCorrespondentFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3" class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt202" id="senderIdentifierCodeMt202" value="${details?.senderIdentifierCodeMt202}"/></td>
	</tr>
	<tr>
		<td>
			<g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202 mt-radio senderCorrespondentOptionB" value="B"  checked="${details?.sendersCorrespondentFlagMt202 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="senderPartyIdentifierMt202" value="${details?.senderPartyIdentifierMt202 ?: details?.reimbursingBankAccountNumber}" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202 mt-radio senderCorrespondentOptionD" value="D" checked="${details?.sendersCorrespondentFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td><g:textArea class="fields-textarea textarea" name="senderNameAndAddressMt202" value="${details?.senderNameAndAddressMt202}" rows="4" readonly="readonly"></g:textArea><%--</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
		<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">54<span class="receiversCorrespondentFlagMt202Mt752202OptionLetter title_label">a</span>: Receiver's Correspondent</span></td>
	</tr>
	<tr>	
		<td class="label_width">
			<g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202 mt-radio receiverCorrespondentOptionA" value="A" checked="${details?.receiversCorrespondentFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt202" id="receiverIdentifierCodeMt202" value="${details?.receiverIdentifierCodeMt202}" /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202 mt-radio receiverCorrespondentOptionB" value="B"  checked="${details?.receiversCorrespondentFlagMt202 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="receiverPartyIdentifierMt202" value="${details?.receiverPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea class="textarea" name="receiverLocationMt202" value="${details?.receiverLocationMt202}" rows="4"/></td>
	</tr>
	<tr>	
		<td valign="top">
			<g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202 mt-radio receiverCorrespondentOptionD" value="D" checked="${details?.receiversCorrespondentFlagMt202 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="receiverNameAndAddressMt202" value="${details?.receiverNameAndAddressMt202}" rows="4" readonly="readonly"></g:textArea>
		<%--
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">56<span class="intermediaryMt202OptionLetter title_label">a</span>: Intermediary</span></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202 mt-radio intermediaryOptionA" value="A" checked="${details?.intermediaryFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCodeMt202" id="intermediaryIdentifierCodeMt202" value="${details?.intermediaryIdentifierCodeMt202}" /></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202 mt-radio intermediaryOptionD" value="D" checked="${details?.intermediaryFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td valign="top"><g:textArea class="fields-textarea textarea" rows="4" name="intermediaryNameAndAddressMt202" value="${details?.intermediaryNameAndAddressMt202}" readonly="readonly"></g:textArea>
		<%--
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
		<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_intermediary">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label"> 57<span class="accountWithInstitutionMt202OptionLetter title_label">a</span>: Account with Institution</span></td>
	</tr>
	<tr>
		<td>
			<g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202 mt-radio acctInstitutionOptionA" value="A" checked="${details?.accountWithBankFlagMt202 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt202" id="accountIdentifierCodeMt202" value="${details?.accountIdentifierCodeMt202}" /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202 mt-radio acctInstitutionOptionB" value="B"  checked="${details?.accountWithBankFlagMt202 == 'B' ? true : false}"/>
			&#160;<span class="field_label">Party Identifier</span>	
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="accountWithBankIdentifierMt202" value="${details?.accountWithBankIdentifierMt202}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea class="fields-textarea textarea" name="accountWithBankLocationMt202" value="${details?.accountWithBankLocationMt202}" rows="4"/></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202 mt-radio acctInstitutionOptionD" value="D" checked="${details?.accountWithBankFlagMt202 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td><g:textArea class="fields-textarea textarea" rows="4" name="accountNameAndAddressMt202"  value="${details?.accountNameAndAddressMt202}" readonly="readonly"></g:textArea>
		<%--
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
		<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_account_with_bank">...</a>
		</td>	
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">58<span class="beneficiaryInstitutionMt202OptionLetter title_label">a</span>: Beneficiary Bank<span class="asterisk">*</span></span></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202 mt-radio beneficiaryInstitutionOptionA" value="A" checked="${details?.beneficiaryBankFlagMt202 == 'A' ? true : false}"/>
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td valign="top" colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt202" id="beneficiaryIdentifierCodeMt202" value="${details?.beneficiaryIdentifierCodeMt202}"/></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202 mt-radio beneficiaryInstitutionOptionD" value="D" checked="${details?.beneficiaryBankFlagMt202 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td valign="top">
			<g:textArea class="fields-textarea textarea" rows="4" name="beneficiaryNameAndAddressMt202" value="${details?.beneficiaryNameAndAddressMt202}" readonly="readonly"></g:textArea>
		<%--
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_beneficiary_bank">...</a>
		</td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label bold">72: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiverMt202" value="${details?.senderToReceiverMt202}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformationMt202" readonly="readonly" value="${details?.senderToReceiverInformationMt202}" rows="6"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id=mt202_popup_btn_sender_receiver_information>...</a>
		</td>
	</tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 202" onclick="viewOutgoingMt(202)"/>
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
		$("input#lcCurrencyMt202").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#lcCurrencyMt202").val()});
		$("#bankIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.bankIdentifierCodeMt202}'});
		$("#senderIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.senderIdentifierCodeMt202}'});
		$("#receiverIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.receiverIdentifierCodeMt202}'});
		$("#intermediaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.intermediaryIdentifierCodeMt202}'});
		$("#accountIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.accountIdentifierCodeMt202}'});
		$("#beneficiaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.beneficiaryIdentifierCodeMt202}'});
		$("#reimbursingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.reimbursingBank}'});
	});
</script>