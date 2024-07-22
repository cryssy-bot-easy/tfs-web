<%--<g:javascript src="utilities/ets/indemnity_issuance/basic_details_utility.js" />--%>
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
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
		<td class="label_width"><span class="field_label"> eTS Date </span></td>
		<td class="input_width"><g:textField class="input_field " readonly="readonly" name="etsDate" value="${etsDate}"/></td>
		<td class="label_width"><span class="field_label"> Processing Unit Code </span></td>
		<td><g:textField class="input_field length3" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> eTS Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly" name="etsNumber" value="${etsNumber}"/></td>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field length20" readonly="readonly"  name="documentNumber" value="${lcNumber}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Indemnity Type</span></td>
		<td>
            <%--<g:textField name="indemnityType" class="input_field" readonly="readonly" value="${indemnityType}" />--%>
            <span class="input_span" id="indemnityTypeSpan">${indemnityType?.equalsIgnoreCase("BG") ? "BANK GUARANTEE" : indemnityType?.equalsIgnoreCase("BE") ? "BANK ENDORSEMENT" : ""}</span>
            <g:hiddenField name="indemnityType" class="input_field" value="${indemnityType}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> Original LC Amount </span></td>
		<td><g:textField class="input_field amountFormat numericCurrency" readonly="readonly" name="originalAmount" value="${originalAmount}" /></td>
		<td><span class="field_label"> Outstanding LC Amount </span></td>
		<td><g:textField class="input_field amountFormat numericCurrency" readonly="readonly" name="outstandingBalance" value="${outstandingBalance}" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Main CIF Number </span></td>
		<td><g:textField class="input_field length7" readonly="readonly" name="mainCifNumber"  value="${mainCifNumber}"/></td>
		<td><span class="field_label"> Main CIF Name </span></td>
		<td><g:textField class="input_field length20" readonly="readonly" name="mainCifName"  value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Transport Medium</span></td>
		<td><g:textField class="input_field" name="transportMedium" value="${transportMedium}" readonly="readonly"/></td>
		<td><span class="field_label"> Shipment Amount</span></td>
		<td><g:textField class="input_field_right amountFormat numericCurrency" name="shipmentAmount" value="${shipmentAmount}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="indent1"><span class="field_label"> Type of BL presented </span></td>
		<td><g:textField name="blPresented" value="${blPresented}" class="input_field" readonly="readonly" />
		</td>
		<td><span class="field_label"> Shipment Currency </span></td>
		<td><g:textField class="input_field " readonly="readonly length3" name="shipmentCurrency"  value="${shipmentCurrency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Indemnity Issue Date </span></td>
		<td><g:textField class="input_field" name="indemnityIssueDate" value="${indemnityIssueDate}" readonly="readonly" /></td>
		<td><span class="field_label"> Shipment Sequence Number </span></td>
		<td><g:textField class="input_field " readonly="readonly" name="shipmentSequenceNumber" value="${shipmentSequenceNumber}"/></td>
	</tr>
	<tr>
		<g:if test="${documentSubType1?.equalsIgnoreCase('REGULAR')}">
			<td><span class="field_label"> TR Line </span></td>
			<td><g:textField class="input_field " readonly="readonly" name="trLine" value="${trLine}" /></td>
		</g:if>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}">
			<td colspan="2"> &#160; </td>
		</g:if>
		<td><span class="field_label"> With 2% CWT?</span></td>
		<td>
            <%--<g:textField class="input_field" name="cwtFlag" readonly="readonly" />--%>
            <g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
        </td>
	</tr>
</table>
<%--<g:render template="../layouts/buttons_for_grid_wrapper" />--%>