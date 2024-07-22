<%@ page import="net.ipc.utils.DateUtils" %>
<%-- Added --%>
<g:javascript src="js-temp/validation_Amendment_ets.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />
<g:hiddenField name="tenor" value="${tenor}" />

<g:hiddenField name="productAmount" value="${productAmount}" />
<g:hiddenField name="outstandingBalance" value="${outstandingBalance}" />

%{--used to pass fields from ets to data entry (data came from opening)--}%
<g:hiddenField name="expiryCountryCode" value="${expiryCountryCode}" />
<g:hiddenField name="destinationBank" value="${destinationBank}" />
<g:hiddenField name="applicableRules" value="${applicableRules}" />
<g:hiddenField name="formOfDocumentaryCredit" value="${formOfDocumentaryCredit}" />

<g:hiddenField name="usancePeriod" value="${usancePeriod}" />
<g:hiddenField name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" />
<g:hiddenField name="swiftNarrativeRadio" value="${swiftNarrativeRadio}" />

%{--fields from importer/exporter details--}%
<g:hiddenField name="importerCbCode" value="${importerCbCode}" />
<g:hiddenField name="importerCifNumber" value="${importerCifNumber}" />
<g:hiddenField name="importerName" value="${importerName}" />
<g:hiddenField name="importerAddress" value="${importerAddress}" />
<g:hiddenField name="exporterCbCode" value="${exporterCbCode}" />
<g:hiddenField name="exporterName" value="${exporterName}" />
<g:hiddenField name="exporterAddress" value="${exporterAddress}" />
<g:hiddenField name="positiveToleranceLimit" value="${positiveToleranceLimit}" />
<g:hiddenField name="negativeToleranceLimit" value="${negativeToleranceLimit}" />
<g:hiddenField name="maximumCreditAmount" value="${maximumCreditAmount}" />
<g:hiddenField name="additionalAmountsCovered" value="${additionalAmountsCovered}" />
<g:hiddenField name="availableWith" value="${availableWith}" />
<g:hiddenField name="availableWithFlag" value="${availableWithFlag}" />
<g:hiddenField name="identifierCode" value="${identifierCode}" />
<g:hiddenField name="nameAndAddress" value="${nameAndAddress}" />
<g:hiddenField name="availableBy" value="${availableBy}" />
<g:hiddenField name="drawee" value="${drawee}" />
<g:hiddenField name="mixedPaymentDetails" value="${mixedPaymentDetails}" />
<g:hiddenField name="deferredPaymentDetails" value="${deferredPaymentDetails}" />
<g:hiddenField name="partialShipment" value="${partialShipment}" />
<g:hiddenField name="transShipment" value="${transShipment}" />
<g:hiddenField name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceipt}" />
<g:hiddenField name="portOfLoadingOrDeparture" value="${portOfLoadingOrDeparture}" />
<g:hiddenField name="portOfDischargeOrDestination" value="${portOfDischargeOrDestination}" />
<g:hiddenField name="placeOfFinalDestination" value="${placeOfFinalDestination}" />
<g:hiddenField name="bspCountryCode" value="${bspCountryCode}" />

%{--fields from shipments, goods--}%
<g:hiddenField name="latestShipmentDate" value="${latestShipmentDate}" />
<g:hiddenField name="shipmentPeriod" value="${shipmentPeriod}" />
<g:hiddenField name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" />

<g:hiddenField name="periodForPresentation" value="${periodForPresentation}" />

<g:hiddenField name="reimbursingBankFlag" value="${reimbursingBankFlag}" />
<g:hiddenField name="reimbursingBankIdentifierCode" value="${reimbursingBankIdentifierCode}" />
<g:hiddenField name="reimbursingBankNameAndAddress" value="${reimbursingBankNameAndAddress}" />
<g:hiddenField name="reimbursingAccountType" value="${reimbursingAccountType}" />
<g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency}" />
<g:hiddenField name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}" />

<g:hiddenField name="adviseThroughBankFlag" value="${adviseThroughBankFlag}" />
<g:hiddenField name="adviseThroughBankIdentifierCode" value="${adviseThroughBankIdentifierCode}" />
<g:hiddenField name="adviseThroughBankLocation" value="${adviseThroughBankLocation}" />
<g:hiddenField name="adviseThroughBankNameAndAddress" value="${adviseThroughBankNameAndAddress}" />

<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />
<g:hiddenField name="senderToReceiverInformationNarrative" value="${senderToReceiverInformationNarrative}" />

<g:hiddenField name="numberOfAmendments" value="${numberOfAmendments}" />
<g:hiddenField name="confirmationInstructionsFlag" value="${confirmationInstructionsFlag}" />

<g:hiddenField name="purposeOfMessage" value="${purposeOfMessage}" />
<g:hiddenField name="otherPlaceOfExpiry" value="${otherPlaceOfExpiry}" />
<g:hiddenField name="specialPaymentConditionsForBeneficiary" value="${specialPaymentConditionsForBeneficiary}" />
<g:hiddenField name="specialPaymentConditionsForReceivingBank" value="${specialPaymentConditionsForReceivingBank}" />
<g:hiddenField name="chargesNarrative" value="${chargesNarrative}" />
<g:hiddenField name="periodForPresentationNumber" value="${periodForPresentationNumber}" />
<g:hiddenField name="requestedConfirmationParty" value="${requestedConfirmationParty}" />
<g:hiddenField name="expiryCountryName" value="${expiryCountryName}" />

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
    <tr>
        <td class="label_width"><span class="field_label"> eTS Number </span></td>
        <td class="input_width"><g:textField name="etsNumber" value="${serviceInstructionId}" class="input_field" readonly="readonly"/></td>
        <td class="label_width"><span class="field_label"> eTS Date </span></td>
        <td class="input_width"><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field date" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Document Number </span></td>
        <td class="input_width"><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
        <td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="tinNumber" value="${tinNumber}"/> </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Processing Unit Code </span></td>
        <td class="input_width"><g:textField  name="processingUnitCode" value="${processingUnitCode}" class="input_field unitCode" readonly="readonly"/></td>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Facility Type </span></td>
        <td class="input_width"><g:textField  name="facilityType" value="${facilityType}" class="input_field facilityType" readonly="readonly"/></td>
        <td class="label_width"> <span class="field_label"> Commodity Code</span></td>
		<td class="input_width">
		    <%-- Auto Complete --%>
		    <input class="select2_dropdown" name="commodity" id="commodity" disabled="disabled"/>
		    <g:hiddenField name="commodityCode" value="${commodityCode}" />
		</td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> Main CIF Number </span></td>
        <td class="input_width"><g:textField  name="mainCifNumber" value="${mainCifNumber}" class="input_field" readonly="readonly"/></td>
        <td class="label_width"><span class="field_label"> Main CIF Name </span></td>
        <td class="input_width"><g:textField  name="mainCifName" value="${mainCifName}" class="input_field" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> FXLC Type </span></td>
        <td class="input_width"><g:textField  name="type" class="input_field type" readonly="readonly" value="${type ?: 'REGULAR'}"/></td>
        <td class="label_width">
            <span class="field_label"> FXLC issue Date </span>
        </td>
        <td class="input_width"><g:textField  name="issueDate" value="${issueDate}" class="input_field date" readonly="readonly"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label"> FXLC Currency </span></td>
        <td class="input_width"><g:textField  name="currency" class="input_field currency" value="${currency}" readonly="readonly"/></td>
        <td class="label_width"><span class="field_label"> FXLC Amount </span></td>
<%--        <td class="input_width"><g:textField  name="outstandingBalance" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>--%>
        <td class="input_width"><g:textField  name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<%-- Added Field --%>
	<tr>
		<td class="label_width"> 
			<span class="field_label"> FXLC Amendment Date<span class="asterisk">*</span> </span>
	 	</td>
		<td class="input_width"><g:textField  name="amendmentDate" class="datepicker_field date required" value="${amendmentDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
		<td class="label_width"> <span class="field_label"> With 2% CWT?<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
    </tr>
</table><%-- End of SEARCH Form--%>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script>
	$(document).ready(function() {
		var commodityCode = $('#commodityCode').val();

		if(commodityCode) {
	        $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    } else {
	        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
	    }
	});
</script>
