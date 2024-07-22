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

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />

<g:hiddenField name="productAmount" value="${productAmount}" />
<g:hiddenField name="outstandingBalance" value="${outstandingBalance}" />

<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="tenor" value="${tenor}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>

%{--used to pass fields from ets to data entry (data came from opening)--}%
<g:hiddenField name="applicantCifNumber" value="${applicantCifNumber}" />
<g:hiddenField name="applicantName" value="${applicantName}" />
<g:hiddenField name="applicantAddress" value="${applicantAddress}" />
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}" />

%{--fields from shipments, goods--}%
<g:hiddenField name="latestShipmentDate" value="${latestShipmentDate}" />
<g:hiddenField name="shipmentPeriod" value="${shipmentPeriod}" />
<g:hiddenField name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" />
<g:hiddenField name="availableBy" value="${availableBy}" />
<g:hiddenField name="usancePeriod" value="${usancePeriod}" />
<g:hiddenField name="tenorOfDraft" value="${tenorOfDraft}" />
<g:hiddenField name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" />
<g:hiddenField name="partialDelivery" value="${partialDelivery}" />
<g:hiddenField name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceipt}" />
<g:hiddenField name="placeOfFinalDestination" value="${placeOfFinalDestination}" />

<g:hiddenField name="numberOfAmendments" value="${numberOfAmendments}" />
<g:hiddenField name="narrative" value="${narrative}" id="_narrative"/>

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
		<td class="label_width"><span class="field_label"> eTS Date (mm/dd/yyyy) </span></td>
		<td><g:textField  name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field date" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label"> DMLC Issue Date </span></td>
		<td><g:textField  name="issueDate" value="${issueDate}" class="input_field date" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField  name="processingUnitCode" value="${processingUnitCode}" class="input_field unitCode" readonly="readonly"/></td>
		<td><span class="field_label"> DMLC Expiry Date </span></td>
		<td><g:textField  name="expiryDate" value="${expiryDate}" class="input_field date" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Type </span></td>
		<td><g:textField name="type" class="input_field type" readonly="readonly" value="${type ?: 'REGULAR'}"/></td>
		<td><span class="field_label"> DMLC Amount </span></td>
<%--		<td><g:textField name="outstandingBalance" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>--%>
		%{--<td><g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${productAmount}"/></td>--}%
		<td><g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Currency </span></td>
		<td><g:textField name="currency" value="${currency}" class="input_field currency" readonly="readonly"/></td>
	</tr>
	<%-- Added --%>
	<tr>
		<td class="label_width"> 
			<span class="field_label"> DMLC Amendment Date<span class="asterisk">*</span> </span>
			<br />
			<span class="field_label"> (mm/dd/yyyy) </span>
	 	</td>
		<td class="input_width"><g:textField  name="amendmentDate" class="datepicker_field date required" value="${amendmentDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
		<td><span class="field_label">With 2% CWT? <span class="asterisk">*</span></span></td>
		<td>

			<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
				${it.radio} ${it.label}&#160;&#160;
			</g:radioGroup>
			<input type="hidden" name="cwt" />
		</td>
	</tr>
	
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />