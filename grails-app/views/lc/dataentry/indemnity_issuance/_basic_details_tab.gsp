<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/dataentry/indemnity_issuance/basic_details_utility.js"/>
<g:javascript src="js-temp/validation_fxlc_bg_issuance_dataentry.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
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
		<td><span class="field_label"> eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${etsNumber}"/></td>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Main CIF Number</span></td>
		<td><g:textField name="mainCifNumber" class="input_field" readonly="readonly" value="${mainCifNumber}"/></td>
		<td><span class="field_label">Main CIF Name</span></td>
		<td><g:textField name="mainCifName" class="input_field" readonly="readonly" value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Indemnity Type</span></td>
		<td>
            <g:textField name="indemnityTypeDisplay" class="input_field" readonly="readonly" value="${indemnityType == "BG" ? "BANK GUARANTEE" : "BANK ENDORSEMENT"}"/>
            <g:hiddenField name="indemnityType" class="input_field" readonly="readonly" value="${indemnityType}"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="referenceNumber" class="input_field" readonly="readonly" value="${lcNumber}"/></td>
		<td><span class="field_label">BG/BE Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Original LC Amount</span></td>
		<td><g:textField name="originalAmount" class="input_field_right numericCurrency" readonly="readonly" value="${originalAmount}"/></td>
		<td><span class="field_label">Outstanding LC Amount</span></td>
		<td><g:textField name="outstandingBalance" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Transport Medium</span></td>
		<td>
            <g:select name="transportMedium" from="${['BY SEA','BY AIR']}" keys="${['SEA', 'AIR']}" value="${transportMedium}" class="select_dropdown" noSelection="['':'SELECT ONE...']"/>
        </td>
		<td><span class="field_label">Shipment Amount</span></td>
		<td><g:textField name="shipmentAmount" class="input_field_right numericCurrency" value="${shipmentAmount}"/></td>
	</tr>
	<tr class="ifBySeaRadio">
		<td><span class="field_label">If by Sea</span></td>
		<td>
            <g:radioGroup name="blPresented" labels="['Original','Copy']" values="['ORIGINAL', 'COPY']" value="${blPresented}" >
		     ${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160;
		  </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td><span class="field_label">TR Line</span></td>
		<td><g:textField name="trLine" value="${trLine}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label">Shipment Currency</span></td>
		<td><g:textField name="shipmentCurrency" class="input_field" readonly="readonly" value="${shipmentCurrency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">BL/Airway Bill Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="blAirwayBillNumber" value="${blAirwayBillNumber}" class="input_field required" maxlength="30"/></td>
		<td><p class="field_label">Shipment Sequence Number</p></td>
		<td><g:textField name="shipmentSequenceNumber" class="input_field" readonly="readonly" value="${shipmentSequenceNumber}"/></td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />