<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="importerCBCode" value="${importerCBCode}"/>
<g:hiddenField name="exporterCbCode" value="${exporterCbCode}"/>
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${serviceInstructionId ?: etsNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Currency</span></td>
		<td>
            <g:textField name="refundCurrency" class="input_field" value="${currency}" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Import Advance Refund Amount</span></td>
		<td><g:textField name="amount" value="${amount}" class="input_field" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT</span></td>
		<td>
            <g:radioGroup name="cwtFlag" values="['Y','N']" labels="['Yes','No']" value="${cwtFlag == 'true' || cwtFlag == 'Y' ? 'Y' : 'N'}">
			<label>${it.radio}&#160;${it.label}</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Corres Bank</span></td>
		<td>
            <input class="tags_cbcode select2_dropdown bigdrop" name="corresBankCode" id="corresBankCode" />
<%--            <g:textField name="corresBankName" value="${corresBankName ?: reimbursingBankName}" class="input_field_long" readonly="readonly"/>--%>
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
            $("#corresBankName").val($("#corresBankCode").select2('data').label);
            $("#tempfcdu").val($("#corresBankCode").select2('data').fcduAccount);
            $("#temprbu").val($("#corresBankCode").select2('data').rbuAccount);
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