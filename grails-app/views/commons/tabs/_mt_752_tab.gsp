<%@ page import="net.ipc.utils.DateUtils" %>
<%-- 
   [Modified by:] Rafael Ski Poblete
   [Modified date:] 09/11/2018
   [Details] Imported charges_deducted_narrative_popup, sender_receiver_popup, narrative_popup gsp and js for new field and functionalities.
             Added asterisk to field 30
             Changed field 71B
             Added charges narrative field
             Added Option on Net Amount fields and conditions
             Change SendertoReceiver field functionality
             Added field79Z
             Added onload and onclick functions to comply in new behaviour of fields.
--%>
<g:javascript src="utilities/dataentry/incoming_mt/mt752/sender_correspondent.js" />
<g:javascript src="utilities/dataentry/incoming_mt/mt752/receiver_correspondent.js" />

<g:javascript src="utilities/dataentry/incoming_mt/mt752/mt_752_utility.js" />
<g:javascript src="utilities/dataentry/incoming_mt/mt752/mt752_popup.js" />

<g:render template="/grails-app/views/commons/popups/charges_deducted_narrative_popup"/>
<g:javascript src="popups/charges_deducted_narrative_popup.js" />

<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

<g:render template="/grails-app/views/commons/popups/narrative_popup"/>
<g:javascript src="popups/narrative_popup.js" />

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

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Negotiating Bank <span class="asterisk">*</span></span></td>
		<td>
            <g:textField class="input_field required" name="negotiatingBankMt752" value="${negotiatingBankMt752 ?: negotiatingBank}" readonly="readonly" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank <span class="asterisk">*</span></span></td>
		<td>
			<g:textField class="input_field required" name="reimbursingBankMt752" value="${reimbursingBankMt752 ?: reimbursingBank}" readonly="readonly" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumberMT752" value="${documentNumberMT752 ?: lcNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">21: Negotiating Bank's <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reference Number <span class="asterisk">*</span> </span></td>
		<td>
            <g:textField class="input_field required" id="negotiatingBanksReferenceNumberMt752" name="negotiatingBanksReferenceNumberMt752" value="${negotiatingBanksReferenceNumberMt752 ?: 
				(negotiatingBanksReferenceNumber?.toString()?.size() > 16 ? negotiatingBanksReferenceNumber.toString().substring(0, 16) : 
				negotiatingBanksReferenceNumber)}" maxlength="16"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> 23: Further Identification <span class="asterisk">*</span></span></td>
		<td><g:select value="${furtherIdentificationMt752 ?: 'ACCEPT'}" name="furtherIdentificationMt752" class="select_dropdown required" from="${['ACCEPT', 'DEBIT', 'NEGOTIATE', 'REIMBURSE', 'REMITTED', 'SEE79Z']}" noSelection="['':'SELECT ONE...']" disabled="disabled"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> 30: Value Date <span class="asterisk">*</span></span></td>
		<td><g:textField class="datepicker_field" name="valueDateMt752" value="${valueDateMt752 ?: valueDateMt}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> 32B: Negotiation Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="negoAmountMt752" value="${negoAmountMt752 ?: negotiationAmount}"/></td>
	</tr>
    <tr>
        <td><span class="field_label">71D: Charges Deducted </span></td>
        <td ><g:textField class="input_field_right numericCurrency" name="discrepancyAmountMt752" value="${discrepancyAmountMt752 ?: discrepancyAmount}" /></td>
    </tr>
    <tr>
        <td valign="top"><span  class="field_label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Charges Narrative </span></td>
        <td>
           <g:textArea name="chargesDeductedNarrative" class="textarea" rows="5" value="${chargesDeductedNarrative}" readonly="readonly"/>
           <a href="javascript:void(0)" class="search_btn" id="popup_btn_charges_deducted_narrative">...</a>
       </td>
    </tr>
	<g:if test="${documentSubType2 == 'SIGHT' }">
		<tr>
            <td><span class="title_label">33B: Net Amount</span></td>
            <td>
            <label><g:radio name="netAmountOption" value="OptionA" class="optionA"/>Option A</label>
            <label><g:radio name="netAmountOption" value="OptionB" class="optionB"/>Option B</label>
            </td>
		</tr>
		<tr>
		<td class="label_width"><span class="field_label">Net Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="netAmountMt752" value="${netAmountMt752 ?: netAmount}" readonly="readonly"/></td>
		</tr>
        <tr>
        <td class="label_width"><span class="field_label">Maturity Date <span id="maturityDateRequired" class="asterisk">*</span></span></td>
            <td><g:textField class="datepicker_field" name="netAmountDateMt752" value="${netAmountDateMt752}" readonly="readonly"/></td>
        </tr>
	</g:if>
	<g:else>
        <tr>
            <td><span class="title_label">33A: Net Amount/Date</span></td>
            <td>
            <label><g:radio name="netAmountOption" value="OptionA" class="optionA"/>Option A</label>
            <label><g:radio name="netAmountOption" value="OptionB" class="optionB"/>Option B</label>
            </td>
        </tr>
        <tr>
        <td class="label_width"><span class="field_label">Net Amount</span></td>
        <td><g:textField class="input_field_right numericCurrency" name="netAmountMt752" value="${netAmountMt752 ?: netAmount}" readonly="readonly"/></td>
        </tr>
        <tr>
        <td class="label_width"><span class="field_label">Maturity Date <span class="asterisk">*</span></span></td>
            <td><g:textField class="datepicker_field" name="netAmountDateMt752" value="${netAmountDateMt752}" readonly="readonly"/></td>
        </tr>
	</g:else>
	<tr>
		<td class="spacer" colspan="4">&#160;</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">53<span class="sendersCorrespondentMt752202OptionLetter title_label">a</span>: Sender's Correspondent</span></td>
	</tr>
	<tr>
		<td class="label_width">
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="mt-radio senderCorrespondentOptionA" value="A"  checked="${sendersCorrespondentMt752 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3" class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt752" id="senderIdentifierCodeMt752" /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="mt-radio senderCorrespondentOptionB" value="B"  checked="${sendersCorrespondentMt752 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>	
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="senderPartyIdentifierMt752" value="${senderPartyIdentifierMt752}" maxlength="34"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea name="senderLocationMt752" class="fields-textarea textarea" value="${senderLocationMt752}" rows="4" maxlength="35"/></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="mt-radio senderCorrespondentOptionD" value="D" checked="${sendersCorrespondentMt752 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="senderNameAndAddressMt752" value="${senderNameAndAddressMt752}" rows="4" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt752_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">54<span class="receiversCorrespondentMt752202OptionLetter title_label">a</span>: Receiver's Correspondent</span></td>
	</tr>
	<tr>	
		<td class="label_width">
			<g:radio name="receiversCorrespondentMt752" class="mt-radio receiverCorrespondentOptionA" value="A" checked="${receiversCorrespondentMt752 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt752" id="receiverIdentifierCodeMt752"  /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="receiversCorrespondentMt752" class="mt-radio receiverCorrespondentOptionB" value="B"  checked="${receiversCorrespondentMt752 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>	
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="receiverPartyIdentifierMt752" value="${receiverPartyIdentifierMt752}" maxlength="34"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea name="receiverLocationMt752" class="fields-textarea textarea" value="${receiverLocationMt752}" rows="4"  maxlength="35"/></td>
	</tr>
	<tr>	
		<td valign="top">
			<g:radio name="receiversCorrespondentMt752" class="mt-radio receiverCorrespondentOptionD" value="D" checked="${receiversCorrespondentMt752 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="receiverNameAndAddressMt752" value="${receiverNameAndAddressMt752}" rows="4" readonly="readonly"></g:textArea>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt752_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label bold">72Z: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverTypeforMT752 name="senderToReceiver" class="newSenderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformation" readonly="readonly" value="${senderToReceiverInformation}" rows="6"></g:textArea>			
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
	</tr>
	   <tr>
        <td valign="top"><span class="field_label bold">79Z: Narrative</span></td>
        <td>
            <g:textArea class="textarea" name="narrative" readonly="readonly" value="${narrative}" rows="6"></g:textArea>           
            <a href="javascript:void(0)" class="search_btn" id="popup_btn_narrative">...</a>
        </td>
    </tr>
</table>
<br />
<table class="buttons_for_grid_wrapper">
	<tr>
		<td>
			<input type="button" class="input_button2" value="View MT 752" onclick="goToViewMt(752)"/>
		</td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/mt752_popup" />
<script>
$(document).ready(function() {
	$("#senderIdentifierCodeMt752").setBankDropdown($(this).attr("id")).select2('data',{id: '${senderIdentifierCodeMt752}'});
	$("#receiverIdentifierCodeMt752").setBankDropdown($(this).attr("id")).select2('data',{id: '${receiverIdentifierCodeMt752}'});

	if($("#documentSubType2").val() == "SIGHT") {
		if(${netAmountOption?.equals("OptionA") ? true : false}) {
			$('.optionA').prop('checked', true);
			$('#maturityDateRequired').show();
		} else {
		    $('.optionB').prop('checked', true);
	        $('#maturityDateRequired').hide();
		}
	} else {
        $('.optionA').prop('checked', true);
		$('.optionB').prop('disabled', true);
	}

    $("#furtherIdentificationMt752").change(function(){
        if ($("#documentSubType2").val() == "SIGHT") {
            if($("#furtherIdentificationMt752").val() == "DEBIT" || $("#furtherIdentificationMt752").val() == "REMITTED"){
                $('.optionB').prop('disabled', true);
                $('.optionA').prop('checked', true);
                $('#maturityDateRequired').show();
            } else {
                $('.optionB').prop('disabled', false)
            }
        }
    });
    
    $(".optionA").click(function(){
    	if($("#documentSubType2").val() == "SIGHT") {
            $('#maturityDateRequired').show();
    	}
    });
    $(".optionB").click(function(){
    	if($("#documentSubType2").val() == "SIGHT") {
    	    $('#maturityDateRequired').hide();
        }
    });
});
</script>