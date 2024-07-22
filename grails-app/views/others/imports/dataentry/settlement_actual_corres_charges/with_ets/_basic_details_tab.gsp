<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td  class="label_width"><span class="field_label">e-TS Number</span></td>
		<td  class="label_width"><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Currency</span></td>
		<td><g:textField name="currency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount</span></td>
		<td><g:textField name="amount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Issue Date</span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S Advance Corres Charges (in PHP)</span></td>
		<td><g:textField name="advanceCorressCharges" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank<span class="asterisk">*</span></span></td>
		<td><g:select from="" name="reimbursingBank" class="select_dropdown" noSelection="['':'Select One...']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Account Type<span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup values="${['RBU','FCDU']}" labels="${['RBU','FCDU']}" name="accountType"><label>${it.radio}${it.label}&#160;</label></g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank's Account Number<span class="asterisk">*</span></span></td>
		<td><g:select from="" name="reimbursingBankAccountNumber" class="select_dropdown" noSelection="['':'Select One...']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Remit Corres Charges?<span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup values="${['Y','N']}" labels="${['Yes','No']}" name="remitCorresCharges" value="N"><label>${it.radio}&#160;${it.label}&#160;&#160;&#160;</label></g:radioGroup>
		</td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />