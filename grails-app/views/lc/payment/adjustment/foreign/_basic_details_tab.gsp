<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<%@page import="net.ipc.utils.DateUtils" %>
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label">eTS Number</span> </td>
		<td class="input_width"> <g:textField name="etsNumber" class="input_field" readonly="readonly" value="${etsNumber}"/> </td>
		<td class="label_width"> <span class="field_label"> eTS Date </span> </td>
		<td> <g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td><g:textField name="currency" class="input_field currency" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label"> FXLC Amount </span></td>
		<td><g:textField name="amount" value="${amount ?: outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td class="column_width"> <g:textField name="documentNumber" value="${documentNumber}" class="input_field textFormat-16" readonly="readonly" /> </td>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>
		<td><g:textField name="type" class="input_field type" value="${type}" readonly="readonly" /></td>
		<td><span class="field_label"> FXLC Tenor </span></td>
		<td><g:textField name="tenor" class="input_field" readonly="readonly" value="${tenor}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> With 2% CWT? </span></td>
		<td>
            <%--<g:textField name="cwtFlag" class="input_field" readonly="readonly" />--%>
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
        </td>
		<td><span class="field_label"> FXLC O/S Amount </span></td>		
		<td><g:textField name="outstandingBalance" value="${outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly" /></td>
	</tr>
	<tr>
		<td> <span class="field_label"> Processing Unit Code </span> </td>
		<td> <g:textField name="processingUnitCode" value="${processingUnitCode}" class="input_field unitCode" readonly="readonly" /> </td>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
	</tr>
</table>
<br/><br/>
<%--<g:render template="/layouts/buttons_for_grid_wrapper" />--%>