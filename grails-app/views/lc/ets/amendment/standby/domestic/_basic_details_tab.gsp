<%@ page import="net.ipc.utils.DateUtils" %>
<%-- Added --%>
<g:javascript src="js-temp/validation_Amendment_ets.js"/>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

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
<g:hiddenField name="documentNumber" value="${documentNumber}" />
<g:hiddenField name="tenor" value="${tenor}" />

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

%{--used to pass fields from ets to data entry (data came from opening)--}%
<g:hiddenField name="standbyTagging" value="${standbyTagging}" />
<g:hiddenField name="purposeNarrative" value="${purposeNarrative}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="formOfDocumentaryCredit" value="${formOfDocumentaryCredit}" />
<g:hiddenField name="applicantCifNumber" value="${applicantCifNumber}" />
<g:hiddenField name="applicantName" value="${applicantName}" />
<g:hiddenField name="applicantAddress" value="${applicantAddress}" />
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}" />
<g:hiddenField name="descriptionOfGoodsServices	" value="${descriptionOfGoodsServices}" />

%{--fields from details of guarantee--}%
<g:hiddenField name="formatType" value="${formatType}" />
<g:hiddenField name="detailsOfGuarantee" value="${detailsOfGuarantee}" />
<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />

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
		<td class="label_width"> <span class="field_label"> eTS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" id="etsNumber" value="${serviceInstructionId}" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> eTS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">Main CIF Number</span> </td>
		<td class="input_width"> <g:textField class="input_field input_seven" name="mainCifNumber" value="${mainCifNumber}" readonly="readonly" /> </td>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field input_twenty" name="mainCifName" value="${mainCifName}" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <g:textField  name="processingUnitCode" value="${processingUnitCode}" class="input_field unitCode required" readonly="readonly"/>
		</td>
		<td class="label_width"> <span class="field_label">DMLC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> 
		  <g:textField class="input_field input_ten lc_issue required" name="issueDate" value="${issueDate}" readonly="readonly" />
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Type</span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="${type ?: 'STANDBY'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="facilityType" value="${facilityType}" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Facility ID </span> </td>
		<td class="input_width"> <g:textField class="input_field input_eleven" name="facilityId" value="${facilityId}" readonly="readonly"/>
<%--		<g:if test="${!session.title.contains("Reversal")}"><a href="javascript:void(0)" class="search_btn popup_btn_facility" id="popup_btn_facility"> Search/Look-up Button </a></g:if> </td>--%>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> 
          <g:textField  name="currency" class="input_field currency required" value="${currency}" readonly="readonly"/>
		</td>
		<td class="label_width"> <span class="field_label"> DMLC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> 
<%--		  <g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly"/>--%>
		  %{--<g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="amount" value="${productAmount}" readonly="readonly"/>--}%
		  <g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="amount" value="${outstandingBalance}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">DMLC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> 
		  <g:textField class="input_field lc_expiry required" name="expiryDate" value="${expiryDate}" readonly="readonly"/>
		</td>
		<td class="label_width"> <span class="field_label">With 2% CWT? <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag?:'N'}" >
		       <label> ${it.radio}&#160;<g:message code="${it.label}" /></label>
		    </g:radioGroup>
		</td>
	</tr>
	<%-- Added --%>
	<tr>
		<td class="label_width"> 
			<span class="field_label"> DMLC Amendment Date<span class="asterisk">*</span> </span>
	 	</td>
		<td class="input_width"><g:textField  name="amendmentDate" class="datepicker_field date required" value="${amendmentDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />
