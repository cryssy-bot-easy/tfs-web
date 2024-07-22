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
		<td><span class="field_label">e-TS Date </span></td>
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
		<td><span class="field_label">If without CIF Number: Importer CB Code</span></td>
		<td><g:textField name="importerCbCode" class="input_field" readonly="readonly"/></td>
<%--		<td><g:select name="importerCbCode" class="select_dropdown" from="${[]}"/></td>--%>
	</tr>
	<tr>
		<td><span class="field_label">Importer Name</span></td>
		<td><g:textField name="importerName" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Currency</span></td>
		<td><g:textField name="importAdvanceRefundCurrency" class="input_field" readonly="readonly"/></td>
<%--		<td><g:select name="importAdvanceRefundCurrency" from="${['USD', 'PHP', 'EUR']}" class="select_dropdown" /></td>--%>
	</tr>
	<tr>
		<td><span class="field_label">Import Advance Amount</span></td>
		<td><g:textField name="importAdvanceRefundAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT? <span class="asterisk">*</span></span></td>
		<td>
			<g:radio name="cwt" value="1"/>Yes
			&#160;&#160;&#160;&#160;&#160;
			<g:radio name="cwt" value="2" checked="checked"/>No
		</td>
	</tr>
</table>

<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>