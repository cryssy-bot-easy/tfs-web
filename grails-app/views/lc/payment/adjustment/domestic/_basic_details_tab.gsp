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
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Date</span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Number</span></td>
		<td><g:textField name="etsNumber" value="${etsNumber}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Type</span></td>
		<td><g:textField name="type" class="input_field" value="${type}" readonly="readonly"/></td>
		<td><span class="field_label">DMLC Amount</span></td>
		<td><g:textField name="amount" value="${amount}" class="input_field_right numericCurrency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Currency</span></td>
		<td><g:textField name="currency" value="${currency}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label">DMLC O/S Amount</span></td>
		<td><g:textField name="outstandingBalance" value="${outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Tenor</span></td>
		<td><g:textField name="tenor" class="input_field" value="${tenor}" readonly="readonly"/></td>
	</tr>
</table>
<br /><br />
<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>