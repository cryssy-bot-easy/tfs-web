<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/dataentry/amendment/amendment_dataentry_basic_details_utility.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<%--for AMLA--%>
<g:hiddenField name="amlaRemittanceFlag" value="${amlaRemittanceFlag}" />
<g:hiddenField name="amlaCheckFlag" value="${amlaCheckFlag}" />
<g:hiddenField name="amlaCashFlag" value="${amlaCashFlag}" />
<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />
<g:hiddenField name="amlaRemittanceFlagPhp" value="${amlaRemittanceFlagPhp}" />
<g:hiddenField name="amlaCheckFlagPhp" value="${amlaCheckFlagPhp}" />
<g:hiddenField name="amlaCashFlagPhp" value="${amlaCashFlagPhp}" />
<g:hiddenField name="amlaCasaFlagPhp" value="${amlaCasaFlagPhp}" />
<g:hiddenField name="amlaRemittanceFlagFx" value="${amlaRemittanceFlagFx}"/>
<g:hiddenField name="amlaCheckFlagFx" value="${amlaCheckFlagFx}"/>
<g:hiddenField name="amlaCashFlagFx" value="${amlaCashFlagFx}"/>
<g:hiddenField name="amlaCasaFlagFx" value="${amlaCasaFlagFx}"/>
<g:hiddenField name="amlaRemittanceFlagAmount" value="${amlaRemittanceFlagAmount}"/>
<g:hiddenField name="amlaCheckFlagAmount" value="${amlaCheckFlagAmount}"/>
<g:hiddenField name="amlaCashFlagAmount" value="${amlaCashFlagAmount}"/>
<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>
<%--<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>--%>
<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagFxCurrency}"/>
<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="expiryDate" value="${expiryDate}" />
<g:hiddenField name="tenor" value="${tenor}" />
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>

<div id="select2setA">
<g:hiddenField name="expiryCountryCode" value="${expiryCountryCode}" />
<g:hiddenField name="destinationBank" value="${destinationBank}" />
</div>

<g:if test="${tsdInitiated}">
    <div id="select2setB">
        <g:hiddenField name="importerCbCode" value="${importerCbCode}" />
        <g:hiddenField name="exporterCbCode" value="${exporterCbCode}" />
        <g:hiddenField name="availableWith" value="${availableWith}" />
        <g:hiddenField name="bspCountryCode" value="${bspCountryCode}" />
        <g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency}" />
		<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
		<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}" />
		<g:hiddenField name="partialDelivery" value="${partialDelivery}" />
    </div>
</g:if>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />
<g:hiddenField name="applicableRules" value="${applicableRules}" />
<g:hiddenField name="formOfDocumentaryCredit" value="${formOfDocumentaryCredit}" />

<g:hiddenField name="usancePeriod" value="${usancePeriod}" />
<g:hiddenField name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" />

<g:hiddenField name="importerName" value="${importerName}" />
<g:hiddenField name="importerCifNumber" value="${importerCifNumber}" />
<g:hiddenField name="importerAddress" value="${importerAddress}" />
<g:hiddenField name="exporterName" value="${exporterName}" />
<g:hiddenField name="exporterAddress" value="${exporterAddress}" />
<g:hiddenField name="positiveToleranceLimit" value="${positiveToleranceLimit}" />
<g:hiddenField name="negativeToleranceLimit" value="${negativeToleranceLimit}" />
<g:hiddenField name="maximumCreditAmount" value="${maximumCreditAmount}" />
<g:hiddenField name="additionalAmountsCovered" value="${additionalAmountsCovered}" />
<g:hiddenField name="availableWithFlag" value="${availableWithFlag}" />
<g:hiddenField name="identifierCode" value="${identifierCode}" />
<g:hiddenField name="nameAndAddress" value="${nameAndAddress}" />
<g:hiddenField name="availableBy" value="${availableBy}" />
<g:hiddenField name="drawee" value="${drawee}" />
<g:hiddenField name="mixedPaymentDetails" value="${mixedPaymentDetails}" />
<g:hiddenField name="deferredPaymentDetails" value="${deferredPaymentDetails}" />
<g:hiddenField name="partialShipment" value="${partialShipment}" />
<g:hiddenField name="transShipment" value="${transShipment}" />
<g:hiddenField name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceipt}" />
<g:hiddenField name="portOfLoadingOrDeparture" value="${portOfLoadingOrDeparture}" />
<g:hiddenField name="portOfDischargeOrDestination" value="${portOfDischargeOrDestination}" />
<g:hiddenField name="placeOfFinalDestination" value="${placeOfFinalDestination}" />

%{--<g:hiddenField name="latestShipmentDate" value="${latestShipmentDate}" />--}%
<g:hiddenField name="shipmentPeriod" value="${shipmentPeriod}" />
<g:hiddenField name="generalDescriptionOfGoods" value="${generalDescriptionOfGoods}" />

<g:hiddenField name="periodForPresentation" value="${periodForPresentation}" />

<g:hiddenField name="reimbursingBankFlag" value="${reimbursingBankFlag}" />
<g:hiddenField name="reimbursingBankIdentifierCode" value="${reimbursingBankIdentifierCode}" />
<g:hiddenField name="reimbursingBankNameAndAddress" value="${reimbursingBankNameAndAddress}" />
<g:hiddenField name="reimbursingAccountType" value="${reimbursingAccountType}" />
<g:hiddenField name="reimbursingBankAccountNumber" value="${reimbursingBankAccountNumber}" />

<g:hiddenField name="adviseThroughBankFlag" value="${adviseThroughBankFlag}" />
<g:hiddenField name="adviseThroughBankIdentifierCode" value="${adviseThroughBankIdentifierCode}" />
<g:hiddenField name="adviseThroughBankLocation" value="${adviseThroughBankLocation}" />
<g:hiddenField name="adviseThroughBankNameAndAddress" value="${adviseThroughBankNameAndAddress}" />

<g:hiddenField name="senderToReceiver" value="${senderToReceiver}" />
<g:hiddenField name="senderToReceiverInformation" value="${senderToReceiverInformation}" />
<g:hiddenField name="narrativeCheck" value="${narrative}" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width">
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label"> Transaction Number</span>
            </g:if>
            <g:else>
                <span class="field_label">eTS Number</span>
            </g:else>
        </td>
		<td class="input_width"><g:textField class="input_field" name="etsNumber" readonly="readonly" value="${tradeServiceReferenceNumber ?: etsNumber}"/></td>
		<td class="label_width">
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label"> Transaction Date </span>
            </g:if>
            <g:else>
                <span class="field_label">eTS Date</span>
            </g:else>
        </td>
		<td><g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>					
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
		<td><span class="field_label"> Document Number </span></td>
		<td><g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Issue Date </span></td>
		<td><g:textField class="input_field" name="issueDate" readonly="readonly" value="${issueDate}"/></td>
		<td><span class="field_label"> DMLC Currency </span></td>
		<td><g:textField class="input_field" name="currency" readonly="readonly" value="${currency}"/></td>
	</tr>
	<tr>
		<td colspan="2" />
		<td><span class="field_label"> DMLC Amount </span></td>
		<td><g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Value Date </span></td>					
		<td><g:textField class="input_field" name="valueDate" value="${valueDate?:DateUtils.shortDateFormat(new Date())}"/></td>
		<td><span class="field_label"> Number of Amendment </span></td>
		<td><g:textField class="input_field" name="numberOfAmendments" readonly="readonly" value="${numberOfAmendments ?: '1'}"/></td>
	</tr>
	<tr>
		<td class="label_width valign_top">
			<span class="field_label"> 
				<g:if test="${referenceType.equalsIgnoreCase('ETS')}">Buyer Name</g:if>
				<g:else>Applicant Name</g:else> 
			</span>
		</td>
		<td><g:textArea class="textarea" name="applicantName" readonly="readonly" value="${applicantName}" rows="2"/></td>
		<g:if test="${!documentSubType1?.equalsIgnoreCase('Standby')}">
		<td class="valign_top"><span class="field_label"> Latest Date of Delivery </span></td>
		<td class="valign_top"><g:textField class="input_field" name="latestShipmentDate" readonly="readonly" value="${latestShipmentDate}"/></td>
		</g:if>
	</tr>
	<tr>
		<td class="valign_top">
			<span class="field_label"> 
				<g:if test="${referenceType.equalsIgnoreCase('ETS')}">Buyer Address</g:if>
				<g:else>Applicant Address</g:else> 
			</span>
		</td>
		<td>
            <g:textArea class="textarea" name="applicantAddress" readonly="readonly" value="${applicantAddress}" rows="4"/>
        </td>
	</tr>
</table>
<br /><br />
<%--<g:if test="${session.userrole.id.contains('TS')}">
<g:if test="${!session['group'].equals('TSD')}">
<div id="dmlc_amendment_narrative">
    <ul>
        <li><p class="p_header">Narrative</p></li>
        <li><div><g:textArea name="narrative" id="narrative_ac1" class="amendment_narrative" value="${narrative}"></g:textArea></div></li>
    </ul>
</div>
</g:if>
</g:if>
--%><br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    function setupTsdInitiated() {
        $("#importerCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
        $("#exporterCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
        $("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWith}'});
        $("#bspCountryCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCode}'});
        $("#reimbursingCurrency").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingCurrency}'});
    }

    $(document).ready(function() {
        $("#select2setA").hide();

        %{--$("#destinationBankTo").select2('data',{id: '${destinationBankTo}'});--}%
        $("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${destinationBankTo}'});
        %{--$("#expiryCountryCodeTo").select2('data',{id: '${expiryCountryCodeTo}'});--}%
        $("#expiryCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${expiryCountryCodeTo}'});

        $("#expiryCountryCode").on("change", function(e) {
            $("#expiryCountry").val($("#expiryCountryCode").select2('data').label)
        });

        var tsdInitiated = '${tsdInitiated}';

        if(tsdInitiated) {
            $("#select2setB").hide();
            setupTsdInitiated();
        }
    });
</script>