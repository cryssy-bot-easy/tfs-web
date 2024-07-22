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

<g:hiddenField name="productAmount" value="${productAmount}" />
<g:hiddenField name="outstandingBalance" value="${outstandingBalance}" />

<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

<g:hiddenField name="documentNumber" value="${documentNumber}" />
<g:hiddenField name="tenor" value="${tenor}" />

%{--used to pass fields from ets to data entry (data came from opening)--}%
<g:hiddenField name="expiryCountryCode" value="${expiryCountryCode}" />
<g:hiddenField name="destinationBank" value="${destinationBank}" />
<g:hiddenField name="applicableRules" value="${applicableRules}" />
<g:hiddenField name="formOfDocumentaryCredit" value="${formOfDocumentaryCredit}" />

<g:hiddenField name="usancePeriod" value="${usancePeriod}" />
<g:hiddenField name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" />

<g:hiddenField name="detailsOfGuarantee" value="${detailsOfGuarantee}" />
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

<g:hiddenField name="senderToReceiver" value="${senderToReceiver}" />
<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />

<g:hiddenField name="purposeOfStandby" value="${purposeOfStandby}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}" />
<g:hiddenField name="furtherIdentification" value="${furtherIdentification}" />

<g:hiddenField name="numberOfAmendments" value="${numberOfAmendments}" />
<g:hiddenField name="confirmationInstructionsFlag" value="${confirmationInstructionsFlag}" />

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width">
                <span class="field_label"> eTS Number </span>
        </td>
		<td class="input_width"> <g:textField class="input_field input_twelve" name="etsNumber" value="${serviceInstructionId}" readonly="readonly" /> </td>
		<td class="label_width">
                <span class="field_label"> eTS Date </span>
        </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
  	<tr>
		<td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
  	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code </span> </td>
		<td class="input_width">
            <g:textField  name="processingUnitCode" value="${processingUnitCode}" class="input_field unitCode" readonly="readonly"/>
		</td>
		<td class="label_width"> <span class="field_label"> FXLC Issue Date </span>  </td>
	        <td class="input_width"> <g:textField class="input_field lc_issue" name="issueDate" value="${issueDate}" readonly="readonly"/> </td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="${type ?: 'STANDBY'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="facilityType" readonly="readonly" value="${facilityType}"/> </td>
		<td class="label_width"> <span class="field_label"> Facility ID </span> </td>
		<td class="input_width">
            <g:textField class="input_field" name="facilityId" readonly="readonly" value="${facilityId}"/>
		<a href="javascript:void(0)" class="search_btn popup_btn_facility"> Search/Look-up Button </a> </td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Currency </span> </td>
		<td class="input_width"> 
          <g:textField  name="currency" class="input_field currency" value="${currency}" readonly="readonly"/>
		</td>
		<td class="label_width"> <span class="field_label"> FXLC Amount</span> </td>
		<td class="input_width"> 
<%--		  <g:textField class="input_field_right input_fifteen lc_amount numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly"/>--%>
		  <g:textField class="input_field_right input_fifteen lc_amount numericCurrency" name="amount" value="${outstandingBalance}" readonly="readonly"/>
		</td>
	</tr>
 	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Expiry Date </span> </td>
		<td class="input_width"> <g:textField class="input_field lc_expiry" name="expiryDate" value="${expiryDate}" readonly="readonly"/></td>
   
		<td class="label_width"> <span class="field_label"> With 2% CWT?<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="disabled">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
<%--		  	<g:radioGroup name="confirmationInstructionsFlag" class="required" labels="['Yes','No','May Add']" values="['Y','N','M']" value="${confirmationInstructionsFlag}" disabled="disabled">--%>
<%--		          ${it.radio}&#160;<g:message code="${it.label}" />--%>
<%--		    </g:radioGroup>--%>
		</td>
	</tr>
	<%-- Added --%>
	<tr>
		<td class="label_width"> 
			<span class="field_label"> FXLC Amendment Date<span class="asterisk">*</span> </span>
	 	</td>
		<td class="input_width"><g:textField  name="amendmentDate" class="datepicker_field date required" value="${amendmentDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>

</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
