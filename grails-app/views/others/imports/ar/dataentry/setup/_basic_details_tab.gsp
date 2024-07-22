<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Booking Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="bookingDate" class="datepicker_field required" value="${bookingDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Reference Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="documentNumber" value="${documentNumber}" class="input_field required" /></td>
	</tr>
	<tr>
		<td><span class="field_label">AR Currency <span class="asterisk">*</span></span></td>
		<td>
            %{--<g:select name="currency" value="${currency}" class="select_dropdown" from="${['PHP', 'USD', 'WON']}"/>--}%
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">AR Amount <span class="asterisk">*</span></span></td>
		<td><g:textField name="amount" value="${amount}" class="input_field_right numericCurrency required" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Nature of Transaction <span class="asterisk">*</span></span></td>
		<td><g:textArea name="natureOfTransaction" value="${natureOfTransaction}" class="input_field required" rows="3"/></td>
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
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});

        $("#saveConfirmBasicDetails").click(function() {
            if(validateARTab("#basicDetailsTabForm") > 0){
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