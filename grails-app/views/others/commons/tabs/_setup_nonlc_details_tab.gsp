<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="setupNonlcDetailsTab" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="tenor" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Tenor Term </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="tenorTerm" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Currency <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="currency" from="" disabled="true"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Draft Amount <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field" name="amount" readonly="readonly" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Due Date <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field" name="dueDate" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank <span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="collectingBank" from="" noSelection="['':'SWIFT']" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Collecting Bank's Address<span class="asterisk">*</span></span> </td>
		<td class="input_width"> <g:textField class="input_field_long" name="collectingBanksAddress" /> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label"> Description of Goods<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textArea class="textarea_long" name="descriptionOfGoods" /> </td>
	</tr>
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />