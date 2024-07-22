<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />

<g:hiddenField name="currency" value="${currency}" />

<table>
	<tr>
		<td><span class="field_label">e-TS Number</span></td>
		<td><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId ?: etsNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	%{--<tr>--}%
		%{--<td><span class="field_label">Processing Unit Code</span></td>--}%
		%{--<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}"/></td>--}%
	%{--</tr>--}%
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
</table>

<g:if test="${referenceType.equals("ETS")}">
    <table class="buttons_for_grid_wrapper saveButtonsContainer">
        <tr>
            <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
        </tr>
        <tr>
            <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
        </tr>
    </table>
</g:if>

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