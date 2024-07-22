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

[Modified by:] Rafael Ski Poblete
[Date Modified:] 7/26/2018
[Description: ] Added Charges Narrative field.
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
<g:hiddenField name="mtMessageId" value="${mtMessageId}" />

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
<input type="hidden" name="allocationUnitCode" value="${allocationUnitCode}"/>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" value="${processingUnitCode ?: session.unitcode}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="lcNumber" class="input_field required" value="${lcNumber}"/></td>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">LC Type <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:select name="lcType" value="${lcType}" class="select_dropdown required" from="${['REGULAR', 'STANDBY']}" noSelection="['':'SELECT ONE...']" /></td>
		<td><span class="field_label">LC Issue Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="lcIssueDate" class="${lcIssueDateClass ?: 'input_field'} datepicker_field required" readonly="readonly" value="${lcIssueDate}"/></td>
	</tr>
	<tr>
       	<td><span class="field_label">LC Tenor Term <span class="lcTenorAsterisk"></span></span></td>
		<td><g:select name="lcTenor" class="select_dropdown" from="${['SIGHT', 'USANCE']}" noSelection="['':'SELECT ONE...']" value="${lcTenor}"/></td>
		<td><span class="field_label">LC Currency <span class="asterisk">*</span></span></td>
		<td><g:textField name="lcCurrency" class="select2_dropdown required"  id="lcCurrency"/></td>
	</tr>
	<tr>
		<td><span class="field_label">If Usance: Usance<br/>Term <span class="usanceTermAsterisk"></span></span></td>
		<td><g:textArea name="usanceTerm" class="textarea required" readonly="readonly" value="${usanceTerm}" rows="4" maxlength="350"/></td>
		<td><span class="field_label">LC Amount <span class="asterisk">*</span></span></td>
		<td><g:textField name="lcAmount" class="input_field_right numericCurrency required" value="${lcAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Exporter CB Code<%-- <br/> (if without CIF No.)--%></span></td>
		<td>
<%--            <g:textField name="exporterCbCode" class="select2_dropdown" id="exporterCbCode"/>--%>
            <input type="text" class="input_field" id ="exporterCbCode" name ="exporterCbCode" readonly="readonly" value="${exporterCbCode}" />
            <g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
			<g:hiddenField name="mainCifName" value="${mainCifName}"/>
<%--            <g:hiddenField name="exporterCbCodeCheck" value="${exporterCbCodeCheck}" />--%>
       	</td>
		<td><span class="field_label">LC Expiry Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="lcExpiryDate" class="datepicker_field required" readonly="readonly" value="${lcExpiryDate}" /></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">Exporter Name</span></td>
		<td><g:textArea name="exporterName" class="textarea" value="${exporterName}" rows="2" maxlength="60"/></td>
		<td class="valign_top"><span class="field_label">Importer Name</span></td>
		<td><g:textArea name="importerName" class="textarea" value="${importerName}" rows="2" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="valign_top"> <span class="field_label">Exporter Address</span></td>
		<td>
            <g:textArea name="exporterAddress" class="textarea" rows="4" value="${exporterAddress}" readonly="readonly"/>
            <a href="javascript:void(0)" class="search_btn" id="popup_btn_exporter_bank_address">...</a>
       </td>
        <td class="valign_top"> <span class="field_label">Importer Address</span></td>
        <td>
        	<g:textArea name="importerAddress" class="textarea" rows="2" value="${importerAddress}" readonly="readonly"/>
        	<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">2nd Advising Bank</span></td>
		<td>
			<g:textField name="advisingBank" class="select2_dropdown" id="advisingBank"/>
			<g:hiddenField name="advisingBankLabel" value="${advisingBankLabel}" />
		</td>
		<td><span class="field_label">Issuing Bank<span class="asterisk">*</span></span></td>
		<td>
			<g:textField name="issuingBank" id="issuingBank" class="select2_dropdown"  />
			<g:hiddenField name="issuingBankName" value="${issuingBankName}" />
			<g:hiddenField name="issuingBankAddress" value="${issuingBankAddress}" />
		</td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">2nd Advising Bank Address</span></td>
		<td valign="top" rowspan="2">
			<g:textArea name="advisingBankAddress" class="textarea" rows="4" value="${advisingBankAddress}" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_2nd_advising_bank_address">...</a>
		</td>
		<td><span class="field_label">Reimbursing Bank</span></td>
		<td><g:textField name="reimbursingBank" id="reimbursingBank" class="select2_dropdown" /></td>
	</tr>
	<tr>
		<td/>
		<td class="valign_top"> <span class="field_label">Sender to Receiver Information</span></td>
		<td>
			<tfs:senderToReceiverTypeforMT730 name="senderToReceiver" class="newSenderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Confirmed by UCPB?</span></td>
		<td>
            <g:radioGroup name="confirmedFlagDisplay" labels="['Yes','No']" values="[1,0]" value="${0}" disabled="disabled"> ${it.radio } ${it.label} &#160; &#160;</g:radioGroup>
            <g:hiddenField name="confirmedFlag" value="0" />
       	</td>
       	<td/>
		<td rowspan="2" colspan="2">
			<g:textArea name="senderToReceiverInformation" class="textarea" rows="6" value="${senderToReceiverInformation}" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
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
	<tr>
		<td class="valign_top"><span class="field_label">Charges Narrative</span></td>
		<td valign="top" rowspan="2">
			<g:textArea name="chargeNarrative" class="textarea" rows="6" value="${chargeNarrative}" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_charge_narrative">...</a>
		</td>
	</tr>
	<tr>
		<td colspan="2"/>
		<td><span class="field_label">Create MT 730?</span></td>
		<td><g:radioGroup name="sendMt730Flag" id="sendMt730Flag" labels="['Yes', 'No']" values="[1,0]" value="${sendMt730Flag ?: 0}"> ${it.radio} ${it.label} &#160; &#160; </g:radioGroup></td>	
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
    function onLcTenorChange() {
        $("#usanceTerm").attr("readonly", "readonly");
        if ($("#lcTenor").val() == "USANCE") {
            $("#usanceTerm").removeAttr("readonly");
        }
    }

    function onChangeLcType(){
        if($("#lcType").val().toUpperCase() != 'REGULAR'){
            $("#lcTenor").val("SIGHT").attr("disabled", "disabled");
            $(".lcTenorAsterisk").removeClass("asterisk").text("");
            $("#usanceTerm").val("").attr("readonly", "readonly");
            $("#sendMt730Flag").attr("disabled", true);
        } else {
            $("#lcTenor").val('${lcTenor}').addClass("required").removeAttr("disabled");
            $(".lcTenorAsterisk").addClass("asterisk").text("*");
            $("#sendMt730Flag").attr("disabled", false);
        }
    }

    function onChangeLcTypeTenor() {
    	if($("#lcType").val() == "REGULAR" && $("#lcTenor").val() == "USANCE") {
             $(".usanceTermAsterisk").addClass("asterisk").text("*");
             $(".usanceTerm").addClass("required");
             $(".usanceTerm").removeAttr("readonly");
 		} else {
 			$(".usanceTermAsterisk").removeClass("asterisk").text("");
 			$("#usanceTerm").val("").removeClass("required");	
 		}
	}

    $(document).ready(function() {
        // $("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
        $("#advisingBank").setLocalBankDropdown($(this).attr("id")).select2('data',{id: '${advisingBank}'});
        $("#lcCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${lcCurrency}'});
        $("#issuingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${issuingBank}'});
        $("#reimbursingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingBank}'});

        $("#lcTenor").change(onLcTenorChange);
        onLcTenorChange();

        $("#advisingBank").change(function(e) {
            $("#advisingBankLabel").val($("#advisingBank").select2('data').label)
        });
        
        $("#issuingBank").change(function(e) {
            $("#issuingBankAddress").val($("#issuingBank").select2('data').address)
            $("#issuingBankName").val($("#issuingBank").select2('data').label)
        });

     	// For CIF CB CODE
        $("#cifSearchSelect").click(function() {
          	var data = $("#grid_list_cif").jqGrid("getRowData"),
          		dataMain = $("#grid_list_main_cif").jqGrid("getRowData");
           	console.log(data[0]);
           	console.log(dataMain[0]);
         	$("#exporterCbCode").val(data[0].cbCode);
         	$("#mainCifNumber").val(dataMain[0].mainCifNumber);
         	$("#mainCifName").val(dataMain[0].mainCifName);
         	$("input[name=allocationUnitCode]").val(data[0].allocationUnitCode);
        });

        /*if($("#exporterCbCodeCheck").val()){
        	$("#cifNumber").toggleClass("required", false);
        	$(".cifNumber.asterisk").hide();
        } else {
        	$("#cifNumber").toggleClass("required", true);
        	$(".cifNumber.asterisk").show();
        }

        $("#exporterCbCode").change(function() {
        	if($(this).val() != ""){
	            $("#exporterName").val($("#exporterCbCode").select2("data").label);
	            $("#exporterAddress").val($("#exporterCbCode").select2("data").address);
            	$("#cifNumber").toggleClass("required", false);
            	$(".cifNumber.asterisk").hide();
            	$("#exporterCbCodeCheck").val("true");
        	} else {
	            $("#exporterName").val("");
	            $("#exporterAddress").val("");
            	$("#cifNumber").toggleClass("required", true);
            	$(".cifNumber.asterisk").show();
            	$("#exporterCbCodeCheck").val("");
          	}

        });*/

        $("input[name=cwtFlagDisplay]").click(function() {
            $("#cwtFlag").val(this.value);
        });

        $("#saveConfirmBasicDetails").click(function() {
        	if(validateExportTab("#basicDetailsTabForm") > 0){
        		triggerAlertMessage(val_msg);
        	} 

        	else {
            	if($("#lcNumber").val().length > 16) {
            		triggerAlertMessage("LC Number cannot be more than 16 characters.");
                }
				//else if(/^[a-zA-Z]*$/.test($("#importerName").val().charAt(0)) == false) {
				//	triggerAlertMessage("No special characters or numbers.");
				//		}
					
                else {
                	mCenterPopup($("#loading_div"), $("#loading_bg"));
                	mLoadPopup($("#loading_div"), $("#loading_bg"));
    	            $("#basicDetailsTabForm").submit();
                }
                
            	
        	}
        
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });

        $("#lcType").change(onChangeLcType);
        onChangeLcType();

        $("#lcNumber").keypress(function(e){
            //x-character set
            var regex=/[a-zA-Z0-9/\-?:().,'+{}\s]/;
            var charCheck = true;
        	var actual_char=String.fromCharCode(e.which);
        	
            if(!regex.test(actual_char)){
                charCheck = false;
            } 
            if(e.keyCode == 8 || e.keyCode == 46){
				//check delete and backspace
            	charCheck=true;
            }
            return charCheck
        });

        onChangeLcTypeTenor();
        $("#lcType").change(onChangeLcTypeTenor);
        $("#lcTenor").change(onChangeLcTypeTenor);
       	
    });
</script>