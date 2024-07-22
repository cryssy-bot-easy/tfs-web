<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="branchUnitcode" value="${branchUnitcode}" />
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
<%--<%@page import="net.ipc.utils.DateUtils" %>--%>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field length20" value="${lcNumber ?: documentNumber}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"  value="${etsDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field disabled length12" readonly="readonly" value="${etsNumber}" /></td>
		<td><span class="field_label">FXLC Expiry Date </span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"  /></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field length3" value="${processingUnitCode}" readonly="readonly" /></td>
		<td><span class="field_label">Outstanding FXLC Amount</span></td>
		<td><g:textField name="outstandingBalance" class="input_field_right amountFormat numericCurrency" value="${outstandingBalance}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Issue Date</span> </span></td>
		<td><g:textField name="issueDate" class="input_field"  value="${issueDate}" readonly="readonly" /></td>
		<td><span class="field_label">Negotiation Value Date </span></td>
		<td><g:textField class="input_field" name="negotiationValueDate" value="${negotiationValueDate}" readonly='readonly' /></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Type</span></td>
		<td><g:textField name="type" class="input_field length10" value="${type}" readonly="readonly" /></td>
		<td><span class="field_label">IC Number</span></td>
		<td><g:textField name="icNumber" class="input_field" value="${icNumber}" readonly="readonly" />
	</tr>
	<tr>
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField name="originalCurrency" class="input_field length3" value="${originalCurrency}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label">Negotiation Currency</span></td>
		<td><g:textField name="negotiationCurrency" class="input_field length3"  readonly="readonly" value="${negotiationCurrency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Amount</span></td>
		<td><g:textField name="originalAmount" class="input_field_right amountFormat numericCurrency" value="${originalAmount}" readonly="readonly"/></td>
		<td><span class="field_label">Negotiation Amount</span></td>
		<td><g:textField name="negotiationAmount" class="input_field_right amountFormat numericCurrency" value="${negotiationAmount}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Value Date</span></td>
		<td><g:textField name="valueDate" class="input_field" value="${valueDate}" readonly="readonly" /></td>
		<td><span class="field_label">Reimbursing Bank - Special Rate</span></td>
		<td><g:textField name="reimbursingBankSpecialRate" class="input_field rateFormat" value="${reimbursingBankSpecialRate}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td></td>
		<td></td>
		<td><span class="field_label">Reimbursing Currency</span></td>
		<td><g:textField name="reimbursingCurrency" class="input_field length3" value="${reimbursingCurrency}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td>&#160;</td>
		<td><span class="field_label">Negotiating Amount</span><br /><span class="field_label">(in Reimbursing Currency)</span></td>
		<td><g:textField name="negotiationAmountInReimbursingCurrency" class="input_field_right amountFormat numericCurrency" value="${negotiationAmountInReimbursingCurrency}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
            <%--<g:textField name="cwtFlag" class="input_field" value="" readonly="readonly" />--%>
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
		</td>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}">
			<td><span class="field_label">AP-Cash Amount</span><br/><span class="field_label">(in Negotiation Currency)</span></td>
			<td><g:textField name="cashAmount" class="input_field_right numericCurrency" value="${cashAmount}" readonly="readonly" /></td>
		</g:if>
	</tr>
	<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}">
		<tr>
			<td/>
			<td/>
			<td><span class="field_label">Overdrawn Negotiation Amount</span><br/><span class="field_label">(in Negotiation Amount)</span></td>
			<td><g:textField name="overdrawnAmount" class="input_field_right numericCurrency" value="${overdrawnAmount}" readonly="readonly" /></td>
		</tr>
	</g:if>
    <g:else>
        <g:hiddenField name="overdrawnAmount" value="${overdrawnAmount}" />
    </g:else>
</table>
<br/>
<g:render template="/layouts/buttons_for_grid_wrapper" /><%--uncomment on sept 20 --%>
