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
		<td class="label_width"> <span class="field_label"> Main CIF Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> DBP Details </span> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="dbpNegotiationCurrency" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBP Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="dbpNegotiationAmount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Proceeds Amount (in Negotiation Currency)<span class="asterisk"> * </span> </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="proceedsAmount" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Amount Due </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="amountDue" readonly="readonly" /> </td>
	</tr>
</table>
<br />
<span class="tab_titles"> Bills Purchased Loan to be Settled </span>
<br />
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> PN Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="pnNumber" readonly="readonly"/> </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />