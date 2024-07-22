<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt400_202Details" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<script type="text/javascript">
var sendersCorrespondentFlag = "${sendersCorrespondentFlag}";
var orderingBankFlag = "${orderingBankFlag}";
<%--var receiversCorrespondentFlag = "${receiversCorrespondentFlag}";--%>
var receiversCorrespondentMt202Flag = "${receiversCorrespondentMt202Flag}";
var receiversCorrespondentMt400Flag = "${receiversCorrespondentMt400Flag}";
var intermediaryFlag = "${intermediaryFlag}";
var accountWithBankFlag = "${accountWithBankFlag}";
var beneficiaryBankFlag = "${beneficiaryBankFlag}";
$(document).ready(function() {
    $("#senderIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCode}'});
    $("#bankIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCode}'});
<%--    $("#receiverIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCode}'});--%>
	$("#receiverMt202IdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverMt202IdentifierCode}'});
	$("#receiverMt400IdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverMt400IdentifierCode}'});
    $("#intermediaryIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCode}'});
    $("#accountIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCode}'});
    $("#beneficiaryIdentifierCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCode}'});



    $("#senderIdentifierCode").change(function() {
        if ($("#senderIdentifierCode").val() != "") {
            $("#sendersCorrespondentComplete").val(true);
        }
    });

    $("#senderLocation").change(function() {
        if ($("#senderLocation").val() != "") {
            $("#sendersCorrespondentComplete").val(true);
        } else {
            $("#sendersCorrespondentComplete").val("");
        }
    });

    $("#senderNameAndAddress").change(function() {
        if ($("#senderNameAndAddress").val() != "") {
            $("#sendersCorrespondentComplete").val(true);
        } else {
            $("#sendersCorrespondentComplete").val("");
        }
    });

    $("#beneficiaryIdentifierCode").change(function() {
        if ($("#beneficiaryIdentifierCode").val() != "") {
            $("#beneficiaryComplete").val(true);
        }
    });

    $("#beneficiaryNameAndAddress").change(function() {
        if ($("#beneficiaryNameAndAddress").val() != "") {
            $("#beneficiaryComplete").val(true);
        } else {
            $("#beneficiaryComplete").val("");
        }
    });
});
</script>
<g:hiddenField name="sendersCorrespondentComplete" class="required" id="sendersCorrespondentComplete" value="${sendersCorrespondentComplete}"/>
<g:hiddenField name="beneficiaryComplete" class="required" id="beneficiaryComplete" value="${beneficiaryComplete}"/>

<table class="tabs_forms_table">
	<tr>
		<td colspan="2"><span class="title_label">Sender's Correspondent<span class="asterisk">*</span></span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="senderCorrespondent" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="A" checked="${'A'.equals(sendersCorrespondentFlag)}"/>&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="senderIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCode" id="senderIdentifierCode" value="${senderIdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="B" checked="${'B'.equals(sendersCorrespondentFlag)}"/>&#160;&#160;Party Identifier</span></td>
		<td><g:textField class="input_field" name="senderPartyIdentifier" value="${senderPartyIdentifier}"/></td>
	</tr>
	<tr>
		<td><span class="field_label_indent2"> Location </span></td>
		<td><g:textField class="input_field" name="senderLocation" value="${senderLocation}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlag" class="sendersCorrespondentFlag" value="D" checked="${'D'.equals(sendersCorrespondentFlag)}"/>&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="senderNameAndAddress" value="${senderNameAndAddress}" readonly="readonly" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
    
	<tr>
		<td valign="top"><span class="field_label bold">72: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverType1 name="senderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformation" readonly="readonly" value="${senderToReceiverInformation}" rows="6"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id=_popup_btn_sender_receiver_information>...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">Ordering Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="orderingBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlag" class="orderingBankFlag" value="A" checked="${'A'.equals(orderingBankFlag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="bankIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCode" id="bankIdentifierCode" value="${bankIdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlag" class="orderingBankFlag" value="D" checked="${'D'.equals(orderingBankFlag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="bankNameAndAddress" value="${bankNameAndAddress}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_ordering_bank">...</a>
		</td>
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
	<tr>
		<td colspan="2"><span class="title_label">Receiver's Correspondent (MT202)</span></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt202Flag" class="receiversCorrespondentMt202Flag" value="A" checked="${'A'.equals(receiversCorrespondentMt202Flag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="receiverMt202IdentifierCode" id="receiverMt202IdentifierCode" value="${receiverMt202IdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt202Flag" class="receiversCorrespondentMt202Flag" value="B" checked="${'B'.equals(receiversCorrespondentMt202Flag)}" />&#160;&#160;Party Identifier</span></td>
		<td><g:textField class="input_field" name="receiver202PartyIdentifier" value="${receiver202PartyIdentifier}" /></td>
	</tr>
	<tr>
		<td><span class="field_label_indent2"> Location </span></td>
		<td><g:textField class="input_field" name="receiverMt202Location" value="${receiverMt202Location}" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt202Flag" class="receiversCorrespondentMt202Flag" value="D" checked="${'D'.equals(receiversCorrespondentMt202Flag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="receiverMt202NameAndAddress" value="${receiverMt202NameAndAddress}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_receiver_correspondent_mt202">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">Receiver's Correspondent (MT400)</span></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt400Flag" class="receiversCorrespondentMt400Flag" value="A" checked="${'A'.equals(receiversCorrespondentMt400Flag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="receiverMt400IdentifierCode" id="receiverMt400IdentifierCode" value="${receiverMt400IdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt400Flag" class="receiversCorrespondentMt400Flag" value="B" checked="${'B'.equals(receiversCorrespondentMt400Flag)}" />&#160;&#160;Party Identifier</span></td>
		<td><g:textField class="input_field" name="receiver400PartyIdentifier" value="${receiver400PartyIdentifier}" /></td>
	</tr>
	<tr>
		<td><span class="field_label_indent2"> Location </span></td>
		<td><g:textField class="input_field" name="receiverMt400Location" value="${receiverMt400Location}" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentMt400Flag" class="receiversCorrespondentMt400Flag" value="D" checked="${'D'.equals(receiversCorrespondentMt400Flag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="receiverMt400NameAndAddress" value="${receiverMt400NameAndAddress}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_receiver_correspondent_mt400">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Time Indication</span></td>
		<td>
			<g:select from="${['SNDTIME','CLSTIME','RNCTIME']}" noSelection="['':'SELECT ONE']" name="timeIndication" class="select_dropdown" value="${timeIndication}"/>
			<g:textField class="input_field" name="timeIndicationField" value="${timeIndicationField}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Intermediary</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="intermediary" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="intermediaryFlag" class="intermediaryFlag" value="A" checked="${'A'.equals(intermediaryFlag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="intermediaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCode" id="intermediaryIdentifierCode" value="${intermediaryIdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="intermediaryFlag" class="intermediaryFlag" value="D" checked="${'D'.equals(intermediaryFlag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="intermediaryNameAndAddressMt" value="${intermediaryNameAndAddressMt}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_intermediary">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Account with Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="accountWithBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="A" checked="${'A'.equals(accountWithBankFlag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="accountIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCode" id="accountIdentifierCode" value="${accountIdentifierCode}"/>
		</td>
	</tr>
	<%--<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${accountWithBankFlag.equals('B')}" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="accountLocation" value="${accountLocation}"/></td>
	</tr>--%>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="D" checked="${'D'.equals(accountWithBankFlag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="accountNameAndAddress" value="${accountNameAndAddress}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_account_with_bank">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Beneficiary Bank<span class="asterisk">*</span></span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="beneficiaryBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag" value="A" checked="${'A'.equals(beneficiaryBankFlag)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="beneficiaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCode" id="beneficiaryIdentifierCode" value="${beneficiaryIdentifierCode}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlag" class="beneficiaryBankFlag" value="D" checked="${'D'.equals(beneficiaryBankFlag)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea  " name="beneficiaryNameAndAddress" value="${beneficiaryNameAndAddress}" rows="13"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_beneficiary_bank">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Details of Charges(MT400)</span></td>
<%--		<td><g:select from="${['BEN','OUR','SHA']}" noSelection="['':'SELECT ONE']" name="detailsOfCharges" class="select_dropdown" value="${detailsOfCharges}"/></td>--%>
		<td>
			<g:textArea class="textarea" name="detailsOfCharges" readonly="readonly" value="${detailsOfCharges}" rows="13"/>
			<input type="button" class="popup_btn_bottom" id="details_charges">		
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Details of Amount Added(MT400)</span></td>
		<td>
			<g:select from="${['INTEREST','RETCOMM','YOURCHAR']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountDescription" class="select_dropdown" value="${detailsOfAmountDescription}"/>
			<g:select from="${['PHP']}" noSelection="['':'SELECT ONE']" name="detailsOfAmountCurrency" class="select_dropdown" value="${detailsOfAmountCurrency}"/>
			<g:textField class="input_field_right numericCurrency" name="detailsOfAmountTextField" value="${detailsOfAmountTextField}"/>
		</td>
	</tr>
	<tr>
		<td></td>
		<td><g:textArea class="textarea" name="detailsOfAmountTextArea" value="${detailsOfAmountTextArea}" rows="4"/></td>
	</tr>
</table>
<br/><br/>

<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
		</td>
	</tr>	
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
	model="${[textAreaPopupId: 'sender_receiver_popup',
		 closeTextAreaBtnPopup: 'sender_receiver_close',
		 textAreaHeader: 'Sender to Receiver Information',
		 textAreaName: 'senderToReceiverInformationComment',
		 saveTextAreaBtnPopupId: 'senderToReceiverInformationPopupSave',
		 saveTextAreaBtnPopup: 'sender_receiver_save',
		 textAreaPopupbg: 'sender_receiver_bg',
		 textAreaScript:'popups/sender_receiver_popup.js']}" />
