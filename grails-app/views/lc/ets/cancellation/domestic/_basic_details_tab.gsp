<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/lc/validation_lc_cancellation.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="currency" value="${currency}" />
<g:hiddenField name="amount" value="${amount}" />
<%--<g:javascript src="temp/fxlc_cancellation.js" />--%>
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

<g:hiddenField name="productAmount" value="${productAmount}" />


<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${serviceInstructionId}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" />
		<g:hiddenField name="hiddenCurrency" value="${currency}" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" value="${processingUnitCode}" readonly="readonly" /></td>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Outstanding DMLC Amount</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly" /></td>
		<td><span class="field_label">Original DMLC Submitted? <span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup name="originalLcSubmittedFlag" class="required" value="${originalLcSubmittedFlag}" labels="['Yes', 'No']" values="['Y', 'N']">
				${it.radio} ${it.label} &#160;&#160;
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Reason for Cancellation <span class="asterisk">*</span></span></td>
		<td><g:textArea name="reasonForCancellation" value="${reasonForCancellation}" class="textarea" rows="4" maxlength="80"/> </td>
	</tr>
</table>


<g:render template="../layouts/buttons_for_grid_wrapper" />