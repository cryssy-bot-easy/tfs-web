<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_form_table">
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Currency of Rebates<span class="asterisk">*</span></span></td>
		<td><g:select from="${['USD','PHP','WON','YEN']}" name="currencyOfRebates" class="select_dropdown" noSelection="['':'Select One']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of Rebates<span class="asterisk">*</span></span></td>
		<td><g:textField name="amountOfRebates" class="input_field"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Type of Account<span class="asterisk">*</span></span></td>
		<td>
			<g:radioGroup values="${['FCDU','RBU']}" name="TypeOfAccount" labels="['FCDU','RDU']">
				<label>${it.radio}&#160; ${it.label}</label>
			</g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Correspondent Bank<span class="asterisk">*</span></span></td>
		<td><g:select from="${['Option 1','Option 2','Option 3','Option 4']}" name="correspondentBank" class="select_dropdown" noSelection="['':'Select One']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Country Code<span class="asterisk">*</span></span></td>
		<td><g:select from="${['Option 1','Option 2','Option 3','Option 4']}" name="countryCode" class="select_dropdown" noSelection="['':'Select One']"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Beneficiary</span></td>
		<td><g:textField name="beneficiary" class="input_field" readonly="readonly" value="UCPB"/></td>
	</tr>
	<tr>
		<td><span class="field_label">TIN of Beneficiary</span></td>
		<td><g:textField name="beneficiaryTIN" class="input_field" readonly="readonly" value="123-456-789"/></td>
	</tr>
	<tr>
		<td valign="top"><span class="field_label">Particulars</span></td>
		<td><g:textArea class="textarea_long" name="particulars" rows="10"/></td>
	</tr>
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />