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
	</tr><tr>
        <td class="label_width"> <span class="field_label">TIN <span class="asterisk">*</span></span> </td>
        <td class="input_width"><g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" maxLength="20"/> </td>
    <tr>
    <tr>
        <td class="label_width"> <span class="field_label">Exporter Code</span></td>
            <td class="input_width"> <g:textField class="input_field" name="participantCode"id="participantCode" value="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label">Particulars</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="particularsLabel" id="particularsLabel" />
            <g:hiddenField name="particulars" value="${particulars}" />
        </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span> </span> </td>
        <td class="input_width">
            <%-- Auto Complete --%> 
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
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
    	var participantCode = $('#participantCode').val(),
            cifNumber = $('#cifNumber').val(),
            commodityCode = $('#commodityCode').val(),
            particulars = $('#particulars').val(),
            splittedCommodity;

	    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});
	    $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: '${particularsLabel}'});
	
	    // If participantCode has no value, try to get the corresponding code on cif table based on CIF number
	    if (participantCode === null || participantCode === undefined || participantCode.length === 0) {
	        $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $('#participantCode').val(data.results[0].id);
	            }
	        });
	    }
	
	    $('#tempTinNumber').change(function() {
	        $('#tinNumber').val($('#tempTinNumber').val());
	    });

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

	    $("#particularsLabel").change(function() {
	        splittedParticulars = $(this).val().split("-");
	        if(splittedParticulars.length > 0) {
	            $('#particulars').val(splittedParticulars[0].toString().trim());
	        }
	    });

	    if(particulars) {
	        $('#particulars').val(particulars.toString().trim())
	        $.get(autoCompleteParticularsUrl, {starts_with: particulars.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    }

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