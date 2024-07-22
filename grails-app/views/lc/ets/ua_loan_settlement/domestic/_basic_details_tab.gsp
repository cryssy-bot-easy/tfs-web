<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="js-temp/validation_Charges_Tab.js"/>

<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />


<div id="ets_dua_loan_settlement_filter">
%{--<g:hiddenField name="lcCurrency" value="${lcCurrency}" />--}%
<g:hiddenField name="lcType" value="${documentSubType1}" />
%{--<g:hiddenField name="lcAmount" value="${lcAmount}" />--}%

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="applicantName" value="${applicantName}" />
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />

%{--<g:textField name="computedOutstandingBalance" value="${computedOutstandingBalance}" />--}%

	<table class="tabs_forms_table">
        <g:if test="${reversalEtsNumber}">
            <tr>
                <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
                <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
            </tr>
        </g:if>
		<tr>
			<td class="label_width"><span class="field_label"> eTS Number </span></td>
			<td class="input_width"><g:textField name="etsNumber" class="input_field" value="${serviceInstructionId}" readonly="readonly"/></td>
			<td class="label_width"><span class="field_label"> eTS Date </span></td>
		        <td class="input_width"><g:textField name="etsDate" class="input_field" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> Document Number</span></td>
			<td><g:textField name="documentNumber" class="input_field" value="${documentNumber}" readonly="readonly"/></td>
			<td><span class="field_label"> Negotiation Number<%--<span class="asterisk">*</span>--%> </span></td>
			<td><g:textField name="negotiationNumber"  value="${negotiationNumber}" class="input_field" readonly="readonly"/></td>
<%--			<td><g:select name="negotiationNumber" from="${[negotiationNumber,'1234-5678-90','4536-5493-64','3459-6832-23']}" class="select_dropdown" value="${negotiationNumber}" noSelection="['':'SELECT ONE...']"/></td>--%>
		</tr>
		<tr>
			<td><span class="field_label">DMLC-DUA Loan Amount </span></td>
		        <td><g:textField name="amount" class="input_field_right lc_amount numericCurrency" value="${amount}" readonly="readonly"/></td>
			<td><span class="field_label"> DMLC-DUA Loan Currency </span></td>
		        <td><g:textField name="currency" class="input_field currency" value="${currency}" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> Processing Unit Code </span></td>
			<td><g:textField  name="processingUnitCode" class="input_field" value="${processingUnitCode}" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> DMLC Issue Date </span></td>
			<td><g:textField name="issueDate" class="input_field" value="${issueDate}" readonly="readonly"/></td>
		</tr>

    <tr>
        <td><span class="field_label">DMLC Amount </span></td>
        <td><g:textField name="lcAmount" class="input_field_right lc_amount numericCurrency" value="${lcAmount}" readonly="readonly"/></td>
        <td><span class="field_label"> DMLC Currency </span></td>
        <td><g:textField name="lcCurrency" class="input_field currency" value="${lcCurrency}" readonly="readonly"/></td>
    </tr>

        <tr>
            <td><span class="field_label">Value Date</span></td>
            <td>
                %{--<g:textField name="valueDate" class="input_field" readonly="readonly" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}"/>--}%
                <g:textField name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}" class="datepicker_field date required"/>
            </td>
        </tr>
		<%--<tr>
			<td><span class="field_label"> O/S MD Balance </span></td>
			<td><g:textField  name="outstandingMdBalance" value="${outstandingMdBalance}" class="input_field" readonly="readonly"/></td>
		</tr>
	--%></table>
</div>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script type="text/javascript">
$(function(){
	$("#amount").focus(function(){
		$(this).blur();
	});
});
</script>
