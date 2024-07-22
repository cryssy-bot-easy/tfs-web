<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tempfcdugl" value="${tempfcdugl}" />
<g:hiddenField name="temprbugl" value="${temprbugl}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode ?: '909'}"/>

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
<%--    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--%>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label">Process Date </span></td>
		<td><g:textField name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly"/></td>
	</tr>

	<tr>
		<td><span class="field_label">Issue Date</span></td>
		<td><g:textField name="issueDate" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly"/></td>
	</tr>

    <tr>
        <td><span class="field_label">Total Billing Currency<span class="asterisk">*</span></span></td>
        <td>
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
    </tr>

    <tr>
        <td><span class="field_label">Total Billing Amount<span class="asterisk">*</span></span></td>
        <td>
            <g:textField name="amount" class="input_field_right required numericCurrency" value="${amount}" />
            %{--<g:hiddenField name="netBillingAmountInPhp" value="${netBillingAmountInPhp}" />--}%
        </td>
    </tr>

    <tr>
        <td><span class="field_label">Settlement Currency<span class="asterisk">*</span></span></td>
        <td>
            <input class="tags_currency select2_dropdown bigdrop required" name="settlementCurrency" id="settlementCurrency" />
        </td>
    </tr>

    <tr>
        <td><span class="field_label">Reimbursement Bank<span class="asterisk">*</span></span></td>
        <td>
            <input class="tags_cbcode select2_dropdown bigdrop required" name="corresBankCode" id="corresBankCode" />
        </td>
    </tr>
    <tr>
        <td/>
        <td><g:textArea name="reimbursingBankName" class="textarea" value="${reimbursingBankName}" rows="2" readonly="readonly"/></td>
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
        <td><span class="field_label small_margin_left">Reimbursing Account Number<span class="asterisk">*</span></span></td>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" /></td>

    </tr>
    <tr>
        <td><span class="field_label small_margin_left">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
    </tr>

	<tr>
		<td><span class="field_label">Remit Corres Charges?<span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup values="${['Y','N']}" labels="${['Yes','No']}" class="required" name="remitCorresCharges" value="${remitCorresCharges ?: 'N'}"><label>${it.radio}&#160;${it.label}&#160;&#160;&#160;</label></g:radioGroup>
		</td>
	</tr>

	<g:hiddenField name="countryCode" class="input_field" readonly="readonly" value="${countryCode}" />

</table>
<br />

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script>
    var autoCompleteDepositoryBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteDepositoryBanks')}';

    $(document).ready(function() {
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#settlementCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${settlementCurrency}'});
		<%--$("#corresBankCode").setDepositoryBankDropdownWithCurrencyCorres($(this).attr("id")).select2('data',{id: '${corresBankCode}'});--%>
        $("#corresBankCode").setDepositoryBankDropdownWithCurrencyCorres($("#currency").val()).select2('data',{id: '${corresBankCode}'});
        $("#corresBankCode").val('${corresBankCode}');
        
        $("#corresBankCode").on("change", function(e) {
            if (e.target.value != "") {
                $("#reimbursingBankName").val($("#corresBankCode").select2('data').label);
                $("#glCode").val($("#corresBankCode").select2('data').glcode);
                $("#tempfcdu").val($("#corresBankCode").select2('data').fcduAccount);
                $("#temprbu").val($("#corresBankCode").select2('data').rbuAccount);
                $("#tempfcdugl").val($("#corresBankCode").select2('data').glcodefcdu);
                $("#temprbugl").val($("#corresBankCode").select2('data').glcoderbu);

                $("input[name=accountType]").removeAttr("disabled");
            } else {
                $("#reimbursingBankName").val("");
                $("#glCode").val("");
                $("#tempfcdu").val("");
                $("#temprbu").val("");
                $("#tempfcdugl").val("");
                $("#temprbugl").val("");

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

        showMt202Tab();
        $("input[type=radio][name=remitCorresCharges]").change(showMt202Tab);
    });

    function showMt202Tab(){
    	if($("input[type=radio][name=remitCorresCharges]:checked").val() == "Y") {
			$(".showMt202Tab").show();
		} else {
			$(".showMt202Tab").hide();
		}
	}
</script>