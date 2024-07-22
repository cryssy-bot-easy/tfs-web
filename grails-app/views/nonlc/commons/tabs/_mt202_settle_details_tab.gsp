<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="mt202" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<g:javascript src="utilities/dataentry/incoming_mt/mt202/mt202_popup.js" />
<script type="text/javascript">
var sendersCorrespondentFlagMt202 = "${sendersCorrespondentFlagMt202}";
var orderingBankFlagMt202 = "${orderingBankFlagMt202}";
var receiversCorrespondentFlag = "${receiversCorrespondentFlag}";
var receiversCorrespondentFlagMt202 = "${receiversCorrespondentFlagMt202}";
var intermediaryFlagMt202 = "${intermediaryFlagMt202}";
var accountWithBankFlagMt202 = "${accountWithBankFlagMt202}";
var beneficiaryBankFlagMt202 = "${beneficiaryBankFlagMt202}";
var beneficiaryBankFlagMt202 = "${beneficiaryBankFlagMt202}";
var beneficiaryBankFlagMt202 = "${beneficiaryBankFlagMt202}";

$(document).ready(function() {
    $("#senderIdentifierCodeMt202").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt202 ? ('A'.equals(sendersCorrespondentFlagMt202) ? senderIdentifierCodeMt202 : '') : ''}'});
    $("#bankIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCodeMt202}'});
	$("#receiverIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt202}'});
    $("#intermediaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCodeMt202}'});
    $("#accountIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCodeMt202}'});
    $("#beneficiaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCodeMt202}'});



    $("#senderIdentifierCodeMt202").change(function() {
        if ($("#senderIdentifierCodeMt202").val() != "") {
            $("#sendersCorrespondentCompleteMt202").val(true);
        }
    });

    /*$("#senderLocationMt202").change(function() {
        if ($("#senderLocationMt202").val() != "") {
            $("#sendersCorrespondentCompleteMt202").val(true);
        } else {
            $("#sendersCorrespondentCompleteMt202").val("");
        }
    });*/

    $("#senderNameAndAddressMt202").change(function() {
        if ($("#senderNameAndAddressMt202").val() != "") {
            $("#sendersCorrespondentCompleteMt202").val(true);
        } else {
            $("#sendersCorrespondentCompleteMt202").val("");
        }
    });

    checkSendersCorrespondent()

    $("#beneficiaryIdentifierCodeMt202").change(checkIdentifierCode);

    checkIdentifierCode();

    $("#beneficiaryNameAndAddressMt202").change(function() {
        if ($("#beneficiaryNameAndAddressMt202").val() != "" && $("input[name=beneficiaryBankFlagMt202]:checked").val() == 'D') {
            $("#beneficiaryCompleteMt202").val(true);
        } else {
            $("#beneficiaryCompleteMt202").val("");
        }
    });

    $("input[name=beneficiaryBankFlagMt202]").click(function() {
    	if (!(($("#beneficiaryNameAndAddressMt202").val() != "" && $("input[name=beneficiaryBankFlagMt202]:checked").val() == 'D') || ($("#beneficiaryIdentifierCodeMt202").val() != "" && $("input[name=beneficiaryBankFlagMt202]:checked").val() == 'A'))) {
	   		$("#beneficiaryCompleteMt202").val("");
       	}
    });

    if(${!beneficiaryBankFlagMt202 && documentClass.equals('DA')}){
        if(!${beneficiaryNameAndAddressMt202 == null}){
        	$.post(autoCompleteBankUrl, {starts_with: '${remittingBank}'}, function(data){
            	if('undefined' !== typeof data && 'undefined' !== typeof data.results[0]){
	            	$("#beneficiaryNameAndAddressMt202").val(data.results[0].label);
               	}
            });
        }
    }
}); 
function checkIdentifierCode() {
	if (($("#beneficiaryIdentifierCodeMt202").val() != "" && $("input[name=beneficiaryBankFlagMt202]:checked").val() == 'A') || ($("#beneficiaryNameAndAddressMt202").val() != "" && $("input[name=beneficiaryBankFlagMt202]:checked").val() == 'D')) {
        $("#beneficiaryCompleteMt202").val(true);
    } else {
        $("#beneficiaryCompleteMt202").val("");
    }
}

function checkSendersCorrespondent() {
	if (($("#senderIdentifierCodeMt202").val() != "" && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == 'A') ||
			 ($("#senderLocationMt202").val() != "" && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == 'B') ||
			  ($("#senderNameAndAddressMt202").val() != "" && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == 'D')) {
		$("#sendersCorrespondentCompleteMt202").val(true);
	}
}
</script>
<g:hiddenField name="sendersCorrespondentCompleteMt202" class="" id="sendersCorrespondentCompleteMt202" value="${sendersCorrespondentCompleteMt202}"/>
<g:hiddenField name="beneficiaryCompleteMt202" class="" id="beneficiaryCompleteMt202" value="${beneficiaryCompleteMt202 ?: (documentClass.equals('DA')) ? true : ''}"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumberMT103" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> 21: Remitting Bank (Ref Number) </span></td>
		<td><g:textField class="input_field" name="remittingBankReferenceNumber" value="${remittingBankReferenceNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">13C: Time Indication</span></td>
		<td>
			<g:select from="${['SNDTIME','CLSTIME','RNCTIME']}" noSelection="['':'SELECT ONE']" name="timeIndicationMt202" class="select_dropdown" value="${timeIndicationMt202}"/>
			<g:textField class="input_field" name="timeIndicationFieldMt202" value="${timeIndicationFieldMt202}" maxlength="9"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> 32A: TS Date/Settlement Currency/ <br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Settlement Amount </span></td>
		<td>
		  <g:textField class="input_field" name="valueDateMt202" value="${valueDateMt202 ?: etsDate}" readonly="readonly"/>
		  <g:textField class="input_field_short" name="lcCurrencyMt202" value="${lcCurrencyMt202 ?: negotiationCurrency}" readonly="readonly"/>
		  <g:textField class="input_field_right numericCurrency" name="netAmountMt202" value="${netAmountMt202 ?: productAmount}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">52<span class="orderingBankMt202OptionLetter title_label"></span>: Ordering Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="orderingBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="orderingBankPartyIdentifierMt202" value="${orderingBankPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="A" checked="${'A'.equals(orderingBankFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="bankIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt202" id="bankIdentifierCodeMt202" value="${bankIdentifierCodeMt202}"/>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="D" checked="${'D'.equals(orderingBankFlagMt202)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="bankNameAndAddressMt202" value="${bankNameAndAddressMt202}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_ordering_bank">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">53<span class="sendersCorrespondentMt202OptionLetter title_label"></span>: Sender's Correspondent <span class="asterisk">*</span> </span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="senderCorrespondent" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="senderPartyIdentifierMt202" value="${senderPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="A" checked="${'A'.equals(sendersCorrespondentFlagMt202)}"/>&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="senderIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt202" id="senderIdentifierCodeMt202" value="${senderIdentifierCodeMt202}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="B" checked="${'B'.equals(sendersCorrespondentFlagMt202)}"/>&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="senderLocationMt202" value="${senderLocationMt202}" readonly="readonly"/></td>
	</tr>
<%--	<tr>--%>
<%--		<td class="valign_top"><span class="field_label_indent2"> Location </span></td>--%>
<%--		<td><g:textArea class="textarea" name="senderLocationMt" value="${senderLocationMt ?: !('A'.equals(sendersCorrespondentFlagMt202) || 'D'.equals(sendersCorrespondentFlagMt202)) ? reimbursingBankName : ''}" rows="2"/></td>--%>
<%--	</tr>--%>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="D" checked="${'D'.equals(sendersCorrespondentFlagMt202)}"/>&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="senderNameAndAddressMt202" value="${senderNameAndAddressMt202}" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="title_label">54<span class="receiversCorrespondentMt202OptionLetter title_label"></span>: Receiver's Correspondent</span></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="receiverPartyIdentifierMt202" value="${receiverPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="A" checked="${'A'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt202" id="receiverIdentifierCodeMt202" value="${receiverIdentifierCodeMt202}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="B" checked="${'B'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Location</span></td>
		<td><g:textArea class="textarea" name="receiverLocationMt202" value="${receiverLocationMt202}" rows=""/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="D" checked="${'D'.equals(receiversCorrespondentFlagMt202)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="receiverNameAndAddressMt202" value="${receiverNameAndAddressMt202}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>
    <tr>
		<td><span class="title_label">56<span class="intermediaryMt202OptionLetter title_label"></span>: Intermediary</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="intermediary" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="intermediaryPartyIdentifierMt202" value="${intermediaryPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="A" checked="${'A'.equals(intermediaryFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="intermediaryIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCodeMt202" id="intermediaryIdentifierCodeMt202" value="${intermediaryIdentifierCodeMt202}"/>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="D" checked="${'D'.equals(intermediaryFlagMt202)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="intermediaryNameAndAddressMt202" value="${intermediaryNameAndAddressMt202}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_intermediary">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="title_label">57<span class="accountWithBankMt202OptionLetter title_label"></span>: Account with Bank</span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-','Option D-Name']}" noSelection="['':'SELECT ONE']" name="accountWithBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="accountPartyIdentifierMt202" value="${accountPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="A" checked="${'A'.equals(accountWithBankFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- <g:textField class="input_field" name="accountIdentifierCode" /> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt202" id="accountIdentifierCodeMt202" value="${accountIdentifierCodeMt202}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="B" checked="${'B'.equals(accountWithBankFlagMt202)}"/>&#160;&#160;Location</span></td>
		<td><g:textArea class="textarea" name="accountWithBankLocationMt202" value="${accountWithBankLocationMt202}" rows="2"/></td>
	</tr>
	<%--<tr>
		<td><span class="field_label small_margin_left"><g:radio name="accountWithBankFlag" class="accountWithBankFlag" value="B" checked="${accountWithBankFlag.equals('B')}" />&#160;&#160;Location</span></td>
		<td><g:textField class="input_field" name="accountLocation" value="${accountLocation}"/></td>
	</tr>--%>
	<tr>
		<td class="valign_top"><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="D" checked="${'D'.equals(accountWithBankFlagMt202)}" />&#160;&#160;Name and Address</span></td>
		<td>
			<g:textArea class="textarea" name="accountNameAndAddressMt202" value="${accountNameAndAddressMt202}" rows="4"/>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt202_popup_btn_account_with_bank">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="title_label">58<span class="beneficiaryBankMt202OptionLetter title_label"></span>: Beneficiary Bank<span class="asterisk">*</span></span></td>
<%--		<td><g:select from="${['Option A-SWIFT Code','Option B-Location','Option D-Name']}" noSelection="['':'SELECT ONE']" name="beneficiaryBank" class="select_dropdown"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Party Identifier</span></td>
		<td><g:textField class="input_field" name="beneficiaryPartyIdentifierMt202" value="${beneficiaryPartyIdentifierMt202}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"><g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="A" checked="${'A'.equals(beneficiaryBankFlagMt202)}" />&#160;&#160;Identifier Code</span></td>
		<td>
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt202" id="beneficiaryIdentifierCodeMt202" />
		</td>
	</tr>
	<tr>
		<td class="valign_top"> <span class="field_label"> <g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="D" checked="${'D'.equals(beneficiaryBankFlagMt202)}" />&#160;&#160;Name and Address</span> </td>
		<td>
			<g:textArea class="textarea" name="beneficiaryNameAndAddressMt202" rows="4">${beneficiaryNameAndAddressMt202}</g:textArea>
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
			<g:textArea class="textarea" name="senderToReceiverInformationMt202" readonly="readonly" value="${senderToReceiverInformationMt202}" rows="6"/>
			<a href="javascript:void(0)" class="search_btn" id="mt202_popup_btn_sender_receiver_information">...</a>
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
</table>
<br/><br/>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/mt202_popup" />
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
<%--<g:render template="../nonlc/commons/popups/textarea_popup"--%>
<%--	model="${[textAreaPopupId: 'sender_receiver_mt202_popup',--%>
<%--		 closeTextAreaBtnPopup: 'sender_receiver_mt202_close',--%>
<%--		 textAreaHeader: 'Sender to Receiver Information',--%>
<%--		 textAreaName: 'senderToReceiverInformationMt202Comment',--%>
<%--		 remainCharsTextArea: 'remainingCharacterSenderToReceiverMt202',--%>
<%--		 remainLinesTextArea: 'remainingLineSenderToReceiverMt202',--%>
<%--		 saveTextAreaBtnPopupId: 'senderToReceiverInformationMt202PopupSave',--%>
<%--		 saveTextAreaBtnPopup: 'sender_receiver_mt202_save',--%>
<%--		 textAreaPopupbg: 'sender_receiver_mt202_bg',--%>
<%--		 textAreaScript:'popups/sender_receiver_mt202_popup.js']}" />--%>
