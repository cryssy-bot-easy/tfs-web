<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="accountType" value="${accountType}"/>
<g:hiddenField name="reimbursingBankCode" value="${reimbursingBankCode}" />
<g:hiddenField name="reimbursingBankName" value="${reimbursingBankName}" />
<g:hiddenField name="exporterCbCode" value="${exporterCbCode}"/>

    <table class="tabs_forms_table">
        <tr>
            <td class="label_width"><span class="field_label">e-TS Number</span></td>
            <td><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${serviceInstructionId ?: etsNumber}" /></td>
        </tr>
        <tr>
            <td><span class="field_label">e-TS Date </span></td>
            <td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
        </tr>
        <tr>
            <td><span class="field_label">Document Number</span></td>
            <td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
        </tr>
        <tr>
            <td><span class="field_label">Processing Unit Code</span></td>
            <td><g:select name="processingUnitCode" from="${['909']}" class="select_dropdown" value="${processingUnitCode ?: '909'}" noSelection="${['':'SELECT ONE...']}"/></td>
        </tr>
        <tr>
            <td><span class="field_label">If without CIF Number: Importer CB Code</span></td>
            <td>
                <g:textField name="importerCBCode" class="input_field" readonly="readonly" value="${importerCBCode}"/>
            </td>
            <%--		<td><g:select name="importerCbCode" class="select_dropdown" from="${[]}"/></td>--%>
        </tr>
        <tr>
            <td><span class="field_label">Importer Name</span></td>
            <td>
                <g:textField name="importerName" class="input_field" readonly="readonly" value="${importerName}" maxlength="60"/>
            </td>
        </tr>
        <tr>
            <td><span class="field_label">Import Advance Currency</span></td>
            <td>
                <g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/>
                %{--<input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />--}%
            </td>
            <%--		<td><g:select name="importAdvanceRefundCurrency" from="${['USD', 'PHP', 'EUR']}" class="select_dropdown" /></td>--%>
        </tr>
        <tr>
            <td><span class="field_label">Import Advance Amount</span></td>
            <td>
                <g:textField name="amount" class="input_field" readonly="readonly" value="${amount}"/>
            </td>
        </tr>
        <tr>
            <td><span class="field_label">With 2% CWT? <span class="asterisk">*</span></span></td>
            <td>
                <g:radioGroup labels="['Yes','No']" values="['Y','N']" name="cwtFlagDisplay" value="${cwtFlag == 'Y' || cwtFlag == true ? 'Y' : 'N'}" disabled="disabled"><label>${it.radio} <g:message code="${it.label}" /></label> &#160;</g:radioGroup>
                <g:hiddenField name="cwtFlag" value="${cwtFlag ?: 'N'}" />
            </td>
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

		var amount = parseFloat($("#amount").val().replace(/,/g, ""));
		$("#amount").val(formatCurrency(amount));
        
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