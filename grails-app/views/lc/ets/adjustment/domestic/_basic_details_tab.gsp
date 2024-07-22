<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/ets/commons/adjustment_utility.js" />
<g:javascript src="js-temp/validation_DMLC_ets.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="type" value="${type}" />
<g:hiddenField name="narrative" value="${narrative}" />
<g:hiddenField name="productAmount" value="${productAmount}" />
<g:hiddenField name="amount" value="${amount}" />

<g:hiddenField name="expiryDate" value="${expiryDate}" />

<g:if test="${documentSubType1?.equalsIgnoreCase("STANDBY")}">
    <g:hiddenField name="standbyTagging" value="${standbyTagging}" />
    <g:hiddenField name="originalStandbyTagging" value="${standbyTagging}" />
    <g:hiddenField name="purposeOfStandby" value="${purposeOfStandby}" />
</g:if>
<g:if test="${!documentSubType1?.equalsIgnoreCase('CASH')}">
	<script>
		$(function(){
			if(${facilityReferenceNumberTo != null}){
				if(${session?.userrole?.id == 'BRM'} && ("undefined" === typeof _viewMode || '' == _viewMode)){
					$.post(requestFacilityBalanceUrl, {
			            facilityId : '${facilityIdTo}',
			            facilityType : '${facilityType}',
		                cifNumber : '${mainCifNumberTo ?: mainCifNumberFrom ?: mainCifNumber}'
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
		})
	</script>
</g:if>

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width" colspan="3"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field textFormat-12" readonly="readonly" value="${serviceInstructionId}"/></td>
		<td class="label_width" colspan="2"><span class="field_label"> eTS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td colspan="3"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field textFormat-20" readonly="readonly" value="${documentNumber}"/></td>
		<td colspan="2"><span class="field_label"> DMLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td colspan="3"><span class="field_label">Processing Unit Code<span class="asterisk">*</span></span></td>
		<td>
            <g:select name="processingUnitCode" class="select_dropdown required" from="${[processingUnitCode]}"/>
            <%-- <g:textField name="processingUnitCode" class="input_field" value="${processingUnitCode}" /> sa screenshot dropdown to --%>
        </td>       
	</tr>
	<tr>
		<td><span class="field_label">CIF Number</span></td>
		<td><span class="right_indent"><g:checkBox name="cifNumberFlag" value="cifNumberEnabled" checked="false"/></span></td>
		<td><span class="field_label">From:</span></td>
		<td><g:textField id="cifNumberFrom" name="cifNumberFrom" value="${cifNumberFrom ?: cifNumber}" class="input_field textFormat-7" readonly="readonly"/></td>
		<td colspan="2"><span class="field_label right_indent">To:</span></td>
		<td>
			<g:textField id="cifNumberTo" value="${cifNumberTo}" name="cifNumberTo" class="input_field textFormat-7" readonly="readonly"/>      
			<a href="javascript:void(0)" id="cif_search" class="search_btn popup_btn_cif_normal"> Search/Look-up Button </a>
			<g:hiddenField name="accountOfficerTo" value="${accountOfficerTo}"/>
            <g:hiddenField name="ccbdBranchUnitCodeTo" value="${ccbdBranchUnitCodeTo}"/>
            <g:hiddenField name="allocationUnitCodeTo" value="${allocationUnitCodeTo}"/>
            <g:hiddenField name="officerCodeTo" value="${officerCodeTo}"/>
            <g:hiddenField name="exceptionCodeTo" value="${exceptionCodeTo}"/>
		</td>
	</tr>
	<tr>
		<td colspan="2"><span class="field_label">CIF Name</span></td>
		<td><span class="field_label">From:</span></td>
		<td><g:textField name="cifNameFrom" value="${cifNameFrom ?: cifName}" class="input_field textFormat-20" readonly="readonly"/></td>
        <td colspan="2"><span class="field_label right_indent">To:</span></td>
        <td><g:textField name="cifNameTo" value="${cifNameTo}" class="input_field textFormat-20" readonly="readonly"/><g:hiddenField name="longNameTo" value="${longNameTo}"/><g:hiddenField name="address1To" value="${address1To}"/><g:hiddenField name="address2To" value="${address2To}"/></td>
	</tr>
	<g:if test="${!documentSubType1.equalsIgnoreCase('CASH')}">
		<tr>
			<td><span class="field_label">Main CIF Number</span></td>
			<td><span class="right_indent"><g:checkBox name="mainCifNumberFlag" value="mainCifNumberEnabled" checked="false"/></span></td>
			<td><span class="field_label">From:</span></td>
			<td><g:textField name="mainCifNumberFrom" value="${mainCifNumberFrom ?: mainCifNumber}" class="input_field textFormat-7" readonly="readonly"/></td>
			<td colspan="2"><span class="field_label right_indent">To:</span></td>
			<td>
				<g:textField name="mainCifNumberTo" value="${mainCifNumberTo}" class="input_field textFormat-7" readonly="readonly"/>
				<a href="javascript:void(0)" id="main_cif_search" class="search_btn popup_btn_cif_main">Search/Look-up Button</a>
			</td>
		</tr>
		<tr>
			<td colspan="2"><span class="field_label">Main CIF Name</span></td>
			<td><span class="field_label">From:</span></td>
			<td><g:textField name="mainCifNameFrom" value="${mainCifNameFrom ?: mainCifName}" class="input_field textFormat-20" type="text" readonly="readonly"/></td>
			<td colspan="2"><span class="field_label right_indent">To:</span></td>
			<td><g:textField name="mainCifNameTo" value="${mainCifNameTo}" class="input_field textFormat-20" type="text" readonly="readonly"/></td>
		</tr>
	</g:if>
	<g:if test="${documentSubType1?.equalsIgnoreCase('REGULAR') }">
		<tr>
			<td><span class="field_label">Partial Cash Settlement</span></td>
			<td>
				<%-- <span class="right_indent"><g:checkBox name="partialCashSettlementFlag" value="partialCashSettlementEnabled" checked="false"/></span></td> --%>
				<span class="right_indent">
					<g:checkBox name="partialCashSettlementFlagBox" checked="${partialCashSettlementFlag.equals("partialCashSettlementEnabled") ? true : false}"/>
					<g:hiddenField name="partialCashSettlementFlag" value="${partialCashSettlementFlag}" />
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="3"><span class="field_label">Cash LC Amount</span><span class="asterisk" id="cashLcAmountAsterisk"></span></td>
			<td><g:textField name="cashAmount" value="${cashAmount ?: ''}" class="input_field numberFormat-15-2 numericCurrency"/></td>
		</tr>
	</g:if>
	<g:if test="${documentSubType1 == 'REGULAR' || documentSubType1 == 'STANDBY'}">
		<tr>
			<td><span class="field_label">Facility ID</span></td>
			<td><span class="right_indent"><g:checkBox name="facilityIdFlag" value="facilityIdEnabled" checked="false"/></span></td>
			<td><span class="field_label">From:</span></td>
			<td><g:textField name="facilityIdFrom" value="${facilityIdFrom ?: facilityId}" class="input_field numberFormat-11" readonly="readonly"/></td>
			<td colspan="2"><span class="field_label right_indent">To:</span></td>
			<td>
				<g:textField name="facilityIdTo" class="input_field numberFormat-11" value="${facilityIdTo}" readonly="readonly" />
				%{--<a href="javascript:void(0)" id="facility_id_search" class="search_btn popup_btn_facility"> Search/Look-up Button </a>--}%
                <a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>
                <g:hiddenField name="facilityReferenceNumberTo" value="${facilityReferenceNumberTo}" />
			</td>
		</tr>
	</g:if>
	<tr>
		<td colspan="3"><span class="field_label">DMLC Currency</span></td>
		<td><g:textField name="currency" class="input_field textFormat-3" value="${currency}" readonly="readonly"/></td> 
		<td colspan="2"><span class="field_label"> OS/DMLC Amount</span></td>
		<td><g:textField name="outstandingBalance" class="input_field_right numberFormat-15-2 numericCurrency"  id="align_amount"  value="${(new java.math.BigDecimal(outstandingBalance) < 0) ? 0 : outstandingBalance}" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td colspan="3"><span class="field_label">Tenor</span></td>
		<td><g:textField name="tenor" class="input_field textFormat-10" value="${tenor}" readonly="readonly"/></td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<g:render template="../commons/popups/cif_search_normal"/>
<g:render template="../commons/popups/cif_search_main"/>
<g:javascript src="popups/dialog_facility_id.js"/>
<g:javascript src="popups/cif_normal_search_popup.js" />
<g:javascript src="popups/cif_main_search_popup.js" />