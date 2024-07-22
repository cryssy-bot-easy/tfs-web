<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="documentNumber" value="${documentNumber}" />
<g:hiddenField name="accountType" value="${accountType}" />
<g:hiddenField name="countryCode" value="${countryCode}" />
<g:hiddenField name="creditFacilityCode" value="${creditFacilityCode}" />
<g:hiddenField name="corresBankName" value="${corresBankName ?: reimbursingBankName}" />


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" class="input_field" value="${processingUnitCode ?: '909'}" readonly="readonly" /></td>
	</tr>
	
    <tr>
		<td class="label_width"><span class="field_label"> Export Advance Currency </span></td>
		<td class="input_width">
            %{--<g:textField name="currency" value="${currency}" class="input_field" readonly="readonly" />--}%
            <g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Export Advance Proceeds</span></td>
		<td class="input_width"><g:textField name="amount" value="${amount}" class="input_field_right numericCurrency" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter CB Code</span></td>
		<td class="input_width">
            <g:textField name="exporterCbCode" value="${exporterCbCode}" class="input_field" readonly="readonly" />
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter Name </span></td>
		<td class="input_width"><g:textField name="exporterName" value="${exporterName}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code </span></td>
		<td class="input_width"><g:textField name="importerCbCode" value="${importerCbCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer Name </span></td>
		<td class="input_width"><g:textField name="importerName" value="${importerName}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Corres Bank </span></td>
		<td class="input_width"><g:textField name="corresBankCode" value="${corresBankCode ?: reimbursingBankCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT? <span class="asterisk"> * </span></span></td>
		<td class="input_width">
            <g:radioGroup labels="['Yes','No']" values="['Y','N']" name="cwtFlagDisplay" value="${cwtFlag == 'Y' || cwtFlag == true ? 'Y' : 'N'}" disabled="disabled"><label>${it.radio} <g:message code="${it.label}" /></label> &#160;</g:radioGroup>
            <g:hiddenField name="cwtFlag" value="${cwtFlag ?: 'N'}" />
        </td>
	</tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>


<script>
    $(document).ready(function() {
        $("#saveConfirmBasicDetails").click(function() {
        	mCenterPopup($("#loading_div"), $("#loading_bg"));
        	mLoadPopup($("#loading_div"), $("#loading_bg"));
        	$(".saveAction").show();
        	$(".cancelAction").hide();
            $("#basicDetailsTabForm").submit();
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>