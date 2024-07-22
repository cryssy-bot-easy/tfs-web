<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/basic_details_utility.js" />
<%-- Added --%>
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
<g:javascript src="js-temp/validation_DMLC_Opening_ets.js"/>

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

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"> <span class="field_label"> eTS Number </span> </td>
		<td class="input_width">
            <g:textField class="input_field" name="etsNumber" id="etsNumber" readonly="readonly" value="${serviceInstructionId}"/>
            <g:hiddenField name="documentNumber" value="${documentNumber}"/>
        </td>
		<td class="label_width"> <span class="field_label"> eTS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">Main CIF Number</span> </td>
		<td class="input_width"> <g:textField class="input_field input_seven numericString" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}" /> </td>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field input_twenty" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown input_three required" name="processingUnitCode" from="${['909']}" noSelection="['':'SELECT ONE']" value="${processingUnitCode ?: '909'}"/> </td>
		<td class="label_width"> <span class="field_label">DMLC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field input_ten lc_issue required" name="issueDate" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Type</span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="REGULAR"/> </td>
		<%--<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="${type ?: 'REGULAR'}"/> </td>--%>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility Type </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="facilityType" value="${facilityType ?: 'FCN'}" readonly="readonly"/> </td>
		<td class="label_width"> <span class="field_label"> Facility ID<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field input_eleven required" name="facilityId" readonly="readonly" value="${facilityId}"/>
            <g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
			<a href="javascript:void(0)" class="search_btn popup_btn_facility"  id="facility_lookup"> Search/Look-up Button </a>
		</td>
		
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Currency<span class="asterisk">*</span> </span> </td>
		    <%-- <td class="input_width"> <g:select name="currency" from="${['PHP','USD','EUR'] }" noSelection="['':'SELECT ONE']" class="select_dropdown currency" value="${currency ?: 'PHP'}"/> </td>--%>
		<td class="input_width"> 
			<%-- <tfs:lcCurrency class="select_dropdown input_fifteen currency" name="currency" value="${currency}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
		</td>
		<td class="label_width"> <span class="field_label"> DMLC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="amount" value="${amount}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <%--<g:select class="select_dropdown input_ten" name="tenor" from="${['SIGHT','USANCE'] }" noSelection="['':'SELECT ONE']" value="${tenor}"/> --%>
            <tfs:tenor id="tenor" class="select_dropdown input_ten required" name="tenor" value="${tenor}" />
        </td>
		<td class="label_width"> <span class="field_label">DMLC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field lc_expiry required" name="expiryDate" value="${expiryDate}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> If Usance: Tenor of Draft <br /> (USANCE Period) </span> </td>
		<td class="input_width"> <g:textField class="usance input_field_short numericWholeQuantity" name="usancePeriod" readonly="readonly" value="${usancePeriod}"/> DAYS </td>
		<td class="label_width"> <span class="field_label">Tenor of Draft(Narrative)</span> </td>
		<td class="input_width"> <g:textArea class="usance textarea input_thirtyFive" readonly="readonly" name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" rows="5" cols="40" maxlength="105"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> General Description of Goods and/or Services <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea input_sixtyFive required" name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" rows="5" cols="40" maxlength="6500"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">With 2% CWT? <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
		       <label>${it.radio}&#160;<g:message code="${it.label}" /></label>
		    </g:radioGroup>
		</td>
		<td><span class="field_label">With Excess Availment Approval From CFP?</span></td>
		<td>
			<g:radioGroup name="cramFlag" labels="['Yes','No']" values="['true','false']" value= "${cramFlag ?: 'false'}" >
				${it.radio}&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		</td>
	</tr>      
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        %{--$("#currency").select2('data',{id: '${currency}'});--}%
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
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