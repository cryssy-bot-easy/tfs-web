<g:hiddenField name="referenceType" value="${referenceType}"/>
<g:hiddenField name="serviceType" value="${serviceType}"/>
<g:hiddenField name="documentType" value="${documentType}"/>
<g:hiddenField name="documentClass" value="${documentClass}"/>
<g:hiddenField name="documentSubType1" value="${documentSubType1}"/>
<g:hiddenField name="documentSubType2" value="${documentSubType2}"/>
<g:hiddenField name="form" value="basicDetails"/>
<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="expiryDate" value="${expiryDate}"/>

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label">eTS Number</span></td>
        <td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}"
                                             readOnly="readOnly"/></td>
        <td class="label_width"><span class="field_label">eTS Date</span></td>
        <td class="input_width"><g:textField class="input_field" name="etsDate" value="${etsDate}"
                                             readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">Document Number</span></td>
        <td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
        <td><span class="field_label">Processing Unit Code</span></td>
        <td><g:textField class="input_field" name="processingUnitCode" value="909" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">DMLC Issue Date</span></td>
        <td><g:textField class="input_field" name="lcIssueDate" value="${DateUtils.shortDateFormat(new Date())}"
                         readonly="readonly"/></td>
        <td><span class="field_label">Processing Date</span></td>
        <td><g:textField class="input_field" name="processDate" value="${DateUtils.shortDateFormat(new Date())}"
                         readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">Negotiation Number</span></td>
        <td><g:textField class="input_field" name="negotiationNumber" value="${negotiationNumber}"
                         readonly="readonly"/></td>
        <td><span class="field_label">With Beneficiary Conformity?</span></td>
        <td>
            <g:radioGroup values="['Y', 'N']" labels="['Yes', 'No']" name="confirmationFlag" value="Y" disabled="true">
                <label>${it.radio}&#160;<g:message code="${it.label}"/></label>
            </g:radioGroup>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Negotiation Currency</span></td>
        <td><g:textField class="input_field" name="negotiationCurrency" value="${currency}" readonly="readonly"/></td>
        <td><span class="field_label">Negotiation Amount (in DMLC Currency)</span></td>
        <td><g:textField class="input_field_right numericCurrency" name="negotiationAmount" value="${amount}" readonly="readonly"/></td>
    </tr>

    <tr>
        <td><span class="field_label">With 2% CWT</span></td>
        <td>
            <g:radioGroup name="cwtFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}"
                          disabled="true">
                <label>${it.radio}&#160;<g:message code="${it.label}"/></label>
            </g:radioGroup>
        </td>
    </tr>
</table>
<%-- <br/>
<table style="margin-left:50px">
	<tr>
		<td>Booking Currency</td>
		<td><g:select name="bookingCurrency" from="${['PHP','USD']}" class="select_dropdown_medium "/></td>
	</tr>
	<tr>
		<td width="110px">Interest Rate</td>
		<td width="110px"><g:textField name="interestRate" class="input_field_medium " readonly="readonly"/></td>
		<td width="110px">Interest Term</td>
		<td width="110px"><g:textField name="interestTerm" class="input_field_medium " readonly="readonly"/></td>
	</tr>
	<tr>
		<td>Repricing Term</td>
		<td><g:textField name="repricingTerm" class="input_field_medium " readonly="readonly"/></td>
		<td>Repricing Term<br/>Code</td>
		<td><g:textField name="repricingTermCode" class="input_field_medium " readonly="readonly"/></td>
	</tr>
	<tr>
		<td>Loan Term</td>
		<td><g:textField name="loanTerm" class="input_field_medium " readonly="readonly"/></td>
		<td>Loan Maturity Date&#160; </td>
		<td><g:textField name="loanMaturityDate" class="input_field_medium" readonly="readonly"/></td>
	</tr>
	<tr>
		<td>Doc Stamp Tagging</td>
		<td><g:textField name="docStampTagging" class="input_field_medium" readonly="readonly"/></td>
	</tr>
</table>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Payment Code</span></td>
		<td class="input_width"><g:select class="select_dropdown" name="paymentCode" from="" disabled="true" noSelection="['':'SELECT ONE']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">PN Number</span></td>
		<td><g:textField class="input_field" name="pnNumber" value="" readonly="readonly" /></td>
		<td></td>
		<td><input type="hidden" name="officer"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Transaction Posting Status</span></td>
		<td><g:textField class="input_field" name="transactionPostingStatus" value="" readonly="readonly" /></td>
	</tr> --%>
</table>
<%--<g:render template="../layouts/buttons_for_grid_wrapper"/>--%>