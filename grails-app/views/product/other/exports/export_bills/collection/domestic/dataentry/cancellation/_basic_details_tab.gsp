<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Exporter CB code <br />(if without CIF No.)</span> 
		</td>
		<td class="input_width"> <g:textField class="input_field" name="exporterCbCode" readonly="readonly" value="${exporterCbCode}"/> </td>
	</tr>
		<tr>
		<td class="label_width"> <span class="field_label"> Exporter Name (Drawer) </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="exporterName" readonly="readonly" value="${exporterName}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Importer Name (Drawee) </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="importerName" readonly="readonly" value="${importerName}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Payment Mode </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="paymentMode" readonly="readonly" value="${paymentMode}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Correspondent Bank </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="corresBankCode" readonly="readonly" value="${corresBankCode}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Reason For Cancellation <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea maxlength="350" class="textarea_long required" name="reasonForCancellation" value="${reasonForCancellation}" /> </td>
	</tr>
</table>
<br />

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
            if(validateExportTab("#basicDetailsTabForm") > 0){
            	triggerAlertMessage(val_msg);
            } else {
            	mCenterPopup($("#loading_div"), $("#loading_bg"));
            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                $("#basicDetailsTabForm").submit();
            }
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>