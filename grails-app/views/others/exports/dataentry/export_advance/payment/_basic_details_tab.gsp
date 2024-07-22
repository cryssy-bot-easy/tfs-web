<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">e-TS Date</span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Processing Unit Code</span></td>
		<td class="input_width"><g:textField name="processingUnitCode" class="input_field" readonly="readonly" value="909" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Export Advance Currency</span></td>
		<td class="input_width"><g:textField name="exportAdvanceCurrency" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Exporter Advance Proceeds</span></td>
		<td class="input_width"><g:textField name="exporterAdvanceProceeds" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Exporter CB Code</span></td>
		<td class="input_width"><g:textField name="exporterCbCode" class="input_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Exporter Name</span></td>
		<td class="input_width"><g:textField name="exporterName" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Importer CB Code</span></td>
		<td class="input_width"><g:textField name="importerCbCode" class="input_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Importer Name</span></td>
		<td class="input_width"><g:textField name="importerName" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Corres Bank</span></td>
		<td class="input_width"><g:select name="corresBank" class="select_dropdown" from="${['SWIFT']}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Type of Account</span></td>
		<td class="input_width"><g:radioGroup name="typeOfAccountFlag" labels="['RBU', 'FCDU']" values="['rbu','fcdu']"> ${it.radio} ${it.label} &#160; &#160; </g:radioGroup> </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Country Code</span></td>
		<td class="input_width"><g:select name="countryCode" class="select_dropdown" from="${[]}" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Shipment Date</span></td>
		<td class="input_width"><g:textField name="shipmentDate" class="datepicker_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Credit Facility Code</span></td>
		<td class="input_width"><g:radioGroup name="creditFacilityCodeFlag" labels="['1-Short Term','2-Long Term']" values="[1,2]" value="1">${it.radio} ${it.label} &#160; &#160; </g:radioGroup></td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />