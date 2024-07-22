<%-- 
	(revision)
	SCR/ER Number:
	SCR/ER Description:EBC Negotiation updated 4130 requirement: made collecting bank name and address editable
		(Redmine# 4126)
	[Revised by:] Robin C. Rafael
	[Date deployed:]
	Program [Revision] Details: 
		- removed the comment on Collecting Bank field (id = collectingBankCode) to enable it again
		-removed readonly attribute for collecting bank name and address
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_nonlc_details_tab.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description: Tab validation (Redmine# 4196)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 04/03/2017 (tfs-web Rev# 7433)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: Added 'data-orig' attribute in every input field.
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _setup_nonlc_details_foreign_tab.gsp
--%>

<%-- 
(revision)
    (revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    [Revised date:] 03/20/2018
    Program [Revision:] add new Fields Commodity Code.
    PROJECT: WEB
    MEMBER TYPE  : WEB
    Project Name: _setup_lc_details_foreign_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="setupNonLcDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor </span> </td>
		<td class="input_width"> 
            %{--<g:select name="nonLcTenor" from="${['DA', 'DP', 'OA']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${nonLcTenor}" />--}%
            <g:hiddenField name="nonLcTenor" value="${paymentMode}" />
            <g:textField name="nonLcTenorDisplay" value="${nonLcTenorDisplay}" data-orig="${nonLcTenorDisplay}" class="input_field_long" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="nonLcTenorTerm" value="${nonLcTenorTerm}" data-orig="${nonLcTenorTerm}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Currency <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required currDd" name="draftCurrency" id="draftCurrency" data-orig="${draftCurrency}" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Amount <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="draftAmount" value="${draftAmount}" data-orig="${draftAmount}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Due Date <g:if test="${paymentMode in ['DA', 'OA']}"><span class="asterisk">*</span></g:if></span> </td>
		<td class="input_width"> <g:textField class="datepicker_field ${paymentMode in ['DA', 'OA'] ? 'required' : ''}" name="dueDate" value="${dueDate}" data-orig="${dueDate}" /> </td>
	</tr>
<%--	<tr>--%>
<%--		<td class="label_width"> <span class="field_label"> BKE?</span> </td>--%>
<%--		<td>--%>
<%--			<g:radioGroup name="bkeFlag" id="bkeFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${bkeFlag}">--%>
<%--				<label>${it.radio} ${it.label} &#160;&#160;</label>--%>
<%--			</g:radioGroup>--%>
<%--		</td>--%>
<%--	</tr>--%>

	<%-- ADDED by HENRY --%>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required bankDd" name="collectingBankCode" id="collectingBankCode" value="${collectingBankCode}" data-orig="${collectingBankCode}"/>
        </td>
	</tr>
	<tr>
	<%-- ADDED by HENRY END--%>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Name</span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="collectingBankName" value="${collectingBankName}" data-orig="${collectingBankName}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Address</span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="collectingBankAddress" value="${collectingBankAddress}" data-orig="${collectingBankAddress}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long required" name="nonLcDescriptionOfGoods" value="${nonLcDescriptionOfGoods}" data-orig="${nonLcDescriptionOfGoods}" /> </td>
	</tr>
    <tr>
        <td class="label_width"> <span class="field_label"> Commodity Code <span class="asterisk">*</span> </span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown required" name="commodity" id="commodity" data-orig="${commodity}"/>
            <g:hiddenField name="commodityCode" value="${commodityCode}" id="commodityCode" data-orig="${commodityCode}"/>
        </td>
    </tr>
	<tr>
		<td><span class="field_label">Nego Advice Addressee <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddressee" class="textarea_long required" value="${negoAdviceAddressee}" data-orig="${negoAdviceAddressee}" maxlength="100"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="negoAdviceAddresseeAddress" class="textarea_long required" value="${negoAdviceAddresseeAddress}" data-orig="${negoAdviceAddresseeAddress}" maxlength="350"/></td>
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
            $("#collectingBankName").removeAttr("readonly");
            $("#collectingBankAddress").removeAttr("readonly");
<%--        if ($("#nonLcTenor").val() == "DA" || $("#nonLcTenor").val() == "DP") {--%>
<%--        } else {--%>
<%--            $("#collectingBankCode").select2('data',{id: ''}).select2("disable");--%>
<%--            $("#collectingBankAddress").val("");--%>
<%--            $("#collectingBankAddress").attr("readonly", "readonly");--%>
<%--        }--%>
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
            $('#commodityCode').val(commodityCode.toString().trim());
            $.get(autoCompleteCommodityCodeUrl, {starts_with: commodityCode.toString().trim()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $("#commodity").setCommodityCodeDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
                }
            });
        }

        $("#collectingBankCode").change(function() {
            if($(this).hasClass("select2_dropdown")){
	            $("#collectingBankName").val($("#collectingBankCode").select2('data').label);
	            $("#collectingBankAddress").val($("#collectingBankCode").select2('data').address);
            }
        });

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

        //For BKE Flag
        $("input[name=bkeFlag]:radio").change(function(){
            onChangeBkeFlag($(this).val());
        });
        //Separated event handler, firing change event on radio manually causes element to 
        //invoke change event for every element value. =_= 
		
    });
</script>