<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />

<table class="tabs_forms_table">
    <tr>
        <td class="label_width"><span class="field_label">e-TS Number</span></td>
        <td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${etsNumber ?: serviceInstructionId}"/></td>
    </tr>
    <tr>
        <td><span class="field_label">e-TS Date</span></td>
        <td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
    </tr>
    <tr>
        <td class="label_width"><span class="field_label">Document Number</span></td>
        <td><g:textField name="documentNumber" class="input_field" value="${documentNumber}"/></td>
    </tr>
    <tr>
        <td><span class="field_label">LC / Non - LC Currency</span></td>
        <td><g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/></td>
    </tr>
    <tr>
        <td><span class="field_label">LC / Non - LC Amount</span></td>
        <td><g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${amount}"/></td>
    </tr>
    <tr>
        <td><span class="field_label">With 2% CWT?</span></td>
        <td><g:radioGroup name="cwtFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
            <span>${it.radio} ${it.label}&#160;&#160;</span>
        </g:radioGroup>
        </td>
    </tr>
</table>

<br /><br />

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
