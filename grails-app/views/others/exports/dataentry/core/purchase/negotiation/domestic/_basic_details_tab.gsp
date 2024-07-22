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
		<td class="label_width"> <span class="field_label"> Invoice Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="invoiceNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Date </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="negotiationDate" value="${DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negoNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsNumber" readonly="readonly"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> e-TS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly"/> </td>
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
		<td class="label_width"> <span class="field_label"> With Outstanding DBC?<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="outstandingDbcFlag" labels="['Yes','No']" values="['Y','N']" value="N">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> If Yes: Negotiation Number </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="negotiationNumber" from="" noSelection="['':'Select One...']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label small_margin_left"> DBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="dbcNegotiationAmount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="negotiationCurrency" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right" name="negotiationAmount" readonly="readonly" /> </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />