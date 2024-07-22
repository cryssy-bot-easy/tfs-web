<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />




<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> e-TS Number </span></td>
		<td class="label_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> e-TS Date </span></td>
		<td><g:textField class="input_field" name="etsDate"readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:select from="${['909']}" class="select_dropdown" name="processingUnitCode"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> LC/Non-LC Currency </span></td>
		<td><g:textField class="input_field" name="nonLCCurrency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> LC/Non-LC Amount </span></td>
		<td><g:textField class="input_field" name="nonLCAmount" readonly="readonly"/></td>
	</tr>	
	<tr>
		<td valign="top"><span class="field_label"> O/S MD Balance </span></td>
		<td>
			<div class="grid_wrapper_apply_ap">
				<table id="grid_list_md_application"></table>
			</div>
		</td>
	</tr>
</table>

<g:render template="../layouts/buttons_for_grid_wrapper" />
