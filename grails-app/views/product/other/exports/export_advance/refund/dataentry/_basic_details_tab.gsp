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
		<td class="input_width"><g:textField name="etsNumber" value="${etsNumber ?: serviceInstructionId}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" class="input_field" value="${processingUnitCode ?: '909'}" readonly="readonly" /></td>
	</tr>
	
    <tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField name="documentNumber" value="${documentNumber}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Export Advance Currency </span></td>
		<td class="input_width"><g:textField name="currency" value="${currency}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Export Advance Proceeds</span></td>
		<td class="input_width"><g:textField name="amount" value="${amount}" class="input_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter CB Code</span></td>
		<td class="input_width"><g:textField name="exporterCbCode" value="${exporterCbCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter Name </span></td>
		<td class="input_width"><g:textField name="exporterName" value="${exporterName}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code </span></td>
		<td class="input_width"><g:textField name="importerCbCode" value="${importerCbCode}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer Name </span></td>
		<td class="input_width"><g:textField name="importerName" value="${importerName}" class="input_field" readonly="readonly" /></td>
	</tr>
    <tr>
        <td class="label_width"><span class="field_label">Corres Bank</span></td>
        <td>
            <input class="tags_cbcode select2_dropdown bigdrop" name="corresBankCode" id="corresBankCode" />
            <g:textField name="corresBankName" value="${corresBankName ?: reimbursingBankName}" class="input_field_long" readonly="readonly"/>
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label single_indent">Type Of Account</span></td>
        <td>
            %{--<g:textField name="accountType" class="input_field" readonly="readonly" value="${accountType}"/>--}%
            <input type="radio" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU

            <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
            <input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label">Country Code</span></td>
        <td>
            <input class="tags_country select2_dropdown bigdrop" name="countryCode" id="countryCode" />
        </td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label">Shipment Date</span></td>
        <td><g:textField name="shipmentDate" class="datepicker_field" value="${shipmentDate}"/></td>
    </tr>
    <tr>
        <td>&#160;</td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label">Credit Facility Code</span></td>
        <td>
            <g:radioGroup name="creditFacilityCode" values="['SHORTTERM','LONGTERM']" labels="['1-Short Term','2-Long Term']" value="${creditFacilityCode ?: 'SHORTTERM'}">
                <label>${it.radio}&#160;${it.label}&#160;</label>
            </g:radioGroup>
        </td>
    </tr>
    <tr>
        <td>&#160;</td>
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
        $("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
        $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode ?: reimbursingBankCode}'});

        $("#corresBankCode").on("change", function(e) {
            $("#glCode").val($("#corresBankCode").select2('data').glcode);
            $("#reimbursingBankCurrency").val($("#corresBankCode").select2('data').currency);
            $("#reimbursingBankName").val($("#corresBankCode").select2('data').label);
            $("#tempfcdu").val($("#corresBankCode").select2('data').fcduAccount);
            $("#temprbu").val($("#corresBankCode").select2('data').rbuAccount);
        });

        $("input[name='accountType']").on("click", function(e) {
            //alert($("input[name='accountType']:checked").val());
            if($("input[name='accountType']:checked").val() == 'RBU') {
                $("#depositoryAccountNumber").val($("#temprbu").val());
            } else {
                $("#depositoryAccountNumber").val($("#tempfcdu").val());
            }
        });

        $("#saveConfirmBasicDetails").click(function() {
        	mCenterPopup($("#loading_div"), $("#loading_bg"));
        	mLoadPopup($("#loading_div"), $("#loading_bg"));
        	$(".saveAction").show();
        	$(".cancelAction").hide();
			$("#basicDetailsTabForm").submit();
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });
    });
</script>