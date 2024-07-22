<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="js-temp/validation_ap_monitoring_application.js"/>

<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />


<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="id" value="${id}" />

<table class="">
	<tr>
		<td><span class="field_label"> Booking Date<span class="asterisk">*</span> </span></td>
		<td><g:textField class="datepicker_field required" name="bookingDate" value="${bookingDate}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Set-up AP Reference Number (PN Number) </span></td>
		<td><g:textField class="input_field length20" name="documentNumber" value="${documentNumber ?: settlementAccountNumber}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Currency </span></td>
		<td><g:textField class="input_field" readonly="readonly" name="currency" value="${currency}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Original AP Amount </span></td>
		<td><g:textField class="input_field numericCurrency" readonly="readonly" name="originalAmount" value="${originalAmount}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> O/S AP Payment</span></td>
		<td><g:textField class="input_field numericCurrency" name="apOutstandingBalance" value="${apOutstandingBalance}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Application Reference Number<span class="asterisk">*</span> </span></td>
		<td><g:textField class="input_field required" name="applicationReferenceNumber" value="${applicationReferenceNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Amount to be Applied (in AP Currency)<span class="asterisk">*</span> </span></td>
		<td><g:textField class="input_field numericCurrency required" name="amount" value="${amount}" /></td>
	</tr>
	%{--<tr>--}%
		%{--<td><span class="field_label"> PN Number </span></td>--}%
		%{--<td><div><g:textField class="input_field"  name="pnNumber" value="${pnNumber}" readonly="readonly"/></div></td>--}%
	%{--</tr>--}%
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />