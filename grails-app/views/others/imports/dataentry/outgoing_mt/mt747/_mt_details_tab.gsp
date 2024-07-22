
<%@ page import="net.ipc.utils.DateUtils" %>
<%--
	[Created by:] Cedrick C. Nungay
	Date: 01/04/19 --%>

<g:render template="/grails-app/views/commons/popups/additional_amounts_covered_popup"/>
<g:javascript src="popups/additional_amounts_covered_popup.js" />
<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
<g:javascript src="popups/sender_receiver_popup.js" />
<g:render template="/grails-app/views/commons/popups/narrative_popup"/>
<g:javascript src="popups/narrative_popup.js" />

<g:hiddenField name="messageType" value="747"/>
<g:hiddenField name="chainName" value="viewMT747"/><%-- Used for chaining in saveOutgoingMt action --%>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/><%-- Used for disabling tab/s in basic_details_utility --%>
<g:hiddenField name="out747flag" value="Y"/>
<g:hiddenField name="increaseAmount" value="${ details?.increaseAmount }"/>
<g:hiddenField name="decreaseAmount" value="${ details?.decreaseAmount }"/>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label title_label">Reimbursing Bank<span class="asterisk">*</span></span></td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="reimbursingBankIdentifierCode" id="reimbursingBankIdentifierCode" value="${ details?.reimbursingBankIdentifierCode }" /></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">20: Document Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumber" class="input_field documentNumber" value="${details?.documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">21: Reimbursing Bank's Reference</span></td>
		<td><g:textField name="reimbursingBankAccountNumber" class="input_field reimbursingBankAccountNumber" value="${details?.reimbursingBankAccountNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">30: Date of the Original Authorization to Reimburse<span class="asterisk">*</span></span></td>
		<td><g:textField name="amendmentDate" class="datepicker_field" value="${details?.amendmentDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">31E: New Date of Expiry</span></td>
		<td><g:textField name="expiryDateTo" class="datepicker_field" value="${details?.expiryDateTo}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">32B: Documentary Credit Amount Currency</span></td>
		<td><input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" value="${details?.currency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">32B: Increase of Documentary Credit Amount</span></td>
		<td><g:textField name="increaseAmountInput" class="input_field numericCurrency" value="${details?.increaseAmount}" /></td>
	</tr>
	<tr>
		<td><span class="field_label title_label">33B: Decrease of Documentary Credit Amount</span></td>
		<td><g:textField name="decreaseAmountInput" class="input_field numericCurrency" value="${details?.decreaseAmount}"/></td>
	</tr>
    <tr>
        <td><span class="field_label title_label">34B: New Documentary Credit Amount Currency</span></td>
        <td><input class="tags_currency select2_dropdown bigdrop" name="newCurrency" id="newCurrency" value="${details?.newCurrency}"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">34B: New Documentary Credit Amount After Amendment</span></td>
        <td><g:textField name="newAmount" class="input_field numericCurrency" value="${details?.newAmount}"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">39A: Percentage Credit Amount Tolerance</span></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Positive Tolerance Limit</span></td>
        <td><g:textField name="positiveToleranceLimit" value="${details?.positiveToleranceLimit}" class="input_field numericQuantity" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label" style="margin-left: 25px;">Negative Tolerance Limit</span></td>
        <td><g:textField name="negativeToleranceLimit" value="${details?.negativeToleranceLimit}" class="input_field numericQuantity" /></td>
    </tr>
    <tr>
        <td><span class="field_label title_label">39C: Additional Amounts Covered</span></td>
        <td>
            <g:textArea class="textarea" name="additionalAmountsCovered" value="${details?.additionalAmountsCovered}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_additional_amounts_covered">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">72Z: Sender to Receiver Information</span></span></td>
        <td><g:select name="senderToReceiver" value="${details?.senderToReceiver}" from="${['CANC']}" class="select_dropdown newSenderToReceiver" noSelection="['':'SELECT ONE']"/></td>
    </tr>
    <tr>
        <td></td>
        <td>
            <g:textArea class="textarea" name="senderToReceiverInformation" value="${details?.senderToReceiverInformation}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="new_sender_info">...</a>
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label">77: Narrative</span></td>
        <td>
            <g:textArea class="textarea" name="narrative" value="${details?.narrative}" rows="4" readonly="readonly" />
            <a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_narrative">...</a>
        </td>
    </tr>
</table>
<br /><br />
<table class="buttons_for_grid_wrapper">
	<g:if test="${tradeServiceId?.tradeServiceId != null}">
		<tr>
			<td>
				<input type="button" class="input_button2" value="View MT 747" onclick="viewOutgoingMt(747)"/>
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
	$("#reimbursingBankIdentifierCode").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${details?.reimbursingBankIdentifierCode}'});
	$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${details?.currency}'});
	$("#newCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${details?.newCurrency}'});

	$('#increaseAmountInput').attr('disabled', ${details?.decreaseAmount != ''});
	$('#decreaseAmountInput').attr('disabled', ${details?.increaseAmount != ''});
});
</script>
