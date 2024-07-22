<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />



<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">MD Application Booking Date</span></td>
		<td><g:textField name="mdApplicationBookingDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Currency</span></td>
		<td><g:textField name="mdCurrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Balance</span></td>
		<td><g:textField name="mbBalance" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of MD To Apply</span></td>
		<td><g:textField name="amountOfMdToApply" class="input_field"/></td>
	</tr>
	
	
	
	<tr>
		<td><span class="field_label">Mode Of Refund</span></td>
		<td><g:select name="modeOfRefundMd" from="${['Credit CASA','Issuance to MC']}" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label">If Credit CASA,Account Number</span></td>
		<td><g:select name="casaAccountNumber" from="" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label">Account Name</span></td>
		<td><g:textField name="casaAccountName" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper"/>

