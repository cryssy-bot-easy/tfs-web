<g:javascript src="utilities/other_imports/commons/mt_details_utility.js"/>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Importer CB Code</span></td>
		<td><g:select name="importerCBCode" from="" noSelection="['':'Select One']" class="select_dropdown" /></td>
		<td><span class="field_label">Importer Name <span class="asterisk">*</span></span></td>
		<td><g:textField name="importerName" class="input_field" maxlength="60"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Beneficiary Name <span class="asterisk">*</span></span></td>
		<td><g:select name="beneficiaryName" from="" noSelection="['':'Select One']" class="select_dropdown" /></td>
		<td valign="top"><br/><span class="field_label">Beneficiary Address <span class="asterisk">*</span></span></td>
		<td rowspan="3"><g:textArea name="beneficiaryAddress" rows="5" class="textarea"></g:textArea></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Currency</span></td>
		<td><g:textField name="importAdvanceCurrency" class="input_field" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Amount</span></td>
		<td><g:textField name="importAdvanceAmount" class="input_field_right" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label">Reimbursing Bank</span></td>
		<td><g:select name="reimbursingBankDropdown" from="" noSelection="['':'Select...']" class="select_dropdown_medium" /> <g:textField name="reimbursingbankTextfield" class="input_field_medium" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Account Type</span></td>
		<td>
			<g:radioGroup name="accountType" labels="['R','F']" values="['R','F']">
	 		${it.radio}&#160;&#160;<g:message code="${it.label}" />
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Reimbursing Bank Currency</span></td>
		<td><g:textField name="reimbursingBankCurrency" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label small_margin_left">Account Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="accountNumber" class="input_field"/></td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />