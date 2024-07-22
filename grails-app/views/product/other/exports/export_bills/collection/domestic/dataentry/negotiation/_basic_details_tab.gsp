<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<g:hiddenField name="paymentMode" value="LC" />
<g:hiddenField name="processingUnitCode" value="${session.unitcode}"/>
<g:each in="${exchange}" var="temp" status="i">
	<g:if test="${!temp.rate_description.contains('BOOKING')}">
		<g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
	</g:if>
	<g:else>
		<g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
	</g:else>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Invoice Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="invoiceNumber" value="${invoiceNumber}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationDate" readonly="readonly" value="${negotiationDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Seller Name </span> </td>
		<td class="input_width"> <g:textArea class="textarea" name="sellerName" value="${sellerName}" maxlength="60" rows="2"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Buyer Name<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea required" name="buyerName" value="${buyerName}" maxlength="60" rows="2"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}" /> </td>
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
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});

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