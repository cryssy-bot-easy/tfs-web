<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">Booking Date <span class="asterisk">*</span></span></td>
		<td><g:textField name="bookingDate" class="datepicker_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Reference Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="referenceNumber" class="input_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">AR Currency <span class="asterisk">*</span></span></td>
		<td><g:select name="arCurrency" class="select_dropdown" from="${['USD', 'PHP', 'WON']}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">AR Amount <span class="asterisk">*</span></span></td>
		<td><g:textField name="arAmount" class="input_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Nature of Transaction <span class="asterisk">*</span></span></td>
		<td><g:textArea name="natureOfTransaction" class="input_field" rows="3"/></td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>