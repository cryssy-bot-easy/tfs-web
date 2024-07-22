<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="setupLcDetails" />

<table class="tabs_forms_table">
	%{--<tr>--}%
		%{--<td class="label_width"> <span class="field_label"> EXLC Advise Number </span> </td>--}%
		%{--<td class="input_width"> <g:textField class="input_field" name="adviseNumber" value="${adviseNumber}" readonly="readonly"/> </td>--}%
	%{--</tr>--}%
	<tr>
		<td class="label_width"> <span class="field_label"> LC Number<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="lcNumber" value="${lcNumber}" maxlength="16"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Issue Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="lcIssueDate" value="${lcIssueDate}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Type<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <g:select noSelection="${['':'SELECT ONE...']}" name="lcType" from="${['REGULAR', 'STANDBY']}" value="${lcType}" class="select_dropdown required"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Tenor Term<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <g:select noSelection="${['':'SELECT ONE...']}" name="lcTenor" from="${['SIGHT', 'USANCE']}" value="${lcTenor}" class="select_dropdown"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> If Usance: Usance Term </span> </td>
		<td class="input_width">
            <g:textField name="usanceTerm" value="${usanceTerm}" class="input_field" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop required" name="lcCurrency" id="lcCurrency" />
        </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="lcAmount" value="${lcAmount}" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> LC Expiry Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="lcExpiryDate" value="${lcExpiryDate}" /> </td>
	</tr>
<%--	<tr>--%>
<%--		<td class="label_width"> <span class="field_label"> Issuing Local Bank<span class="asterisk">*</span> </span> </td>--%>
<%--		<td class="input_width">--%>
<%--            <input class="tags_cbcode select2_dropdown bigdrop required" name="issuingBankCode" id="issuingBankCode" />--%>
<%--        </td>--%>
<%--	</tr>--%>
	<tr>
		<td class="label_width"> <span class="field_label"> Issuing Local Bank's Address </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long_upper" name="issuingBankAddress" value="${issuingBankAddress}"/> </td>
	</tr>
	<%-- n/a in fsd --%>
	<%--
	<tr>
		<td class="label_width"> <span class="field_label"> Reimbursing Bank </span> </td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop" name="reimbursingBankCode" id="reimbursingBankCode" />
        </td>
	</tr>
	--%>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long_upper required" name="lcDescriptionOfGoods" value="${lcDescriptionOfGoods}" /> </td>
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

    function setupUsanceTerm() {
        var lcTenor = $("#lcTenor").val();

        if (lcTenor == 'USANCE') {
            $("#usanceTerm").removeAttr("readonly");
            $("#usanceTerm").val('${usanceTerm}');
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
        return error;
    }

    $(document).ready(function() {
        $("#lcCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${lcCurrency ?: currency}'});
        $("#issuingBankCode").setLocalBankDropdown($(this).attr("id")).select2('data',{id: '${issuingBankCode}'});
        $("#reimbursingBankCode").setDepositoryBankDropdownWithCurrency($("#lcCurrency").val()).select2('data',{id: '${reimbursingBankCode}'});
<%--        $("#lcNumber").autoNumeric({aSep: "", mDec: 0, vMax: '9999999999999999.99'});--%>

        $("#lcType").change(setupLcType);
        setupLcType();

        $("#lcTenor").click(setupUsanceTerm);
        setupUsanceTerm();

        $("#issuingBankCode").change(function() {
            $("#issuingBankAddress").val($("#issuingBankCode").select2('data').address);
        });

        $("#saveSetupLcDetails").click(function() {
        	if(validateSetupLcDetails() > 0){
        		$("#alertMessage").text("Please fill in all the required fields.");
        		triggerAlert();
        	} else {
        		/*if($("#lcNumber").val().length < 16) {
            		triggerAlertMessage("LC Number cannot be less than 16 characters.");
                } else {*/
        			$("#setupLcDetailsTabForm").submit();
	        	//}
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