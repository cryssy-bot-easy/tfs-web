
<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="subType1" value="${subType1}" />
<g:hiddenField name="subType2" value="${subType2}" />
<br/>	
<script type="text/javascript">
	var serviceType='${serviceType}';
	var referenceType='${referenceType}';
	var documentType='${documentType}';
	var documentClass='${documentClass}';
	var subType1='${subType1}';
	var subType2='${subType2}';
	
	var etsExportAdvanceRefundUrl = '${g.createLink(controller:'etsExportAdvanceRefund', action: 'viewExportAdvanceRefundEts')}';
</script>

<g:javascript src="grids/export_advance_inquiry_jqgrid.js" />

<table class="body_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">CIF Name</span> </td>
		<td class="input_width"><g:textField name="cifName" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">Currency</span> </td>
		<td><g:select name="currency" class="select_dropdown" from="${[]}"  noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td><span class="field_field"> Document Number </span></td>
		<td><g:textField name="documentNumber" class="input_field" /></td>
		<td><span class="field_label">Amount <span class="right_indent">From:</span></span></td>
		<td><g:textField name="amountFrom" class="input_field" /></td>
	</tr>
	<tr>
		<td/>
		<td/>
		<td><span class="field_label right_indent">To:</span>
		<td><g:textField name="amountTo" class="input_field" /></td>
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
	<table id="grid_list_export_advance_inquiry"></table>
	<div id="grid_pager_export_advance_inquiry"></div>
</div>
