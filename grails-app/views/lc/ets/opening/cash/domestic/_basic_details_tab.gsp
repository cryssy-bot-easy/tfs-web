<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/basic_details_utility.js" />
<%-- Added --%>
<g:javascript src="js-temp/validation_DMLC_Opening_ets.js"/>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<%--added documentNumber for report --%>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="saveAs" value=""/>

<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="mainCifName" value="${mainCifName}" />

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
        </td>
		<td class="label_width"> <span class="field_label"> eTS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown input_three required" name="processingUnitCode" from="${['909']}" noSelection="['':'SELECT ONE']" value="${processingUnitCode ?: '909'}"/> </td>
		<td class="label_width"> <span class="field_label">DMLC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field input_ten lc_issue required" name="issueDate" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Type</span> </td>
		<td class="input_width"> <g:textField class="input_field input_ten" name="type" readonly="readonly" value="${type ?: 'CASH'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DMLC Currency<span class="asterisk">*</span> </span> </td>
		<%-- <td class="input_width"> <g:select name="currency" from="${['PHP','USD','EUR']}" noSelection="['':'SELECT ONE']" class="select_dropdown currency" value="${currency}"/> </td>--%>
		<td class="input_width"> 
			<%-- <tfs:lcCurrency class="select_dropdown input_fifteen currency" name="currency" value="${currency}"/> --%>
			
			<%-- Auto Complete --%>
			<input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
		</td>
		<td class="label_width"> <span class="field_label"> DMLC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right input_fifteen lc_amount numericCurrency required" name="amount" value="${amount}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">DMLC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field input_ten lc_expiry required" name="expiryDate" value="${expiryDate}"/> </td>
		<td class="label_width"> <span class="field_label"> Tenor</span> </td>
		<td class="input_width"> <g:textField name="tenor" class="input_field" readonly="readonly" value="${tenor ?: 'SIGHT'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> General Description of Goods and/or Services <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea input_sixtyFive required" name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" rows="5" cols="40" maxlength="6500"/> </td>
		<td class="label_width"> <span class="field_label">With 2% CWT? <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" class="required" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
		      <label> ${it.radio}&#160;<g:message code="${it.label}" /></label>
		    </g:radioGroup>
		</td>
	</tr> 
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        %{--$("#currency").select2('data',{id: '${currency}'});--}%
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
    });
</script>