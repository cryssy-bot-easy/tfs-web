<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Invoice Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="invoiceNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationDate" readonly="readonly" value="${DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Seller Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="sellerName" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Buyer Name<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="buyerName" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negoNumber" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="negoCurrency" from="['PHP']" noSelection="['':'Select One...']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negoAmount" /> </td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />