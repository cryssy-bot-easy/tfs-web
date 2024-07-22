<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/lc/validation_lc_cancellation.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<%--<g:javascript src="temp/fxlc_cancellation.js" />--%>

<div id="fxlc_cancellation_validation">
<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>

<g:hiddenField name="productAmount" value="${productAmount}" />
<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>

<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${serviceInstructionId}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}" /></td>
        <td class="label_width"> <span class="field_label"> Commodity Code</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="commodity" id="commodity" disabled="disabled"/>
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
	</tr>
	<tr>
        <td class="label_width"> <span class="field_label">TIN<span class="asterisk">*</span> </span> </td>
        <td class="input_width"> <g:textField class="input_field required" name="tinNumber" value="${tinNumber}" maxlength="20"/> </td>
        <td class="label_width"> <span class="field_label">Importer Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" maxlength="10"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>
		<td><g:textField class="input_field" name="type" readonly="readonly" value="${type}" /></td>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField class="datepicker_field3" name="issueDate" value="${issueDate}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td><g:textField class="input_field" name="currency" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label"> Outstanding FXLC Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" value="${processingUnitCode}" id="processingUnitCode" readonly="readonly"/></td>
		<td><span class="field_label">Reason for Cancellation <span class="asterisk">* </span></span></td>
		<td rowspan="2"><g:textArea class="input_field required" value="${reasonForCancellation}" name="reasonForCancellation" id="reasonForCancellation" maxlength="80"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Original LC Submitted<span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup name="originalLcSubmittedFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${originalLcSubmittedFlag}" >
			     ${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
			  </g:radioGroup>			
		</td>
	</tr>
</table>
</div>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
	$(document).ready(function() {
	    var commodityCode = $('#commodityCode').val(),
	        splittedCommodity;

	    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

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
	            }
	        });
	    }

	});
</script>