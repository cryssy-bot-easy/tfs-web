<%--<g:javascript src="utilities/dataentry/commons/ordering_institution.js" />--%>
<%--<g:javascript src="utilities/dataentry/commons/sender_correspondent.js" />--%>
<%--<g:javascript src="utilities/dataentry/commons/receiver_correspondent.js" />--%>
<%--<g:javascript src="utilities/dataentry/commons/intermediary.js" />--%>
<%--<g:javascript src="utilities/dataentry/commons/account_institution.js" />--%>
<%--<g:javascript src="utilities/dataentry/commons/beneficiary_institution.js" />--%>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="detailsForMt202" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>

<div id="data_entry_ua_loan_settlement_filter">
	<table class="tabs_forms_table">
		<tr>
			<td class="label_width"><span class="field_label">Reimbursing Bank <span class="asterisk"> * </span></span></td>
			<td class="input_width">
				<%-- <g:select from="${['REIMBURSING BANK 1', 'REIMBURSING BANK 2', 'REIMBURSING BANK 3']}" keys="${['RBANK_1','RBANK_2','RBANK_3']}" name="reimburseBank" class="select_dropdown" noSelection="['':'SELECT ONE...']"/> --%>
				
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop required" name="reimburseBank" id="reimburseBank" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Negotiating Bank's Reference Number<span class="asterisk"> * </span></span></td>
			<td><g:textField name="negotiatingBanksReferenceNumber" class="input_field numberFormat-16 required" value="${negotiatingBanksReferenceNumber ?: negotiationNumber}"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Discrepancy Fee/Charge</span></td>
			<td><g:textField name="descripancyFee" class="input_field numberFormat-15-2" /></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">BSP Creditor</span></td>
			<td><g:textField name="bspCreditor" class="input_field" readonly="readonly"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Value Date <span class="asterisk"> * </span></span></td>
			<td><g:textField name="valueDateMt202" class="datepicker_field input_ten required" value="${valueDateMt202 ?: etsDate}" readonly="readonly"/></td>
		</tr>	
		<tr>	
			<td><span class="field_label">Net Amount</span></td>
			<td><g:textField name="netAmountMt202" class="input_field numeric_fourteen" value="${netAmountMt202 ?: amount}" readonly="readonly"/></td>
		</tr>
	</table>
	<br/><br/>
	<table class="tabs_forms_table">		
		<tr>
			<td colspan="2"><span class="field_label">52<span class="orderingInstitutionOption field_label"></span>Ordering Institution<span class="asterisk">*</span></span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="A" checked="${orderingBankFlagMt202.equals('A')}" />&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="bankIdentifierCodeMt202" id="bankIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="orderingBankFlagMt202" class="orderingBankFlagMt202" value="D" checked="${orderingBankFlagMt202.equals('D')}" />&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="bankNameAndAddressMt202" value="${bankNameAndAddressMt202}" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_ordering_bank">...</a>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td colspan="2"><span class="field_label">53<span class="sendersCorrespondentOption field_label"></span>Sender's Correspondent</span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="A" checked="${sendersCorrespondentFlagMt202.equals('A')}"/>&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt202" id="senderIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="B" checked="${sendersCorrespondentFlagMt202.equals('B')}"/>&#160;&#160;Location</span></td>
			<td><g:textField class="input_field" name="senderLocationMt202" value="${senderLocationMt202}"/></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="sendersCorrespondentFlagMt202" class="sendersCorrespondentFlagMt202" value="D" checked="${sendersCorrespondentFlagMt202.equals('D')}"/>&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="senderNameAndAddressMt202" value="${senderNameAndAddressMt202}" readonly="readonly" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_sender_correspondent">...</a>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td colspan="2"><span class="field_label">54<span class="receiversCorrespondentOption field_label"></span>Receiver's Correspondent</span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="A" checked="${receiversCorrespondentFlagMt202.equals('A')}" />&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt202" id="receiverIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="B" checked="${receiversCorrespondentFlagMt202.equals('B')}" />&#160;&#160;Location</span></td>
			<td><g:textField class="input_field" name="receiverLocationMt202" value="${receiverLocationMt202}" /></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="receiversCorrespondentFlagMt202" class="receiversCorrespondentFlagMt202" value="D" checked="${receiversCorrespondentFlagMt202.equals('D')}" />&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="receiverNameAndAddressMt202" value="${receiverNameAndAddressMt202}" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_receiver_correspondent_mt202">...</a>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>
		<tr>
			<td colspan="2"><span class="field_label">56<span class="intermediaryOption field_label"></span>Intermediary</span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="A" checked="${intermediaryFlagMt202.equals('A')}" />&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="intermediaryIdentifierCodeMt202" id="intermediaryIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="intermediaryFlagMt202" class="intermediaryFlagMt202" value="D" checked="${intermediaryFlagMt202.equals('D')}" />&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="intermediaryNameAndAddressMt202" value="${intermediaryNameAndAddressMt202}" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_intermediary">...</a>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>		
		<tr>
			<td colspan="2"><span class="field_label">57<span class="accountWithInstitutionOption field_label"></span>Account with Institution</span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="A" checked="${accountWithBankFlagMt202.equals('A')}" />&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="accountIdentifierCodeMt202" id="accountIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="accountWithBankFlagMt202" class="accountWithBankFlagMt202" value="D" checked="${accountWithBankFlagMt202.equals('D')}" />&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="accountNameAndAddressMt202" value="${accountNameAndAddressMt202}" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_account_with_bank">...</a>
			</td>
		</tr>
		<tr>
			<td>&#160;</td>
		</tr>		
		<tr>
			<td colspan="2"><span class="field_label">58<span class="beneficiaryInstitutionOption field_label"></span>Beneficiary's Institution<span class="asterisk">*</span></span></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="A" checked="${beneficiaryBankFlagMt202.equals('A')}" />&#160;&#160;Identifier Code</span></td>
			<td>
				<%-- Auto Complete --%>
				<input class="tags_bank select2_dropdown bigdrop" name="beneficiaryIdentifierCodeMt202" id="beneficiaryIdentifierCodeMt202" />
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label small_margin_left"><g:radio name="beneficiaryBankFlagMt202" class="beneficiaryBankFlagMt202" value="D" checked="${beneficiaryBankFlagMt202.equals('D')}" />&#160;&#160;Name and Address</span></td>
			<td>
				<g:textArea class="textarea" name="beneficiaryNameAndAddressMt202" value="${beneficiaryNameAndAddressMt202}" rows="4"/>
				<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_beneficiary_bank">...</a>
			</td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">72: Sender to Receiver Information</span></td>
			<td>
				<tfs:senderToReceiverType1 name="senderToReceiverMt202" value="${senderToReceiverMt202}"/>
				<br/>
				<g:textArea class="textarea" name="senderToReceiverInformationMt202" readonly="readonly" value="${senderToReceiverInformationMt202}" rows="4"/>
				<a href="javascript:void(0)" class="search_btn" id="sender_info">...</a>
			</td>
		</tr>
	</table>
</div>
<br />

<g:hiddenField name="orderingInstitutionComplete" id="orderingInstitutionComplete" value="${orderingInstitutionComplete}" class="required" />
<g:hiddenField name="beneficiaryInstitutionComplete" id="beneficiaryInstitutionComplete" value="${beneficiaryInstitutionComplete}" class="required" />

<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 202" onclick="goToViewMt(202)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<%-- Sender to receiver popup --%>
<%--<g:render template="../commons/popups/sender_receiver_popup" />
<g:javascript src="popups/sender_receiver_popup.js" />--%>
<g:render template="../nonlc/commons/popups/textarea_popup"
	model="${[textAreaPopupId: 'sender_receiver_popup',
		 closeTextAreaBtnPopup: 'sender_receiver_close',
		 textAreaHeader: 'Sender to Receiver Information',
		 textAreaName: 'senderToReceiverInformationComment',
		 saveTextAreaBtnPopupId: 'senderToReceiverInformationPopupSave',
		 saveTextAreaBtnPopup: 'sender_receiver_save',
		 textAreaPopupbg: 'sender_receiver_bg',
		 remainCharsTextArea: 'remainingCharacterSenderToReceiver',
		 remainLinesTextArea: 'remainingLineSenderToReceiver',
		 textAreaScript:'popups/sender_receiver_popup.js']}" />

<script type="text/javascript">
var sendersCorrespondentFlagMt202 = "${sendersCorrespondentFlagMt202}";
var orderingBankFlagMt202 = "${orderingBankFlagMt202}";
var receiversCorrespondentFlagMt202 = "${receiversCorrespondentFlagMt202}";
var intermediaryFlagMt202 = "${intermediaryFlagMt202}";
var accountWithBankFlagMt202 = "${accountWithBankFlagMt202}";
var beneficiaryBankFlagMt202 = "${beneficiaryBankFlagMt202}";

$(document).ready(function() {
$("#senderIdentifierCodeMt202").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt202}'});
$("#bankIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${bankIdentifierCodeMt202}'});
$("#receiverIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt202}'});
$("#intermediaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${intermediaryIdentifierCodeMt202}'});
$("#accountIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${accountIdentifierCodeMt202}'});
$("#beneficiaryIdentifierCodeMt202").setBankDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryIdentifierCodeMt202}'});

    %{--$("#reimburseBank").select2('data',{id: '${reimburseBank}'});--}%
    $("#reimburseBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimburseBank}'});

    $("#orderingInstitutionIdentifierCode, #orderingInstitutionNameAndAddress").change(function() {
        $("#orderingInstitutionComplete").val("true");
    });

    $("#beneficiarysInstitutionIdentifierCode, #beneficiarysInstitutionNameAndAddress").change(function() {
        $("#beneficiaryInstitutionComplete").val("true");
    });
    
    $("#senderIdentifierCodeMt202").attr("readonly", "readonly");
    $("#senderIdentifierCodeMt202").select2("disable");
	$("#senderLocationMt202").attr("readonly", "readonly");
	$("#senderNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_sender_correspondent").hide();
	
	$(".sendersCorrespondentOption").text("a:");
	if($(".sendersCorrespondentFlagMt202").length > 0){
	$(".sendersCorrespondentFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#senderIdentifierCodeMt202").removeAttr("readonly");
			$("#senderIdentifierCodeMt202").select2("enable");
			$("#senderLocationMt202").val("");
			$("#senderLocationMt202").attr("readonly", "readonly");
			$("#senderNameAndAddressMt202").val("");
			$("#popup_btn_sender_correspondent").hide();
			$(".sendersCorrespondentOption").text("A:");

		} else if($(this).val() == 'B'){
			$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
			$("#senderIdentifierCodeMt202").select2('data',{id: ''});
			$("#senderIdentifierCodeMt202").select2("disable");
			$("#senderLocationMt202").removeAttr("readonly");
			$("#senderNameAndAddressMt202").val("");
			$("#popup_btn_sender_correspondent").hide();
			$(".sendersCorrespondentOption").text("B:");

		} else if($(this).val() == 'D'){
			$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
			$("#senderIdentifierCodeMt202").select2('data',{id: ''});
			$("#senderIdentifierCodeMt202").select2("disable");
			$("#senderLocationMt202").val("");
			$("#senderLocationMt202").attr("readonly", "readonly");
			$("#popup_btn_sender_correspondent").show();
			$(".sendersCorrespondentOption").text("D");

		} 
	});
	}
	
	$("#bankIdentifierCodeMt202").attr("readonly", "readonly");
	$("#bankIdentifierCodeMt202").select2("disable");
	$("#bankNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_ordering_bank").hide();

	$(".orderingInstitutionOption").text("a:");
	if($(".orderingBankFlagMt202").length > 0){
	$(".orderingBankFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#bankIdentifierCodeMt202").removeAttr("readonly").select2("enable");
			$("#bankNameAndAddressMt202").val("");
			$("#popup_btn_ordering_bank").hide();
			$(".orderingInstitutionOption").text("A:");
						
		} else if($(this).val() == 'D'){
			$("#bankIdentifierCodeMt202").attr("readonly", "readonly")
			$("#bankIdentifierCodeMt202").select2('data',{id: ''});
			$("#bankIdentifierCodeMt202").select2("disable");
			$("#popup_btn_ordering_bank").show();
			$(".orderingInstitutionOption").text("D:");
				
		}
	});
	}
	
	$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
	$("#receiverIdentifierCodeMt202").select2("disable");
	$("#receiverLocationMt202").attr("readonly", "readonly");
	$("#receiverNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_receiver_correspondent_mt202").hide();
	$(".receiversCorrespondentOption").text("a:");
	$(".receiversCorrespondentFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#receiverIdentifierCodeMt202").removeAttr("readonly").select2("enable");
			$("#receiverLocationMt202").val("");
			$("#receiverLocationMt202").attr("readonly", "readonly");
			$("#receiverNameAndAddressMt202").val("");
			$("#popup_btn_receiver_correspondent_mt202").hide();
			$(".receiversCorrespondentOption").text("A:");
			
		} else if($(this).val() == 'B'){
			$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
			$("#receiverIdentifierCodeMt202").select2('data',{id: ''});
			$("#receiverIdentifierCodeMt202").select2("disable");
			$("#receiverLocationMt202").removeAttr("readonly");
			$("#receiverNameAndAddressMt202").val("");
			$("#popup_btn_receiver_correspondent_mt202").hide();
			$(".receiversCorrespondentOption").text("B:");
			
		} else if($(this).val() == 'D'){
			$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
			$("#receiverIdentifierCodeMt202").select2('data',{id: ''});
			$("#receiverIdentifierCodeMt202").select2("disable");
			$("#receiverLocationMt202").val("");
			$("#receiverLocationMt202").attr("readonly", "readonly");
			$("#popup_btn_receiver_correspondent_mt202").show();
			$(".receiversCorrespondentOption").text("D:");
			
		} 
	});
	
	$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
	$("#intermediaryIdentifierCodeMt202").select2("disable");
	$("#intermediaryNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_intermediary").hide();
	
	$(".intermediaryOption").text("a:");
	if($(".intermediaryFlagMt202").length > 0){
	$(".intermediaryFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#intermediaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
			$("#intermediaryNameAndAddressMt202").val("");
			$("#popup_btn_intermediary").hide();
			$(".intermediaryOption").text("A:");
						
		} else if($(this).val() == 'D'){
			$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
			$("#intermediaryIdentifierCodeMt202").select2('data',{id: ''});
			$("#intermediaryIdentifierCodeMt202").select2("disable");
			$("#popup_btn_intermediary").show();
			$(".intermediaryOption").text("D:");
				
		} 
	});
	}
	
	$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
	$("#accountIdentifierCodeMt202").select2("disable");
	$("#accountNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_account_with_bank").hide();
	$(".accountWithInstitutionOption").text("a:");
	if($(".accountWithBankFlagMt202").length > 0){
	$(".accountWithBankFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#accountIdentifierCodeMt202").removeAttr("readonly").select2("enable");
			//$("#accountLocation").val("");
			$("#accountNameAndAddressMt202").val("");
			$("#popup_btn_account_with_bank").hide();
			$(".accountWithInstitutionOption").text("A:");
						
		} else if($(this).val() == 'D'){
			$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
			$("#accountIdentifierCodeMt202").select2('data',{id: ''});
			$("#accountIdentifierCodeMt202").select2("disable");
			/*$("#accountLocation").val("");
			$("#accountLocation").attr("readonly", "readonly");*/
			$("#popup_btn_account_with_bank").show();
			$(".accountWithInstitutionOption").text("D:");
		
		} 
	});
	}
	
	$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
	$("#beneficiaryIdentifierCodeMt202").select2("disable");
	$("#beneficiaryNameAndAddressMt202").attr("readonly", "readonly");
	$("#popup_btn_beneficiary_bank").hide();
	$(".beneficiaryInstitutionOption").text("a:");
	if($(".beneficiaryBankFlagMt202").length > 0){
	$(".beneficiaryBankFlagMt202").change(function(){
		if($(this).val() == 'A'){
			$("#beneficiaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
			$("#beneficiaryNameAndAddressMt202").val("")
			$("#popup_btn_beneficiary_bank").hide();
			$(".beneficiaryInstitutionOption").text("A:");
						
		} else if($(this).val() == 'D'){
			$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
			$("#beneficiaryIdentifierCodeMt202").select2('data',{id: ''});
			$("#beneficiaryIdentifierCodeMt202").select2("disable");
			$("#popup_btn_beneficiary_bank").show();
			$(".beneficiaryInstitutionOption").text("D:");
				
		} 
	});
	}
	
	if(sendersCorrespondentFlagMt202 == 'A'){
		$("#senderIdentifierCodeMt202").removeAttr("readonly");
		$("#senderLocationMt202").attr("readonly", "readonly");
		$("#senderNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(sendersCorrespondentFlagMt202 == 'B'){
		$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
		$("#senderLocationMt202").removeAttr("readonly");
		$("#senderNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(sendersCorrespondentFlagMt202 == 'D'){
		$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
		$("#senderLocationMt202").attr("readonly", "readonly");
		$("#senderNameAndAddressMt202").removeAttr("readonly");
		
	} 
	
	if(orderingBankFlagMt202 == 'A'){
		$("#bankIdentifierCodeMt202").removeAttr("readonly");
		$("#bankNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(orderingBankFlagMt202 == 'D'){
		$("#bankIdentifierCodeMt202").attr("readonly", "readonly");
		$("#bankNameAndAddressMt202").removeAttr("readonly");
		
	}
		
	if(receiversCorrespondentFlagMt202 == 'A'){
		$("#receiverIdentifierCodeMt202").removeAttr("readonly");
		$("#receiverLocationMt202").attr("readonly", "readonly");
		$("#receiverNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(receiversCorrespondentFlagMt202 == 'B'){
		$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
		$("#receiverLocationMt202").removeAttr("readonly");
		$("#receiverNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(receiversCorrespondentFlagMt202 == 'D'){
		$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
		$("#receiverLocationMt202").attr("readonly", "readonly");
		$("#receiverNameAndAddressMt202").removeAttr("readonly");
		
	}
		
	if(intermediaryFlagMt202 == 'A'){
		$("#intermediaryIdentifierCodeMt202").removeAttr("readonly");
		$("#intermediaryNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(intermediaryFlagMt202 == 'D'){
		$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
		$("#intermediaryNameAndAddressMt202").removeAttr("readonly");
		
	} 
	
	if(accountWithBankFlagMt202 == 'A'){
		$("#accountIdentifierCodeMt202").removeAttr("readonly");
		$("#accountNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(accountWithBankFlagMt202 == 'D'){
		$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
		/*$("#accountLocation").attr("readonly", "readonly");*/
		$("#accountNameAndAddressMt202").removeAttr("readonly");
		
	} 
	
	if(beneficiaryBankFlagMt202 == 'A'){
		$("#beneficiaryIdentifierCodeMt202").removeAttr("readonly");
		$("#beneficiaryNameAndAddressMt202").attr("readonly", "readonly");
		
	} else if(beneficiaryBankFlagMt202 == 'D'){
		$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
		$("#beneficiaryNameAndAddressMt202").removeAttr("readonly");
		
	}	
});
</script>