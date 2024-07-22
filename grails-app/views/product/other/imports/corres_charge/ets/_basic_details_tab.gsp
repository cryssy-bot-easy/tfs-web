<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
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
		<td  class="label_width"><span class="field_label">e-TS Number</span></td>
		<td  class="input_width"><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="etsDate" class="input_field required" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Billing Currency <span class="asterisk">*</span></span></td>
		<td>
            %{--<g:textField name="currency" class="input_field" value="${currency ?: 'PHP'}" readonly="readonly"/>--}%
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Billing Amount <span class="asterisk">*</span></span></td>
		<td>
            <g:textField name="amount" class="input_field_right numericCurrency required" value="${amount}"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Issue Date</span></td>
		<td><g:textField name="issueDate" class="datepicker_field" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S Advance Corres Charges (in PHP)</span></td>
		<td><g:textField name="outstandingCorresCharge" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingCorresCharge}"/></td>
	</tr>

    <tr>
        <td><span class="field_label">Settlement Currency <span class="asterisk">*</span></span></td>
        <td>
            %{--<g:textField name="currency" class="input_field" value="${currency ?: 'PHP'}" readonly="readonly"/>--}%
            <input class="tags_currency select2_dropdown bigdrop required" name="settlementCurrency" id="settlementCurrency" />
        </td>
    </tr>
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
    $(document).ready(function() {
        $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
        $("#settlementCurrency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${settlementCurrency}'});

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