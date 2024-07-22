<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tranCode" value="${tranCode ?: '184'}" />

<g:hiddenField name="tempfcdugl" value="${tempfcdugl}" />
<g:hiddenField name="temprbugl" value="${temprbugl}" />
<table class="tabs_form_table">
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="rebateDocumentNumber" class="input_field" value="${rebateDocumentNumber ?: documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Currency of Rebates<span class="asterisk">*</span></span></td>
		<td>
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of Rebates<span class="asterisk">*</span></span></td>
		<td><g:textField name="amount" class="input_field_right numericCurrency required" value="${amount}" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Correspondent Bank<span class="asterisk">*</span></span></td>
		<td>
            <input class="tags_cbcode select2_dropdown bigdrop required" name="corresBankCode" id="corresBankCode" />
        </td>
	</tr>
	<tr>
		<td/>
		<td><g:textArea name="correspondentBankName" class="textarea" value="${correspondentBankName}" readonly="readonly" rows="2"/></td>
	</tr>
    <tr>
        <td><span class="field_label small_margin_left">Account Type<span class="asterisk">*</span></span></td>
        <td>
            <input type="radio" disabled="disabled" class="required" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" disabled="disabled" class="required" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU

        </td>
    </tr>
    <tr>
        <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        <td><span class="field_label small_margin_left">Account Number<span class="asterisk">*</span></span></td>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" /></td>

    </tr>
    <tr>
        <td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
    </tr>
	<tr>
		<td><span class="field_label">Country Code<span class="asterisk">*</span></span></td>
		<td>
            <input class="tags_country select2_dropdown bigdrop required" name="countryCode" id="countryCode" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Beneficiary</span></td>
		<td><g:textField name="beneficiary" class="input_field" readonly="readonly" value="${beneficiary ?: 'UCPB'}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">TIN of Beneficiary</span></td>
		<td><g:textField name="beneficiaryTin" class="input_field" readonly="readonly" value="${beneficiaryTin ?: '000507736000'}"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Particulars</span></td>
		<td><g:textArea class="textarea_long" name="particulars" rows="10" value="${particulars}"/></td>
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
    	$("#rebateDocumentNumber").change(function() {
            if($("#rebateDocumentNumber").val()){
                $.post('${g.createLink(controller: "rebate", action: "getCifDetailsFromDocumentNumber")}', {documentNumber: $("#rebateDocumentNumber").val()}, function(data){
                	$("#cifNumber").val(data.cifNumber);
                	$("#cifNumberParam").val(data.cifNumber);
                	$("#cifName").val(data.cifName);
                	$("#cifNameParam").val(data.cifName);
                	$("#accountOfficer").val(data.accountOfficer);
                	$("#accountOfficerParam").val(data.accountOfficer);
                	$("#ccbdBranchUnitCode").val(data.ccbdBranchUnitCode);
                	$("#ccbdBranchUnitCodeParam").val(data.ccbdBranchUnitCode);
                	$("#longName").val(data.longName);
                	$("#longNameDisplay").text(data.longName);
                	$("#address1").val(data.address1);
                	$("#address1Display").text(data.address1);
                	$("#address2").val(data.address2);
                	$("#address2Display").text(data.address2);
                }).error(function(){
                    //$("#documentNumber").val("")
                    triggerAlertMessage("Not Found.");
                });
            }
         });
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        <%--$("#corresBankCode").setDepositoryBankDropdownWithCurrency($(this).attr("id")).select2('data',{id: '${corresBankCode}'});--%>
        <%--$("#corresBankCode").setDepositoryBankDropdownWithCurrency2($(this).attr("id")).select2('data',{id: '${corresBankCode}'});--%>
        $("#corresBankCode").setDepositoryBankDropdownWithCurrencyCorres($("#currency").val()).select2('data',{id: '${corresBankCode}'});
        $("#corresBankCode").val('${corresBankCode}');
        $("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});

        $("#corresBankCode").on("change", function(e) {
            if (e.target.value != "") {
                $("#correspondentBankName").val($("#corresBankCode").select2('data').label);
                $("#glCode").val($("#corresBankCode").select2('data').glcode);
                $("#tempfcdu").val($("#corresBankCode").select2('data').fcduAccount);
                $("#temprbu").val($("#corresBankCode").select2('data').rbuAccount);
                $("#tempfcdugl").val($("#corresBankCode").select2('data').glcodefcdu);
                $("#temprbugl").val($("#corresBankCode").select2('data').glcoderbu);

                $("input[name=accountType]").removeAttr("disabled");
            } else {
                $("#glCode").val("");
                $("#tempfcdu").val("");
                $("#temprbu").val("");
                $("#tempfcdugl").val("");
                $("#temprbugl").val("");

                $("#correspondentBankName").val("");
                $("#depositoryAccountNumber").val("");
                $("input[name=accountType]").removeAttr("checked");
                $("input[name=accountType]").attr("disabled", "disabled");
            }
            
            if($("#temprbugl").val() && $("#tempfcdugl").val()){
            	$("#accountType[value=RBU]").attr('checked',true);
                $("#accountType[value=RBU]").click();
            }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
    	        if(!$("#temprbugl").val()) {
    	            $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
    	            $("#accountType[value=FCDU]").attr('checked',true);
    	            $("#accountType[value=FCDU]").click();
    	        }
    	
    	        if(!$("#tempfcdugl").val()) {
    	            $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
    	            $("#accountType[value=RBU]").attr('checked',true);
    	            $("#accountType[value=RBU]").click();
    	        }
			}
        });

        if ($("#corresBankCode").val() != "") {
            $("input[name=accountType]").removeAttr("disabled");
        }

        $("input[name='accountType']").on("click", function(e) {
            if($("input[name='accountType']:checked").val() == 'RBU') {
                $("#depositoryAccountNumber").val($("#temprbu").val());
                $("#glCode").val($("#temprbugl").val());
            } else {
                $("#depositoryAccountNumber").val($("#tempfcdu").val());
                $("#glCode").val($("#tempfcdugl").val());
            }
        });

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
    });
</script>