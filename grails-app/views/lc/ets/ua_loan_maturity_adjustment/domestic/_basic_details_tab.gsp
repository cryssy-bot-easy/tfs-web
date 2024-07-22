<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<%--<g:javascript src="utilities/temp_validation_js/validation_js.js" />--%>
<g:javascript src="/js-temp/validation_DMLC_Ua_Loan_Maturity_Adjustment_ets.js" />

<g:hiddenField name="referenceNumber" value="${referenceNumber}" />
<g:hiddenField name="negoTradeServiceId" value="${negoTradeServiceId}" />

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="negotiationValueDate" value="${negotiationValueDate}" />
<g:hiddenField name="issueDate" value="${issueDate}"/>

	<table class="tabs_forms_table">
        <g:if test="${reversalEtsNumber}">
            <tr>
                <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
                <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
            </tr>
        </g:if>
		<tr>
			<td class="label_width"><span class="field_label"> eTS Number </span> </td>
			<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/></td>
			<td class="label_width"><span class="field_label"> eTS Date </span> </td>
			<td class="input_width"><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
		</tr>
		<tr>
			<td><span class="field_label"> Document Number <span class="asterisk"></span></span> </td>
			<td><g:textField class="input_field required" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>	
			<td><span class="field_label"> DMLC Issue Date </span></td>
			<td><g:textField class="input_field" name="issueDate" readonly="readonly" value="${issueDate}"/> </td>
		</tr>
	<tr>
		<td><span class="field_label"> Negotiation Number <%--<span class="asterisk">*</span>--%> </span></td>
		<td><g:textField name="negotiationNumber" class="input_field" value="${negotiationNumber}" readonly="readonly"/></td>
<%--		<td><g:select name="negotiationNumber" from="${[negotiationNumber,'1234-5678-90','4536-5493-64','3459-6832-23']}" class="select_dropdown" value="${negotiationNumber}" noSelection="['':'SELECT ONE...']"/></td>--%>
		<td><span class="field_label"> Negotiation Currency </span></td>
		<td>
            <g:textField class="input_field currency" name="negotiationCurrency" value="${negotiationCurrency}" readonly="readonly"/>
            <g:hiddenField name="currency" value="${currency ?: negotiationCurrency}" />
        </td>
		
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Amount </span></td>
		<td><g:textField class="input_field_right lc_amount right numericCurrency" name="amount" value="${amount}" readonly="readonly"/></td>	
		<td><span class="field_label">With Beneficiary's <br /> Conformity? <span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup class="required" values="['Y','N']" labels="['Yes','No']" name="beneficiaryConformityFlag" value="${beneficiaryConformityFlag}">
				<label>${it.radio}&#160;<g:message code="${it.label }"/></label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span> </td>
		<td><g:textField name="processingUnitCode" value="${processingUnitCode}" class="input_field" readonly="readonly"/></td>	
		<td><span class="field_label">With 2% CWT </span></td>
		<td>
			<g:radioGroup values="['Y','N']" labels="['Yes','No']" name="cwtFlag" value="${cwtFlag ?: 'N'}">
				<label>${it.radio }&#160;<g:message code="${it.label }"/></label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">DUA Loan Maturity Date</span></td>
		<td><g:textField class="input_field lc_issue" name="loanMaturityDateFrom" readonly="readonly" value="${loanMaturityDateFrom ?: loanMaturityDate}" /></td>
		<td><span class="field_label right_indent">To: <span class="asterisk">*</span></span></td>
		<td>
			<%-- Iniba ang name neto galing 'uaLoanMaturityDate' sa 'uaLoanMaturityDateTo' napupunta kasi ung value sa uaLoanMaturityDateFrom--%>
			<g:textField class="datepicker_field lc_expiry required" name="loanMaturityDateTo" value="${loanMaturityDateTo}"/>
		</td>
		
	</tr>
</table>
<br/>
<g:render template="/layouts/buttons_for_grid_wrapper" />
<script type="text/javascript">
$(function(){
	$("#amount").focus(function(){
		$(this).blur();
	});
});
</script>