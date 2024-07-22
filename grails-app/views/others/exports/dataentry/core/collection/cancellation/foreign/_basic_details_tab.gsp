<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label"> Exporter CB code (if </span> <br />
			<span class="field_label"> without CIF No.) </span>
		</td>
		<td class="input_width"> <g:textField class="input_field" name="exporterCbCode" readonly="readonly" /> </td>
	</tr>
		<tr>
		<td class="label_width"> <span class="field_label"> Exporter Name (Drawer) </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="exporterName" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Importer Name (Drawee) </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="importerName" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Payment Mode </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="paymentMode" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationCurrency" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="negotiationAmount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Correspondent Bank </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="correspondentBank" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Reason For Cancellation<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="reasonForCancellation" /> </td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />