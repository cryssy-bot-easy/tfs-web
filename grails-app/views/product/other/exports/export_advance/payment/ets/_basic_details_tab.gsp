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
		<td class="input_width"><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:select name="processingUnitCode" value="${processingUnitCode ?: '909'}" class="select_dropdown" from="${['909']}" noSelection="${["":"SELECT ONE..."]}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Export Advance Proceeds Currency<span class="asterisk">*</span><br/></span></td>
		<td class="input_width">
            <input class="tags_currency select2_dropdown required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Export Advance Proceeds <br/>Amount<span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField name="amount" value="${amount}" class="input_field_right numericCurrency required" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT?<span class="asterisk"> * </span></span></td>
		<td class="input_width">
            <g:radioGroup labels="['Yes','No']" values="['Y','N']" name="cwtFlag" value="${cwtFlag ?: 'N'}"><label>${it.radio} <g:message code="${it.label}" /></label> &#160;</g:radioGroup>
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
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';

    function onChangeCurrency() {
        $("#totalAmountDueLcCurrency").text($("#currency").val());
    }

    $(document).ready(function() {
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency ?: 'PHP'}'});
        $("#currency").change(onChangeCurrency);

        $("#saveConfirmBasicDetails").click(function() {
        	if(validateExportTab("#basicDetailsTabForm") > 0){
        		triggerAlertMessage(val_msg);
        	} else {
            	if($("#lcNumber").val().length > 16) {
            		triggerAlertMessage("LC Number cannot be more than 16 characters.");
                } else {
                	mCenterPopup($("#loading_div"), $("#loading_bg"));
                	mLoadPopup($("#loading_div"), $("#loading_bg"));
    	            $("#basicDetailsTabForm").submit();
                }
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