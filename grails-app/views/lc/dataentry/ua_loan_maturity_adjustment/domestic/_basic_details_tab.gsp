<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="referenceNumber" value="${referenceNumber}" />
<g:hiddenField name="negoTradeServiceId" value="${negoTradeServiceId}" />

<g:hiddenField name="productCurrency" value="${productCurrency ?: negotiationCurrency}"/>
<g:hiddenField name="productAmount" value="${productAmount ?: amount}" />

<g:javascript src="utilities/temp_validation_js/validation_js.js" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate"  value="${etsDate}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly" /></td>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" value="${processingUnitCode}" readonly="readonly" /></td>
	</tr>
	<tr>	
		<td><span class="field_label">DMLC Issue Date</span></td>
		<td><g:textField class="input_field" name="issueDate"  value="${issueDate}" readonly="readonly" /></td>
		<td><span class="field_label">Processing Date</span></td>
		<td><g:textField class="input_field" name="processDate"  value="${processDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Number</span></td>
		<td><g:textField class="input_field" name="negotiationNumber" value="${negotiationNumber}" readonly="readonly" /></td>
		<td><span class="field_label">With Beneficiary Conformity?</span></td>
		<td>

			<g:radioGroup values="['Y', 'N']" labels="['Yes','No']" name="beneficiaryConformityFlag" value="${beneficiaryConformityFlag}" disabled="disabled">
			<%-- <g:radioGroup values="['Y','N']" labels="['Yes','No']" name="beneficiaryConformityFlag" value="Y" disabled="true"> --%> <%-- 'Y' default value --%>
				<label>${it.radio}&#160;<g:message code="${it.label}"/></label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Currency</span></td>
		<td>
            <g:textField class="input_field" name="negotiationCurrency" value="${negotiationCurrency}" readonly="readonly" />
            <g:hiddenField name="currency" value="${currency}" />
        </td>
		<td><span class="field_label">Negotiation Amount (in DMLC Currency)</span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" value="${amount}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">DUA Loan Maturity Date</span></td>
		<td><g:textField class="input_field" name="loanMaturityDateFrom"  value="${loanMaturityDateFrom ?: loanMaturityDate}" readonly="readonly" /></td>
		<td><span class="field_label">New DUA Loan Maturity Date<span class="asterisk">*</span></span></td>
		<%-- Iniba ang name neto galing 'uaLoanMaturityDate' sa 'uaLoanMaturityDateTo' napupunta kasi ung value sa uaLoanMaturityDateFrom--%>
		<td><g:textField class="datepicker_field required" name="loanMaturityDateTo" value="${loanMaturityDateTo}" /></td>
	</tr>
</table>

<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />