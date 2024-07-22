<%@ page import="net.ipc.utils.DateUtils" %>
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

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
		1. EBC Nego - Importer Address should follow the template for beneficiary address (Redmine# 4125)
		2. There is EXPORTERCBCODE in EBC Nego but none in EBP Nego (Redmine# 4136) 
		3. EBP Negotiation Importer Address (Redmine# 4139)
		4. EBP Negotiation - Data Entry Inquiry (Redmine# 4152)
		5. Unnecessary Field found in eTS Basic Details Tab (Redmine# 4165)
		6. EBP Negotiation - E-TS Inquiry and Data Entry Inquiry and EBP Settlement Inquiry Screens (Redmine# 4158)
		7. EBP NEGO - Proceeds via PDDTS (Redmine# 4190)
		8. Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 01/26/2017 (tfs-web Rev# 7350)
		2. 01/26/2017 (tfs-web Rev# 7356)
		3. 02/08/2017 (tfs-web Rev# 7357)
		4. 02/14/2017 (tfs-web Rev# 7384), 02/17/2017 (tfs-web Rev# 7400), 02/21/2017 (tfs-web Rev# 7401)
		5. 02/15/2017 (tfs-web Rev# 7396), 02/16/2017 (tfs-web Rev# 7397)
		6. 02/21/2017 (tfs-web Rev# 7406)
		7. 03/21/2017 (tfs-web Rev# 7436)
		8. 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Added an ellipsis button for Importer Address.
		2. Added an Exporter CB Code dropdown list.
		3. Importer Address name was changed from importerAddress to buyerAddress, same procedure for the value.
		4. Added hidden fields for data extraction.
		5. Element swiftAddress was changed from 'g:hiddenField' to 'input type="hidden"'
		6. Added a condition that validates if viewed in inquiry.
		7. Element 'Export proceeds to be remitted via PDDTS' was deleted.
		8. Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _basic_details_tab.gsp
--%>
<%-- 
(revision)
    (revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    [Revised date:] 03/20/2018
    Program [Revision:] add new Fields TIN, Exporter Code, Particulars and their behavior. Add temporary name tempTinNumber to prevent saving 2 tinNumber.
    PROJECT: WEB
    MEMBER TYPE  : WEB
    Project Name: _basic_details_tab.gsp
--%>


<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />

<%-- For EBC details --%>
<g:hiddenField name="stat" value="${statusAction}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="valueDate" value="${valueDate ?: DateUtils.shortDateFormat(new Date())}" />
<g:hiddenField name="totalAmountClaimedFlag" value="" />
<g:hiddenField name="totalAmountClaimedDate" value="" />
<g:hiddenField name="totalAmountClaimedCurrencyA" value="" />
<g:hiddenField name="totalAmountClaimedCurrencyB" value="" />
<g:hiddenField name="totalAmountClaimedA" value="" />
<g:hiddenField name="totalAmountClaimedB" value="" />
<g:hiddenField name="corresBankAccountFlag" value="" />
<g:hiddenField name="corresBankAccountCode" value="" />
<g:hiddenField name="corresBankLocation" value="" />
<g:hiddenField name="corresBankNameAndAddress" value="" />
<g:hiddenField name="corresBankFlag" value="" />
<g:hiddenField name="corresBankCode" value="" />
<g:hiddenField name="corresBankAccountNameAndAddress" value="" />
<g:hiddenField name="accountType" value="" />
<g:hiddenField name="depositoryAccountNumber" value="" />
<g:hiddenField name="glCode" value="" />
<g:hiddenField name="countryCode" value="" />
<g:hiddenField name="corresBankAccountNumberComplete" value="" />
<g:hiddenField name="corresBankComplete" value="" />
<g:hiddenField name="issuingBankName" value="${issuingBankName ?: ''}" />
<g:hiddenField name="negoAdviceAddressee" value="${negoAdviceAddressee ?: ''}" />
<g:hiddenField name="negoAdviceAddresseeAddress" value="${negoAdviceAddresseeAddress ?: ''}" />
<g:hiddenField name="collectingBankName" value="${collectingBankName ?: ''}" />
<g:hiddenField name="collectingBankAddress" value="${collectingBankAddress ?: ''}" />
<input type="hidden" name="collectingBankCode" value="${collectingBankCode ?: ''}"/>
<input type="hidden" name="swiftAddress" value="${swiftAddress ?: ''}">

<g:if test="${params.mode=='dev'}">
    %{--SESSION '${session}'--}%
    '${ amount}'
    '${ advanceInterest}'
    '${ new BigDecimal(amount?.replace(',','')) - new BigDecimal(advanceInterest?.replace(',',''))}'
</g:if>

<g:javascript src="popups/ets_opening_header_utility.js" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId ?: etsNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" id="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
    %{--<tr>--}%
        %{--<td class="label_width"> <span class="field_label"> Document Number </span> </td>--}%
        %{--<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>--}%
    %{--</tr>--}%
	<tr>
		<td class="label_width"> <span class="field_label"> Main CIF Number<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}" data-orig="${mainCifNumber}"/>
		<%-- Redmine 4168 - Main CIF --%>
		<a href="javascript:void(0)" id="main_cif_search_new" class="search_btn popup_btn_cif_main_new">Search/Look-up Button</a></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
	</tr>
	
<%-- Added Exporter CB Code for Issue# 4316 --%>	
	<tr>
		<td class="label_width">
			<span class="field_label"> Exporter CB code<%-- <br />(if without CIF No.)<span class="asterisk">*</span>--%></span>
		</td>
		<td class="input_width">
            <g:textField class="input_field" name="exporterCbCode" id="exporterCbCode" readonly="readonly" value="${exporterCbCode}"/>
<%--            <input class="tags_cbcode select2_dropdown bigdrop cbcodeDd" readonly="readonly" disabled="disabled" name="exporterCbCode" id="exporterCbCode" data-orig="${exporterCbCode}" />--%>
<%--            <g:hiddenField name="exporterCbCodeCheck" value="${exporterCbCodeCheck}" />--%>
        </td>
	</tr>
<%-- End of Issue# 4316 --%>	
	<tr>
		<td class="label_width"> <span class="field_label">Exporter Name (Drawer)<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField maxlength="100" class="input_field required" name="sellerName" value="${sellerName}" data-orig="${sellerName}" maxlength="100"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Exporter Address<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:textArea maxlength="300" name="sellerAddress" value="${sellerAddress}" data-orig="${sellerAddress}" class="textarea required" rows="4"/>
		</td>
	</tr>
	<tr>
        <td class="label_width"> <span class="field_label">TIN <span class="asterisk">*</span></span> </td>
        <td class="input_width"><g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" data-orig="${tinNumber}" maxLength="20"/> </td>
    <tr>
    <tr>
        <td class="label_width"> <span class="field_label">Exporter Code</span></td>
        <td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode}" data-orig="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Particulars</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="particularsLabel" id="particularsLabel" data-orig="${particularsLabel}"/>
            <g:hiddenField name="particulars" id="particulars"  value="${particulars}" data-orig="${particulars}"/>
        </td>
    </tr>
	<tr>
		<td class="label_width"><span class="field_label">Drawee</span></td>
		<td class="input_width"><g:textField class="input_field" name="drawee" value="${drawee}" data-orig="${drawee}" maxlength="100" /></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Importer Name <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField maxlength="100" class="input_field required" name="buyerName" value="${buyerName}" data-orig="${buyerName}" maxlength="100"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top"><span class="field_label"> Importer Address<span class="asterisk">*</span> </span> </td>
	<%-- added ellipsis button for Issue# 4125 of Deffered Issues --%>
		<td class="input_width">
			<g:textArea name="buyerAddress" value="${buyerAddress}" data-orig="${buyerAddress}" class="textarea required" rows="4" readonly="readonly"/>
			<span class="float_right">
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
			</span>
		</td>
	<%-- end of Issue# 4125	--%>
	
<%--		<td class="input_width">--%>
<%--			<g:textArea maxlength="300" name="buyerAddress" value="${buyerAddress}" class="textarea required" rows="4"/>--%>
<%--		</td>--%>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Processing Unit Code<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown required" name="processingUnitCode" from="['909']" noSelection="${['':'SELECT ONE...']}" value="${processingUnitCode ?: '909'}" data-orig="${processingUnitCode ?: '909'}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Payment Mode<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown required" name="paymentMode" from="['LC','DP','DA','OA','DR']" noSelection="['':'SELECT ONE...']" value="${paymentMode}" data-orig="${paymentMode}"/> </td>
		<g:hiddenField name="paymentMode" id="paymentModeHidden" value="${paymentMode}" data-orig="${paymentMode}" disabled="true"/>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> EXLC Advice Number </span> </td>
        <td class="input_width">
        	<input class="select2_dropdown bigdrop exlcDd" name="exlcAdviseNumber" id="exlcAdviseNumber" data-orig="${exlcAdviseNumber}" />
        </td>
    </tr>
	<tr>
		<td class="label_width"> <span class="field_label"> EB Facility Type<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown required" name="bpFacilityType" keys="['FBE', 'FEB']" from="['Export Bills Purchased', 'Export Bills Purchased Discounted']" noSelection="['':'SELECT ONE...']" value="${bpFacilityType}" data-orig="${bpFacilityType}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> With Outstanding EBC?<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="withBcFlag" id="withBcFlag" labels="['Yes','No']" values="[1,0]" value="${withBcFlag}" data-orig="${withBcFlag}" >
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		    <g:hiddenField name="withBcFlagCheck" id="withBcFlagCheck" class="required" />
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> If Yes: Negotiation Number <span class="withBcFlagAsterisk asterisk"></span> </span> </td>
		<td class="input_width">
            <g:select class="select_dropdown" name="negotiationNumber" from="" noSelection="['':'SELECT ONE...']" value="${negotiationNumber}" data-orig="${negotiationNumber}" id="negotiationNumber" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="bcCurrency" id="bcCurrency" readonly="readonly" value="${bcCurrency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> EBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="bcAmount" id="bcAmount" readonly="readonly" value="${bcAmount}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <input class="tags_currency select2_dropdown bigdrop required currForDd" name="currency" id="currency" data-orig="${currency}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="amount" id="amount" value="${amount}" data-orig="${amount}" onchange="validateEBPNegoAmt();" /> </td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Advance Interest </span> </td>
        <td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="advanceInterest" value="${advanceInterest?:0}" data-orig="${advanceInterest?:0}" /> </td>
    </tr>
<%--	<tr>--%>
<%--		<td class="label_width"> <span class="field_label small_margin_left"> Outstanding EBC Amount </span> </td>--%>
<%--		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="outstandingBcAmount" readonly="readonly"/> </td>--%>
<%--	</tr>--%>

<%-- commented for bug# 4190--%>
<%--	<tr>--%>
<%--		<td class="label_width">--%>
<%--			<span class="field_label"> Export proceeds to be remitted </span> <br />--%>
<%--			<span class="field_label"> via PDDTS? </span>--%>
<%--		</td>--%>
<%--		<td class="input_width">--%>
<%--		  	<g:radioGroup name="exportViaPddtsFlag" labels="['Yes','No']" values="[1,0]" value="${exportViaPddtsFlag ?: 0}">--%>
<%--		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;--%>
<%--		    </g:radioGroup>--%>
<%--		</td>--%>
<%--	</tr>--%>

	<tr>
		<td class="label_width"> <span class="field_label"> With 2% CWT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}" data-orig="${cwtFlag ?: 'N'}" >
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
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
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

    <!-- Redmine 4168 - Fix on Main CIF -->
    $("#main_cif_search_new").click(onMainCifLookup);
    
    function onMainCifLookup() {
    	// set readonly attributes
    	$("#mainCIFNumberMainSearch").attr("readonly", true);
    	$("#mainCIFNameMainSearch").attr("readonly", true);
    	// change label names
    	$("#mainCifNumberLabel").text("CIF Number");
    	$("#mainCifNameLabel").text("CIF Name");
    	
<%--    	// copy cif number--%>
    	if( $("#cifNumber").val() != "" ){
    		$("#mainCIFNumberMainSearch").val($("#cifNumber").val());
<%--    		$("#mainCIFNumberMainSearch").addAttr("data-orig");--%>
<%--    		$("#mainCIFNumberMainSearch").attr("data-orig", $("#cifNumber").val());--%>
    		$("#mainCIFNameMainSearch").val($("#cifName").val());
<%--    		$("#mainCIFNameMainSearch").addAttr("data-orig");--%>
<%--    		$("#mainCIFNameMainSearch").val("data-orig", $("#cifName").val());--%>
<%--    		--%>
    		// auto click search button
    		$("#mainCifSearchBtn").click();
    	} else {
    		// disable button when no CIF
    		$("input[name=mainCifSearchBtn]").attr('disabled', true);
    		$("input[name=mainCifSelectBtn]").attr('disabled', true);
    	}
    }
    
    <%-- 12092016 EBP Extraction - Case 2 --%>
	<%-- Validation:  EBP Nego amt should be equal or less than the EBC Nego amount --%>
	function validateEBPNegoAmt(){
		var ebpNegoAmt = $("#amount").val();
		var ebcNegoAmt = $("#bcAmount").val();
		ebpNegoAmt = ebpNegoAmt.replace(/,/g, '');
		ebcNegoAmt = ebcNegoAmt.replace(/,/g, '');
		ebpNegoAmt = parseFloat(ebpNegoAmt);
		ebcNegoAmt = parseFloat(ebcNegoAmt);
		if ( ebpNegoAmt > ebcNegoAmt ){
			triggerAlertMessage("Please do not exceed EBC Nego Amount." + "<br />" + "<b>EBP Nego Amount: </b>" + $("#amount").val());
<%--			$("#amount").val($("#bcAmount").val());--%>
		}
	}

    function onWithBcFlagChange() {
        $("#negotiationNumber").val("");
        $("#negotiationNumber").attr("disabled", "disabled");

        var withBcFlag = $("input[name=withBcFlag]:checked").val();

        if (withBcFlag == 1) {

			<%-- 12092016 EBP Extraction - Case 2 --%>
        	var cifNo = $("#cifNumber").val();
        	if( cifNo != null ){
				mCenterPopup($("#loading_div"),$("#loading_bg"));
				mLoadPopup($("#loading_div"),$("#loading_bg"));
			} 
			
            var url = '${g.createLink(controller: "product", action: "retrieveAllCollections")}';
            var cifUrl = '${g.createLink(controller: "product", action: "retrieveAllExportBills")}';
            var cifUrlNoBpCurrencyRestriction = '${g.createLink(controller: "product", action: "retrieveAllExportBillsNoBPCurrencyRestriction")}';
            
            $.post(cifUrlNoBpCurrencyRestriction, {cifNumber: $("#cifNumber").val(), exportBillType: 'EBC'}, function(data) {
                $("#negotiationNumber").empty();
                $("#negotiationNumber").append($('<option></option>').val("").html("SELECT ONE..."));

                if(data.documentNumbers.length > 0){
	                $.each(data.documentNumbers, function(idx, val) { 
	                    var option = "<option value="+val+">"+val+"</option>";
	
	                    $("#negotiationNumber").append(option)
	                });
	                $("#negotiationNumber").removeAttr("disabled");
					mDisablePopup($("#loading_div"),$("#loading_bg"));

                } else {
					<%--                    
                	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
                    triggerAlertMessage("No Outstanding EBC's found.");
        			$("#negotiationNumber").removeClass("required");
        			$(".withBcFlagAsterisk").text("");
                    $("#outstandingBcAmount").parents("tr").hide();
					--%>                     
					mDisablePopup($("#loading_div"),$("#loading_bg"));
                    triggerAlertMessage("Please input CIF number first.");
                    $("input[name=withBcFlag][value=0]").attr("checked", "checked");
                }

                if ('${negotiationNumber}') {
                    $("#negotiationNumber").val('${negotiationNumber}');
	            	if ('${statusAction}'.toUpperCase() === "APPROVE") {
		            	var elem = document.getElementById('negotiationNumber');
		    			var opt = document.createElement("option");
		    			
		    			opt.text = '${negotiationNumber}';
						elem.add(opt);
						
		                $("#negotiationNumber").val('${negotiationNumber}');
		                $("#negotiationNumber").attr("disabled", "disabled");
	            	}
//                    setEbcAmount();
                }
            }).error(function (){
            	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
                triggerAlertMessage("No Outstanding EBC's found.");
    			$("#negotiationNumber").removeClass("required");
    			$(".withBcFlagAsterisk").text("");
                $("#outstandingBcAmount").parents("tr").hide();
            });

			$("#negotiationNumber").addClass("required");
			$(".withBcFlagAsterisk").text("*");
			
        } else {
            $("#outstandingBcAmount").parents("tr").hide();

			$("#negotiationNumber").removeClass("required");
			$(".withBcFlagAsterisk").text("");

            $("#currency").select2("enable");
            $("#bcCurrency, #bcAmount").val("");

            $("select[name=paymentMode]").removeAttr("disabled");
            $("input[name=paymentMode]").attr("disabled", "disabled");
<%--            $("#paymentMode").val("");--%>
        }
        if (withBcFlag) {
            $("#withBcFlagCheck").val("true");
        } else {
            $("#withBcFlagCheck").val("");
        }

        computeOutstandingBcAmount();
    }

    function onPostError(){
    	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
        triggerAlertMessage("No Outstanding EBC's found.");
		$("#negotiationNumber").removeClass("required");
		$(".withBcFlagAsterisk").text("");
        $("#outstandingBcAmount").parents("tr").hide();
    }

    function setEbcAmount() {
        var negotiationNumber = $("#negotiationNumber").val();
        var url = '${g.createLink(controller: "product", action: "retrieveCollectionAmount")}';

        if (negotiationNumber) {
            $.post(url, {documentNumber: negotiationNumber}, function(data) {
                $("#buyerName").val(data.buyerName);
                $("#buyerAddress").val(data.buyerAddress);
                $("#bcCurrency").val(data.currency);
                $("#bcAmount").val(formatCurrency(data.amount));
                console.log(data);
                
                //brian
                var exportDetails = data.exportBills.details;
                $("#totalAmountClaimedFlag").val(exportDetails.totalAmountClaimedFlag);
                $("#totalAmountClaimedDate").val(exportDetails.totalAmountClaimedDate);
                $("#totalAmountClaimedCurrency" + exportDetails.totalAmountClaimedFlag).val(exportDetails.totalAmountClaimedCurrencyA || exportDetails.totalAmountClaimedCurrencyB);
                $("#totalAmountClaimed" + exportDetails.totalAmountClaimedFlag).val(exportDetails.totalAmountClaimedA || exportDetails.totalAmountClaimedB);
                $("#corresBankAccountFlag").val(exportDetails.corresBankAccountFlag);
                $("#corresBankAccountCode").val(exportDetails.corresBankAccountCode);
                $("#corresBankLocation").val(exportDetails.corresBankLocation);
                $("#corresBankNameAndAddress").val(exportDetails.corresBankNameAndAddress);
                $("#corresBankFlag").val(exportDetails.corresBankFlag);
                $("#corresBankCode").val(exportDetails.corresBankCode);
                $("#corresBankAccountNameAndAddress").val(exportDetails.corresBankAccountNameAndAddress);
                $("#accountType").val(data.exportBills.details.accountType);
                $("#depositoryAccountNumber").val(exportDetails.depositoryAccountNumber);
                $("#glCode").val(exportDetails.glCode);
                $("#countryCode").val(exportDetails.countryCode);
                $("#issuingBankName").val(exportDetails.issuingBankName);
                $("#negoAdviceAddressee").val(exportDetails.negoAdviceAddressee);
                $("#negoAdviceAddresseeAddress").val(exportDetails.negoAdviceAddresseeAddress);
                $("input[name=collectingBankCode]").val(exportDetails.collectingBankCode);
                $("#collectingBankName").val(exportDetails.collectingBankName);
                $("#collectingBankAddress").val(exportDetails.collectingBankAddress);
                $("#corresBankComplete").val(exportDetails.corresBankComplete);
                $("#corresBankAccountNumberComplete").val(exportDetails.corresBankAccountNumberComplete);

                $("input[name=swiftAddress]").val(exportDetails.swiftAddress);
                $("#bcCurrency").val(data.currency);

                if('${amount}'.length == 0){
                	$("#amount").val(formatCurrency(data.amount));
                }

                $("#currency").select2('data',{id: data.currency});
                $("#currency").select2("disable");

                $("select[name=paymentMode]").attr("disabled", "disabled");
                $("input[name=paymentMode]").removeAttr("disabled");
                $("#paymentMode, #paymentModeHidden").val(data.paymentMode);
                computeOutstandingBcAmount();
            });
        } else {
            $("#bcCurrency").val("");
            $("#bcAmount").val("");
            $("#amount").val("");

            $("#currency").select2('data', null);
            $("#currency").select2("enable");

            $("select[name=paymentMode]").removeAttr("disabled");
            $("input[name=paymentMode]").attr("disabled", "disabled");
            $("#paymentMode").val("");
            computeOutstandingBcAmount();
        }
    }

    function computeOutstandingBcAmount(){
        if($("#negotiationNumber").val()){
            if($("#amount").val().replace(/,/g , "") <= $("#bcAmount").val().replace(/,/g , "")){
            	$("#outstandingBcAmount").val(formatCurrency(parseFloat($("#bcAmount").val().replace(/,/g , "") - $("#amount").val().replace(/,/g , ""))));
            } else {
            	$("#outstandingBcAmount").val(formatCurrency(0));
            }
        } else {
        	$("#outstandingBcAmount").val('');
        }
    }

    function onChangePaymentMode() {
        if ($("#paymentMode").val() != "LC") {
            $("#exlcAdviseNumber").select2("data", null);
            $("#exlcAdviseNumber").parents("tr").hide();
        } else {
        	$("#exlcAdviseNumber").parents("tr").show();
        }
    }
    
    var autoCompleteExportAdvisingUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteExportAdvising")}';
    $(document).ready(function() {
        var participantCode = $('#participantCode').val(),
	        cifNumber = $('#cifNumber').val(),
	        particulars = $('#particulars').val(),
	        splittedParticulars;

        $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: '${particularsLabel}'});

        $('#tempTinNumber').change(function() {
            $('#tinNumber').val($('#tempTinNumber').val());
        });

        if ($("#cifNumber").length > 0) {
            $("#cifNumber").change(function() {
                $("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});
                $('#tempTinNumber').val($('#tinNumber').val());

	            $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
	                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                    $('#participantCode').val(data.results[0].id);
	                }
	            });
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

        // For CIF CB CODE
        $("#cifSearchSelect").click(function() {
        	var data = $("#grid_list_cif").jqGrid("getRowData");
        	console.log(data[0].cbCode);
        	 $("#exporterCbCode").val(data[0].cbCode);
        });
        
        
        //comment by robin 4122 : should not allow PHP
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
       	//commented by vico 
       	//$("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
        $("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});

        /*if ($("#exlcAdviseNumber").val()) {
            $("#currency").select2("disable");
        }*/
        
		if ('${statusAction}'.toUpperCase() === "APPROVE") {
			$("#exlcAdviseNumber").attr("disabled", "disabled");
		} 
		
        $("#exlcAdviseNumber").change(function() {
        	// 12092016 EBP Extraction - Case 4 - START
            
            id = $("#exlcAdviseNumber").select2('data').documentNumber;
            currency = $("#exlcAdviseNumber").select2('data').currency;
            amount = $("#exlcAdviseNumber").select2('data').amount;
            buyerName = $("#exlcAdviseNumber").select2('data').buyerName;
            buyerAddress = $("#exlcAdviseNumber").select2('data').buyerAddress;
            sellerName = $("#exlcAdviseNumber").select2('data').sellerName;
            sellerAddress = $("#exlcAdviseNumber").select2('data').sellerAddress;
            cbCode = $("#exlcAdviseNumber").select2('data').cbCode;
            cif = $("#exlcAdviseNumber").select2('data').cif;
            
            $("#currency").select2("data", {id: currency});
            $("#currency").select2("disable");
            $("#amount").val(amount);
            $("#sellerName").val(sellerName);
            $("#sellerAddress").val(sellerAddress);
            $("#buyerName").val(buyerName);
            $("#buyerAddress").val(buyerAddress).text(buyerAddress);
            
            if (cif) {
                $("#cifNumber").val(cif.cifNumber);
                $("#cifName").val(cif.cifName);
                $("#accountOfficer").val(cif.accountOfficer);
                $("#ccbdBranchUnitCode").val(cif.ccbdBranchUnitCode);

                $("#cifNumberParam").val(cif.cifNumber);
                $("#cifNameParam").val(cif.cifName);
                $("#accountOfficerParam").val(cif.accountOfficer);
                $("#ccbdBranchUnitCodeParam").val(cif.ccbdBranchUnitCode);
                $("#exporterCbCode").val(cif.exporterCbCode);
                $("#mainCifNumber").val(cif.mainCifNumber);
                $("#mainCifName").val(cif.mainCifName);
            }
            
            if (cbCode) {
                $("#exporterCbCode").select2("data", {id: cbCode});
            }
            
            // 12092016 EBP Extraction - Case 4 - END
            var changeUrl = '${g.createLink(controller: "exportBillsPurchase", action: "getExportAdvising")}';
            $.get(changeUrl, {exlcNumber: $("#exlcAdviseNumber").val()}, function(exportAdvising) {
                $("#adviseNumber").val($("#exlcAdviseNumber").val());
                $("#lcNumber").val(exportAdvising.lcNumber);
                $("#lcIssueDate").val(exportAdvising.lcIssueDate);
                $("#lcType").val(exportAdvising.lcType);
                $("#lcTenor").val(exportAdvising.lcTenor);
                $("#usanceTerm").val(exportAdvising.usanceTerm);
                $("#lcCurrency").val(exportAdvising.lcCurrency);
                $("#lcAmount").val(formatCurrency(exportAdvising.lcAmount));
                $("#lcExpiryDate").val(exportAdvising.lcExpiryDate);
                console.log(exportAdvising)

                $("#issuingBankCode").val(exportAdvising.issuingBank);
                $("#issuingBankName").val(exportAdvising.issuingBankName);
                $("#issuingBankAddress").val(exportAdvising.issuingBankAddress);

                $("#reimbursingBankCode").val(exportAdvising.reimbursingBank);
            })
        });

        $("input[name=withBcFlag]").click(onWithBcFlagChange);
        onWithBcFlagChange();

        $("#negotiationNumber").change(setEbcAmount);

        if ('${negotiationNumber}') {
            $("#currency").select2("disable");
            $("select[name=paymentMode]").attr("disabled", "disabled");
            $("input[name=paymentMode]").removeAttr("disabled");
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

        $("#amount").change(computeOutstandingBcAmount);
        computeOutstandingBcAmount();

        $("#paymentMode").change(onChangePaymentMode);
        onChangePaymentMode();
    });
</script>

<g:render template="../commons/popups/cif_search_main"/>
<g:javascript src="popups/cif_main_search_popup.js" />