<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="js-temp/validation_ap_monitoring_setup.js"/>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="processingUnitCode" value="${processingUnitCode}" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label"> Booking Date </span></td>
		<td><div><g:textField  class="datepicker_field" name="bookingDate" value="${bookingDate}"/></div></td>
	</tr>
	%{--<tr>--}%
		%{--<td class="label_width"><span class="field_label"> PN Number </span></td>--}%
		%{--<td class="input_width"><div><g:textField class="input_field"  name="pnNumber" value="${pnNumber}" readonly="readonly"/></div></td>--}%
	%{--</tr>--}%
	<tr>
		<td class="label_width"><span class="field_label"> Reference Number <span class="asterisk">*</span> </span></td>
		<td class="input_width"><g:textField class="input_field required" name="documentNumber" value="${documentNumber}" /></td>
	</tr>
</table><br />
<div class="title_label"> Payment Details </div>
<br /><table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> AP Currency<span class="asterisk">*</span> </span></td>
		<td class="input_width">
            %{--<g:select class="select_dropdown" from="${['PHP','USD','EUR']}" name="currency" value="${currency}" noSelection="['':'Select One']"/>--}%
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> AP Amount<span class="asterisk">*</span> </span></td>
		<td class="input_width"><g:textField class="input_field numericCurrency required" name="amount" value="${amount}" /></td>
	</tr>
	<tr>
		<td class="label_width vtop"><span class="field_label"> Nature of Transaction </span></td>
		<td colspan="2"><g:textArea class="input_field natureOfTransaction" name="natureOfTransaction" value="${natureOfTransaction}" /></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
$(document).ready(function() {
	$("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
});
</script>