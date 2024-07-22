<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="">
	<tr>
		<td><span class="field_label"> Booking Date<span class="asterisk">*</span> </span></td>
		<td><g:textField class="datepicker_field" name="bookingDate" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Set-up AP Reference Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly" name="setupAPReferenceNumber" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Currency </span></td>
		<td><g:textField class="input_field" readonly="readonly" name="apCurrency" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Original AP Amount </span></td>
		<td><g:textField class="input_field" readonly="readonly" name="originalApAmount" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> O/S AP Payment</span></td>
		<td><g:textField class="input_field" name="osApPayment" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Application Reference Number<span class="asterisk">*</span> </span></td>
		<td><g:textField class="input_field" name="applicationReferenceNumber" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Amount to be Applied (in AP Currency)<span class="asterisk">*</span> </span></td>
		<td><g:textField class="input_field" name="appliedAPAmount" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> PN Number </span></td>
		<td><div><g:textField class="input_field"  name="pnNumber" readonly="readonly"/></div></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
