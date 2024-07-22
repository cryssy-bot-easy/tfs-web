<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/basic_details_utility.js" />
<%-- Added --%>
<g:javascript src="js-temp/validation_FXLC_Opening_ets.js"/>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

%{--<g:hiddenField name="facilityBalance" value="${facilityBalance}" />--}%

<g:hiddenField name="saveAs" value=""/>

<g:hiddenField name="tenor" value="${tenor ?: documentSubType2}" />

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"> <span class="field_label"> eTS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field input_twelve" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/> </td>
		<td class="label_width"> <span class="field_label"> eTS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
  	<tr>
		<td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
		<td class="input_width"> <g:textField class="input_field numericString" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
  	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> 
			<g:select class="select_dropdown input_three required" name="processingUnitCode" from="['909']" noSelection="['':'SELECT ONE']" value="${processingUnitCode ?: '909'}"/>
			<g:hiddenField name="documentNumber" value="${documentNumber}"/> 
		</td>
		<td class="label_width"> <span class="field_label"> FXLC Issue Date <span class="asterisk">*</span> </span>  </td>
		<td class="input_width"> <g:textField class="datepicker_field lc_issue required" name="issueDate" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="${type ?: 'STANDBY'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="facilityType" readonly="readonly" value="${facilityType ?: 'FCN'}"/> </td>
		<td class="label_width"> <span class="field_label"> Facility ID<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="facilityId" readonly="readonly" value="${facilityId}"/>
            <g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
			<a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>
		</td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Currency<span class="asterisk">*</span> </span> </td>
<%--		<td class="input_width"> <g:select class="select_dropdown input_fifteen currency" name="currency" from="['PHP','USD','EUR']" noSelection="['':'SELECT ONE']" value="${currency}"/> </td>--%>
		<td class="input_width"> 
			<%-- <tfs:lcCurrency class="select_dropdown input_fifteen currency" name="currency" value="${currency}"/> --%>
		
			<%-- Auto Complete --%>
		<g:if test="${!status || status.equalsIgnoreCase('pending')}">
			<input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency"/>
		</g:if>
		<g:else>
			<input class="tags_currency select2_dropdown bigdrop input_field required" name="currency" id="currency" value="${currency}" readonly="readonly"/>
		</g:else>
		</td>
		<td class="label_width"> <span class="field_label"> FXLC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		<g:if test="${!status || status.equalsIgnoreCase('pending')}">
			<g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="amount" value="${amount}"/>
		</g:if>
		<g:else>
			<g:textField class="input_field right input_fifteen lc_amount numericCurrency required" name="amount" value="${amount}" readonly="readonly"/>
		</g:else>
		</td>
	</tr>
 	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field lc_expiry required" name="expiryDate" value="${expiryDate}"/> </td>
   
 		<td class="label_width"> <span class="field_label"> Confirmation Instructions: Confirmed?<span class="asterisk">*</span> </span>   </td>
		<td class="input_width">
  			<g:radioGroup name="confirmationInstructionsFlag" class="required" labels="['Yes','No','May Add']" values="['Y','N','M']" value="${confirmationInstructionsFlag ?: 'Y'}">
			    ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
    <tr>
   
		<td class="label_width"> <span class="field_label"> Collect Advance Corres Charges from Applicant? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="advanceCorresChargesFlag" labels="['Yes','No']" values="['Y', 'N']" value="${advanceCorresChargesFlag}" >
			    ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
		<td class="label_width"> <span class="field_label"> With 2% CWT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">With Excess Availment Approval From CFP?</span></td>
		<td>
			<g:radioGroup name="cramFlag" labels="['Yes','No']" values="['true','false']" value="${cramFlag ?: 'false'}" >
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		</td>
	</tr>
</table> <%-- End of SEARCH Form--%>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        %{--$("#currency").select2('data',{id: '${currency}'});--}%
        %{--$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--}%
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        if(${serviceInstructionId != null}){
            if(${session?.userrole?.id == 'BRM'} && ("undefined" === typeof _viewMode || '' == _viewMode)){
	        	$.post(requestFacilityBalanceUrl, {
		            facilityId : '${facilityId}',
		            facilityType : '${facilityType}',
	                cifNumber : '${mainCifNumber}'
	            }, function(data) {
	                if(data.status == 'success'){
	        			doBalanceCheck2(0, data.transactionSequenceNumber)
	                }
	            });
	        } else {
		        if($("#overAvailment").val() == "NOTE: Transaction has been rejected."){
	            	$("#overAvailment").val(" ");
	            	$(".overAvailment").html(" ");
		        }
	        }
        }
    });
</script>