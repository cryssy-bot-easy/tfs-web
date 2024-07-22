<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
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
		<td class="label_width"><span class="field_label">e-TS Number</span></td>
		<td><g:textField name="etsNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">e-TS Date</span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">MD Application Booking Date</span></td>
		<td><g:textField name="mdApplicationBookingDate" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">O/S MD Amount</span></td>
		<td><g:textField name="osMdAmount" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">MD Settlement Currency</span></td>
		<td><g:textField name="mdSettlementCurrency" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Amount of MD To Apply</span></td>
		<td><g:textField name="amountOfMdToApply" class="input_field"/></td>
	</tr>
	<tr >
		<td><span class="field_label"> Mode Of Application<span class="asterisk">*</span></span></td>
		<td><g:select name="modeOfRefundMdApply" from="${['Apply to Loan','Refund to Client']}" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr class="pn-number">
		<td><span class="field_label">PN Number</span></td>
		<td><g:textField name="pnNumber" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr class="modeRefund">
		<td><span class="field_label">If Refund to Client: Mode Of Refund</span></td>
		<td><g:select name="modeOfRefundMd" from="${['Credit CASA','Issuance to MC']}" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label small_margin_left">If Credit CASA,Account Number</span></td>
		<td><g:select name="casaAccountNumber" from="" class="select_dropdown" noSelection="['':'Select One...']" /></td>
	</tr>
	<tr class="md-casa">
		<td><span class="field_label small_margin_left">Account Name</span></td>
		<td><g:textField name="casaAccountName" class="input_field" readonly="readonly"/></td>
	</tr>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />
