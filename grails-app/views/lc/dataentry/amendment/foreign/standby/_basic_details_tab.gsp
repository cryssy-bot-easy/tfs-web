<%-- 
(revision)
SCR/ER Number: 20161121-097
SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
[Revised by:] John Patrick C. Bautista
[Date deployed:] 1/10/2016
Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<g:javascript src="utilities/dataentry/amendment/amendment_dataentry_basic_details_utility.js" />
<g:javascript src="utilities/dataentry/amendment/amendment_dataentry_ie_details_utility.js" />
<g:javascript src="utilities/dataentry/amendment/amendment_dataentry_shipments_goods_utility.js" />

<g:javascript src="js-temp/validation_fxlc_amendment_dataentry.js"/>

<g:javascript src="popups/description_of_goods_popup.js" />
<g:javascript src="jquery.limit-1.2.source.js"/>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%
<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="furtherIdentification" value="${furtherIdentification}" />
<g:hiddenField name="destinationBank" value="${destinationBank}" />

<%--for AMLA--%>
<%--<g:hiddenField name="amlaRemittanceFlag" value="${amlaRemittanceFlag}" />--%>
<%--<g:hiddenField name="amlaCheckFlag" value="${amlaCheckFlag}" />--%>
<%--<g:hiddenField name="amlaCashFlag" value="${amlaCashFlag}" />--%>
<%--<g:hiddenField name="amlaCasaFlag" value="${amlaCasaFlag}" />--%>
<%--<g:hiddenField name="amlaRemittanceFlagPhp" value="${amlaRemittanceFlagPhp}" />--%>
<%--<g:hiddenField name="amlaCheckFlagPhp" value="${amlaCheckFlagPhp}" />--%>
<%--<g:hiddenField name="amlaCashFlagPhp" value="${amlaCashFlagPhp}" />--%>
<%--<g:hiddenField name="amlaCasaFlagPhp" value="${amlaCasaFlagPhp}" />--%>
<%--<g:hiddenField name="amlaRemittanceFlagFx" value="${amlaRemittanceFlagFx}"/>--%>
<%--<g:hiddenField name="amlaCheckFlagFx" value="${amlaCheckFlagFx}"/>--%>
<%--<g:hiddenField name="amlaCashFlagFx" value="${amlaCashFlagFx}"/>--%>
<%--<g:hiddenField name="amlaCasaFlagFx" value="${amlaCasaFlagFx}"/>--%>
<%--<g:hiddenField name="amlaRemittanceFlagAmount" value="${amlaRemittanceFlagAmount}"/>--%>
<%--<g:hiddenField name="amlaCheckFlagAmount" value="${amlaCheckFlagAmount}"/>--%>
<%--<g:hiddenField name="amlaCashFlagAmount" value="${amlaCashFlagAmount}"/>--%>
<%--<g:hiddenField name="amlaCasaFlagAmount" value="${amlaCasaFlagAmount}"/>--%>
<%--<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>--%>
<%--<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagFxCurrency}"/>--%>


<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />

<g:hiddenField name="importerName" value="${importerName}" />

<g:hiddenField name="importerAddress" value="${importerAddress}" />
<g:hiddenField name="exporterName" value="${exporterName}" />
<g:hiddenField name="exporterAddress" value="${exporterAddress}" />
<g:hiddenField name="positiveToleranceLimit" value="${positiveToleranceLimit}" />
<g:hiddenField name="negativeToleranceLimit" value="${negativeToleranceLimit}" />
<g:hiddenField name="maximumCreditAmount" value="${maximumCreditAmount}" />
<g:hiddenField name="additionalAmountsCovered" value="${additionalAmountsCovered}" />

<g:if test="${tsdInitiated}">
    <g:hiddenField name="amount" value="${outstandingBalance}" />
    <div id="select2setB">

        <g:hiddenField name="exporterCbCode" value="${exporterCbCode}" />
        <g:hiddenField name="availableWith" value="${availableWith}" />
        <g:hiddenField name="bspCountryCode" value="${bspCountryCode}" />
        <g:hiddenField name="reimbursingCurrency" value="${reimbursingCurrency}" />
    </div>
</g:if>

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

<g:hiddenField name="latestShipmentDate" value="${latestShipmentDate}" />
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
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />
<table class="tabs_forms_table">
	<tr>
		<td>&#160;</td>
		<td>
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label">Transaction Date</span>
            </g:if>
            <g:else>
                <span class="field_label">eTS Date</span>
            </g:else>
        </td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td class="label_width">
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label">Transaction Number</span>
            </g:if>
            <g:else>
                <span class="field_label">eTS Number</span>
            </g:else>
        </td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${tradeServiceReferenceNumber ?: etsNumber}"/></td>
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td class="label_width"><span class="field_label">Main CIF Number</span></td>
		<td class="input_width"><g:textField name="mainCifNumber" class="input_field" readonly="readonly" value="${mainCifNumber}"/></td>
		<td class="label_width"><span class="field_label">Main CIF Name</span></td>
		<td class="input_width"><g:textField name="mainCifName" class="input_field" readonly="readonly" value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span class="field_label">Processing Unit Code</span></td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly" value="${processingUnitCode}"/></td>
		<td><span class="field_label">Process Date</span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span class="field_label">FXLC Type</span></td>
		<td><g:textField name="type" class="input_field" readonly="readonly" value="${type}"/></td>
		<td><span class="field_label">FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span class="field_label">Facility Type</span></td>
		<td><g:textField name="facilityType" class="input_field" readonly="readonly" value="${facilityType}" /></td>
		<td><span class="field_label">Facility ID</span></td>
		<td>
            <g:hiddenField name="facilityReferenceNumberTo" value="${facilityReferenceNumber}" />
            <g:textField name="facilityId" class="input_field" readonly="readonly" value="${facilityId}"/>
        </td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField name="currency" class="input_field" value="${currency}" readonly="readonly"/></td>
		<td><span class="field_label">Facility Balance Before Opening</span></td>
		<td><g:textField name="facilityBalanceBeforeOpening" value="${facilityBalanceBeforeOpening}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span class="field_label">Related Reference</span></td>
		<td><g:textField name="receiversReference" class="input_field" value="${receiversReference ?: 'NONREF'}" /></td>
		<%--<td colspan="2"><span class="field_label">Sender's Reference Number</span></td>--%>
		<%--<td><g:textField name="sendersReference" class="input_field" value="${sendersReference ?: 'NONREF'}" /></td>--%>
		<td><span class="field_label">Number of Amendments</span></td>
		<td><g:textField name="numberOfAmendments" value="${numberOfAmendments ?: '1'}" class="input_field" readonly="readonly" /></td>
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="purposeOfStandbySwitchDisplay" />
			<g:hiddenField name="purposeOfStandbySwitch" value="${purposeOfStandbySwitch ?: 'off'}" />
		</td>
		<td><span class="field_label">Purpose of FXLC Standby</span></td>
		<td><g:textArea name="purposeOfStandby" class="textarea textFormat-60" value="${purposeOfStandby}" rows="4" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="purposeOfStandbyToAsterisk">*</span></span></td>
		<td><g:textArea maxlenght="400" name="purposeOfStandbyTo" class="textarea textFormat-60" value="${purposeOfStandbyTo}" rows="4"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="standbyTaggingSwitchDisplay" />
			<g:hiddenField name="standbyTaggingSwitch" value="${standbyTaggingSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label">Tagging</span></td>
		<td><g:textField name="standbyTagging" class="input_field" value="${standbyTagging}" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="standbyTaggingToAsterisk">*</span></span></td>
		<td><g:select disabled="disabled" name="standbyTaggingTo" class="select_dropdown" from="${['FINANCIAL', 'PERFORMANCE']}" keys="${['FINANCIAL','PERFORMANCE']}" noSelection="['':'SELECT ONE...']" value="${standbyTaggingTo}"/></td>
		
	</tr>
	<tr>
		<td>
		    <g:if test="${tsdInitiated!='true'}"><g:checkBox name="amountSwitchDisplay" /></g:if>
			<g:hiddenField name="amountSwitch" value="${amountSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> FXLC Amount </span></td>
        <g:if test="${tsdInitiated!='true'}"><td><g:textField name="amountFrom" class="input_field_right numericCurrency" readonly="readonly" value="${productAmount}"/>
        <g:hiddenField name="productAmount" value="${productAmount}"/></td></g:if>
        <g:else><td><g:textField name="amountFrom" class="input_field_right numericCurrency" readonly="readonly" value="${amountFrom?:productAmount}"/></td></g:else>
		<td><g:if test="${tsdInitiated!='true'}"><span class="field_label right_indent">To: <span class="amountToAsterisk">*</span></span></g:if></td>
		<td><g:if test="${tsdInitiated!='true'}"><g:textField name="amountTo" value="${amountTo?:0}" class="input_field_right numericCurrency"/></g:if></td>
	</tr>
	<tr>
        <td colspan="2"><span class="field_label">Outstanding Balance</span></td>
        <td><g:textField name="outstandingBalance2" value="${outstandingBalance2?:outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly"/>
		<g:hiddenField name="outstandingBalance" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td>
		    <g:if test="${tsdInitiated!='true'}"><g:checkBox name="expiryDateSwitchDisplay" />
				<g:hiddenField name="expiryDateSwitch" value="${expiryDateSwitch ?: 'off'}" />
			</g:if>
		</td>
		<td><span class="field_label"> FXLC Expiry Date </span></td>
		<td>
			<g:hiddenField name="expiryDate" value="${expiryDateFrom ?: expiryDate}" />
			<g:textField name="expiryDateFrom" class="input_field" readonly="readonly" value="${expiryDateFrom ?: expiryDate}"/>
		</td>
		<td><g:if test="${tsdInitiated!='true'}"><span class="field_label right_indent">To: <span class="expiryDateToAsterisk">*</span> </span></g:if></td>
		<td><g:if test="${tsdInitiated!='true'}"><g:textField name="expiryDateTo" value="${expiryDateTo}" class="datepicker_field" /></g:if></td>
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="importerCifNumberSwitchDisplay" />
			<g:hiddenField name="importerCifNumberSwitch" value="${importerCifNumberSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Importer CIF Number</span></td>
		<td class="input_width"><g:textField name="importerCifNumberFrom" value="${importerCifNumberFrom ?: importerCifNumber}" class="input_field" readonly="readonly"  /></td>
		<td class="label_width"><span class="field_label right_indent">To: <span class="importerCifNumberToAsterisk">*</span></span></td>
		<td class="input_width">
			<g:textField name="importerCifNumberTo" class="input_field" value="${importerCifNumberTo}" readonly="readonly"/>
			<a href="javascript:void(0)" class="popup_btn_cif_normal search_btn">...</a>
		</td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="importerCbCodeSwitchDisplay" />
			<g:hiddenField name="importerCbCodeSwitch" value="${importerCbCodeSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">If without CIF Number:<br/>Importer CB Code</span></td>
		<td class="input_width"><g:textField name="importerCbCodeFrom" value="${importerCbCodeFrom ?: importerCbCode}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label right_indent">To: <span class="importerCbCodeToAsterisk">*</span></span></td>
		<td class="input_width"><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCodeTo" id="importerCbCodeTo" /></td>	
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="importerNameSwitchDisplay" />
			<g:hiddenField name="importerNameSwitch" value="${importerNameSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Importer Name</span></td>
		<td><g:textField name="importerNameFrom" value="${importerNameFrom ?: importerName}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="importerNameToAsterisk">*</span></span></td>
		<td><g:textField maxlength="60" name="importerNameTo" value="${importerNameTo}" class="input_field" maxlength="60"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="importerAddressSwitchDisplay" />
			<g:hiddenField name="importerAddressSwitch" value="${importerAddressSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Importer Address</span></td>
		<td class="input_width"><g:textArea name="importerAddressFrom"  class="textarea" readonly="readonly" rows="4" value="${importerAddressFrom ?: importerAddress}"/></td>
		<td class="label_width"><span class="field_label right_indent">To: <span class="importerAddressToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="importerAddressTo" value="${importerAddressTo}" class="textarea" rows="4" />
			<a href="javascript:void(0)" class="popup_btn_bottom amend_importer_address" id="popup_btn_importer_bank_address">...</a>
		</td>
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="exporterCbCodeSwitchDisplay" />
			<g:hiddenField name="exporterCbCodeSwitch" value="${exporterCbCodeSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter CB Code</span></td>
		<td><g:textField name="exporterCbCodeFrom" value="${exporterCbCodeFrom ?: exporterCbCode}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="exporterCbCodeToAsterisk">*</span></span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="exporterCbCodeTo" id="exporterCbCodeTo" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="exporterNameSwitchDisplay" />
			<g:hiddenField name="exporterNameSwitch" value="${exporterNameSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter Name</span></td>
		<td><g:textField maxlength="60" name="exporterNameFrom" class="input_field" readonly="readonly" value="${exporterNameFrom ?: exporterName}" /></td>
		<td><span class="field_label right_indent">To: <span class="exporterNameToAsterisk">*</span></span></td>
		<td><g:textField name="exporterNameTo" class="input_field" value="${exporterNameTo}" maxlength="60"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="exporterAddressSwitchDisplay" />
			<g:hiddenField name="exporterAddressSwitch" value="${exporterAddressSwitch}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter Address</span></td>
		<td><g:textArea name="exporterAddressFrom" value="${exporterAddressFrom ?: exporterAddress}" class="textarea" rows="2" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="exporterAddressToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="exporterAddressTo" value="${exporterAddressTo}" class="textarea" rows="2" />
			<a href="javascript:void(0)" class="popup_btn_bottom amend_exporter_address" id="popup_btn_exporter_bank_address">...</a>
		</td>
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="confirmationInstructionsFlagSwitchDisplay" />
			<g:hiddenField name="confirmationInstructionsFlagSwitch" value="${confirmationInstructionsFlagSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> Confirmation Instructions: Confirmed? </span>
		</td>
		<td><g:textField name="confirmationInstructionsFlagFrom" value="${confirmationInstructionsFlagFrom ?: confirmationInstructionsFlag}" class="input_field" readonly = "readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="confirmationInstructionsToAsterisk">*</span> </span></td> 
		<td><g:select name="confirmationInstructionsFlagTo" noSelection="${['':'SELECT ONE...']}" value="${confirmationInstructionsFlagTo}" from="${['YES','NO','MAY ADD']}" class="select_dropdown"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="destinationBankSwitchDisplay" />
			<g:hiddenField name="destinationBankSwitch" value="${destinationBankSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> Destination Bank </span></td>
		<td><g:textField name="destinationBankFrom" value="${destinationBankFrom ?: destinationBank}"  class="input_field" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="destinationBankToAsterisk">*</span> </span></td>
		<td>
			<%-- <g:select name="destinationBankTo" from="${['DESTINATION BANK 1', 'DESTINATION BANK 2', 'DESTINATION BANK 3']}" keys="${['DESTINATIONBANK1', 'DESTINATIONBANK2', 'DESTINATIONBANK3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" value="${destinationBankTo}"/> --%>
		  
			<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop" name="destinationBankTo" id="destinationBankTo" />
		</td>
	</tr>
	<tr><td colspan="7">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="availableWithSwitchDisplay" />
			<g:hiddenField name="availableWithSwitch" value="${availableWithSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Available With (41A)</span></td>
	</tr>
	<tr>
		<td colspan="2">		
			<span class="field_label">
				<g:radio name="availableWithFlagFrom" value="A" checked="${(availableWithFlagFrom ?: availableWithFlag) == 'A' ? true : false}" disabled="true"/>
				&#160;<label for="availableWithFlagFrom">Option A <br /> Identifier Code</label>
			</span>
		</td>
		<td><g:textField name="availableWithFrom" value="${availableWithFrom ?: availableWith}" class="input_field" readonly="readonly"/></td>
		<td>
			<span class="field_label">
				<g:radio name="availableWithFlagTo" class="availableWithTo  avialableWithA" value="A" checked="${availableWithFlagTo == 'A' ? true : false}"/>
				&#160;<label for="availableWithFlagTo">Option A <br /> Identifier Code</label>
			</span>
		</td>
		<td><input class="tags_bank select2_dropdown bigdrop" name="availableWithTo" id="availableWithTo" /></td>
	</tr>
	<tr>
		<td colspan="2">
			<span class="field_label">
				<g:radio name="availableWithFlagFrom" value="D" checked="${(availableWithFlagFrom ?: availableWithFlag) == 'D' ? true : false}" disabled="true"/>
				&#160;<label for="nameAndAddress">Option D <br /> Name and Address</label>
			</span>
		</td>
		<td><g:textArea name="nameAndAddressFrom" value="${nameAndAddress}"  class="textarea" rows="4" readonly="readonly" /></td>
		<td>
			<span class="field_label">
				<g:radio name="availableWithFlagTo" disabled="disabled" class="availableWithTo avialableWithB"  value="D" checked="${availableWithFlagTo == 'D' ? true : false}"/>
				&#160;<label for="availableNameAndAddressIERadioTo">Option D <br /> Name and Address</label>
			</span>
		</td>
		<td>
			<g:textArea name="nameAndAddressTo" value="${nameAndAddressTo}" class="textarea" rows="4" />
			<input type="button" class="popup_btn_bottom" id="popup_btn_bank_address" />
		</td>
	</tr>
	<%--
	<tr class="advising_bank_hide">
		<td> &#160; </td>
		<td><span class="field_label advisingBank"> Advising Bank </span></td>>
		<td><g:textField name="confirmingBankFrom" value="${confirmingBankFrom ?: confirmingBank}" class="input_field advisingBankFrom" readonly="readonly" /></td>
		<td><span class="right_indent">To: </span></td>
		<td><g:textField name="confirmingBankTo" value="${confirmingBankTo}" class="input_field advisingBankTo" /></td>
	</tr>
	--%>
	<tr>
		<td>
		    <g:checkBox name="applicableRulesSwitchDisplay" />
			<g:hiddenField name="applicableRulesSwitch" value="${applicableRulesSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> Applicable Rules </span></td>
		<td><g:textField name="applicableRulesFrom" value="${applicableRulesFrom ?: applicableRules}" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="applicableRulesToAsterisk">*</span></span></td>
		<td><g:select name="applicableRulesTo" from="${['EUCP LATEST VERSION','EUCPURR LATEST VERSION', 'ISP LATEST VERSION', 'OTHR', 'UCP LATEST VERSION', 'UCPURR LATEST VERSION']}" noSelection="['':'SELECT ONE...']" keys="${['EUCP','EURR','ISP', 'OTHR', 'UCP', 'UCUR']}" value="${applicableRulesTo ?: 'UCP'}" class="select_dropdown" /></td>
	</tr>
	<tr class="other_rule_hide">
		<td> &#160; </td>
		<td><span class="field_label ifOtherRule1 othr_label"> If 'OTHER': Other Rule </span></td>
		<td><g:textField name="otherRuleFrom" class="input_field ifOtherRuleFrom othr_field"  value="${otherRuleFrom ?: otherRule}" readonly="readonly" /></td>
		<td><span class="field_label right_indent ifOtherRuleTo othr_labelTo">To: </span></td>
		<td><g:textField name="otherRuleTo" value="${otherRuleTo}" class="input_field ifOtherRuleTo othr_fieldTo" /></td>
	</tr>
	<tr>
		<td>
		    <g:checkBox name="expiryCountryCodeSwitchDisplay" />
			<g:hiddenField name="expiryCountryCodeSwitch" value="${expiryCountryCodeSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> Expiry Country Code </span></td>
		<td><g:textField name="expiryCountryCodeFrom" value="${expiryCountryCodeFrom ?: expiryCountryCode}" class="input_field" readonly="readonly" /></td>
		<td><span class="field_label right_indent">To: <span class="expiryCountryCodeToAsterisk">*</span></span></td>
		<td>
		    <%-- <g:select name="expiryCountryCodeTo" value="${expiryCountryCodeTo}" from="${['BSP CODE 1', 'BSP CODE 2', 'BSP CODE 3'] }" keys="${['BSP_CODE1', 'BSP_CODE2', 'BSP_CODE3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown"/> --%>
		    
		    <%-- Auto Complete --%> 
        	<input class="tags_country select2_dropdown bigdrop" name="expiryCountryCodeTo" id="expiryCountryCodeTo" />
		</td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="formOfDocumentaryCreditSwitchDisplay" />
			<g:hiddenField name="formOfDocumentaryCreditSwitch" value="${formOfDocumentaryCreditSwitch ?: 'off'}" />
		</td>
		<td><span class="field_label"> Form of Documentary Credit </span></td>
		<td><g:textField name="formOfDocumentaryCreditFrom" value="${formOfDocumentaryCreditFrom ?: formOfDocumentaryCredit}" noSelection="['':'SELECT ONE...']" class="input_field" readonly="readonly"/></td>
		<td><span class="field_label right_indent">To: <span class="formOfDocumentaryCreditToAsterisk">*</span></span></td>
		<td><tfs:formOfDocumentaryCredit name="formOfDocumentaryCreditTo" value="${formOfDocumentaryCreditTo}" class="select_dropdown" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="generalDescriptionOfGoodsSwitchDisplay"/>
			<g:hiddenField name="generalDescriptionOfGoodsSwitch" value="${generalDescriptionOfGoodsSwitch ?: 'off'}" />
        </td>
		<td><span class="field_label"> Description of Goods and/or Services </span></td>
		<td><g:textArea name="generalDescriptionOfGoodsFrom" class="textarea" readonly="readonly" rows="4" value="${generalDescriptionOfGoodsFrom ?: generalDescriptionOfGoods}"/></td>
		<td><span class="field_label right_indent">To: <span class="generalDescriptionOfGoodsToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="generalDescriptionOfGoodsTo" value="${generalDescriptionOfGoodsTo}" class="textarea" rows="4" readonly="readonly"/>
			<input type="button" class="popup_btn_bottom amend_description_of_goods_btn" id="popup_btn_description_of_goods"/>
		</td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="senderToReceiverSwitchDisplay"/>
			<g:hiddenField name="senderToReceiverSwitch" value="${senderToReceiverSwitch ?: 'off'}"/>
		</td>
		<td><span class="field_label">Sender to Receiver Information</span></td>
		<td>
			<tfs:senderToReceiverType1 name="senderToReceiverFrom" value="${senderToReceiverFrom ?: senderToReceiver}" disabled="true"/>
		</td>
		<td><span class="field_label right_indent">To: <span class="senderToReceiverToAsterisk">*</span></span></td>
		<td>
			<tfs:senderToReceiverType1 name="senderToReceiverTo" value="${senderToReceiverTo}"/>
		</td>
	</tr>	
	<tr>
		<td colspan="2">&#160;</td>
		<td colspan="2"><g:textArea name="senderToReceiverInformationFrom" value="${senderToReceiverInformationFrom ?: senderToReceiverInformation}" class="textarea" rows="4" readonly="readonly" /></td>
		<td> 
			<g:textArea maxlength="210" name="senderToReceiverInformationTo" class="textarea" rows="4" value="${senderToReceiverInformationTo}"/>
			<%--<input type="button" class="popup_btn_bottom" id="sender_info">--%>
		</td>
	</tr>	
</table>
<br /><br />
<g:render template="/layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/description_goods_popup" />
<script>
function setupTsdInitiated() {
    $("#importerCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
	$("#exporterCbCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
	$("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWith}'});
	$("#bspCountryCode").setBankDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCode}'});
	$("#reimbursingCurrency").setBankDropdown($(this).attr("id")).select2('data',{id: '${reimbursingCurrency}'});
}

function onChangeImporterCifNumber() {
	if($("#importerCifNumberSwitchDisplay").attr("checked") == "checked") {
		$("#importerCifNumberSwitch").val("on");
		$(".popup_btn_cif_normal").show();
		$(".importerCifNumberToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
		$("#importerCifNumberSwitch").val("off");
		$("#importerCifNumberTo").val("");
		$(".popup_btn_cif_normal").hide();
		$(".importerCifNumberToAsterisk").addClass("clear_font").removeClass("asterisk");
	}
}

function setImporterCifNumberDataEntry() {
	var importerCifNumberSwitch = $("#importerCifNumberSwitch").val();

	if(importerCifNumberSwitch) {
		if(importerCifNumberSwitch.toLowerCase() == "on") {
			$("#importerCifNumberSwitchDisplay").attr("checked", "checked");
		} else {
			$("#importerCifNumberSwitchDisplay").attr("checked", false);
		}
	}else {
		$("#importerCifNumberSwitchDisplay").attr("checked", false);
	}
}

function onChangeImporterCbCode() {
	if($("#importerCbCodeSwitchDisplay").attr("checked") == "checked") {
		$("#importerCbCodeSwitch").val("on");
		$("#importerCbCodeTo").select2("enable");
		$(".importerCbCodeToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
		$("#importerCbCodeSwitch").val("off");
		$("#importerCbCodeTo").select2("disable");
		$("#importerCbCodeTo").select2('data',{id: null});
		$(".importerCbCodeToAsterisk").addClass("clear_font").removeClass("asterisk");
	}
}

function setImporterCbCodeDataEntry() {
	var importerCbCodeSwitch = $("#importerCbCodeSwitch").val();

	if(importerCbCodeSwitch) {
		if(importerCbCodeSwitch.toLowerCase() == "on") {
			$("#importerCbCodeSwitchDisplay").attr("checked", "checked");
		} else {
			$("#importerCbCodeSwitchDisplay").attr("checked", false);
		}
	}else {
		$("#importerCbCodeSwitchDisplay").attr("checked", false);
	}
}

function setPurposeOfStandbyCheckDataEntry() {
	if($("#purposeOfStandbySwitch").val()) {
		if($("#purposeOfStandbySwitch").val().toLowerCase() == "on") {
			$("#purposeOfStandbySwitchDisplay").attr("checked", "checked");
		} else {
			$("#purposeOfStandbySwitchDisplay").attr("checked", false);
		}
	} else {
		$("#purposeOfStandbySwitchDisplay").attr("checked", false);
	}
}

function onChangePurposeOfStandby() {
	if($("#purposeOfStandbySwitchDisplay").attr("checked") == "checked") {
        $("#purposeOfStandbySwitch").val("on");
		$("#purposeOfStandbyTo").removeAttr("readonly");
		$(".purposeOfStandbyToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
        $("#purposeOfStandbySwitch").val("off");
		$("#purposeOfStandbyTo").val("");
		$("#purposeOfStandbyTo").attr("readonly", "readonly");
		$(".purposeOfStandbyToAsterisk").addClass("clear_font").removeClass("asterisk");
	}
}

function setStandbyTaggingCheckDataEntry() {
	if($("#standbyTaggingSwitch").val()) {
		if($("#standbyTaggingSwitch").val().toLowerCase() == "on") {
			$("#standbyTaggingSwitchDisplay").attr("checked", "checked");
		} else {
			$("#standbyTaggingSwitchDisplay").attr("checked", false);
		}
	} else {
		$("#standbyTaggingSwitchDisplay").attr("checked", false);
	}
}

function onChangeStandbyTagging() {
	if($("#standbyTaggingSwitchDisplay").attr("checked") == "checked") {
        $("#standbyTaggingSwitch").val("on");
		$("#standbyTaggingTo").removeAttr("disabled");
		$(".standbyTaggingToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
		$("#standbyTaggingSwitch").val("off");
		$("#standbyTaggingTo").val("");
		$("#standbyTaggingTo").attr("disabled", "disabled");
	}
}

function onChangeFxlcAmount() {
	if($("#amountSwitchDisplay").attr("checked") == "checked") {
		$("#amountSwitch").val("on");
		$("#amountTo").removeAttr("readonly");
		$(".amountToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
		$("#amountSwitch").val("off");
		$("#amountTo").val("");
		$("#amountTo").attr("readonly", "readonly");
		$(".amountToAsterisk").addClass("clear_font").removeClass("asterisk");
	}
}

function setSenderToReceiverCheckDataEntry() {
	if($("#senderToReceiverSwitch").val()) {
		if($("#senderToReceiverSwitch").val().toLowerCase() == "on") {
			$("#senderToReceiverSwitchDisplay").attr("checked", "checked");
		} else {
			$("#senderToReceiverSwitchDisplay").attr("checked", false);
		}
	} else {
		$("#senderToReceiverSwitchDisplay").attr("checked", false);
	}
}

function onChangeSenderToReceiver() {
	if($("#senderToReceiverSwitchDisplay").attr("checked") == "checked") {
		$("#senderToReceiverSwitch").val("on");
		$("#senderToReceiverTo").removeAttr("disabled");
		$("#senderToReceiverInformationTo").removeAttr("readonly");
		$(".senderToReceiverToAsterisk").addClass("asterisk").removeClass("clear_font");
	} else {
		$("#senderToReceiverSwitch").val("off");
		$("#senderToReceiverTo").val("");
		$("#senderToReceiverInformationTo").val("");
		$("#senderToReceiverTo").attr("disabled", "disabled");
		$("#senderToReceiverInformationTo").attr("readonly", "readonly");
		$(".senderToReceiverToAsterisk").addClass("clear_font").removeClass("asterisk");
	}
}

function onChangeConfirmationInstruction() {
	if($("#confirmationInstructionsFlagTo").val() == "YES") {
		$("input[type=radio][name=availableWithFlagTo][value=A]").attr("checked", "checked");
		$("#nameAndAddressTo").val('${nameAndAddressTo}');
	}
	else if($("#confirmationInstructionsFlagTo").val() == "NO") {
		$("input[type=radio][name=availableWithFlagTo][value=D]").attr("checked", "checked");
		$("#nameAndAddressTo").val("ANY BANK");
	}
	else {
		$("input[type=radio][name=availableWithFlagTo][value=D]").attr("checked", "checked");
		$("#nameAndAddressTo").val("ANY BANK");
	}
}

function onExpiryCountryCodeCheckDataEntry() {
	if ($("#expiryCountryCodeSwitchDisplay").attr("checked") == "checked") {
		$("#expiryCountryCodeSwitch").val("on");
		$("#expiryCountryCodeTo").select2("enable");
		$("#expiryCountryCodeTo").addClass("required");
		$("#expiryCountryLabelTo").addClass("required");
		$(".expiryCountryCodeToAsterisk").addClass("asterisk");
		$(".expiryCountryCodeToAsterisk").removeClass("clear_font");
		$('#expiryCountryLabelTo').removeAttr('readonly');
	} else {
		$("#expiryCountryCodeSwitch").val("off");
		$("#expiryCountryCodeTo").select2("disable");
		$("#expiryCountryCodeTo").removeClass("required");
		$("#expiryCountryLabelTo").removeClass("required");
		$("#expiryCountryCodeTo").select2('data', {
			id : null
		});
		$(".expiryCountryCodeToAsterisk").removeClass("asterisk");
		$(".expiryCountryCodeToAsterisk").addClass("clear_font");
		$("#expiryCountryLabelTo").val("");
		$('#expiryCountryLabelTo').attr('readonly', 'readonly');
	}
}

function setExpiryCountryCodeDataEntry() {
	var expiryCountryCodeSwitch = $("#expiryCountryCodeSwitch").val();

	if (expiryCountryCodeSwitch) {
		if (expiryCountryCodeSwitch.toLowerCase() == "on") {
			$("#expiryCountryCodeSwitchDisplay").attr("checked", "checked");
		} else {
			$("#expiryCountryCodeSwitchDisplay").attr("checked", false);
		}
	} else {
		$("#expiryCountryCodeSwitchDisplay").attr("checked", false);
	}
}

$(document).ready(function() {
	%{--$("#destinationBankTo").select2('data',{id: '${destinationBankTo}'});--}%
	$("#destinationBankTo").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${destinationBankTo}'});
	%{--$("#expiryCountryCodeTo").select2('data',{id: '${expiryCountryCodeTo}'});--}%
	$("#expiryCountryCodeTo").setCountryDropdown($(this).attr("id")).select2('data',{id: '${expiryCountryCodeTo}'});

	$("#importerCbCodeTo").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCodeTo}'});
	$("#exporterCbCodeTo").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCodeTo}'});
	$("#availableWithTo").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWithTo}'});

	setImporterCifNumberDataEntry();
	onChangeImporterCifNumber();
	$("#importerCifNumberSwitchDisplay").change(onChangeImporterCifNumber);
	
	setImporterCbCodeDataEntry();
	onChangeImporterCbCode();
	$("#importerCbCodeSwitchDisplay").change(onChangeImporterCbCode);

	setExpiryCountryCodeDataEntry();
	$("#expiryCountryCodeSwitchDisplay").click(
		onExpiryCountryCodeCheckDataEntry);
	onExpiryCountryCodeCheckDataEntry();
	
	var tsdInitiated = '${tsdInitiated}';

	if(tsdInitiated) {
		$("#select2setB").hide();
		setupTsdInitiated();
	}

	setPurposeOfStandbyCheckDataEntry();
	$("input[type=checkbox][name=purposeOfStandbySwitchDisplay]").change(onChangePurposeOfStandby);
	onChangePurposeOfStandby();

	setStandbyTaggingCheckDataEntry();
	$("input[type=checkbox][name=standbyTaggingSwitchDisplay]").change(onChangeStandbyTagging);
	onChangeStandbyTagging();

	onChangeFxlcAmount();
	$("input[type=checkbox][name=amountSwitchDisplay]").change(onChangeFxlcAmount);

	setSenderToReceiverCheckDataEntry();
	$("input[type=checkbox][name=senderToReceiverSwitchDisplay]").change(onChangeSenderToReceiver);
	onChangeSenderToReceiver();
	
	onChangeConfirmationInstruction();
	$("#confirmationInstructionsFlagTo").change(function() {
	onChangeConfirmationInstruction();
		if($("#confirmationInstructionsFlagTo").val() == "YES") {
			$("#availableWithTo").select2('data',{id: $("#destinationBankTo").select2('data').id});
			$("#draweeTo").val($("#availableWithTo").val());
		}
		else {
			$("#availableWithTo").select2('data',{id: null});
		}
	});

	$("#destinationBankTo").change(function() {
		if($("#confirmationInstructionsFlagTo").val() == "YES" && $("input[type=checkbox][name=availableWithSwitchDisplay]:checked").val() == "on") {
			$("#availableWithTo").select2('data',{id: $("#destinationBankTo").select2('data').id});
			$("#draweeTo").val($("#availableWithTo").val());
		}
	});

	$("input[type=checkbox][name=destinationBankSwitchDisplay]").click(function() {
		if($("input[type=checkbox][name=destinationBankSwitchDisplay]:checked").val() == "on") {
			$("#destinationBankTo").select2('data',{id: '${destinationBankTo}'});
			$("#availableWithTo").select2('data',{id: $("#destinationBankTo").select2('data').id});
		} else {
			$("#destinationBankTo").select2('data',{id: null});
			$("#availableWithTo").select2('data',{id: null});
		}
	});

	$("input[type=checkbox][name=availableWithSwitchDisplay]").click(function() {
		if($("input[type=checkbox][name=availableWithSwitchDisplay]:checked").val() == "on") {
			$("#availableWithTo").select2('data',{id: $("#destinationBankTo").select2('data').id});
		} else {
			$("#availableWithTo").select2('data',{id: null});
		}
	});

});
</script>