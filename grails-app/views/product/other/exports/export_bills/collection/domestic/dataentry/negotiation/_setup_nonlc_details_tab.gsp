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
            <g:select name="nonLcTenor" from="${['DA', 'DP', 'OA']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${nonLcTenor}" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="nonLcTenorTerm" value="${nonLcTenorTerm}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Currency <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="draftCurrency" id="draftCurrency" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Amount <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="draftAmount" value="${draftAmount}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Due Date <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="dueDate" value="${dueDate}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank <span class="asterisk">*</span></span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="collectingBankCode" id="collectingBankCode" />
        </td>
	</tr>
<%--	<tr>--%>
<%--		<td class="label_width"> <span class="field_label"> Collecting Bank's Name<span class="asterisk">*</span></span> </td>--%>
<%--		<td class="input_width"> <g:textField class="input_field_long required" name="collectingBankName" value="${collectingBankName}" /> </td>--%>
<%--	</tr>--%>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Address</span> </td>
		<td class="input_width"> <g:textField class="input_field_long" name="collectingBankAddress" value="${collectingBankAddress}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="nonLcDescriptionOfGoods" value="${nonLcDescriptionOfGoods}" /> </td>
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
        if ($("#nonLcTenor").val() == "OA" || $("#nonLcTenor").val() == "DA") {
            $("#nonLcTenorTerm").removeAttr("readonly");
        } else {
            $("#nonLcTenorTerm").val("");
            $("#nonLcTenorTerm").attr("readonly", "readonly");
        }

        setupCollectingBank();
    }

    function setupCollectingBank() {
        if ($("#nonLcTenor").val() == "DA" || $("#nonLcTenor").val() == "DP") {
            $("#collectingBankCode").select2("enable");
            $("#collectingBankName").removeAttr("readonly");
            $("#collectingBankAddress").removeAttr("readonly");
        } else {
            $("#collectingBankCode").select2('data',{id: ''}).select2("disable");
            $("#collectingBankName").val("");
            $("#collectingBankAddress").val("");
            $("#collectingBankName").attr("readonly", "readonly");
            $("#collectingBankAddress").attr("readonly", "readonly");
        }
    }

    $(document).ready(function() {
        $("#draftCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${draftCurrency ?: currency}'});
        $("#collectingBankCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${collectingBankCode}'});

        $("#collectingBankCode").change(function() {
            $("#collectingBankName").val($("#collectingBankCode").select2('data').label);
            $("#collectingBankAddress").val($("#collectingBankCode").select2('data').address);
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
    });
</script>