<%@ page import="net.ipc.utils.DateUtils" %>
<%--<g:javascript src="js-temp/validation_Charges_Tab.js"/>--%>
<g:javascript src="temp_validation/validation_negotiation.js"/>

<script type="text/javascript">

    $(document).ready(function () {
		var icAmount = $("#totalIcAmount").val();

        if (icAmount<=0) {
        	$("#outstandingBalanceLessIcLabel").hide();
        	$("#outstandingBalanceLessIc").hide();
        } else {
        	$("#outstandingBalanceLessIcLabel").show();
        	$("#outstandingBalanceLessIc").show();
        }
    });
   
</script>

<g:hiddenField name="branchUnitcode" value="${branchUnitcode ?: session.unitcode}" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="icCount" value="${icCount}" />

<g:hiddenField name="productAmount" value="${productAmount}" />

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />

<g:hiddenField name="facilityId" value="${facilityId}" />
<g:hiddenField name="facilityType" value="${facilityType}" />
<g:hiddenField name="facilityReferenceNumber" value="${facilityReferenceNumber}" />

<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}" />

<g:hiddenField name="positiveToleranceLimit" value="${positiveToleranceLimit}" />
<g:hiddenField name="negativeToleranceLimit" value="${negativeToleranceLimit}" />
<g:hiddenField name="partialShipment" value="${partialShipment}" />

<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
<g:hiddenField name="applicantName" value="${applicantName}" />

<g:hiddenField name="cashFlag" value="${cashFlag}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>
<g:hiddenField name="shipmentNumber" value="${shipmentNumber ?: shipmentCount ? shipmentCount.intValue() + 1 : '1'}" />
%{--<g:textField name="tradeProductNumber" value="${tradeProductNumber}" />--}%
<g:hiddenField name="totalIcAmount" value="${totalIcAmount}" />
<g:hiddenField name="totalIcCashAmount" value="${totalIcCashAmount}" />
<g:hiddenField name="icRegularAmount" value="${icRegularAmount}" />
<g:hiddenField name="icCashAmount" value="${icCashAmount}" />
<table class="tabs_forms_table">
    <g:if test="${reversalEtsNumber}">
        <tr>
            <td class="label_width"><span class="field_label">Reversal eTS Number</span></td>
            <td><g:textField name="reversalEtsNumber" value="${reversalEtsNumber}" class="input_field" readonly="readonly"/></td>
        </tr>
    </g:if>
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"><g:textField class="input_field length12" name="etsNumber" value="${serviceInstructionId}" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${lcNumber ?: documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField class="input_field" name="processingUnitCode" readonly="readonly" value="${processingUnitCode}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Issue Date </span></td>
		<td><g:textField class="input_field" name="issueDate" readonly="readonly" value="${issueDate}"/></td>
		<td><span class="field_label">DMLC Expiry Date </span></td>
		<td><g:textField class="input_field" name="expiryDate" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Type</span></td>
		<td><g:textField class="input_field" name="type" value="${type}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Currency</span></td>
		<td><g:textField class="input_field" name="originalCurrency" value="${originalCurrency ?: currency}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Amount</span></td>
		<td><g:textField class="input_field_right numeric-fifteen numericCurrency" name="originalAmount" value="${originalAmount}" readonly="readonly"/></td>
		<td><span class="field_label">Outstanding DMLC Balance</span></td>
		<td><g:textField class="input_field_right numeric-fifteen numericCurrency" name="outstandingBalance" value="${outstandingBalance}" readonly="readonly"/></td>
	</tr>
	<tr>
	<tr>
		<td><span class="field_label">IC Number</span></td>
		<td>
            %{--<g:select name="icNumber" from="${['DN-001', 'DN-002', 'DN-003']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${icNumber}"/>--}%
       			<g:select name="icNumber" from="${icNumbers}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" value="${icNumber}"/>
        </td>
        <td><span class="field_label" id="outstandingBalanceLessIcLabel">O/S Balance (less IC Amount)</span></td>
        <td><g:textField id="outstandingBalanceLessIc" name="outstandingBalanceLessIc" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${outstandingBalanceLessIc}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Currency</span></td>
		<td><g:textField class="input_field input_three" name="negotiationCurrency" value="${negotiationCurrency ?: currency}" readonly="readonly"/></td>
		<td><span class="field_label">Negotiation Value Date</span></td>
		<td><g:textField class="datepicker_field" name="negotiationValueDate" value="${negotiationValueDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiation Amount<span class="asterisk">*</span></span></td>
		<td><g:textField class="input_field_right numeric-fifteen numericCurrency required" name="negotiationAmount" value="${negotiationAmount}"/></td>
		<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
			<td><span class="field_label">Cash LC Amount</span></td>
			<td><g:textField name="cashAmount" value="${cashAmount}" class="input_field_right numericCurrency" readonly="readonly" /></td>
		</g:if>
	</tr>
	<g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
		<tr>
			<td/>
			<td/>
			<td><span class="field_label">Amount Due For Payment</span></td>
			<td><g:textField name="overdrawnAmount" class="input_field_right numericCurrency" readonly="readonly" value="${overdrawnAmount}" /></td>
		</tr>
	</g:if>
	<g:else>
        <g:hiddenField name="overdrawnAmount" class="input_field numericCurrency" readonly="readonly" value="${overdrawnAmount}" />
    </g:else>

</table>

<g:hiddenField name="negotiationBank" value="${negotiationBank}" />
<g:hiddenField name="negotiationBankRefNumber" value="${negotiationBankRefNumber}" />
<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />

<br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />

