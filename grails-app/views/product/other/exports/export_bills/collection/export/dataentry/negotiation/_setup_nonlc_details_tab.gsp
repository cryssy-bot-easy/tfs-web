<%-- 
	(revision)
	SCR/ER Number:
	SCR/ER Description:EBC Negotiation - Nego Advice Addressee and Collecting bank fields needed in the report 
		(Redmine# 4126)
	[Revised by:] Robin C. Rafael
	[Date deployed:]
	Program [Revision] Details: changed the function that set the Collecting Bank dropdown (setBankDropdown) 
		to setRmaBankDropdown.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_nonlc_details_tab.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
		1. EBP Negotiation - E-TS Inquiry and Data Entry Inquiry and EBP Settlement Inquiry Screens (Redmine# 4158)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 02/21/2017 (tfs-web Rev# 7406)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Added a condition that validates if viewed in inquiry.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_nonlc_details_foreign_tab.gsp
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
<g:hiddenField name="status" value="${statusAction}" />
<g:hiddenField name="form" value="setupNonLcDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor </span> </td>
		<td class="input_width"> 
            %{--<g:select name="nonLcTenor" from="${['DA', 'DP', 'OA']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${nonLcTenor}" />--}%
            <g:hiddenField name="nonLcTenor" value="${paymentMode}" />
            <g:textField name="nonLcTenorDisplay" value="${nonLcTenorDisplay}" class="input_field_long" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="nonLcTenorTerm" value="${nonLcTenorTerm}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Currency <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="draftCurrency" id="draftCurrency" readonly="readonly" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Amount <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="draftAmount" value="${amount}" readonly="readonly"/> </td>
		<%-- 	<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="draftAmount" value="${draftAmount}"/> </td>--%>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Due Date <span class="dueDateAsterisk asterisk"></span></span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="dueDate" value="${dueDate}" /> </td>
	</tr>
<%--	<tr>--%>
<%--		<td class="label_width"> <span class="field_label"> BKE?</span> </td>--%>
<%--		<td>--%>
<%--			<g:radioGroup name="bkeFlag" id="bkeFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${bkeFlag}">--%>
<%--				<label>${it.radio} ${it.label} &#160;&#160;</label>--%>
<%--			</g:radioGroup>--%>
<%--		</td>--%>
<%--	</tr>--%>

<%-- add field collecting bank with picklist and delete collecting bank's name field to match TSD and FSD
        MAX Lulab --%>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank <span class="asterisk">*</span></span> </td>
		<td id="collectingBankContainer" class="input_width">
            <input type="text" class="tags_cbcode select2_dropdown bigdrop select2-container-active select2-dropdown-open required" name="collectingBankCode" id="collectingBankCode" />
        </td>
	</tr>

 	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Name<span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textArea maxlength="100" class="textarea_long required" name="collectingBankName" value="${collectingBankName}"/> </td>
	</tr>
	<%--- end of collecting bank and collecting bank's Name  MAX Lulab --%>

	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Address <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textArea maxlength="350" class="textarea_long required" name="collectingBankAddress" value="${collectingBankAddress}" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea maxlength="6500" class="textarea_long required" name="nonLcDescriptionOfGoods" value="${nonLcDescriptionOfGoods}" /> </td>
	</tr>
	<tr>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span></span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" />
            <g:hiddenField name="commodityCode" value="${commodityCode}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Nego Advice Addressee <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddressee" class="textarea_long required" value="${negoAdviceAddressee}" maxlength="100"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddresseeAddress" class="textarea_long required" value="${negoAdviceAddresseeAddress}" maxlength="350"/></td>
	</tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveSetupNonLcDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelSetupNonLcDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>

    function setupNonLcTenor() {
        if ($("#nonLcTenor").val() in {OA:1, DP:1, DR:1}) {
            $("#nonLcTenorTerm").val("").parents("tr").hide();

            if ($("#nonLcTenor").val() == "OA") {
                $("#nonLcTenorDisplay").val("OPEN ACCOUNT");
            } else if ($("#nonLcTenor").val() == "DR") {
                $("#nonLcTenorDisplay").val("DIRECT REMITTANCE");
            } else {
            	$("#nonLcTenorDisplay").val("DOCUMENTS AGAINST PAYMENT");
            }
        } else {
            $("#nonLcTenorTerm").parents("tr").show();
            $("#nonLcTenorDisplay").val("DOCUMENTS AGAINST ACCEPTANCE");

        }

        setupCollectingBank();
    }

    function setupCollectingBank() {
            $("#collectingBankCode").select2("enable");
<%--            $("#collectingBankName").removeAttr("readonly");--%>
            $("#collectingBankAddress").removeAttr("readonly");
<%--        if ($("#nonLcTenor").val() == "DA" || $("#nonLcTenor").val() == "DP") {--%>
<%--        } else {--%>
<%--            $("#collectingBankCode").select2('data',{id: ''}).select2("disable");--%>
<%--            $("#collectingBankAddress").val("");--%>
<%--            $("#collectingBankAddress").attr("readonly", "readonly");--%>
<%--        }--%>
    }

    function onChangeNonLcTenor() {
		if($("#nonLcTenorDisplay").val() == "DOCUMENTS AGAINST PAYMENT"
			|| $("#nonLcTenorDisplay").val() == "DIRECT REMITTANCE") {
			$("#dueDate").removeClass("required");
			$(".dueDateAsterisk").text("");
		} else {
			$("#dueDate").addClass("required");
			$(".dueDateAsterisk").text("*");
		}
	}

    $(document).ready(function() {
    	var commodityCode = $('#commodityCode').val(),
            splittedCommodity;

        $("#draftCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${draftCurrency ?: currency}'});
        $("#collectingBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${collectingBankCode}'});
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

        //comment by robin 4130
        $("#collectingBankCode").change(function() {
        	console.log($("#collectingBankCode").select2('data'));
        	console.log("hi test label: " + $("#collectingBankCode").select2('data').label);
        	console.log("hi test address: " + $("#collectingBankCode").select2('data').address);
            if($(this).hasClass("select2_dropdown")){
	            $("#collectingBankName").val($("#collectingBankCode").select2('data').label);
	            $("#collectingBankAddress").val($("#collectingBankCode").select2('data').address);
            }
        });
        // 4130
        
        
        if ('${statusAction}'.toUpperCase() === "APPROVE") {
			$("#collectingBankCode").attr("disabled", "disabled");
        }

        $("#nonLcTenor").change(setupNonLcTenor);
        setupNonLcTenor();

        $("#saveSetupNonLcDetails").click(function() {
        	if(validateExportTab("#setupNonLcDetailsTabForm") > 0){
        		$("#alertMessage").text("Please fill in all the required fields.");
        		triggerAlert();
        	} else {
            	$("#setupNonLcDetailsTabForm").submit();
        	}
        });

        $("#cancelSetupNonLcDetails").click(function() {
        	/*$(".saveAction").hide();
        	$(".cancelAction").show();
            mCenterPopup($("#setupNonLcDetailsDiv"), $("#setupNonLcDetailsBg"));
            mLoadPopup($("#setupNonLcDetailsDiv"), $("#setupNonLcDetailsBg"));*/
        	location.href='${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
        });

        onChangeNonLcTenor();

        //For BKE Flag
        $("input[name=bkeFlag]:radio").change(function(){
            onChangeBkeFlag($(this).val());
        });
        //Separated event handler, firing change event on radio manually causes element to 
        //invoke change event for every element value. =_= 
		function onChangeBkeFlag(bkeFlag){
			   $("#collectingBankCode").removeClass('input_field');                                                       
			   $("#collectingBankCode").addClass('tags_cbcode select2_dropdown bigdrop');                                   
			      $("#collectingBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${collectingBankCode}'});
//            if(bkeFlag == "Y"){
//                $("#collectingBankCode").removeClass('input_field');
//            	$("#collectingBankCode").addClass('tags_cbcode select2_dropdown bigdrop');
//                $("#collectingBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${collectingBankCode}'});
//            }else{
//                $("#collectingBankCode").select2('destroy');
//                $("#collectingBankCode").removeClass('tags_cbcode select2_dropdown bigdrop');
//                $("#collectingBankCode").addClass('input_field');
//                $("#collectingBankCode").val('${collectingBankCode}');
//            }
		}
		//Fire onChange BKE Event Handler for Init
		onChangeBkeFlag('${bkeFlag}');
    });
</script>