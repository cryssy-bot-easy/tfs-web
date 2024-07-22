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
<g:hiddenField name="cableFee" value="${cableFee}"/>

<%-- field for mt700, needed for letter of advise report --%>
<g:hiddenField name="sequenceOfTotal" value="${sequenceOfTotal}"/>
<g:hiddenField name="formOfDocumentaryCredit" value="${formOfDocumentaryCredit}"/>
<g:hiddenField name="documentaryCreditNumber" value="${documentaryCreditNumber}"/>
<g:hiddenField name="referenceToPreAdvice" value="${referenceToPreAdvice}"/>
<g:hiddenField name="applicableRules" value="${applicableRules}"/>
<g:hiddenField name="dateAndPlaceOfExpiry" value="${dateAndPlaceOfExpiry}"/>
<g:hiddenField name="percentageCreditAmountTolerance" value="${percentageCreditAmountTolerance}"/>
<g:hiddenField name="maximumCreditAmount" value="${maximumCreditAmount}"/>
<g:hiddenField name="additionalAmountsCovered" value="${additionalAmountsCovered}"/>
<g:hiddenField name="availableWithBy" value="${availableWithBy}"/>
<g:hiddenField name="drawee" value="${drawee}"/>
<g:hiddenField name="mixedPaymentDetails" value="${mixedPaymentDetails}"/>
<g:hiddenField name="deferredPaymentDetails" value="${deferredPaymentDetails}"/>
<g:hiddenField name="partialShipments" value="${partialShipments}"/>
<g:hiddenField name="transshipment" value="${transshipment}"/>
<g:hiddenField name="placeOfTakingInCharge" value="${placeOfTakingInCharge}"/>
<g:hiddenField name="portOfLoading" value="${portOfLoading}"/>
<g:hiddenField name="placeOfFinalDestination" value="${placeOfFinalDestination}"/>
<g:hiddenField name="latestDateOfShipment" value="${latestDateOfShipment}"/>
<g:hiddenField name="shipmentPeriod" value="${shipmentPeriod}"/>
<g:hiddenField name="descriptionOfGoodsAndOrServices" value="${descriptionOfGoodsAndOrServices}"/>
<g:hiddenField name="documentsRequired" value="${documentsRequired}"/>
<g:hiddenField name="additionalConditions" value="${additionalConditions}"/>
<g:hiddenField name="charges" value="${charges}"/>
<g:hiddenField name="periodForPresentation" value="${periodForPresentation}"/>
<g:hiddenField name="confirmationInstructions" value="${confirmationInstructions}"/>
<g:hiddenField name="instructionsToThePayingBank" value="${instructionsToThePayingBank}"/>
<g:hiddenField name="adviseThroughBank" value="${adviseThroughBank}"/>

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label">Process Date</span></td>
        <td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
        <td class="label_width"><span class="field_label">2nd Advising Bank</span></td>
        <td class="input_width">
        	<g:textField name="advisingBank" class="input_field" readonly="readonly" value="${advisingBank}" />
			<g:hiddenField name="advisingBankLabel" value="${advisingBankLabel}" />
        </td>
    </tr>
    <tr>
        <td><span class="field_label">Document Number</span></td>
        <td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/> </td>
        <td class="valign_top" rowspan="2"> <span class="field_label">2nd Advising Bank Address</span></td>
        <td rowspan="2"> <g:textArea name="advisingBankAddress" class="textarea" rows="4" readonly="readonly" value="${advisingBankAddress}" /> </td>
    </tr>
    <tr>
        <td><span class="field_label">Exporter CB Code <br/> (if without CIF No.)</span></td>
        <td><g:textField name="exporterCbCode" class="input_field" readonly="readonly" value="${exporterCbCode}" /> </td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label">Exporter Name (Drawer)</span></td>
        <td><g:textArea name="exporterName" class="textarea" readonly="readonly" value="${exporterName}" rows="2" maxlength="60"/> </td>
        <td><span class="field_label">Date of Cancellation <span class="asterisk"> * </span></span></td>
        <td><g:textField name="dateOfCancellation" class="datepicker_field required" readonly="readonly" value="${dateOfCancellation}" /></td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label">Exporter Address</span></td>
        <td><g:textArea name="exporterAddress" class="textarea" rows="4" readonly="readonly" value="${exporterAddress}" /> </td>
        <td><span class="field_label">Related Reference</span></td>
        <td><g:textField name="relatedReference" class="input_field"  value="${relatedReference ?: 'NONREF' }"/></td>
    </tr>
    <tr>
        <td class="valign_top"><span class="field_label">Importer Name (Drawee)</span></td>
        <td valign="top"><g:textArea name="importerName" class="textarea" readonly="readonly" value="${importerName}" rows="2"/> </td>
        <td class="valign_top"><span class="field_label">Narrative <span class="asterisk"> * </span></span></td>
        <td><g:textArea name="narrative" class="textarea required" rows="4" value="${narrative}" maxlength="1750"/></td>
    </tr>
    <tr>
		<td class="valign_top"> <span class="field_label">Importer Address</span></td>
        <td><g:textArea name="importerAddress" class="textarea" rows="2" value="${importerAddress ?: importerNameAddress}" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">LC Type</span></td>
        <td><g:textField name="lcType" class="input_field" readonly="readonly" value="${lcType}"/> </td>
        <td><span class="field_label">Send MT 799?</span></td>
        <td><g:radioGroup name="sendMt799Flag" labels="['Yes', 'No']" values="[1,0]" value="${sendMt799Flag ?: 0}"> ${it.radio} ${it.label} &#160; &#160;</g:radioGroup></td>
    </tr>
    <tr>
        <td><span class="field_label">LC Number</span></td>
        <td><g:textField name="lcNumber" maxlength="16" class="input_field" readonly="readonly" value="${lcNumber}" /> </td>
        <td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
    </tr>
    <tr>
        <td><span class="field_label">LC Issue Date</span></td>
        <td><g:textField name="lcIssueDate" class="input_field" readonly="readonly" value="${lcIssueDate}" /> </td>
    </tr>
    <tr>
        <td><span class="field_label">LC Tenor Term</span></td>
        <td><g:textField name="lcTenor" class="input_field" readonly="readonly" value="${lcTenor}" /> </td>
    </tr>
    <tr>
        <td><span class="field_label">If Usance: Usance Term</span></td>
        <td><g:textField name="usanceTerm" class="input_field" readonly="readonly" value="${usanceTerm}" /> </td>
    </tr>
    <tr>
        <td><span class="field_label">LC Currency</span></td>
        <td>
            <g:textField name="lcCurrency" class="input_field" readonly="readonly" value="${lcCurrency}"/>
        </td>
    </tr>
    <tr>
        <td><span class="field_label">LC Amount</span></td>
        <td><g:textField name="lcAmount" class="input_field numericCurrency" readonly="readonly" value="${lcAmount}"/> </td>
    </tr>
    <tr>
        <td><span class="field_label">LC Expiry Date</span></td>
        <td><g:textField name="lcExpiryDate" class="input_field" readonly="readonly" value="${lcExpiryDate}" /> </td>
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
        <td><g:textField name="reimbursingBank" class="input_field" readonly="readonly" value="${reimbursingBank}"/> </td>
    </tr>
    <tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
            <g:radioGroup name="cwtFlagDisplay" labels="['Yes','No']" values="['Y','N']" value="${cwtFlagDisplay ?: (cwtFlag == true ? 'Y' : 'N')}">
				${it.radio } ${it.label} &#160; &#160;
			</g:radioGroup>
            <g:hiddenField name="cwtFlag" value="${cwtFlag == true ? 'Y' : 'N'}" />
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
var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';

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
	
	$.post(autoCompleteBankUrl, {starts_with: $("#advisingBank").val()}, function(data) {
        if (data.results[0] != null) {
            $("#advisingBankLabel").val(data.results[0].label);
        }
	});
});
</script>
