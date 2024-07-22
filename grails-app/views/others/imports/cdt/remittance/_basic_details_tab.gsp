<script type="text/javascript">
	$(document).ready(function(){
			$("#viewReport").click(function(){
					alert('View Report Here...');
				});
		});
</script>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails"/>

<table>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Type Of Report</span></td>
		<td><g:select from="${['IPF','Final CDT','Advance CDT','Export Charges','IPF and Export Charges','Final and Advance CDT','All']}"
			name="reportType" class="select_dropdown" noSelection="['':'Select One']"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Transaction Code</span></td>
		<td><g:textField class="input_field" name="transactionCode" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Date of Remittance</span></td>
		<td><g:textField class="datepicker_field" name="remittanceDate"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Collection Period</span></td>
	</tr>
	<tr>
		<td><span class="float_right">From</span></td>
		<td><g:textField class="datepicker_field" name="collectionPeriodFrom"/></td>
	</tr>
	<tr>
		<td><span class="float_right">To</span></td>
		<td><g:textField class="datepicker_field" name="collectionPeriodTo"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Total Amount for Remittance</span></td>
		<td><g:textField class="input_field" name="remittanceAmount" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">BOC Account</span></td>
		<td><g:textField class="input_field" name="remittanceAmount" readonly="readonly"/></td>
		<td><g:submitToRemote class="input_button2" value="Debit CASA"/></td>
	</tr>
</table>
<br/>
<br/>
<g:submitToRemote class="input_button left_indent" id="viewReport" value="View"/>
<g:render template="../layouts/buttons_for_grid_wrapper" />