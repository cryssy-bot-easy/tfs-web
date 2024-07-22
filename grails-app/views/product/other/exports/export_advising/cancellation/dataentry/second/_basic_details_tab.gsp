<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceReferenceNumber" value="${tradeServiceReferenceNumber}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />

<g:hiddenField name="exportsAdvisingFee" value="${exportsAdvisingFee}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td colspan="2"><span class="title_label"> Other Bank Charges (for Payment via MC)</span></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
		<td class="label_width"><span class="field_label">Receiving Bank </span></td>
		<td class="input_width"><g:textField name="receivingBank" class="input_field" readonly="readonly" value="${receivingBank}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Exporter CB Code <br/> (if without CIF No.)</span></td>
		<td><g:textField name="exporterCbCode" class="input_field" readonly="readonly" /></td>
		<td><span class="field_label">Total Amount of Other <span class="asterisk"> *</span> <br/> Bank Charges</span></td>
		<td><g:textField name="totalBankCharges" class="input_field numericCurrency required" value="${totalBankCharges}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Exporter Name (Drawer)</span></td>
		<td><g:textArea name="exporterName" class="input_field" readonly="readonly" value="${exporterName}" rows="2"/></td>
		<td><span class="field_label">Date of Cancellation <span class="asterisk"> *</span></span></td>
		<td><g:textField name="dateOfCancellation" class="datepicker_field required" readonly="readonly" value="${dateOfCancellation}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Exporter Address</span></td>
		<td><g:textArea name="exporterAddress" class="textarea" rows="4" readonly="readonly" value="${exporterAddress}" /></td>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Importer Name (Drawee)</span></td>
		<td><g:textArea name="importerName" class="textarea" readonly="readonly" value="${importerName}" rows="2"/></td>
	</tr>
	<tr>
	    <td class="valign_top"> <span class="field_label">Importer Address</span></td>
        <td><g:textArea name="importerAddress" class="textarea" rows="2" value="${importerAddress}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Type</span></td>
		<td><g:textField name="lcType" class="input_field" readonly="readonly" value="${lcType}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Number</span></td>
		<td><g:textField name="lcNumber" maxlength="16" class="input_field" readonly="readonly" value="${lcNumber}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Issue Date</span></td>
		<td><g:textField name="lcIssueDate" class="input_field" readonly="readonly" value="${lcIssueDate}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Tenor Term</span></td>
		<td><g:textField name="lcTenor" class="input_field" readonly="readonly" value="${lcTenor}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">If Usance: Usance Term</span></td>
		<td><g:textField name="usanceTerm" class="input_field" readonly="readonly" value="${usanceTerm}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Currency</span></td>
		<td>
            <g:textField name="lcCurrency" class="input_field" readonly="readonly" value="${lcCurrency}"/>
       </td>
	</tr>
	<tr>
		<td><span class="field_label">LC Amount</span></td>
		<td><g:textField name="lcAmount" class="input_field numericCurrency" readonly="readonly" value="${lcAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Expiry Date</span></td>
		<td><g:textField name="lcExpiryDate" class="input_field" readonly="readonly" value="${lcExpiryDate}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Confirmed by UCPB?</span></td>
		<td>
            <g:radioGroup name="confirmedFlagDisplay" labels="['Yes','No']" values="[1,0]" value="${0}" disabled="disabled"> ${it.radio } ${it.label} &#160; &#160;</g:radioGroup>
            <g:hiddenField name="confirmedFlag" value="0" />
       </td>
	</tr>
	<tr>
		<td><span class="field_label">Issuing Bank</span></td>
		<td>
			<g:textField name="issuingBank" class="input_field" readonly="readonly" value="${issuingBank}" />
			<g:hiddenField name="issuingBankAddress" value="${issuingBankAddress}" />	
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank</span></td>
		<td><g:textField name="reimbursingBank" class="input_field" readonly="readonly" value="${reimbursingBank}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
            <g:radioGroup name="cwtFlagDisplay" labels="['Yes','No']" values="['Y','N']" value="${cwtFlagDisplay ?: 'N'}">
				${it.radio } ${it.label} &#160; &#160;
			</g:radioGroup>
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

        $("input[name=cwtFlagDisplay]").click(function() {
            $("#cwtFlag").val(this.value);
        });
    });
</script>
