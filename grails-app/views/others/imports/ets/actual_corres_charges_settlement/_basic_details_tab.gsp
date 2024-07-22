<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td  class="label_width"><span class="field_label">e-TS Number</span></td>
		<td  class="label_width"><g:textField name="etsNumber" value="${serviceInstructionId ?: etsNumber}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Currency</span></td>
		<td>
            %{--<g:textField name="currency" class="input_field" value="${currency}"/>--}%
            <input class="tags_currency select2_dropdown bigdrop" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Amount</span></td>
		<td><g:textField name="amount" class="input_field numericCurrency" value="${amount}"/></td>
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
		<td><g:textField name="outstandingCorresCharge" class="input_field numericCurrency" readonly="readonly" value="${outstandingCorresCharge}"/></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
    });
</script>