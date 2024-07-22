
<%@ page import="net.ipc.utils.DateUtils" %>
<%--
	[Created by:] Cedrick C. Nungay
	Date: 01/04/19 --%>
	
<g:render template="/grails-app/views/commons/popups/other_place_of_expiry_popup"/>
<g:javascript src="popups/other_place_of_expiry_mt740_popup.js" />
<g:render template="/grails-app/views/commons/popups/additional_amounts_covered_popup"/>
<g:javascript src="popups/additional_amounts_covered_popup.js" />
<g:render template="/grails-app/views/commons/popups/exporter_address_popup"/>
<g:javascript src="popups/exporter_address_popup.js" />
<g:render template="/grails-app/views/commons/popups/bank_address_popup"/>
<g:javascript src="popups/bank_address_popup.js" />
<g:render template="/grails-app/views/commons/popups/tenor_of_drafts_popup"/>
<g:javascript src="popups/tenor_of_drafts_popup.js" />
<g:render template="/grails-app/views/commons/popups/mixed_payment_details_popup"/>
<g:javascript src="popups/mixed_payment_details_popup.js" />
<g:render template="/grails-app/views/commons/popups/deferred_payment_details_popup"/>
<g:javascript src="popups/deferred_payment_details_popup.js" />
<g:render template="/grails-app/views/commons/popups/other_charges_popup"/>
<g:javascript src="popups/other_charges_popup.js" />
<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />

<g:hiddenField name="messageType" value="740"/>
<g:hiddenField name="chainName" value="viewMT740"/><%-- Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%-- Used for disabling tab/s in basic_details_utility --%>
<g:hiddenField name="out740flag" value="Y"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label">Reimbursing Bank<span class="asterisk">*</span></span></td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="destinationBank" id="destinationBank" value="${ details?.destinationBank }" /></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">20: Document Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumber" class="input_field documentNumber" value="${details?.documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">25: Account Identification</span></td>
		<td><g:textField name="reimbursingBankAccountNumber" class="input_field reimbursingBankAccountNumber" value="${details?.reimbursingBankAccountNumber}"/></td>
	</tr>
    <tr>
        <td><span class="field_label title_label">40F: Applicable Rules<span class="asterisk">*</span> </span></td>
        <td><g:select name="applicableRules" value="${details?.applicableRules}" from="${['NOTURR','URR LATEST VERSION']}" class="select_dropdown required" noSelection="['':'SELECT ONE']"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">31D: Expiry Date</span></td>
        <td><g:textField name="expiryDate" value="${details?.expiryDate}" class="datepicker_field" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Expiry Country Code</span></td>
        <td><input class="tags_country select2_dropdown bigdrop" name="expiryCountryCode" id="expiryCountryCode" value="${ details?.expiryCountryCode }" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Expiry Country Name</span></td>
        <td><g:textField name="expiryCountryLabel" class="input_field" value="${ details?.expiryCountryLabel }" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Other Place of Expiry</span></td>
        <td>
            <g:textArea name="otherPlaceOfExpiry"  class="textarea" readonly="readonly" rows="4" value="${details?.otherPlaceOfExpiry}"/>
            <a href="javascript:void(0)" class="popup_btn_bottom other_place_of_expiry" id="popup_btn_other_place_of_expiry">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">58A: Negotiating Bank</span></td>
        <td><input class="tags_bank select2_dropdown bigdrop" name="negotiatingBank" id="negotiatingBank" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">59: Beneficiary</span></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Name</span></td>
        <td><g:textField name="exporterName" class="input_field" value="${details?.exporterName}"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Address</span></td>
        <td>
            <g:textArea class="textarea" name="exporterAddress" value="${details?.exporterAddress}" rows="4" readonly="readonly"/>
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_exporter_address">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">32B: Credit Amount Currency<span class="asterisk">*</span></span></td>
        <td><input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" value="${details?.currency}"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">32B: Credit Amount<span class="asterisk">*</span></span></td>
        <td><g:textField name="amount" value="${details?.amount}" class="input_field" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">39A: Percentage Credit Amount Tolerance</span></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Positive Tolerance Limit</span></td>
        <td><g:textField name="positiveToleranceLimit" value="${details?.positiveToleranceLimit}" class="input_field numericCurrency" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Negative Tolerance Limit</span></td>
        <td><g:textField name="negativeToleranceLimit" value="${details?.negativeToleranceLimit}" class="input_field numericCurrency" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">39C: Additional Amounts Covered</span></td>
        <td>
            <g:textArea class="textarea" name="additionalAmountsCovered" value="${details?.additionalAmountsCovered}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_additional_amounts_covered">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">41A: Available With<span class="asterisk">*</span></span></td>
    </tr>
    <tr>
        <td>
            <input type="radio" id="availableWithFlagA" name="availableWithFlag" value="A" style="margin-left: 25px;"/>
            <label for="availableWithFlagA">&nbspOption A</label><br/><label for="availableWithFlagA" style="margin-left: 43px;">Identifier Code</label>
        </td>
        <td><input class="tags_bank select2_dropdown bigdrop" name="availableWith" id="availableWith" /></td>
    </tr>
    <tr>
        <td>
            <input type="radio" id="availableWithFlagD" name="availableWithFlag" value="D" style="margin-left: 25px;"/>
            <label for="availableWithFlagD">&nbspOption D</label><br/><label for="availableWithFlagD" style="margin-left: 43px;">Name and Address</label></td>
        <td>
            <g:textArea class="textarea" name="nameAndAddress" value="${details?.nameAndAddress}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_bank_address">...</a>
        </td>
    </tr>
    <tr>
	    <td><span class="field_label" style="margin-left: 25px;">By... <span class="asterisk">*</span></span></td>
	    <td>
	        <tfs:availableBy id="availableBy" name="availableBy" class="select_dropdown required" value="${details?.availableBy}" />
	    </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">42A: Drawee</span></td>
        <td><input class="tags_bank select2_dropdown bigdrop" name="drawee" id="drawee" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">42C: Tenor of Draft(Narrative)</span></td>
        <td>
            <g:textArea class="textarea" name="tenorOfDraftNarrative" value="${details?.tenorOfDraftNarrative}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_tenor_draft">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">42M: Mixed Payment Details</span></td>
        <td>
            <g:textArea class="textarea" name="mixedPaymentDetails" value="${details?.mixedPaymentDetails}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_mixed_payments_details">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">42P: Negotiation/Deferred Payment Details</span></td>
        <td>
            <g:textArea class="textarea" name="deferredPaymentDetails" value="${details?.deferredPaymentDetails}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_deferred_payments_details">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">71A: Reimbursing Bank's Charges</span></td>
        <td><g:select name="reimbursingBankCharges" value="${details?.reimbursingBankCharges}" from="${['CLM','OUR']}" class="select_dropdown" noSelection="['':'SELECT ONE']"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">71D: Other Charges</span></td>
        <td>
            <g:textArea class="textarea" name="otherCharges" value="${details?.otherCharges}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_other_charges">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">72Z: Sender to Receiver Information</span></span></td>
        <td><tfs:senderToReceiverTypeforMT700 name="senderToReceiver" value="${details?.senderToReceiver}" class="newSenderToReceiver"/></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <g:textArea class="textarea" name="senderToReceiverInformation" value="${details?.senderToReceiverInformation}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="new_sender_info">...</a>
        </td>
    </tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 740" onclick="viewOutgoingMt(740)"/>
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
	$("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.destinationBank}'});
	$("#expiryCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${details?.expiryCountryCode}'})
	.on("change",function(e){
        if("" == e.val){
            $("#expiryCountryLabel").val("");
        }else{
            $("#expiryCountryLabel").val($.trim($(this).select2('data').label));
        }
    });
	$("#negotiatingBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.negotiatingBank}'});
	$("#drawee").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.drawee}'});
	$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${details?.currency}'});
    if ('${details?.availableWithFlag}' == 'A') {
      console.log('bitin na bitin');
      $('#availableWithFlagA').attr('checked', true);
    } else if ('${details?.availableWithFlag}' == 'D') {
    	console.log('di mo lang alam');
      $('#availableWithFlagD').attr('checked', true);
    }

    $("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.availableWith}'});
});
</script>
