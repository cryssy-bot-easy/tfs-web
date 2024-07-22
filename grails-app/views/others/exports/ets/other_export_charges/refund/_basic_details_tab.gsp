<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" class="input_field" value="909" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code </span></td>
		<td class="input_width"><g:textField name="importerCbCode" class="input_field"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Client Name </span></td>
		<td class="input_width"><g:textField name="clientName" class="input_field" readonly="readonly" /></td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />