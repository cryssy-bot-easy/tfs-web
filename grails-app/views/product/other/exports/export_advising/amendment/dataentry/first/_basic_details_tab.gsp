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

<g:hiddenField name="lcTypeSR2021" value="${lcType}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> Process Date</span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label"> 2nd Advising Bank</span></td>
		<td class="input_width">
			<g:textField name="advisingBank" class="select2_dropdown" id="advisingBank"/>
			<g:hiddenField name="advisingBankLabel" value="${advisingBankLabel}" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}" /></td>
		<td class="valign_top" rowspan="2"><span class="field_label">2nd Advising Bank Address</span></td>
		<td rowspan="2"><g:textArea name="advisingBankAddress" class="textarea" rows="4" readonly="readonly" value="${advisingBankAddress}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Exporter CB Code <br/> (if without CIF No.)</span></td>
		<td><g:textField name="exporterCbCode" class="select2_dropdown" readonly="readonly" value="${exporterCbCode}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Exporter Name</span></td>
		<td>
            <g:hiddenField name="exporterNameFrom" value="${exporterNameFrom ?: exporterName}" />
            <g:textArea name="exporterName" class="textarea" readonly="readonly" value="${exporterName}" rows="2" maxlength="60"/>
       	</td>
		<td class="valign_top" rowspan="2"><span class="field_label"> Sender to Receiver Information</span></td>
		<td>
			<tfs:senderToReceiverTypeforMT730 name="senderToReceiver" class="newSenderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Exporter Address</span></td>
		<td><g:textArea name="exporterAddress" class="textarea" rows="4" readonly='readonly' value="${exporterAddress}" /></td>
		<td>
			<g:textArea name="senderToReceiverInformation" class="textarea" rows="6" value="${senderToReceiverInformation}" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">LC Number </span></td>
		<td><g:textField name="lcNumber" maxlength="16" class="input_field" readonly="readonly" value="${lcNumber}"/></td>
		<td><span class="field_label">Create MT 730? </span ></td>
		<td><g:radioGroup name="sendMt730Flag" id="sendMt730Flag" labels="['Yes', 'No']" values="[1,0]" value="${sendMt730Flag ?: 0}"> ${it.radio} ${it.label} &#160;&#160; </g:radioGroup></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Issue Date</span></td>
		<td><g:textField name="lcIssueDate" class="input_field" readonly="readonly" value="${lcIssueDate}" /></td>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Type</span></td>
		<td><g:textField name="lcType" class="input_field" readonly="readonly" value="${lcType}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Date of Amendment <span class="asterisk"> *</span></span></td>
		<td><g:textField name="lastAmendmentDate" class="datepicker_field required" readonly="readonly" value="${lastAmendmentDate ? DateUtils.shortDateFormat(new Date(lastAmendmentDate)) : DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Number of Amendment</span></td>
		<td><g:textField name="numberOfAmendments" class="input_field" readonly="readonly" value="${numberOfAmendments}" /></td>
		<g:hiddenField name="numberOfAmendmentsCounter" value="${numberOfAmendmentsCounter ?: (new Integer(numberOfAmendments) + 1)}" />
	</tr>
	<tr>
		<td><br/></td>
	</tr>
	<tr>
		<td><span class="title_label"> Fields of Amendment</span></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Currency</span></td>
		<td>
            <g:hiddenField name="lcCurrencyFrom" value="${lcCurrencyFrom ?: lcCurrency}"/>
            <g:textField name="lcCurrency" class="select2_dropdown" id="lcCurrency"/>
       </td>
	</tr>
	<tr>
		<td><span class="field_label">LC Amount</span></td>
		<td>
            <g:hiddenField name="lcAmountFrom" value="${lcAmountFrom ?: lcAmount}" />
            <g:textField name="lcAmount" class="input_field numericCurrency" value="${lcAmount}" />
       </td>
	</tr>
	<tr>
		<td><span class="field_label">LC Expiry Date</span></td>
		<td><g:textField name="lcExpiryDate" class="datepicker_field" readonly='readonly' value="${lcExpiryDate}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">New Exporter's Name</span></td>
		<td><g:textArea name="newExporterName" class="textarea" value="${newExporterName}" rows="2" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">New Exporter's Address</span></td>
		<td>
			<g:textArea name="newExporterAddress" class="textarea" rows="4" value="${newExporterAddress}" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_new_exporter_bank_address">...</a>
		</td>
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
			<g:textField name="issuingBank" class="select2_dropdown" value="${issuingBank}" readonly="readonly"/>
			<g:hiddenField name="issuingBankAddress" value="${issuingBankAddress}" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank</span></td>
		<td><g:textField name="reimbursingBank" class="select2_dropdown" id="reimbursingBank" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
            <g:radioGroup name="cwtFlagDisplay" labels="['Yes','No']" values="['Y','N']" value="${cwtFlagDisplay ?: 0}">
				${it.radio } ${it.label} &#160; &#160;
			</g:radioGroup>
            <g:hiddenField name="cwtFlag" value="${cwtFlag ?: 'N'}" />
		</td>
	</tr>
</table> <%-- End of SEARCH Form--%>

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

	if($("#lcTypeSR2021").val() == "STANDBY"){
        $("#sendMt730Flag").attr("disabled", true);
    }

    $(document).ready(function() {
        $("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
        $("#advisingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${advisingBank}'});
        $("#advisingBank").select2("disable");
        $("#lcCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${lcCurrency}'});
        $("#issuingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${issuingBank}'});
        $("#reimbursingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingBank}'});

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
        if($("#numberOfAmendmentsCounter").val() > $("#numberOfAmendments").val()){
        	$("#numberOfAmendments").val($("#numberOfAmendmentsCounter").val());
        }
        
        if($("#newExporterName").val() == "") {
        	$("#newExporterName").val($("#exporterName").val());
        } if($("#newExporterAddress").val() == "") {
        	$("#newExporterAddress").val($("#exporterAddress").val());
        }

        $("input[name=cwtFlagDisplay]").click(function() {
            $("#cwtFlag").val(this.value);
        });

        $.post(autoCompleteBankUrl, {starts_with: $("#advisingBank").val()}, function(data){
            if  (data.results[0] != null) {
                $("#advisingBankLabel").val(data.results[0].label);
            }
    	});
    });
</script>
