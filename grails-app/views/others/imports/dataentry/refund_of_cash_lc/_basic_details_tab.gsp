<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table>
	<tr>
		<td><span class="field_label">e-TS Number</span></td>
		<td><g:textField class="input_field" name="etsNumber" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly"/></td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />