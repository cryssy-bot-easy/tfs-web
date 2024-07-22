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

<g:javascript src="utilities/other_imports/commons/mt_details_utility.js"/>
<g:javascript src="utilities/commons/autocomplete_utility.js"/>
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Importer CB Code</span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="importerCBCode" id="importerCBCode" /></td>
		<td><span class="field_label">Beneficiary CB Code</span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="beneficiaryCbCode" id="beneficiaryCbCode" /></td>
		<g:hiddenField name="exporterCbCode" value="${exporterCbCode}" />
	</tr>
	<tr>
		<td><span class="field_label">Importer Name <span class="asterisk">*</span></span></td>
		<td><g:textField id="importerName" name="importerName" value="${importerName}" class="input_field required" maxlength="60"/></td>
		<td><span class="field_label">Beneficiary Name <span class="asterisk">*</span></span></td>
		<td><g:textField name="beneficiaryName" value="${beneficiaryName}" class="input_field required" maxlength="50"/></td>
	</tr>
	<tr>
		<td valign="top"><br/><span class="field_label">Importer Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="importerAddress" value="${importerAddress}" rows="5" class="textarea required" /></td>
		<td valign="top"><br/><span class="field_label">Beneficiary Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" rows="5" class="textarea required" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Currency<span class="asterisk">*</span></span></td>
		<td><g:textField name="importAdvanceCurrency" value="${currency}" class="input_field required" maxlength="3"/></td>
		<td><span class="field_label">Beneficiary Account Number<span class="asterisk">*</span></span></td>
		<td><g:textField name="beneficiaryAccountNumber" value="${beneficiaryAccountNumber}" class="input_field required" maxlength="60"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Amount<span class="asterisk">*</span></span></td>
		<td><g:textField name="amount" value="${amount}" class="input_field numericCurrency required"  /></td>
				<td><span class="field_label">Original Port</span>
		<td class="input_width"><input class="tags_country select2_dropdown bigdrop" name="originalPort" id="originalPort"/></td>
		<g:hiddenField name="originalPort_bspCode" value="${originalPort_bspCode ?: originalPort}" />
		<g:hiddenField name="countryCode" value="${countryCode ?: originalPort ? originalPort.toString().substring(originalPort.toString().length()-3,originalPort.toString().length()) : ''}"/>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank</span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="reimbursingBankCode" id="reimbursingBankCode" /></td>
	</tr>
	<tr>
		<td/>
		<td><g:textField name="reimbursingBankName" value="${reimbursingBankName}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Account Type</span></td>
		<td>
            <input type="radio" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU

		</td>
	</tr>
    <tr>
        <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        <input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
        <input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
        <td><span class="field_label small_margin_left">Account Number<span class="asterisk">*</span></span></td>
        <td><input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" /></td>

    </tr>
    <tr>
        <td><span class="field_label small_margin_left">GL Code<span class="asterisk">*</span></span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field required" readonly="readonly" /></td>
    </tr>
	<tr>
		<td><span class="field_label small_margin_left">Reimbursing Bank Currency</span></td>
		<td><g:textField id="reimbursingBankCurrency" name="reimbursingBankCurrency" value="${reimbursingBankCurrency}" class="input_field" readonly="readonly" /></td>
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
    var paymentStatusUrl = '${g.createLink(controller:'importCharges', action:'getPaymentStatus')}';

    $(document).ready(function() {
        $("#importerCBCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCBCode}'});
        $("#beneficiaryCbCode").setFirmLibDropdown($(this).attr("id")).select2('data',{id: '${beneficiaryCbCode}'});
        $("#originalPort").setCountryIsoDropdown($(this).attr("id")).select2('data',{id: '${originalPort}'});
        $("#reimbursingBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingBankCode}'});

        $("#reimbursingBankCode").val("");

        $("#originalPort").change(function(){
            $("#originalPort_bspCode").val($(this).val());
            $("#countryCode").val($(this).val().substring($(this).val().length-3,$(this).val().length));
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

    $("#importerCBCode").on("change", function(e) {
        $("#importerName").val($("#importerCBCode").select2('data').label);
    });

    $("#beneficiaryCbCode").on("change", function(e) {
        $("#beneficiaryName").val($("#beneficiaryCbCode").select2('data').label);
        $("#exporterCbCode").val($(this).val());
    });

    $("#reimbursingBankCode").on("change", function(e) {
    	var data = $("#reimbursingBankCode	").select2('data');
    	if(data != null){
            $("#glCode").val(data.glcode);
            $("#reimbursingBankCurrency").val(data.currency);
            $("#reimbursingBankName").val(data.label);
            $("#tempfcdu").val(data.fcduAccount);
            $("#temprbu").val(data.rbuAccount);
            $("#tempfcdugl").val(data.glcodefcdu);
            $("#temprbugl").val(data.glcoderbu);

            $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
            $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
            $("#depositoryAccountNumber").val('');
        }else{
            $("#glCode").val('');
            $("#reimbursingBankCurrency").val('');
            $("#reimbursingBankName").val('');
            $("#tempfcdu").val('');
            $("#temprbu").val('');
            $("#tempfcdugl").val('');
            $("#temprbugl").val('');
        }
    	if($("#temprbugl").val() && $("#tempfcdugl").val()){
        	$("#accountType[value=RBU]").attr('checked',true);
            $("#accountType[value=RBU]").click();
        }else {
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

    $("input[name='accountType']").on("click", function(e) {
        if($("input[name='accountType']:checked").val() == 'RBU') {
            $("#depositoryAccountNumber").val($("#temprbu").val());
            $("#glCode").val($("#temprbugl").val());
        } else {
            $("#depositoryAccountNumber").val($("#tempfcdu").val());
            $("#glCode").val($("#tempfcdugl").val());
        }
    });

</script>