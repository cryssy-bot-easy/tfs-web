<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<g:javascript src="js-temp/validation_Charges_Tab.js"/>
<%@page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />

<table class="tabs_forms_table">
	<tr>
	     <td class="label_width"><span class="field_label">Transaction Number</span></td>
	     <td class="input_width" ><g:textField name="transactionNumber" value="${tradeServiceReferenceNumber}" class="input_field" readonly="readonly" /> </td>
	     <td class="label_width"><span class="field_label">Transaction Date</span></td>
	     <td><g:textField name="transactionDate" class="input_field" readonly="readonly" value="${transactionDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
	     <td><span class="field_label">Document Number</span></td>
		 <%-- referenceNumber, is the document number starting from opening --%>
	     <td><g:textField name="documentNumber" value="${referenceNumber}" class="input_field" readonly="readonly" /></td>
	     <td><span class="field_label">Process Date</span></td>
	     <td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
	     <td><span class="field_label">Processing Unit Code</span></td>
	     <td><g:textField name="processingUnitCode" class="input_field" readonly="readonly" value="${processingUnitCode}" /></td>
	     <td><span class="field_label">FXLC Issue Date </span></td>
	     <td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
	     <td><span class="field_label">FXLC Type</span></td>
	     <td><g:textField name="type" class="input_field" readonly="readonly" value="${type ?: documentSubType1}"/></td>
	     <td><span class="field_label">FXLC Tenor</span></td>
	     <td><g:textField name="tenor" class="input_field" readonly="readonly" value="${tenor ?: documentSubType2}"/></td>
	</tr>
	<tr>
	     <td><span class="field_label">FXLC Currency</span></td>
	     <td><g:textField name="currency" class="input_field input_three" readonly="readonly" value="${shipmentCurrency}" /></td>
	     <td><span class="field_label">Indemnity Amount</span></td>
	     <td><g:textField name="amount" class="input_field_right numeric_fifteen numericCurrency" readonly="readonly" value="${shipmentAmount}"/></td>
	</tr>
	<tr>
	     <td><span class="field_label">With 2% CWT?</span></td>
	     <td>
	     	<g:radioGroup name="cwtFlag" labels="['Yes','No']" values="['Y', 'N']" value="${cwtFlag ?: 'N'}" disabled="true">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
		</td>
	     <td><span class="field_label">FXLC O/S Amount</span></td>
	     <td><g:textField name="outstandingBalance" value="${outstandingBalance}" class="input_field_right numeric_fifteen numericCurrency" readonly="readonly" /></td>
	</tr>
</table>
<%--<br /><br />--%>
<%--<g:render template="/layouts/buttons_for_grid_wrapper" />--%>