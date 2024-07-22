<%--<g:javascript src="grids/payment_jqgrid.js"/>--%>
<g:javascript src="utilities/other_imports/ap_monitoring/display_casa.js"/>
<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> e-TS Number </span></td>
		<td class="input_width"><g:textField class="input_field length20" readonly="readonly" name="etsNumber" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> e-TS Date </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="etsDate" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Date </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="processingDate"	/></td>
	</tr>
</table>
<br />
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />