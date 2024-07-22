<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />
<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${etsNumber}"/></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>					
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td class="label_width"><span class="field_label"> Document Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Type </span></td>					
		<td class="input_width"><g:textField class="input_field" name="type" value="${type}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label"> Tenor </span></td>					
		<td class="input_width"><g:textField class="input_field" name="tenor" readonly="readonly" value="${tenor}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> DMLC Currency </span></td>
		<td class="input_width"><g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/></td>
		<td class="label_width"><span class="field_label"> DMLC Amount </span></td>
		<td class="input_width"><g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/></td>
	</tr>
	<g:if test="${!serviceType?.equalsIgnoreCase('Opening') }">
		<tr>
			<td class="label_width"><span class="field_label"> DMLC O/S Amount </span></td>
			<td class="input_width"><g:textField class="input_field_right numericCurrency" name="outstandingBalance" readonly="readonly" value="${outstandingBalance ?: amount}"/></td>
		</tr>
	</g:if>
	<tr>
		<td class="label_width"><span class="field_label"> With 2% CWT? </span></td>
		<td class="input_width">
			<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
		</td>
	</tr>
</table>

<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>