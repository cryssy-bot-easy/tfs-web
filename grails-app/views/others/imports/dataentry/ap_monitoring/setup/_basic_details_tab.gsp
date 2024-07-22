
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label"> Booking Date </span></td>
		<td><div><g:textField  class="datepicker_field" name="bookingDate" /></div></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> PN Number </span></td>
		<td class="input_width"><div><g:textField class="input_field"  name="pnNumber" readonly="readonly"/></div></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field length20"  name="documentNumber" /></td>
	</tr>
</table><br />
<div class="title_label"> Payment Details </div>
<br /><table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> AP Currency<span class="asterisk">*</span> </span></td>
		<td class="input_width"><g:select class="select_dropdown" from="${['PHP','USD','EUR']}" name="apCurrency" noSelection="['':'Select One']"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> AP Amount<span class="asterisk">*</span> </span></td>
		<td class="input_width"><g:textField class="input_field" name="apAmount" /></td>
	</tr>
	<tr>
		<td class="label_width vtop"><span class="field_label"> Nature of Transaction </span></td>
		<td colspan="2"><g:textArea class="input_field natureOfTransaction" name="natureOfTransaction" /></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />