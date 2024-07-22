<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%--<g:javascript src="utilities/other_imports/commons/mt_message_utility.js"/>--%>
<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="messageType" value="103"/>
<g:hiddenField name="chainName" value="viewMT103"/><%--Used for chaining in saveOutgoingMt action--%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for disabling tab/s in basic_details_utility--%>
<%--Needed by select2 utility:--%>
<g:hiddenField name="currencyValue" value="${details?.currency}"/>
<g:hiddenField name="sendersChargesCurrencyValue" value="${details?.senderChargesCurrency}"/>
<g:hiddenField name="receiversChargesCurrencyValue" value="${details?.receiverChargesCurrency}"/>



<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label"> Destination Bank<span class="asterisk">*</span> </span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop" name="destinationBank" id="destinationBank" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label title_label">20: Document Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumber" class="input_field" value="${details?.documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">13C: Time Indication</span></td>
		<td>
			<g:select name="timeIndication" from="${['CLSTIME','RNCTIME','SNDTIME'] }" class="select_dropdown" noSelection="['':'SELECT ONE']" value="${details?.timeIndication}"/>
			<g:textField name="timeIndicationField" class="input_field" value="${details?.timeIndicationField}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 23B: Bank Operation Code <span class="asterisk">*</span> </span></td>
		<td><g:select from="${['CRED','SPAY','SPRI','SSTD']}" noSelection="['':'SELECT ONE']" name="bankOperationCode" class="select_dropdown required" value="${details?.bankOperationCode ?: 'CRED'}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 23E: Instruction Code </span></td>
		<td>
			<g:select from="${['SDVA','INTC','REPA','CORT','HOLP','CHQB','PHOB','TELB','PHON','TELE','PHOI','TELI']}" 
				noSelection="['':'SELECT ONE']" name="instructionCode" class="select_dropdown" value="${details?.instructionCode}" disabled="${details?.bankOperationCode in ['SPAY','SSTD']}"/> 
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>
			<g:textArea class="textarea" name="bankOperationTextArea" value="${details?.bankOperationTextArea}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_instruction_code">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">26T: Transaction Type Code</span></td>
		<td><input class="tags_currency select2_dropdown bigdrop" name="transactionTypeCode" id="transactionTypeCode" value="${details?.transactionTypeCode}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">32A:<span class="asterisk">*</span></span></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Value Date</span></td>
		<td><g:textField name="valueDate" class="datepicker_field" readonly="readonly" value="${details?.valueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Currency</span></td>
		<td><input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" value="${details?.currency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Interbank Settle Amount</span></td>
		<td><g:textField name="swiftAmount" class="input_field_right numericCurrency"  value="${details?.swiftAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">33B: Settlement Currency/<br/>Settlement Amount</span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="currency33b" id="currency33b" value="${details?.currency33b}"/>
			<g:textField name="productAmount33b" class="input_field_right numericCurrency" value="${details?.productAmount33b}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"><span class="field_label title_label">36: Exchange Rate</span></span></td>
		<td><g:textField name="exchangeRate" class="input_field" value="${details?.exchangeRate }"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">50K: Importer Account Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="importerAccountNumber" class="input_field" value="${details?.importerAccountNumber }"/></td>
		
	</tr>
	<tr>
		<td><span class="field_label">Importer Name</span></td>
		<td><g:textField name="importerNameMT103" class="input_field" value="${details?.importerName ?: details?.importerNameMT103 }"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Importer Address</span></td>
		<td><g:textField name="importerAddressMT103" class="input_field" value="${details?.importerAddress ?: details?.importerAddressMT103 }"/></td>
	</tr>	
	<tr>
		<td colspan="2"> <span class="title_label">52<span class="orderingInstitutionMt103OptionLetter title_label"></span>: Ordering Institution </span></td>
	</tr>
<%--	<tr>--%>
<%--		<td><span class="field_label small_margin_left">Party Identifier</span></td>--%>
<%--		<td><g:textField class="input_field" name="orderingInstitutionPartyIdentifier" value="${details?.orderingInstitutionPartyIdentifier}" /></td>--%>
<%--	</tr>--%>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="orderingBankFlag" class="orderingBankFlag" value="A" checked="${'A'.equals(details?.orderingBankFlag)}" />
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="orderInstIdentifierCode" id="orderInstIdentifierCode" value="${details?.orderInstIdentifierCode}"/></td>
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="orderingBankFlag" class="orderingBankFlag" value="D" checked="${'D'.equals(details?.orderingBankFlag)}" />
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="bankNameAndAddress" value="${details?.bankNameAndAddress}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_ordering_bank">...</a> 
		</td>
	</tr>
	<tr>
		<td colspan="2"> <span class="title_label">53<span class="sendersCorrespondentMt103OptionLetter title_label"></span>: Sender's Correspondent <span class="asterisk">*</span> </span></td>
	</tr>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				Party Identifier--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><g:textField class="input_field" name="sendersPartyIdentifier" value="${details?.sendersPartyIdentifier}" /></td>--%>
<%--	</tr>--%>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagA" value="A" checked="${'A'.equals(details?.sendersCorrespondentFlag)}"/>
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" value="${details?.senderIdentifierCode}"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagB" value="B" checked="${'B'.equals(details?.sendersCorrespondentFlag)}"/>
				&#160;&#160;Location
			</span>
		</td>
		<td><g:textField class="input_field" name="senderLocation" value="${details?.senderLocation ?: details?.sendersLocation}"/></td>
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag sendersCorrespondentFlagD" value="D" checked="${'D'.equals(details?.sendersCorrespondentFlag)}"/>
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="senderNameAndAddress" value="${details?.senderNameAndAddress}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"> <span class="title_label">54<span class="receiversCorrespondentMt103OptionLetter title_label"></span>: Receiver's Correspondent </span></td>
	</tr>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				Party Identifier--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><g:textField class="input_field" name="receiverPartyIdentifier" value="${details?.receiverPartyIdentifier}" /></td>--%>
<%--	</tr>--%>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="A" checked="${'A'.equals(details?.receiversCorrespondentFlag)}" />
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="receiverCorrIdentifierCode" id="receiverCorrIdentifierCode" value="${details?.receiverCorrIdentifierCode}"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="B" checked="${'B'.equals(details?.receiversCorrespondentFlag)}" />
				&#160;&#160;Location
			</span>
		</td>
		<td><g:textField class="input_field" name="receiverLocation" value="${details?.receiverLocation}" /></td>
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="D" checked="${'D'.equals(details?.receiversCorrespondentFlag)}" />
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="receiverNameAndAddress" value="${details?.receiverNameAndAddress}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>

	<tr>
		<td><span class="field_label title_label"> 55A: Third Reimbursement Institution </span></td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="thirdReimbursementInstitution" id="thirdReimbursementInstitution" value="${details?.thirdReimbursementInstitution}"/></td>
	</tr>
	<tr>
		<td colspan="2"> <span class="title_label">56<span class="intermediaryMt103OptionLetter title_label"></span>: Intermediary </span></td>
	</tr>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				Party Identifier--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><g:textField class="input_field" name="intermediaryPartyIdentifier" value="${details?.intermediaryPartyIdentifier}" /></td>--%>
<%--	</tr>--%>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="intermediaryFlag" class="intermediaryFlag" value="A" checked="${'A'.equals(details?.intermediaryFlag)}" />
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="intermedIdentifierCode" id="intermedIdentifierCode" value="${details?.intermedIdentifierCode}"/></td>
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="intermediaryFlag" class="intermediaryFlag" value="D" checked="${'D'.equals(details?.intermediaryFlag)}" />
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="intermediaryNameAndAddressMt" value="${details?.intermediaryNameAndAddressMt}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_intermediary">...</a>
		</td>
	</tr>	
<%--	<tr>--%>
<%--		<td colspan="2"> <span class="title_label">57<span class="accountWithInstitutionMt103OptionLetter title_label"></span>: Account with Institution </span></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td>--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="A" checked="${'A'.equals(details?.accountWithBankFlag)}" />--%>
<%--				&#160;&#160;Identifier Code--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td><input class="tags_bank select2_dropdown bigdrop" name="acctWithInstIdentifierCode" id="acctWithInstIdentifierCode" value="${details?.acctWithInstIdentifierCode}"/></td>--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td class="valign_top"> <span class="field_label_indent"> Location </span></td>--%>
<%--		<td><g:textArea class="textarea" name="accountLocation" value="${details?.accountLocation}" rows="2"/></td>	--%>
<%--	</tr>--%>
<%--	<tr>--%>
<%--		<td class="valign_top">--%>
<%--			<span class="field_label small_margin_left">--%>
<%--				<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="D" checked="${'D'.equals(details?.accountWithBankFlag)}" />--%>
<%--				&#160;&#160;Name and Address--%>
<%--			</span>--%>
<%--		</td>--%>
<%--		<td>--%>
<%--			<g:textArea class="textarea" name="accountNameAndAddress" value="${details?.accountNameAndAddress}" rows="4" readonly="readonly"/>--%>
<%--			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_account_with_bank">...</a>--%>
<%--		</td>--%>
<%--	</tr>--%>
	<tr>
		<td colspan="2"> <span class="title_label">57<span class="accountWithInstitutionMt103OptionLetter title_label"></span>: Account with Institution </span></td>
	</tr>
<!-- 	<tr>
		<td>
			<span class="field_label small_margin_left">
				Party Identifier
			</span>
		</td>
		<td><g:textField class="input_field" name="acctWithInstPartyIdentifier" value="${details?.acctWithInstPartyIdentifier}" /></td>
	</tr> -->
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="A" checked="${'A'.equals(details?.accountWithBankFlag)}" />
				&#160;&#160;Identifier Code
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="acctWithInstIdentifierCode" id="acctWithInstIdentifierCode" value="${details?.acctWithInstIdentifierCode ?: details?.accountWithInstitution}"/></td>
	</tr>
	<tr>
		<td>
			<span class="field_label small_margin_left">
				<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${'B'.equals(details?.accountWithBankFlag)}" />
				&#160;&#160;Location
			</span>
		</td>
		<td><g:textField class="input_field" name="accountLocation" value="${details?.accountLocation}"/></td>	
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label small_margin_left">
				<g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="D" checked="${'D'.equals(details?.accountWithBankFlag)}" />
				&#160;&#160;Name and Address
			</span>
		</td>
		<td>
			<g:textArea class="textarea" name="accountNameAndAddress" value="${details?.accountNameAndAddress}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_account_with_bank">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">59: Beneficiary:</span></td>
	</tr>
	<!-- Added Beneficiary Account Number - Bug 3197 -->
	<tr>
		<td><span class="field_label_indent">Account Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="beneficiaryAccountNumber" class="input_field" value="${details?.beneficiaryAccountNumber}" maxlength="34"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent">Beneficiary Name<span class="asterisk">*</span></span></td>
		<td><g:textField name="beneficiaryName" class="input_field" value="${details?.beneficiaryName ?: details?.beneficiaryNameMt103}" maxlength="50"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label_indent">Beneficiary Address<span class="asterisk">*</span></span></td>
		<td>
			<g:textArea class="textarea" name="beneficiaryAddress" value="${details?.beneficiaryAddress ?: details?.beneficiaryAddressMt103}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_beneficiary_bank">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 70: Remittance Information </span></td>
		<td><g:select from="${['INV','RFB','BU','IPI','ROC']}" noSelection="['':'SELECT ONE']" name="remittanceInformation" class="select_dropdown" value="${details?.remittanceInformation ?: 
			(documentNumber?.documentNumber.toString().toUpperCase().contains('IBCP') ? 'RFB' : '')}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
		<g:textArea class="textarea" name="remittanceInformationTextArea" value="${details?.remittanceInformationTextArea ?: 
			(documentNumber?.documentNumber.toString().toUpperCase().contains('IBCP') ? 'PROCEEDS OF DOMESTIC LC\nNEGO UNDER DMLC ' +
				 documentNumber?.documentNumber.toString().replaceAll('-','') : '')}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="mt103_popup_btn_remittanceInformation"> Search/Look-up Button </a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 71A: Details of Charges <span class="asterisk">*</span> </span></td>
		<td><g:select name="detailsOfCharges" value="${details?.detailsOfCharges}" from="${['BEN','OUR','SHA']}" class="select_dropdown required" noSelection="['':'SELECT ONE']"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 71F: Sender's Charges </span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="senderChargesCurrency" id="senderChargesCurrency" />
			<%-- <g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="senderChargesCurrency" class="select_dropdown" value="${senderChargesCurrency}"/> --%>
			<g:textField class="input_field_right numericCurrency" name="senderCharges" value="${details?.senderCharges}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 71G: Receiver's Charges </span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="receiverChargesCurrency" id="receiverChargesCurrency" />
			<%-- <g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="receiverChargesCurrency" class="select_dropdown" value="${receiverChargesCurrency}"/> --%>
			<g:textField class="input_field_right numericCurrency" name="receiverCharges" value="${details?.receiverCharges}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 72: Sender to Receiver Information </span></td>
		<td>
			<tfs:senderToReceiverType2 name="senderToReceiverInformation" value="${details?.senderToReceiverInformation}"/>
		</td>
	</tr>
	<tr>
		<td/>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformationTextArea" value="${details?.senderToReceiverInformationTextArea}" rows="6" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt103_popup_btn_sender_receiver_information"> ... </a>			
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 77B: Regulatory Reporting </span></td>			
		<td><g:select name="regulatoryReporting" value="${details?.regulatoryReporting}" from="${['BENEFRES','ORDRRES']}" class="select_dropdown" noSelection="['':'SELECT ONE']"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="regulatoryReportingTextArea" value="${details?.regulatoryReportingTextArea}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="mt103_popup_btn_regulatoryReporting"> Search/Look-up Button </a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label">77T: Envelope Contents</span></td>
		<td>
            <g:select name="envelopeContents" from="${['ANSI','NARR','SWIF','EUDI'] }" class="select_dropdown" noSelection="['':'SELECT ONE']" value="${details?.envelopeContentsSelect }"/>
        </td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="envelopeContentsTextArea" value="${details?.envelopeContentsTextArea}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="mt103_popup_btn_envelopeContents"> Search/Look-up Button </a>
		</td>
	</tr>
</table>
<br />
	

<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 103" onclick="viewOutgoingMt(103)"/>
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
	var transactionTypeCodeAutoCompleteUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteTransactionTypeCode")}';
	
	$(document).ready(function(){
		$("input#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#currencyValue").val()});
		$("input#currency33b").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#currency33b").val()});
		$("input#senderChargesCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#sendersChargesCurrencyValue").val()});
		$("input#receiverChargesCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#receiversChargesCurrencyValue").val()});
		$("#transactionTypeCode").setTransactionTypeCode($(this).attr("id")).select2('data',{id: $("input#transactionTypeCode").val()});
		$("#orderInstIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.orderInstIdentifierCode}'});
		$("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.destinationBank ?: details?.receivingBank ?: details?.reimbursingBank}'});
		$("#senderIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.senderIdentifierCode}'});
		$("#receiverCorrIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.receiverCorrIdentifierCode}'});
		$("#thirdReimbursementInstitution").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.thirdReimbursementInstitution}'});
		$("#intermedIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.intermedIdentifierCode}'});
		$("#acctWithInstIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.acctWithInstIdentifierCode}'});
	});
</script>