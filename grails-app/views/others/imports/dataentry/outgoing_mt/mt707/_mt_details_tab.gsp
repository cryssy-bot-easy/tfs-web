
<%@ page import="net.ipc.utils.DateUtils" %>
<%-- 
   [Modified by:] Rafael Ski Poblete
   [Modified date:] 09/11/2018
   [Details] 
--%>
<g:hiddenField name="messageType" value="707"/>
<g:hiddenField name="chainName" value="viewMT707"/>
<g:hiddenField name="outgoingTradeServiceId" value="${tradeServiceId?.tradeServiceId}"/>
<g:hiddenField name="purposeOfMessageSwitch" value="off"/>
<g:hiddenField name="formOfDocumentaryCreditSwitch" value="off"/>
<g:hiddenField name="applicableRulesSwitch" value="off"/>
<g:hiddenField name="expiryDateSwitch" value="off"/>
<g:hiddenField name="importerNameSwitch" value="off"/>
<g:hiddenField name="exporterNameSwitch" value="off"/>
<g:hiddenField name="amountSwitchDisplay" value="off"/>
<g:hiddenField name="positiveToleranceLimitSwitchDisplay" value="off"/>
<g:hiddenField name="additionalAmountsCoveredSwitch" value="off"/>
<g:hiddenField name="availableWithSwitch" value="off"/>
<g:hiddenField name="tenorSwitch" value="off"/>
<g:hiddenField name="draweeSwitch" value="off"/>
<g:hiddenField name="mixedPaymentDetailsSwitch" value="off"/>
<g:hiddenField name="deferredPaymentDetailsSwitch" value="off"/>
<g:hiddenField name="partialShipmentSwitch" value="off"/>
<g:hiddenField name="transShipmentSwitch" value="off"/>
<g:hiddenField name="placeOfTakingDispatchOrReceiptSwitch" value="off"/>
<g:hiddenField name="portOfLoadingOrDepartureSwitch" value="off"/>
<g:hiddenField name="portOfDischargeOrDestinationSwitch" value="off"/>
<g:hiddenField name="placeOfFinalDestinationSwitch" value="off"/>
<g:hiddenField name="latestShipmentDateSwitch" value="off"/>
<g:hiddenField name="shipmentPeriodSwitch" value="off"/>
<g:hiddenField name="generalDescriptionOfGoodsSwitch" value="off"/>
<g:hiddenField name="mtDocumentsSwitch" value="off"/>
<g:hiddenField name="mtConditionsSwitch" value="off"/>
<g:hiddenField name="specialPaymentConditionsForBeneficiarySwitch" value="off"/>
<g:hiddenField name="specialPaymentConditionsForReceivingBankSwitch" value="off"/>
<g:hiddenField name="chargesNarrativeSwitch" value="off"/>
<g:hiddenField name="periodForPresentation1Switch" value="off"/>
<g:hiddenField name="confirmationInstructionsFlagSwitchDisplay" value="off"/>
<g:hiddenField name="requestedConfirmationPartySwitchDisplay" value="off"/>
<g:hiddenField name="reimbursingBankSwitchDisplay" value="off"/>
<g:hiddenField name="adviseThroughBankSwitchDisplay" value="off"/>
<g:hiddenField name="senderToReceiverSwitch" value="off"/>
<g:hiddenField name="field707O" value="707O"/>








<table class="tabs_forms_table MT707">
    <tr>
        <td><span class="field_label title_label"> Destination Bank<span class="asterisk">*</span> </span></td>
        <td>
            <input class="tags_bank select2_dropdown bigdrop" name="destinationBank" id="destinationBank" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 20: Sender's Reference <span class="asterisk">*</span> </span></td>
        <td><g:textField class="input_field" name="documentNumber" value="${details?.documentNumber}" maxlength="16"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 21: Receiver's Reference<span class="asterisk">*</span> </span></td>
        <td><g:textField class="input_field" name="receiversReference" value="${details?.receiversReference}" maxlength="16"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 23: Issuing Bank Reference<span class="asterisk">*</span> </span></td>
        <td><g:textField class="input_field" name="issuingBankReference" value="${details?.issuingBankReference}" maxlength="16"/></td>
        <g:hiddenField name="out707flag" value="707O"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 31C: Date Of Issue<span class="asterisk">*</span> </span></td>
        <td><g:textField class="datepicker_field" name="dateOfIssue" value="${details?.dateOfIssue}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 26E: Number Of Amendments<span class="asterisk">*</span> </span></td>
        <td><g:textField class="input_field numericWithNumpad" name="numberOfAmendments" value="${details?.numberOfAmendments}" maxlength="2"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 30: Date Of Amendment<span class="asterisk">*</span> </span></td>
        <td><g:textField class="datepicker_field" name="processDate" value="${details?.processDate}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 22A: Purpose Of Message<span class="asterisk">*</span> </span></td>
        <td>
            <input class="select2_dropdown bigdrop" name="purposeOfMessage" id="purposeOfMessage" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label title_label"> 23S: Cancellation Request<span class="asterisk">*</span> </span></td>
        <td><g:textField class="input_field_right" name="cancellationRequest" value="CANCEL" readonly="readonly"/></td>
    </tr>
</table>
<table class="buttons_for_grid_wrapper">
    <g:if test="${tradeServiceId?.tradeServiceId != null}">
        <tr>
            <td>
                <input type="button" class="input_button2" value="View MT 707" onclick="viewOutgoingMt('707')"/>
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
        $("#destinationBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${details?.destinationBank}'});
        $("#purposeOfMessage").setPurposeOfMessageDropdown($(this).attr("id")).select2('data', { id: '${details?.purposeOfMessage}' });

    });
</script>