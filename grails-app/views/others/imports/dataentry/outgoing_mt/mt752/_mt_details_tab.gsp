
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
<g:render template="/grails-app/views/commons/popups/charges_deducted_narrative_popup"/>
<g:javascript src="popups/charges_deducted_narrative_popup.js" />

<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

<g:render template="/grails-app/views/commons/popups/narrative_popup"/>
<g:javascript src="popups/narrative_popup.js" />

<g:hiddenField name="messageType" value="752"/>
<g:hiddenField name="chainName" value="viewMT752"/><%--Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%--Used for disabling tab/s in basic_details_utility--%>
<%--Needed by select2 utility:--%>

<g:hiddenField name="documentNumber" value="${details?.documentNumber ?: lcNumber}"/>
<g:hiddenField name="currencyValue" value="${details?.currency}"/>
<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label"> Negotiating Bank<span class="asterisk">*</span> </span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop" name="negotiatingBank" id="negotiatingBank" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 20: Document Number </span></td>
		<td><g:textField class="input_field" name="lcNumber" maxlength="16" value="${details?.lcNumber}" /></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">21: Negotiating Bank's <br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Reference Number <span class="asterisk">*</span> </span></td>
		<td>
            <g:textField class="input_field" id="negotiatingBanksReferenceNumber" name="negotiatingBanksReferenceNumber" maxlength="16" value="${details?.negotiatingBanksReferenceNumber}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 23: Further Identification <span class="asterisk">*</span></span></td>
		<td><g:select value="${details?.furtherIdentificationMt752 ?: 'ACCEPT'}" name="furtherIdentificationMt752" class="select_dropdown" from="${['ACCEPT', 'DEBIT', 'NEGOTIATE', 'REIMBURSE', 'REMITTED', 'SEE79Z']}" noSelection="['':'SELECT ONE...']" /></td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 30: Value Date<span class="asterisk">*</span> </span></td>
		<td><g:textField class="datepicker_field" name="valueDateMt752" value="${details?.valueDateMt752}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Currency</span></td>
		<td>
			<input class="tags_currency select2_dropdown bigdrop" name="negotiationCurrency" id="negotiationCurrency" value="${details?.negotiationCurrency}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label title_label"> 32B: Negotiation Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="negoAmountMt752" value="${details?.negoAmountMt752}"/></td>
	</tr>
    <tr>
        <td><span class="field_label title_label">71D: Charges Deducted </span></td>
        <td ><g:textField class="input_field_right numericCurrency" name="discrepancyAmountMt752" value="${details?.discrepancyAmountMt752}" /></td>
    </tr>
    <tr>
        <td valign="top"><span  class="field_label">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Charges Narrative </span></td>
        <td>
           <g:textArea name="chargesDeductedNarrative" class="textarea" rows="5" value="${details?.chargesDeductedNarrative}" readonly="readonly"/>
           <a href="javascript:void(0)" class="search_btn" id="popup_btn_charges_deducted_narrative">...</a>
       </td>
    </tr>
	<tr>
		<td><span class="title_label">33<span class="netAmountMt752OptionLetter title_label">A</span></span><span class="title_label">: Net Amount </span><span id="netLabel" class="title_label">& Maturity Date </span> </td>
		<td>
			<g:radio name="documentSubType2" id="documentSubType2" class="documentSubType2 mt-radio documentSubType2OptionA optionA" value="USANCE"  checked="${details?.documentSubType2 == 'USANCE' ? true : false}" /><span class="field_label">Option A</span>
			<g:radio name="documentSubType2" id="documentSubType2" class="documentSubType2 mt-radio documentSubType2OptionB optionB" value="SIGHT"  checked="${details?.documentSubType2 == 'SIGHT' ? true : false}" /><span class="field_label"> Option B</span>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Net Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="netAmountMt752" value="${details?.netAmountMt752}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Maturity Date<span id="maturityDateRequired" class="asterisk">*</span></span></td>
		<td><g:textField class="datepicker_field" name="netAmountDateMt752" value="${details?.netAmountDateMt752}"/></td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">53<span class="sendersCorrespondentMt752202OptionLetter title_label">a</span>: Sender's Correspondent</span></td>
	</tr>
	<tr>
		<td>
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="sendersCorrespondentMt752 mt-radio senderCorrespondentOptionA" value="A"  checked="${details?.sendersCorrespondentMt752 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3" class="input_width"><input class="tags_bank select2_dropdown bigdrop" name="senderIdentifierCodeMt752" id="senderIdentifierCodeMt752" value="${details?.senderIdentifierCodeMt}"/></td>
	</tr>
	<tr>
		<td>
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="sendersCorrespondentMt752 mt-radio senderCorrespondentOptionB" value="B"  checked="${details?.sendersCorrespondentMt752 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>	
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="senderPartyIdentifierMt752" value="${details?.senderPartyIdentifierMt752}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea name="senderLocationMt752" class="fields-textarea textarea" maxlength="34" value="${details?.senderLocationMt752}" rows="4"/></td>
	</tr>
	<tr>
		<td valign="top">
			<g:radio name="sendersCorrespondentMt752" id="sendersCorrespondentMt752" class="sendersCorrespondentMt752 mt-radio senderCorrespondentOptionD" value="D" checked="${details?.sendersCorrespondentMt752 == 'D' ? true : false}"/>
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="senderNameAndAddressMt752" value="${details?.senderNameAndAddressMt752}" rows="4" readonly="readonly"></g:textArea>
		<%-- 
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt752_popup_btn_sender_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="4"><span class="title_label">54<span class="receiversCorrespondentMt752202OptionLetter title_label">a</span>: Receiver's Correspondent</span></td>
	</tr>
	<tr>	
		<td>
			<g:radio name="receiversCorrespondentMt752" class="receiversCorrespondentMt752 mt-radio receiverCorrespondentOptionA" value="A" checked="${details?.receiversCorrespondentMt752 == 'A' ? true : false}" />
			&#160;<span class="field_label">Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop" name="receiverIdentifierCodeMt752" id="receiverIdentifierCodeMt752" value="${details?.receiverIdentifierCodeMt752}" /></td>
	</tr>
	<tr>
		<td>
			<g:radio name="receiversCorrespondentMt752" class="receiversCorrespondentMt752 mt-radio receiverCorrespondentOptionB" value="B"  checked="${details?.receiversCorrespondentMt752 == 'B' ? true : false}" />
			&#160;<span class="field_label">Party Identifier</span>	
		</td>
		<td colspan="3"><g:textField class="fields-textarea input_field" name="receiverPartyIdentifierMt752" value="${details?.receiverPartyIdentifierMt752}"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Location</span></td>
		<td><g:textArea name="receiverLocationMt752" class="fields-textarea textarea" maxlength="34" value="${details?.receiverLocationMt752}" rows="4"/></td>
	</tr>
	<tr>	
		<td valign="top">
			<g:radio name="receiversCorrespondentMt752" class="receiversCorrespondentMt752 mt-radio receiverCorrespondentOptionD" value="D" checked="${details?.receiversCorrespondentMt752 == 'D' ? true : false}" />
			&#160;<span class="field_label">Name and Address</span>
		</td>
		<td>
			<g:textArea class="fields-textarea textarea" name="receiverNameAndAddressMt752" value="${details?.receiverNameAndAddressMt752}" rows="4" readonly="readonly"></g:textArea>
		<%--
		</td>
		<td valign="bottom" colspan="2">	
			<span>&#160;<span id="remainingCharacterSenders"></span>&#160;Characters Left</span><br />
			<span>&#160;<span id="remainingLineSenders"></span>&#160;Lines Left</span>
		--%>
			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt752_popup_btn_receiver_correspondent">...</a>
		</td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label title_label">72Z: Sender to Receiver Information</span></td>
		<td colspan="2">
			<tfs:senderToReceiverTypeforMT752 name="senderToReceiver" class="newSenderToReceiver" value="${details?.senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>
			<g:textArea class="textarea" name="senderToReceiverInformation" readonly="readonly" value="${details?.senderToReceiverInformation}" rows="6"></g:textArea>			
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
	</tr>
       <tr>
        <td valign="top"><span class="field_label title_label">79Z: Narrative</span></td>
        <td>
            <g:textArea class="textarea" name="narrative" readonly="readonly" value="${details?.narrative}" rows="6"></g:textArea>           
            <a href="javascript:void(0)" class="search_btn" id="popup_btn_narrative">...</a>
        </td>
    </tr>
<%--	<tr>--%>
<%--		<td>&#160;</td>--%>
<%--		<td>--%>
<%--			<g:textArea class="textarea" name="senderToReceiverInformationMt752" readonly="readonly" value="${details?.senderToReceiverInformationMt752}" rows="6"></g:textArea>--%>
<%--			<a href="javascript:void(0)" class="popup_btn_bottom" id="mt752_popup_btn_sender_receiver_information">...</a>--%>
<%--		</td>--%>
<%--	</tr>--%>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 752" onclick="viewOutgoingMt(752)"/>
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
		$("input#negotiationCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("input#negotiationCurrency").val()});
		$("#senderIdentifierCodeMt752").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.senderIdentifierCodeMt752}'});
		$("#receiverIdentifierCodeMt752").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.receiverIdentifierCodeMt752}'});
		$("#negotiatingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.negotiatingBank}'});


		if($("#documentSubType2").val() == null || typeof $("#documentSubType2").val() == 'undefined'){
            $('.optionA').prop('checked', false);			
            $('.optionB').prop('checked', false);
            $('#maturityDateRequired').hide();            
		}

        if($("#documentSubType2").val() == "USANCE"){
            $('.optionA').prop('checked', true);
            $('.optionB').prop('disabled', true);
   		 	$("#netAmountDateMt752").toggleClass("required", true);            
            $('#maturityDateRequired').show();     
        } else {
        	$('.optionB').prop('disabled', false)
            $('.optionB').prop('checked', true);
   		 	$("#netAmountDateMt752").toggleClass("required", false);    
            $('#maturityDateRequired').hide();
        }
		 
		$("#furtherIdentificationMt752").change(function(){
            if($("#furtherIdentificationMt752").val() == "DEBIT" || $("#furtherIdentificationMt752").val() == "REMITTED"){
                $('.optionB').prop('disabled', true);
                $('.optionA').prop('checked', true);
       		 	$("#netAmountDateMt752").toggleClass("required", true);  
                $('#maturityDateRequired').show();
            } else {
                $('.optionB').prop('disabled', false)
       		 	$("#netAmountDateMt752").toggleClass("required", false);
            }
	    });
	    
	    $(".optionA").click(function(){
	            $('#maturityDateRequired').show();
       		 	$("#netAmountDateMt752").toggleClass("required", true);  	            
	    });
	    $(".optionB").click(function(){
	            $('#maturityDateRequired').hide();
       		 	$("#netAmountDateMt752").toggleClass("required", false);  
	    });

		$("#discrepancyAmountMt752").change(computeNetAmountForMt);
		$("#negoAmountMt752").change(computeNetAmountForMt);

	    function computeNetAmountForMt() {		    
			var negotiationAmount = 0;
		    var discrepancyAmount = 0;
	
		    if("undefined" !== typeof $("#negoAmountMt752").val() && $("#negoAmountMt752").val() != ""){
		    	negotiationAmount = parseFloat($("#negoAmountMt752").val().replace(/,/g,""));
		    }
		    
		    if("undefined" !== typeof $("#discrepancyAmountMt752").val() && $("#discrepancyAmountMt752").val() != "") {
		        discrepancyAmount = parseFloat($("#discrepancyAmountMt752").val().replace(/,/g,""));
		    }
	
		    var netAmount = negotiationAmount - discrepancyAmount;
	
		    if(netAmount < 0) {
		        netAmount = 0;
		    }
	
		    $("#netAmountMt752").val(formatCurrency(netAmount));
	    }	    
	});
</script>