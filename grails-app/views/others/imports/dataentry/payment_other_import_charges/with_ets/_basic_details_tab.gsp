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
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC / Non - LC Currency</span></td>
		<td><g:textField name="lcNonLcCurrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">LC / Non - LC Amount</span></td>
		<td><g:textField name="lcNonLcAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">With 2% CWT?</span></td>
		<td>
			<g:radioGroup name="cwtFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}">
				<span>${it.radio} ${it.label}&#160;&#160;</span>
			</g:radioGroup>
		</td>
	</tr>
</table>

<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper"/>