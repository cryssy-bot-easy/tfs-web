<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="expiryDate" value="${expiryDate}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label"> eTS Number </span></td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" value="${etsNumber}" readonly="readonly" /></td>
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>					
		<td><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<g:if test="${documentSubType1.equalsIgnoreCase('CASH')}">
			<td>
				<g:hiddenField name="facilityType" value="${facilityType}"/>
				<g:hiddenField name="facilityId" value="${facilityId}"/>
			</td>
			<td>&#160;</td>
			<td>&#160;</td>
			<td>&#160;</td>
		</g:if>
		<g:else>
				<td><span class="field_label"> Facility Type </span></td>					
				<td><g:textField class="input_field" name="facilityType" readonly="readonly" value="${facilityType}"/></td>
				<td><span class="field_label"> Facility ID </span></td>					
				<td><g:textField class="input_field" name="facilityId" readonly="readonly" value="${facilityId}"/></td>
		</g:else>
	</tr>
	<tr>
		<td><span class="field_label"> Main CIF Number </span></td>					
		<td><g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/></td>
		<td><span class="field_label"> Main CIF Name </span></td>					
		<td><g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>					
		<td><g:textField class="input_field" name="type" value="${type}" readonly="readonly" /></td>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField class="input_field" name="issueDate" value="${issueDate}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td><g:textField class="input_field" name="currency" value="${currency}" readonly="readonly" /></td>
		<td><span class="field_label"> FXLC Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly" /></td>
	</tr>
</table>
<br /><br />
<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>
