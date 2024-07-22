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

%{--<g:textField name="facilityBalance" value="${facilityBalance}" />--}%

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
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/> </td>
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
            <g:select class="select_dropdown required" name="processingUnitCode" from="['909']" noSelection="['':'SELECT ONE']" value="${processingUnitCode ?: '909'}"/>
            <g:hiddenField name="documentNumber" value="${documentNumber}"/>
        </td>
		<td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" maxlength="20"/> </td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Type<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="type" readonly="readonly" value="${type ?: 'REGULAR'}"/> </td>
		<td class="label_width"> <span class="field_label">Importer Code</span></td>
		<td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Facility Type </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="facilityType" readonly="readonly" value="${facilityType ?: 'FCN'}"/> </td>
		<td class="label_width"> <span class="field_label"> Facility ID<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="facilityId" readonly="readonly" value="${facilityId}"/>
            <g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
			<a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a> 
		</td>
 	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> FXLC Currency<span class="asterisk">*</span> </span> </td>
		<%-- <td class="input_width"> <g:select class="select_dropdown" name="currency" from="['PHP','USD','EUR']" noSelection="['':'SELECT ONE...']" value="${currency}"/> </td>--%>
		<td class="input_width"> 
			<%-- <tfs:lcCurrency class="select_dropdown input_fifteen currency" name="currency" value="${currency}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
		</td>
		<td class="label_width"> <span class="field_label"> FXLC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}"/> </td>
	</tr>
	<tr>	
		<td class="label_width"> <span class="field_label"> FXLC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="expiryDate" value="${expiryDate}"/> </td>
		<td class="label_width"> <span class="field_label"> FXLC Issue Date <span class="asterisk">*</span> </span>  </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="issueDate" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
    </tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Price Term </span> </td>
		<td class="input_width">
            <%--<g:select class="select_dropdown" name="priceTerm" from="${['EXW - Ex-Works',--%>
			<%--'FCA - Free Carrier','FAS - Free Alongside Ship','FOB - Free on Board','CFR - Cost and Freight',--%>
			<%--'C.I.F. - Cost, Insurance and Freight','CPT - Carriage Paid To','CIP - Carriage and Insurance Paid To',--%>
			<%--'DAT - Delivered at Terminal','DAP - Delivered at Place','DDP - Delivered Duty Paid','OTH - Others']}"--%>
			<%--noSelection="['':'SELECT ONE']" value="${priceTerm}"/> </td>--%>
            <tfs:priceTerm id="priceTerm" class="select_dropdown input_thirtyFive" name="priceTerm" value="${priceTerm ?: 'OTH'}"/>
		<td class="label_width"> <span class="field_label"> If others, please specify <span class="asterisk othersPriceTermAsterisk">*</span></span></td>
		<td class="input_width"> <g:textArea maxlength="100" class="input_field required textarea" name="otherPriceTerm" value="${otherPriceTerm}" rows="4"/> </td>
 	</tr>
 	<tr>
		<td class="label_width"> <span class="field_label"> Marine Insurance </span> </td>
		<td class="input_width">
            <tfs:marineInsurance class="select_dropdown" name="marineInsurance" value="${marineInsurance}" />
        </td>
		<td class="label_width"> <span class="field_label"> Tenor <span class="asterisk">*</span></span> </td>
		<td class="input_width"> 
            <tfs:tenor class="select_dropdown input_ten required" name="tenor" value="${tenor}" />
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> If Usance: Tenor of Draft <br /> (usance period) </span> </td>
		<td class="input_width"> <g:textField maxlength="19" class="input_field_short numericWholeQuantity" name="usancePeriod" readonly="readonly" value="${usancePeriod}"/> DAYS </td>
		<td class="label_width"> <span class="field_label"> If Usance: Tenor of Draft <br /> (narrative) </span> </td>
		<td class="input_width"> <g:textArea maxlength="105" class="textarea" name="tenorOfDraftNarrative" rows="5" cols="40" readonly="readonly" value="${tenorOfDraftNarrative}"/> </td>
	</tr>
 	<tr>
 		<td class="label_width"> <span class="field_label"> Confirmation Instructions: Confirmed?<span class="asterisk">*</span> </span>   </td>
		<td class="input_width">
  			<g:radioGroup name="confirmationInstructionsFlag" class="required" labels="['Yes','No','May Add']" values="['Y','N','M']" value="${confirmationInstructionsFlag ?: 'Y'}">
			    ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
   		<td class="label_width"> <span class="field_label"> General Description of Goods and/or Services <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textArea maxlength="6500" class="textarea required" name="generalDescriptionOfGoods" rows="5" cols="40" value="${generalDescriptionOfGoods}"/> </td>
	</tr>
 	<tr>
		<td class="label_width"> <span class="field_label"> Collect Advance Corres Charges from Applicant? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="advanceCorresChargesFlag" labels="['Yes','No']" values="['Y', 'N']" value="${advanceCorresChargesFlag}" >
			    ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
		<td class="label_width"> <span class="field_label"> Commodity Code </span> </td>
		<td class="input_width">
			<%-- Auto Complete 
			<input class="select2_dropdown required" name="commodity" id="commodity" /> --%>
			<input class="select2_dropdown" name="commodity" id="commodity" />
			<g:hiddenField name="commodityCode" value="${commodityCode}" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">With Excess Availment Approval From CFP?</span></td>
		<td>
			<g:radioGroup name="cramFlag" labels="['Yes','No']" values="['true','false']" value="${cramFlag ?: 'false'}" >
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
</table> <%-- End of SEARCH Form--%>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
$(document).ready(function() {
	var participantCode = $('#participantCode').val(),
        cifNumber = $('#cifNumber').val(),
        splittedCommodity;
    
	%{--$("#currency").select2('data',{id: '${currency}'});--}%
	%{--$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});--}%
	$("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
	$("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
	
	$('#cifNumber').change(function() {
        $('#tempTinNumber').val($('#tinNumber').val());

        $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                $('#participantCode').val(data.results[0].id);
            }
        });
    });

	$("#commodity").change(function() {
        splittedCommodity = $(this).val().split("-");
        if(splittedCommodity.length > 0) {
            $('#commodityCode').val(splittedCommodity[0].toString().trim());
        }
    });

	$('#tempTinNumber').change(function() {
        $('#tinNumber').val($('#tempTinNumber').val().trim());
    });

	if($("#priceTerm").val() == "OTH") {
		$("#otherPriceTerm").removeAttr("readonly");
	} else {
		$("#otherPriceTerm").attr("readonly", "readonly");
	}
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