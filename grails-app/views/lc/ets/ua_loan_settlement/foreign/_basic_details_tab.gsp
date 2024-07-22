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

<div id="ets_ua_loan_settlement_filter">
%{--<g:hiddenField name="lcCurrency" value="${lcCurrency}" />--}%
<g:hiddenField name="lcType" value="${documentSubType1}" />
%{--<g:hiddenField name="lcAmount" value="${lcAmount}" />--}%
<g:hiddenField name="outstandingBalance" value="${outstandingBalance}" />

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />

<g:hiddenField name="reimbursingBank" value="${reimbursingBank ?: reimbursingBankIdentifierCode}"/>
<g:hiddenField name="reimbursingBankName" value="${reimbursingBankName ?: reimbursingBankNameAndAddress}"/>
<g:hiddenField name="accountType" value="${accountType ?: reimbursingAccountType}"/>
<g:hiddenField name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}"/>
<g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency}"/>

<g:hiddenField name="negotiatingBank" value="${negotiatingBank}"/>
<g:hiddenField name="negotiatingBanksReferenceNumber" value="${negotiatingBanksReferenceNumber}"/>

	<table class="tabs_forms_table validation_table">
        <g:if test="${reversalEtsNumber}">
            <tr>
                <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
                <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
            </tr>
        </g:if>
		<tr>
			<td class="label_width"><span class="field_label"> eTS Number </span></td>
			<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${serviceInstructionId}" /></td>
			<td class="label_width"><span class="field_label"> eTS Date </span></td>
		    <td class="input_width"><g:textField name="etsDate" class="input_field" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
		</tr>
		<tr>
			<td><span class="field_label"> Document Number </span></td>
			<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}" /></td>
			<td><span class="field_label"> FXLC Issue Date </span></td>
			<td><g:textField name="issueDate" class="input_field" value="${issueDate}" readonly="readonly"/></td>
		</tr>
		<tr>
	        <td class="label_width"> <span class="field_label">Importer Code</span></td>
	        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
	        <td class="label_width"> <span class="field_label"> Commodity Code </span> </td>
	        <td class="input_width">
	            <%-- Auto Complete --%>
	            <input class="select2_dropdown " name="commodity" id="commodity" />
                <g:hiddenField name="commodityCode" value="${commodityCode}" />
	        </td>
	    </tr>
		<tr>
			<td><span class="field_label"> Negotiation Number </span></td>
<%--			<td><g:select name="negotiationNumber" from="${['1234-5678-90','4536-5493-64','3459-6832-23']}" class="select_dropdown" value="${negotiationNumber}" noSelection="['':'SELECT ONE...']"/></td>--%>
			<td><g:textField name="negotiationNumber"  value="${negotiationNumber}" class="input_field" readonly="readonly"/></td>
			<td><span class="field_label"> With Beneficiary's Conformity? <span class="asterisk">*</span></span></td>
			<td><g:radioGroup name="beneficiaryConformityFlag" class="required" labels="['Yes', 'No']" values="['Y', 'N']" value="${beneficiaryConformityFlag ?: 'N'}"><label>${it.radio} ${it.label}</label> &#160;&#160;</g:radioGroup></td>
		</tr>
		<tr>
			<td><span class="field_label"> Processing Unit Code </span></td>
			<td><g:textField  name="processingUnitCode" class="input_field" readonly="readonly" value="${processingUnitCode}" /></td>
			<td><span class="field_label"> FXLC UA Loan Currency </span></td>
	        	<td><g:textField  name="currency" class="input_field currency" readonly="readonly" value="${currency}" /></td>
		</tr>
		<tr>
			<td><span class="field_label"> FXLC UA Loan Amount </span></td>
		        <td><g:textField  name="amount" class="input_field_right lc_amount numericCurrency" readonly="readonly" value="${amount}" /></td>
		</tr>

    <tr>
        <td><span class="field_label">FXLC Amount </span></td>
        <td><g:textField name="lcAmount" class="input_field_right lc_amount numericCurrency" value="${lcAmount}" readonly="readonly"/></td>
        <td><span class="field_label">FXLC Currency </span></td>
        <td><g:textField name="lcCurrency" class="input_field currency" value="${lcCurrency}" readonly="readonly"/></td>
    </tr>

		<tr>
			<td><span class="field_label"> Value Date <span class="asterisk">*</span></span></td>
			<td>
                %{--<g:textField name="valueDate" value="${valueDate}" class="datepicker_field date required"/>--}%
                <g:textField name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}" class="datepicker_field date required"/>
            </td>
		</tr>
		<tr>
			<td><span class="field_label"> With 2% CWT </span></td>
			<td>
				<g:radioGroup name="cwtFlag" values="['Y', 'N']" labels="['Yes','No']" value="${cwtFlag ?: 'N'}">
					${it.radio}&#160;<g:message code="${it.label}" />
				</g:radioGroup>
			</td>
		</tr>
	</table>
</div>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<script type="text/javascript">
$(function(){
	var participantCode = $('#participantCode').val(),
        cifNumber = $('#cifNumber').val(),
        commodityCode = $('#commodityCode').val(),
        splittedCommodity;

	$("#amount").focus(function(){
		$(this).blur();
	});

	// If participantCode has no value, try to get the corresponding code on cif table based on CIF number
	if (participantCode === null || participantCode === undefined || participantCode.length === 0) {
	    $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
	        if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	            $('#participantCode').val(data.results[0].id);
	        }
	    });
	}

	$("#commodity").change(function() {
        splittedCommodity = $(this).val().split("-");
        if(splittedCommodity.length > 0) {
            $('#commodityCode').val(splittedCommodity[0].toString().trim());
        }
    });

	if(commodityCode) {
        $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
            } else {
            	$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: null});
            }
        });
    } else {
    	$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
    }
    
});
</script>


