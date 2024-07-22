<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt400" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<script type="text/javascript">
var sendersCorrespondentFlagMt400 = "${sendersCorrespondentFlagMt400}";
var orderingBankFlagMt400 = "${orderingBankFlagMt400}";
<%--var receiversCorrespondentFlag = "${receiversCorrespondentFlag}";--%>
var receiversCorrespondentFlagMt400 = "${receiversCorrespondentFlagMt400}";
var intermediaryFlagMt400 = "${intermediaryFlagMt400}";
var accountWithBankFlagMt400 = "${accountWithBankFlagMt400}";
var beneficiaryBankFlagMt400 = "${beneficiaryBankFlagMt400}";
$(document).ready(function() {
    $("#senderIdentifierCodeMt400").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt400 ?: !('B'.equals(sendersCorrespondentFlagMt400) && 'D'.equals(sendersCorrespondentFlagMt400)) ? reimbursingBank : ''}'});
    $("#bankIdentifierCodeMt400").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCodeMt400}'});
<%--    $("#receiverIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCode}'});--%>
	$("#receiverIdentifierCodeMt400").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt400}'});
    $("#intermediaryIdentifierCodeMt400").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCodeMt400}'});
    $("#accountIdentifierCodeMt400").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCodeMt400}'});
    $("#beneficiaryIdentifierCodeMt400").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCodeMt400 ?: remittingBank}'});
});
</script>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumberMT103" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> 21: Remitting Bank (Ref Number) </span></td>
		<td><g:textField class="input_field" name="remittingBankRefNumber" value="${remittingBankReferenceNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> 32a: Amount Collected </span></td>
		<td>
		  <g:textField class="input_field" name="tsDate400" value="${etsDate}" readonly="readonly"/>
		  <g:textField class="input_field_short" name="settlementCurrency400" value="${currency}" readonly="readonly"/>
		  <g:textField class="input_field_right numericCurrency" name="settlementAmount400" value="${productAmount}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> 33A: Proceeds Remitted </span></td>
		<td>
		  <g:textField class="input_field" name="tsDate400_A" value="${etsDate}" readonly="readonly"/>
		  <g:textField class="input_field_short" name="settlementCurrency400_A" value="${currency}" readonly="readonly"/>
		  <g:textField class="input_field_right numericCurrency" name="settlementAmount400_A" value="${productAmount}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">52<span class="orderingBankMt400OptionLetter title_label"></span>: Ordering Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="orderingBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt400" class="orderingBankFlagMt400" value="A" checked="${'A'.equals(orderingBankFlagMt400)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="bankIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt400" id="bankIdentifierCodeMt400" value="${bankIdentifierCodeMt400}"/>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt400" class="orderingBankFlagMt400" value="D" checked="${'D'.equals(orderingBankFlagMt400)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="bankNameAndAddressMt400" value="${bankNameAndAddressMt400}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_ordering_bankMt400">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">53<span class="sendersCorrespondentMt400OptionLetter title_label"></span>: Sender's Correspondent </span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="senderCorrespondent" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt400" class="sendersCorrespondentFlagMt400" value="A" checked="${!('B'.equals(sendersCorrespondentFlagMt400) && 'D'.equals(sendersCorrespondentFlagMt400))}"/>&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="senderIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt400" id="senderIdentifierCodeMt400" value="${senderIdentifierCodeMt400}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt400" class="sendersCorrespondentFlagMt400" value="B" checked="${'B'.equals(sendersCorrespondentFlagMt400)}"/>&#160;&#160;Party Identifier</span></td>
		<td><g:textField class="input_field" name="senderPartyIdentifierMt400" value="${senderPartyIdentifierMt400}"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label_indent2"> Location </span></td>
		<td><g:textArea class="textarea" name="senderLocationMt400" value="${senderLocationMt400}" rows="2"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt400" class="sendersCorrespondentFlagMt400" value="D" checked="${'D'.equals(sendersCorrespondentFlagMt400)}"/>&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="senderNameAndAddressMt400" value="${senderNameAndAddressMt400}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_sender_correspondentMt400">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">54<span class="receiversCorrespondentMt400OptionLetter title_label"></span>: Receiver's Correspondent</span></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt400" class="receiversCorrespondentFlagMt400" value="A" checked="${'A'.equals(receiversCorrespondentFlagMt400)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt400" id="receiverIdentifierCodeMt400" value="${receiverIdentifierCodeMt400}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt400" class="receiversCorrespondentFlagMt400" value="B" checked="${'B'.equals(receiversCorrespondentFlagMt400)}" />&#160;&#160;Party Identifier</span></td>
		<td><g:textField class="input_field" name="receiver400PartyIdentifierMt400" value="${receiver400PartyIdentifierMt400}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label_indent2"> Location </span></td>
		<td><g:textArea class="textarea" name="receiverLocationMt400" value="${receiverLocationMt400}" rows="2"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt400" class="receiversCorrespondentFlagMt400" value="D" checked="${'D'.equals(receiversCorrespondentFlagMt400)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="receiverNameAndAddressMt400" value="${receiverNameAndAddressMt400}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_receiver_correspondent_mt400">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="title_label">57<span class="accountWithBankMt400OptionLetter title_label"></span>: Account with Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="accountWithBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt400" class="accountWithBankFlagMt400" value="A" checked="${'A'.equals(accountWithBankFlagMt400)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="accountIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt400" id="accountIdentifierCodeMt400" value="${accountIdentifierCodeMt400}"/>
		</td>
	</tr>
	<%--<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${accountWithBankFlag.equals('B')}" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="accountLocation" value="${accountLocation}"/></td>
	</tr>--%>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt400" class="accountWithBankFlagMt400" value="D" checked="${'D'.equals(accountWithBankFlagMt400)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="accountNameAndAddressMt400" value="${accountNameAndAddressMt400}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_account_with_bankMt400">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="title_label">58<span class="beneficiaryBankMt400OptionLetter title_label"></span>: Beneficiary Bank </span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="beneficiaryBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlagMt400" class="beneficiaryBankFlagMt400" value="A" checked="${'A'.equals(beneficiaryBankFlagMt400)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="beneficiaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt400" id="beneficiaryIdentifierCodeMt400" value="${beneficiaryIdentifierCodeMt400 ?: remittingBank}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlagMt400" class="beneficiaryBankFlagMt400" value="B" checked="${'B'.equals(beneficiaryBankFlagMt400)}"/>&#160;&#160;Location</span></td>
		<td>
			<g:textField class="input_field" name="beneficiaryBankLocationMt400" value="${beneficiaryBankLocationMt400}"/>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlagMt400" class="beneficiaryBankFlagMt400" value="D" checked="${'D'.equals(beneficiaryBankFlagMt400)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea  " name="beneficiaryNameAndAddressMt400" value="${beneficiaryNameAndAddressMt400}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_beneficiary_bankMt400">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">71B: Details of Charges</span></td>
<%--		<td><g:select from="${['BEN','OUR','SHA']}" noSelection="['':'SELECT ONE']" name="detailsOfCharges" class="select_dropdown" value="${detailsOfCharges}"/></td>--%>
		<%-- <td>
			<g:textArea class="textarea" name="detailsOfChargesMt400" readonly="readonly" value="${detailsOfChargesMt400}" rows="4"/>
			<input type="button" class="popup_btn_bottom" id="details_chargesMt400">		
		</td> --%>
		<td>
			<g:select from="${['AGENT','COMM','CORCOM','DISK','INSUR','POST','STAMP','TELECHAR','WAREHOUS']}" noSelection="['':'SELECT ONE']" name="detailsOfChargesDescriptionMt400" class="select_dropdown" value="${detailsOfChargesDescriptionMt400}"/>
			<g:textField class="input_field" name="detailsOfChargesCurrencyMt400" value="${currency}"  readonly="readonly"/>
			<%-- <g:select from="" noSelection="['':'SELECT ONE']" name="detailsOfChargesCurrencyMt400" class="select_dropdown" value="${currency}"/> --%>
			<g:textField class="input_field_right numericCurrency" name="detailsOfChargesTextFieldMt400" value="${detailsOfChargesTextFieldMt400}"/>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><g:textArea class="textarea" name="detailsOfChargesTextAreaMt400" value="${detailsOfChargesTextAreaMt400}" rows="4"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label bold">72: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiverMt400" value="${senderToReceiverMt400}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformationMt400" readonly="readonly" value="${senderToReceiverInformationMt400}" rows="6"/>
			<a href="javascript:void(0)" class="search_btn" id="sender_infoMt400">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">73: Details of Amount Added</span></td>
		<td>
			<g:select from="${['INTEREST','RETCOMM','YOURCHAR']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountDescriptionMt400" class="select_dropdown" value="${detailsOfAmountDescriptionMt400}"/>
			<g:textField class="input_field" name="detailsOfAmountCurrencyMt400" value="${currency}" readonly="readonly"/>
			<%-- <g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountCurrencyMt400" class="select_dropdown" value="${detailsOfAmountCurrencyMt400}"/>  --%>
			<g:textField class="input_field_right numericCurrency" name="detailsOfAmountTextFieldMt400" value="${detailsOfAmountTextFieldMt400}"/>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><g:textArea class="textarea" name="detailsOfAmountTextAreaMt400" value="${detailsOfAmountTextAreaMt400}" rows="4"/></td>
	</tr>
	
	<%--<tr>
		<td><span class="field_label">Receiver's Correspondent</span></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="A" checked="${receiversCorrespondentFlag.equals('A')}" />&#160;&#160;Identifier Code</span></td>
		<td>
			 <g:textField class="input_field" name="receiverIdentifierCode" /> 
			
			 Auto Complete 
			<input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCode" id="receiverIdentifierCode" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="B" checked="${receiversCorrespondentFlag.equals('B')}" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="receiverLocation" value="${receiverLocation}" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlag" class="receiversCorrespondentFlag" value="D" checked="${receiversCorrespondentFlag.equals('D')}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="receiverNameAndAddress" value="${receiverNameAndAddress}"/></td>
	</tr>--%>
	
	
</table>
<br/><br/>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 400" onclick="goToViewMt(400)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<%--<g:render template="../commons/popups/sender_receiver_popup"/>--%>
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'details_charges_popup',
		 closeTextAreaBtnPopup: 'details_charges_close',
		 textAreaHeader: 'Details of Charges',
		 textAreaName: 'detailsOfChargesComment',
		 saveTextAreaBtnPopupId: 'detailsOfChargesPopupSave',
		 saveTextAreaBtnPopup: 'details_charges_save',
		 textAreaPopupbg: 'details_charges_bg',
		 textAreaScript:'popups/details_charges_utility.js']}" />
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'sender_receiver_mt400_popup',
		 closeTextAreaBtnPopup: 'sender_receiver_mt400_close',
		 textAreaHeader: 'Sender to Receiver Information',
		 textAreaName: 'senderToReceiverInformationMt400Comment',
		 remainCharsTextArea: 'remainingCharacterSenderToReceiverMt400',
		 remainLinesTextArea: 'remainingLineSenderToReceiverMt400',
		 saveTextAreaBtnPopupId: 'senderToReceiverInformationMt400PopupSave',
		 saveTextAreaBtnPopup: 'sender_receiver_mt400_save',
		 textAreaPopupbg: 'sender_receiver_mt400_bg',
		 textAreaScript:'popups/sender_receiver_mt400_popup.js']}" />
