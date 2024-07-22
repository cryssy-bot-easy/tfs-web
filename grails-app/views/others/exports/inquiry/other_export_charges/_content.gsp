
<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="grids/other_export_charges_inquiry_jqgrid.js" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="subType1" value="${subType1}" />
<g:hiddenField name="subType1" value="${subType2}" />
<br/>
<table class="form_table_inquiry">
	<tr>
		<td class="label_width"><span class="field_label">CIF Name</span> </td>
		<td class="input_width"><g:textField name="cifName" class="input_field" /></td>
		<td><span class="field_label">Negotiation Date <span class="right_indent">From:</span></span></td>
		<td><g:textField name="negotiationDateFrom" class="datepicker_field" /></td>
	</tr>
	<tr>
		<td><span class="field_field"> Importer's Name </span></td>
		<td><g:textField name="documentNumber" class="input_field" /></td>
		<td><span class="field_label right_indent">To: </span>
		<td><g:textField name="negotiationDateTo" class="datepicker_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Exporter's Name</span></td>
		<td><g:textField name="exporterName" class="input_field" maxlength="60"/></td>
		<td><span class="field_label">Settlement Date <span class="right_indent">From: </span></span>
		<td><g:textField name="settlementDateFrom" class="datepicker_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Transaction</span></td>
		<td><g:select name="transaction" class="select_dropdown" from="${['Domestic Bills for Collection','Domestic Bills for Purchase','Export Bills for Collection', 'Export Bills for Purchase'] }" noSelection="['':'Select One...']" /></td>
		<td><span class="field_label right_indent">To: </span>
		<td><g:textField name="settlementDateTo" class="datepicker_field" /></td>
	</tr>
</table>
<table class="buttons_for_grid_wrapper">
	<tr>
		<td><input type="button" id="btnSearch" class="input_button" value="Search" /></td>
	</tr>
	<tr>
		<td><input type="button" id="btnReset" class="input_button_negative" value="Reset" /></td>
	</tr>
</table>
<br/>
<div class="grid_wrapper clear-float">
	<table id="grid_list_other_export_charges_inquiry"></table>
	<div id="grid_pager_other_export_charges_inquiry"></div>
</div>