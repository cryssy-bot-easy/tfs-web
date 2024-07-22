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
	
	<%--Bug #3272 only tsd should see Document number  --%>
	<g:if test="${session['group']?.equalsIgnoreCase("TSD")}" >
	<tr>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" /></td>
	</tr>
	</g:if>
	<tr>
		<td class="label_width"><span class="field_label"> Export Advance Currency </span></td>
		<td class="input_width"><g:textField name="exportAdvanceCurrency" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Export Advance Proceeds</span></td>
		<td class="input_width"><g:textField name="exportAdvanceProceeds" class="input_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter CB Code</span></td>
		<td class="input_width"><g:textField name="exporterCbCode" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Exporter Name </span></td>
		<td class="input_width"><g:textField name="exporterName" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer CB Code </span></td>
		<td class="input_width"><g:textField name="importerCbCode" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Importer Name </span></td>
		<td class="input_width"><g:textField name="importerName" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Corres Bank </span></td>
		<td class="input_width"><g:textField name="corresBank" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT? <span class="asterisk"> * </span></span></td>
		<td class="input_width"><g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}"> ${it.radio} ${it.label} &#160 &#160</g:radioGroup> </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />