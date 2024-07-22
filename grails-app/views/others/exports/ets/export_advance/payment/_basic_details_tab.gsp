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
		<td class="input_width"><g:select name="processingUnitCode" class="select_dropdown" from="${['909']}" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Export Advance Proceeds<span class="asterisk"> * </span><br/>Currency</span></td>
		<td class="input_width"><g:select name="exportAdvanceProceedsCurrency" class="select_dropdown" from="${[]}" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Export Advance Proceeds<span class="asterisk"> * </span><br/>Amount</span></td>
		<td class="input_width"><g:textField name="exportAdvanceProceedsAmount" class="input_field" /></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">With 2% CWT?<span class="asterisk"> * </span></span></td>
		<td class="input_width"><g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y','N']" value="${cwtFlag ?: 'N'}"> ${it.radio} ${it.label} &#160 &#160</g:radioGroup> </td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />