<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="processingUnitCode" value="${processingUnitCode}"/>

<g:hiddenField name="referenceNumber" value="${referenceNumber}"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
    <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td><span class="field_label"> BG Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" value="${documentNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Cancellation Issue Date </span></td>
		<td class="input_width"><g:textField class="input_field" name="cancellationDate" value="${cancellationDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label"> Process Date </span></td>
		<td><g:textField class="input_field" name="processDate" value="${processDate ?: DateUtils.shortDateFormat(new Date())}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Outstanding LC Amount </span></td>
		<td><g:textField class="input_field numeric_fifteen numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly"/></td>
		<td><span class="field_label"> Bill of Lading Number </span></td>
		<td><g:textField class="input_field" name="blAirwayBillNumber" value="${blAirwayBillNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Shipment Currency </span></td>
		<td><g:textField class="input_field input_three" name="shipmentCurrency" value="${shipmentCurrency}" readonly="readonly" /></td>
	</tr>
	<tr>				
		<td><span class="field_label"> Shipment Number </span></td>
		<td><g:textField class="input_field" name="shipmentSequenceNumber" value="${shipmentSequenceNumber}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Shipment Amount </span></td>
        <td><g:textField class="input_field_right numeric_fifteen numericCurrency" name="shipmentAmount" value="${shipmentAmount}" readonly="readonly"/></td>
	</tr>
    <tr>
		<td><span class="field_label"> Issuance Booking Date </span></td>
		<td><g:textField class="input_field" name="indemnityIssueDate" value="${indemnityIssueDate}" readonly="readonly"/></td>
		<td><span class="field_label"> With 2% CWT? </span></td>
		<td>
		<%--<g:radioGroup name="cwtFlag" value="${cwtFlag}" labels="['Yes', 'No']" values="['Y','N']" >--%>
		<%--${it.radio}${it.label}&#160;&#160;--%>
		<%--</g:radioGroup>--%>
			<g:textField class="input_field" name="cwtFlag" value="${cwtFlag ?: 'N'}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Date of Release of Shipping<br />Documents to Client<br /> </span></td>
		<td><g:textField class="datepicker_field" name="dateOfReleaseOfShippingDocumentsToClient" value="${dateOfReleaseOfShippingDocumentsToClient}" /></td>
		<td><span class="field_label">Client Initiated?</span></td>
		<td>
			<g:radioGroup name="clientInitiatedFlag" id="clientInitiatedFlag" labels="['Yes', 'No']" values="['Y', 'N']" value="${clientInitiatedFlag ?: 'N'}">
				<label>${it.radio} ${it.label} &#160;&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
