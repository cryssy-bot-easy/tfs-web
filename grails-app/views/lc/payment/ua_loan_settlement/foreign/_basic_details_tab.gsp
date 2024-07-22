<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="branchUnitcode" value="${branchUnitcode}" />
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="reimbursingBank" value="${reimbursingBank}"/>
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" id="etsNumber" value="${etsNumber}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" value="${etsDate}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field input_three" value="${processingUnitCode}" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC UA Loan Currency</span></td>
		<td>
            %{--<g:textField name="uaLoanCurrency" class="input_field currency" value="${uaLoanCurrency}" readonly="readonly"/> --}%
            <g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/>
        </td>
		<td><span class="field_label">FXLC UA Loan Amount</span></td>
		<td>
            %{--<g:textField name="uaLoanAmount" class="input_field right lc_amount numericCurrency" value="${uaLoanAmount}" readonly="readonly"/> --}%
            <g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${amount}"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Balance</span></td>
		<td><g:textField name="outstandingMdBalance" value="${outstandingMdBalance}" class="input_field allCapsOnly" readonly="readonly"/></td>
		<td><span class="field_label">FXLC O/S Amount</span></td>
		<td><g:textField name="outstandingBalance" value="${outstandingBalance}" class="input_field_right numeric_fifteen numericCurrency" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td><span class="field_label">Value Date</span></td>
		<td><g:textField name="valueDate" class="input_field input_ten lc_issue" value="${valueDate}" readonly="readonly"/></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT</span></td>
		<td>
            <%--<g:textField name="cwtFlag" class="input_field" value="${cwtFlag}" readonly="readonly"/>--%>
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
        </td>
		<td></td>
		<td></td>
	</tr>
</table>
<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>