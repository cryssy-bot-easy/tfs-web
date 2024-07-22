<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetailsTabForm" />


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> e-TS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${serviceInstructionId}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> e-TS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:select name="processingUnitCode" from="${['909']}" class="select_dropdown" value="${processingUnitCode}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Import Advance Currency</span></td>
		<td><g:select name="currency" from="${['PHP']}" class="select_dropdown" noSelection="['':'SELECT ONE...']" value="${currency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Import Advance Amount</span></td>
		<td><g:textField class="input_field_right" name="amount" value="${amount}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> With 2% CWT?<span class="asterisk"> *</span> </span></td>
		<td><g:radioGroup labels="['Yes','No']" values="['Y','N']" name="cwtFlag" value="${cwtFlag ?: 'N'}"><label>${it.radio} <g:message code="${it.label}" /></label> &#160;</g:radioGroup></td>
	</tr>	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
