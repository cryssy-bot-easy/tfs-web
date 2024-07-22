<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
		1. In EBC Nego, Issuing Bank Name was blank after select Issuing Bank Code (Redmine# 4157)
		2. EBP Negotiation - E-TS Inquiry and Data Entry Inquiry and EBP Settlement Inquiry Screens (Redmine# 4158)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 02/14/2017 (tfs-web Rev# 7390)
		2. 02/21/2017 (tfs-web Rev# 7406)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Specific name/id was used in assigning of Issuing Bank Name value.
		2. Added a condition that validates if viewed in inquiry.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_lc_details_foreign_tab.gsp
--%>

<%-- 
(revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    [Date revised:] 03/16/2018
    Program [Revision:] add field commodity code and set auto suggest).
    PROJECT: WEB
    MEMBER TYPE  : WEB
    Project Name:  _setup_nonlc_details_foreign_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="setupLcDetails" />

	<%-- 
		revision)
		SCR/ER Number:
		SCR/ER Description: 4126 EBC Negotiation - Nego Advice Addressee and Collecting bank fields needed in the report
		[Revised by:] Robin C. Rafael
		[Date deployed:]
		Program [Revision] Details: 
			-added a dropdown Nego Advice Addressee Code
			-used the function setRMAdropdown for this field
			-added id for the textArea negoAdviseAddressee
			-added swiftAddress.change function to extract the name and address of the selected swiftcode

		extraction
		Member Type: Groovy Server Pages (GSP)
		Project: WEB
		Project Name: _setup_lc_details_foreign_tab.gsp
	--%>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> EXLC Advise Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="adviseNumber" id= "adviseNumber" value="${adviseNumber}" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Number <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField maxlength="21" class="input_field required" id="lcNumber" name="lcNumber" value="${lcNumber}" maxlength="16"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="lcIssueDate" value="${lcIssueDate}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Type <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <g:select noSelection="${['':'SELECT ONE...']}" id="lcType" name="lcType" from="${['REGULAR', 'STANDBY']}" value="${lcType}" class="select_dropdown required"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Tenor Term <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <g:select noSelection="${['':'SELECT ONE...']}" id="lcTenor" name="lcTenor" from="${['SIGHT', 'USANCE']}" value="${lcTenor}" class="select_dropdown"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> If Usance: Usance Term </span> </td>
		<td class="input_width">
            %{--<g:textArea class="textarea_long" name="usanceTerm"/> --}%
            <g:textField maxlength="255" name="usanceTerm" id="usanceTerm" value="${usanceTerm}" class="input_field" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Currency <span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="lcCurrency" id="lcCurrency" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Amount <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" id="lcAmount" name="lcAmount" value="${amount}" readonly="readonly"/> </td><%--TO MAKE FIELD PROTECTED -- MAX --%>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="lcExpiryDate" value="${lcExpiryDate}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Bank<span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="issuingBankCode" id="issuingBankCode" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Bank Name <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textArea maxlength="100" class="textarea_long required" id="issuingBankName" name="issuingBankName" value="${issuingBankName}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Bank Address <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textArea maxlength="350" class="textarea_long required" id="issuingBankAddress"name="issuingBankAddress" value="${issuingBankAddress}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Reimbursing Bank <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="reimbursingBankCode" id="reimbursingBankCode"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea maxlength="6500" class="textarea_long required" name="lcDescriptionOfGoods" value="${lcDescriptionOfGoods}" /> </td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Commodity Code<span class="asterisk">*</span> </span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
    </tr>
	<%-- test by robin 4126--%>
	<tr>
		<td class="label_width"> <span class="field_label">Nego Advice Addressee Code<span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="swiftAddress" id="swiftAddress" />
        </td>
	</tr>
	
	<tr>
		<td><span class="field_label">Nego Advice Addressee <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddressee" class="textarea_long required" id = "negoAdviceAddressee" value="${negoAdviceAddressee}" maxlength="100" readonly="readonly"/></td>
	</tr>

	<%-- test end 4126--%>
	<tr>
		<td><span class="field_label">Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddresseeAddress" class="textarea_long required" value="${negoAdviceAddresseeAddress}" maxlength="350"/></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Courier Bank <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="courierBank" id="courierBank" />
        </td>
	</tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveSetupLcDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelSetupLcDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    function setupLcType() {
        var lcType = $("#lcType").val();

        if (lcType == 'STANDBY') {
            $("#lcTenor").val("SIGHT");
            $("#lcTenor").attr("disabled", "disabled");
            $("#lcTenor").toggleClass("required", false);
        } else {
            $("#lcTenor").removeAttr("disabled");
            $("#lcTenor").val('${lcTenor}');
            $("#lcTenor").toggleClass("required", true);
        }

        setupUsanceTerm();
    }
   
    function setupEXLCType(){
	var adviseNumber = $("#adviseNumber").val()

       if(adviseNumber.isEmpty || adviseNumber == "" || adviseNumber == " " || adviseNumber == null){
    	  $("#lcType").attr("enable", "enable");
    	  $("#lcTenor").attr("enable", "enable");
    	  $("#usanceTerm").attr("enable", "enable");
    	  $("#lcAmount").attr("enable", "enable");
    	  $("#issuingBankCode").attr("enable", "enable");
    	  $("#reimbursingBankCode").attr("enable", "enable");
    	  $("#lcNumber").attr("enable", "enable");
    	  
           }
       else{
           $("#lcType").attr("disabled", "disabled");
           $("#lcTenor").attr("disabled", "disabled");
           $("#usanceTerm").attr("disabled", "disabled");
           $("#lcAmount").attr("disabled", "disabled");
           $("#issuingBankCode").select2("disable");
        // $("#reimbursingBankCode").select2("disable"); //comment by robin 4199
           $("#lcNumber").attr("disabled", "disabled");
           }

        }

    function setupUsanceTerm() {
        var lcTenor = $("#lcTenor").val();
        
        if (lcTenor == 'USANCE') {
            $("#usanceTerm").removeAttr("readonly");
        } else {
            $("#usanceTerm").val('');
            $("#usanceTerm").attr("readonly", "readonly");
        }
    }

    function validateSetupLcDetails() {
    	var error = 0;
    	$("#setupLcDetailsTabForm :input").each(function(){
            if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
               if ($(this).val() == "") {
                   error ++;
               }
            }
        });
        //validation check for cifNumber
    	if ($("#cifNumber").attr("class") != undefined && $("#cifNumber").attr("class") != null && $("#cifNumber").attr("class").indexOf("required") != -1) {
            if ($("#cifNumber").val() == "") {
                error ++;
            }
        }

        if ($("#lcTenor").val() == "USANCE" && $("#usanceTerm").val() == "") {
            error ++;
        }

        return error;
    }

    function validateDates() {
        var lcIssueDate = $("#lcIssueDate").val();
        var parts = lcIssueDate.split('/');
        var lcIssueDateActual = new Date(parseInt(parts[2], 10),     // year
                parseInt(parts[1], 10) - 1, // month, starts with 0
                parseInt(parts[0], 10));    // day

        var lcExpiryDate = $("#lcExpiryDate").val();
        var parts = lcExpiryDate.split('/');
        var lcExpiryDateActual = new Date(parseInt(parts[2], 10),     // year
                parseInt(parts[1], 10) - 1, // month, starts with 0
                parseInt(parts[0], 10));    // day

        if (lcIssueDateActual > lcExpiryDateActual) {
            return 1
        }

        return 0;
    }

    $(document).ready(function() {
    	var commodityCode = $('#commodityCode').val(),
        splittedCommodity;
        
        $("#lcCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${lcCurrency ?: currency}'});
        $("#issuingBankCode").setDepositoryBankDropdownWithCurrency($("#lcCurrency").val()).select2('data',{id: '${issuingBankCode}'});
        $("#reimbursingBankCode").setDepositoryBankDropdownWithCurrency($("#lcCurrency").val()).select2('data',{id: '${reimbursingBankCode ?: reimbursingBankCodeHidden}'}); <%--added by max  reimbursingBankCodeHidden for redmine 3678--%>
        $("#courierBank").setDepositoryBankDropdownWithCurrency($("#lcCurrency").val()).select2('data',{id: '${courierBank}'});
        <%-- test by robin 4126--%>
        $("#swiftAddress").setBankDropdown($("#lcCurrency").val()).select2('data',{id: '${swiftAddress}'});
        <%-- test end--%>
        $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: '${commodity}'});

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
<%--        $("#lcNumber").autoNumeric({aSep: "", mDec: 0, vMax: '9999999999999999.99'});--%>

        $("#lcType").change(setupLcType);
        setupLcType();

        $("#adviseNumber").change(setupEXLCType);
        setupEXLCType();

        $("#lcTenor").click(setupUsanceTerm);
        setupUsanceTerm();

        $("#issuingBankCode").change(function() {
            $("#issuingBankAddress").val($("#issuingBankCode").select2('data').address);
            $("textarea[name=issuingBankName]").val($("#issuingBankCode").select2('data').label);
        });

        //test by robin
        $("#swiftAddress").change(function() {
        	console.log($("#swiftAddress").select2('data'));
        	console.log("hi test2: " + $("#swiftAddress").select2('data').label);
        	$("#negoAdviceAddressee").val($("#swiftAddress").select2('data').label);
        	$("#negoAdviceAddresseeAddress").val($("#swiftAddress").select2('data').address);
        });

        //test end

        $("#saveSetupLcDetails").click(function() {
        	if(validateSetupLcDetails() > 0){
        		$("#alertMessage").text("Please fill in all the required fields.");
        		triggerAlert();
        	} else {
        		/*if($("#lcNumber").val().length < 16) {
	                triggerAlertMessage("LC Number cannot be less than 16 characters.");
	            } else {
	            	if (validateDates() > 0) {
	                    $("#alertMessage").text("Issue Date cannot be greater than Expiry Date.");
	                    triggerAlert();
	                } else {*/
	                $("#setupLcDetailsTabForm").submit();
	            	/*}
	            }*/
        	}
        });

        $("#cancelSetupLcDetails").click(function() {
        	/*$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#setupLcDetailsDiv"), $("#setupLcDetailsBg"));
            mLoadPopup($("#setupLcDetailsDiv"), $("#setupLcDetailsBg"));*/
        	location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
        });

        $("#lcNumber").keypress(function(e){
            var charCheck = true;
            if (e.charCode == 45){
                charCheck = false;
            }
            return charCheck
        });
    });
</script>