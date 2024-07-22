<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="id" value="${id}" />
<g:hiddenField name="natureOfTransaction" value="${natureOfTransaction}" />
<g:hiddenField name="bookingDate" value="${bookingDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> e-TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="etsNumber" value="${serviceInstructionId}" /></td>
		<td class="label_width"><span class="field_label"> Document Number/ </span><br /><span class="field_label"> Reference Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" value="${documentNumber ?: setupApplicationReferenceNumber}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> e-TS Date </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="etsDate" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:select class="select_dropdown required" name="processingUnitCode" from="['909']" noSelection="['':'SELECT ONE']" value="${processingUnitCode ?: '909'}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Currency </span></td>
		<td><g:textField class="input_field" readonly="readonly" name="currency" value="${currency}" /></td>
		<td><span class="field_label"> AP Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" readonly="readonly" name="amount" value="${amount ?: originalAmount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> AP Outstanding Balance </span></td>
		<td><g:textField class="input_field_right numericCurrency" readonly="readonly" name="outstandingAmount" value="${outstandingAmount ?: apOutstandingBalance}"/></td>
	</tr>
</table>
<br/>

<g:render template="../layouts/buttons_for_grid_wrapper" />
