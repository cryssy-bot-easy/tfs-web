<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" value="${etsNumber}" readOnly="readOnly" /></td>
		<td class="label_width"><span class="field_label">eTS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" value="${etsDate}" readOnly="readOnly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" value="${documentNumber}" readOnly="readOnly" /></td>
		<td><span class="field_label">FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="input_field" readOnly="readOnly" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Number</span></td>
		<td><g:textField name="processingNumber" class="input_field" value="${processingNumber}" readOnly="readOnly" /></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>	
	<tr>
		<td><span class="field_label">With Beneficiary Conformity?</span></td>
		<td><g:radioGroup name="beneficiaryConformityFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${beneficiaryConformityFlag}"><label>
            ${it.radio} ${it.label}</label> &#160;&#160;</g:radioGroup></td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Number</span></td>
		<td><g:textField name="negotiationNumber" class="input_field" value="${negotiationNumber}" readOnly="readOnly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
			<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
		</td>
	</tr>		
</table>
<%--<g:render template="/layouts/buttons_for_grid_wrapper" />--%>