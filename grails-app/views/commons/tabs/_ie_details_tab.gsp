<script>
var ucpbSenderAddress = "${grailsApplication.config.tfs.constants.sender.address + grailsApplication.config.tfs.constants.sender.suffix}";
</script>

<g:if test="${serviceType == 'Amendment'}">
    <g:javascript src="utilities/dataentry/amendment/amendment_dataentry_ie_details_utility.js" />
</g:if>
<g:else>
    <g:javascript src="utilities/dataentry/commons/ieDetailsCheckBoxFunction.js" />
    <g:javascript src="utilities/dataentry/commons/byDropdownFunction.js" />
    <g:javascript src="utilities/dataentry/commons/amendmentNameAndAddressCounter.js" />
    <g:javascript src="utilities/dataentry/commons/availableWithRadio.js" />
</g:else>

<g:if test="${serviceType == 'Amendment' }">
<g:javascript src="utilities/dataentry/commons/amendmentNarrative.js" />
</g:if>

<g:javascript src="utilities/commons/ie_details_utility.js"/>
<g:javascript src="popups/view_related_lc_popup.js" />
<g:javascript src="popups/exporter_cb_code_popup.js" />
<g:javascript src="popups/additional_amounts_covered_popup.js" />
<g:javascript src="popups/deferred_payment_details_popup.js" />
<g:javascript src="popups/mixed_payment_details_popup.js" />
<g:javascript src="popups/cif_normal_search_popup.js" />
<g:if test="${serviceType == 'Amendment' }">
<g:javascript src="popups/tenor_of_drafts_popup.js" />
</g:if>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="ieDetails" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<g:if test="${serviceType != 'Amendment' }">
<table>
	<tr>
		<td class="label_width"><span class="field_label">Importer CB Code</span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" /></td>
		<td><span class="field_label">Exporter CB Code <%--<span class="asterisk">*</span>--%></span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="exporterCbCode" id="exporterCbCode" /></td>
	</tr>
	<tr>
		<td></td>
		<td><a href="javascript:void(0)" id="popup_btn_view_related_lc"> (View Related LC's)</a></td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label">Importer CIF Number
				<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
					 <span class="asterisk">*</span>
				</g:if>
			</span>
		</td>
		<td class="input_width">
			<g:if test="${referenceType?.equalsIgnoreCase('DATA_ENTRY')}">
				<g:textField name="importerCifNumber" class="input_field required" value="${importerCbCode ? importerCifNumber : cifNumber}" readonly="readonly"/>
				<a href="javascript:void(0)" class="popup_btn_cif_normal search_btn">...</a>
			</g:if>
			<g:else>
				<g:textField name="importerCifNumber" class="input_field required" value="${importerCbCode ? importerCifNumber : cifNumber}" readonly="readonly"/>
			</g:else>
		</td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label">Importer Name
				<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
					 <span class="asterisk">*</span>
				</g:if>
			</span>
		</td>
		<td><g:textField name="importerName" class="input_field required" value="${importerName ?: cifName}" maxlength="60"/></td>
		<td><span class="field_label">Exporter Name <span class="asterisk">*</span></span></td>
		<td><g:textField name="exporterName" class="input_field required" value="${exporterName}" maxlength="60"/></td>
	</tr>
	<tr>
		<td class="label_width">
			<span class="field_label">Importer Address
				<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
					 <span class="asterisk">*</span>
				</g:if>
			</span>
		</td>
		<td>
			<g:textArea name="importerAddress" value="${importerAddress ?: (address1 + "\n" + address2)}" class="textarea required" rows="4" readonly="readonly"/>
			<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a></span>
		</td>
		<td><span class="field_label">Exporter Address <span class="asterisk">*</span></span></td>
		<td>
			<g:textArea name="exporterAddress" value="${exporterAddress}" class="textarea required" readonly="readonly" rows="4" />
			<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_exporter_bank_address">...</a></span>
		</td>
	</tr>
	<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
		<tr>
			<td class="label_width"><span class="field_label">Positive Tolerance Limit</span></td>
			<td><g:textField name="positiveToleranceLimit" value="${positiveToleranceLimit}" class="input_field numericCurrency"  /></td>
			<td><span class="field_label">Negative Tolerance Limit</span></td>
			<td><g:textField name="negativeToleranceLimit" value="${negativeToleranceLimit}" class="input_field numericCurrency"  /></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Maximum Credit Amount</span></td>
			<td><g:textField name="maximumCreditAmount" value="${maximumCreditAmount ?: 'NOT EXCEEDING'}" class="input_field" readonly="readonly" /></td>
			<td><p class="field_label">Additional Amounts<br />Covered</p></td>
			<td>
				<g:textArea name="additionalAmountsCovered"  value="${additionalAmountsCovered}" class="textarea" readonly="readonly" rows="4" />
				<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_additional_amounts_covered">...</a></span>
			</td>
		</tr>
	</g:if>
	<tr>
		<td class="label_width"><span class="field_label">Available With <span class="asterisk">*</span></span></td>
		<td>
        	<input class="tags_bank select2_dropdown bigdrop required" name="availableWith" id="availableWith" />
		</td>
		<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
            <td><span class="field_label">By... <span class="asterisk">*</span></span></td>
            <td>
                <tfs:availableBy name="availableByDisplay" class="select_dropdown required" value="${availableBy}" />
                <g:hiddenField name="availableBy" value="${availableBy}" />
           </td>
		</g:if>
	</tr>
	<tr>
		<td class="label_width">
            <g:hiddenField name="availableWithFlagValue" value="${availableWithFlag}" />
			<g:radio name="availableWithFlag" class="availableWithA" value="A"  checked="${availableWithFlag == 'A' ? 'checked' : false}" />
			&#160;<span class="field_label">Option A - <br/>Identifier Code</span>
		</td>
		<td colspan="3"><g:textField name="identifierCode" class="input_field" value="${identifierCode}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td class="label_width">
			<g:radio name="availableWithFlag" class="availableWithB" value="D"  checked="${availableWithFlag == 'D' ? 'checked' : false}" />
			&#160;<span class="field_label">Option D - <br/>Name and Address</span>
		</td>
		<td colspan="3"><g:textArea name="nameAndAddress" value="${nameAndAddress}" class="textarea" readonly="readonly" rows='4'/>
		<a href="javascript:void(0)" class="search_btn bank_address_popup" id="popup_btn_bank_address">...</a>
		</td>
	</tr>
	<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
        <tr class="vtop label_width field_hide drawee">
            <td><span class="field_label">Drawee</span></td>
            <td><g:textField name="drawee" value="${drawee}" class="input_field" readonly="readonly" /></td>
            <td><span class="field_label">Tenor of Draft (Narrative)</span></td>
            <td>
                <g:textArea name="tenorOfDraftNarrative" class="textarea" rows="4" readonly="readonly" value="${(tenor?.equalsIgnoreCase("SIGHT")) ? 'DRAFT AT SIGHT' : tenorOfDraftNarrative}" />
           </td>
        </tr>
        <tr class="vtop label_width field_hide mixed_payment_details">
            <td><span class="field_label">Mixed Payment Details <span class="asterisk">*</span></span></td>
            <td colspan="3">
                <g:textArea name="mixedPaymentDetails" value="${mixedPaymentDetails}" class="textarea" readonly="readonly" rows="4" />
                <a href="javascript:void(0)" class="search_btn" id="popup_btn_mixed_payments_details">...</a>
           </td>
        </tr>
        <tr class="vtop label_width field_hide deffered_payment_details">
            <td><span class="field_label">Deferred Payment Details <span class="asterisk">*</span></span></td>
            <td colspan="3">
                <g:textArea name="deferredPaymentDetails" value="${deferredPaymentDetails}" class="textarea" readonly="readonly" rows="4" />
                <a href="javascript:void(0)" class="search_btn" id="popup_btn_deferred_payments_details">...</a>
           </td>
        </tr>
        <tr>
            <td class="label_width"><span class="field_label">Country Code <span class="asterisk">*</span></span></td>
            <td>
        		<input class="tags_country select2_dropdown bigdrop required" name="countryCode" id="countryCode" />
           </td>
        </tr>
        <tr>
            <td class="label_width"><span class="field_label">Partial Shipment <span class="asterisk">*</span></span></td>
            <td colspan="3">
              <g:select name="partialShipment" value="${partialShipment}"  from="${['ALLOWED', 'NOT ALLOWED']}" keys="${['ALLOWED','NOT ALLOWED']}" noSelection="['':'SELECT ONE...']" class="select_dropdown required" />
           </td>
        </tr>
        <tr>
            <td class="label_width"><span class="field_label">Transshipment<span class="asterisk">*</span></span></td>
            <td colspan="3">
              <g:select name="transShipment" value="${transShipment}" from="${['ALLOWED', 'NOT ALLOWED']}" keys="${['ALLOWED','NOT ALLOWED']}" noSelection="['':'SELECT ONE...']" class="select_dropdown required" />
           </td>
        </tr>
        <tr>
            <td class="label_width">
                <p class="field_label">Place of Taking in Charge<br/>/Dispatch from.../Place of<br/>Receipt</p>
           </td>
            <td colspan="3"><g:textArea name="placeOfTakingDispatchOrReceipt" value="${placeOfTakingDispatchOrReceiptTo ?: placeOfTakingDispatchOrReceipt}" class="textarea" rows="4" maxlength="65"/></td>
        </tr>
        <tr>
            <td class="label_width">
                <p class="field_label">Port of Loading/Airport of<br/>Departure <span class="asterisk">*</span></p>
           </td>
            <td><g:textArea name="portOfLoadingOrDeparture" value="${portOfLoadingOrDeparture}" class="textarea required" rows="4" maxlength="65"/></td>
            <td><span class="field_label">BSP Country Code <span class="asterisk">*</span></span></td>
            <td>
        		<input class="tags_country select2_dropdown bigdrop required" name="bspCountryCode" id="bspCountryCode" />
           </td>
        </tr>
        <tr>
            <td class="label_width">
                <p class="field_label">Port of Discharge/Airport<br/>of Destination <span class="asterisk">*</span> </p>
           </td>
            <td colspan="3"><g:textArea name="portOfDischargeOrDestination" value="${portOfDischargeOrDestinationTo ?: portOfDischargeOrDestination}" class="textarea required" rows="4" maxlength="65"/></td>
        </tr>
        <tr>
            <td class="label_width">
                <p class="field_label">Place of Final Destination<br/>/For Transportation to.../<br/>Place of Delivery</p>
           </td>
            <td colspan="3"><g:textArea name="placeOfFinalDestination" value="${placeOfFinalDestinationTo ?: placeOfFinalDestination}" class="textarea" rows="4" maxlength="65"/></td>
        </tr>
	</g:if>
</table>
</g:if>

<g:if test="${serviceType == 'Amendment' }">
<table>
	<tr>
		<td colspan="6"><p class="title_label">Importer</p></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">Importer CIF Number</span></td>
		<td/>
		<td colspan="3"><g:textField name="importerCifNumber" value="${importerCifNumber}" class="input_field" readonly="readonly"  /></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">If without CIF Number:<br/>Importer CB Code</span></td>
		<td/>
		<td colspan="3">
        	<input class="tags_cbcode select2_dropdown bigdrop" name="importerCbCode" id="importerCbCode" />
		</td>	
	</tr>
		
	<tr><td colspan="6" class="spacer">&#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="importerNameSwitchDisplay" />
			<g:hiddenField name="importerNameSwitch" value="${importerNameSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Importer Name</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td width="230"><g:textField name="importerNameFrom" value="${importerNameFrom ?: importerName}" class="input_field" readonly="readonly"/></td>
		<td><span class="right_indent">To: <span class="importerNameToAsterisk">*</span></span></td>
		<td><g:textField name="importerNameTo" value="${importerNameTo}" class="input_field" maxlength="60"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="importerAddressSwitchDisplay" />
			<g:hiddenField name="importerAddressSwitch" value="${importerAddressSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Importer Address</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textArea name="importerAddressFrom"  class="textarea" readonly="readonly" rows="4" value="${importerAddressFrom ?: importerAddress}"/>
		</td>
		<td><span class="right_indent">To: <span class="importerAddressToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="importerAddressTo" value="${importerAddressTo}" class="textarea" rows="4" />
			<a href="javascript:void(0)" class="popup_btn_bottom amend_importer_address" id="popup_btn_importer_bank_address">...</a>
		</td>
	</tr>
	<tr><td colspan="6" class="spacer">&#160;</td></tr>
	<tr>
		<td colspan="6"><p class="title_label">Exporter</p></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="exporterCbCodeSwitchDisplay" />
			<g:hiddenField name="exporterCbCodeSwitch" value="${exporterCbCodeSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter CB Code</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
            <g:textField name="exporterCbCodeFrom" value="${exporterCbCodeFrom ?: exporterCbCode}" class="input_field" readonly="readonly"/>
		</td>
		<td><span class="right_indent">To: <span class="exporterCbCodeToAsterisk">*</span></span></td>
		<td><input class="tags_cbcode select2_dropdown bigdrop" name="exporterCbCodeTo" id="exporterCbCodeTo" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="exporterNameSwitchDisplay" />
			<g:hiddenField name="exporterNameSwitch" value="${exporterNameSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter Name</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textField name="exporterNameFrom" class="input_field" readonly="readonly" value="${exporterNameFrom ?: exporterName}" />
		</td>
		<td><span class="right_indent">To: <span class="exporterNameToAsterisk">*</span></span></td>
		<td><g:textField name="exporterNameTo" class="input_field" value="${exporterNameTo}" maxlength="60" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="exporterAddressSwitchDisplay" />
			<g:hiddenField name="exporterAddressSwitch" value="${exporterAddressSwitch}" />
		</td>
		<td class="label_width"><span class="field_label">Exporter Address</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textArea name="exporterAddressFrom" value="${exporterAddressFrom ?: exporterAddress}" class="textarea" rows="4" readonly="readonly"/>
		</td>
		<td><span class="right_indent">To: <span class="exporterAddressToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="exporterAddressTo" value="${exporterAddressTo}" class="textarea" rows="4" />
			<a href="javascript:void(0)" class="popup_btn_bottom amend_exporter_address" id="popup_btn_exporter_bank_address">...</a>
		</td>
	</tr>
	<tr><td colspan="6" class="spacer">&#160;</td></tr>
		
	<tr>
		<td colspan="6"><p class="title_label">Percentage Credit Amount Tolerance</p></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="positiveToleranceLimitSwitchDisplay" />
			<g:hiddenField name="positiveToleranceLimitSwitch" value="${positiveToleranceLimitSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Positive Tolerance Limit</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textField name="positiveToleranceLimitFrom" value="${positiveToleranceLimitFrom ?: positiveToleranceLimit}" class="input_field" readonly="readonly" />
		</td>
		<td><span class="right_indent">To: <span class="positiveToleranceLimitToAsterisk">*</span></span></td>
		<td><g:textField name="positiveToleranceLimitTo" class="input_field numericQuantity" value="${positiveToleranceLimitTo}"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="negativeToleranceLimitSwitchDisplay" />
			<g:hiddenField name="negativeToleranceLimitSwitch" value="${negativeToleranceLimitSwitch  ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Negative Tolerance Limit</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textField name="negativeToleranceLimitFrom" value="${negativeToleranceLimitFrom ?: negativeToleranceLimit}" class="input_field" readonly="readonly"/>
		</td>
		<td><span class="right_indent">To: <span class="negativeToleranceLimitToAsterisk">*</span></span></td>
		<td><g:textField name="negativeToleranceLimitTo" class="input_field numericQuantity" value="${negativeToleranceLimitTo}" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="maximumCreditAmountSwitchDisplay" />
			<g:hiddenField name="maximumCreditAmountSwitch" value="${maximumCreditAmountSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Maximum Credit Amount</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textField name="maximumCreditAmountFrom" value="${maximumCreditAmountFrom ?: maximumCreditAmount ?: 'NOT EXCEEDING'}" class="input_field" readonly="readonly" />
		</td>
		<td><span class="right_indent">To: <span class="maximumCreditAmountToAsterisk">*</span></span></td>
		<td><g:textField name="maximumCreditAmountTo" class="input_field" value="${maximumCreditAmountTo}"/></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="additionalAmountsCoveredSwitchDisplay" />
			<g:hiddenField name="additionalAmountsCoveredSwitch" value="${additionalAmountsCoveredSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Additional Amounts Covered</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textArea name="additionalAmountsCoveredFrom" value="${additionalAmountsCoveredFrom ?: additionalAmountsCovered}" class="textarea" readonly="readonly" rows="4"></g:textArea>
		</td>
		<td><span class="right_indent">To: <span class="additionalAmountsCoveredToAsterisk">*</span></span></td>
		<td>
			<g:textArea name="additionalAmountsCoveredTo" class="textarea" rows="4" value="${additionalAmountsCoveredTo}" />
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_additional_amounts_covered">Additional Amount Covered</a>
		</td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="availableWithSwitchDisplay" />
			<g:hiddenField name="availableWithSwitch" value="${availableWithSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Available With (41A)</span></td>
		<td><span class="right_indent">&#160;</span></td>
	    <td>
            <g:textField name="availableWithFrom" value="${availableWithFrom ?: availableWith}" class="input_field" readonly="readonly"/>
		</td>
	    <td><span class="right_indent">To: <span class="availableWithToAsterisk">*</span></span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop" name="availableWithTo" id="availableWithTo" />
		</td>
	</tr>
	<tr>
		<td colspan="3">
			<g:radio name="availableWithFlagFrom" value="A" checked="${(availableWithFlagFrom ?: availableWithFlag) == 'A' ? true : false}" disabled="true"/>
			&#160;<label for="availableWithFlagFrom">Option A <br /> Identifier Code</label>
		</td>
		<td><g:textField name="identifierCode" value="${identifierCode}" class="input_field" readonly="readonly"/></td>
		<td>
			<g:radio name="availableWithFlagTo" class="availableWithTo  avialableWithA" value="A" checked="${availableWithFlagTo == 'A' ? true : false}"/>
			&#160;<label for="availableWithFlagTo">Option A <br /> Identifier Code</label>
		</td>
		<td>
		  <input class="tags_bank select2_dropdown bigdrop" name="identifierCodeTo" id="identifierCodeTo" />
		</td>
	</tr>
	<tr>
		<td colspan="3">
		  <g:radio name="availableWithFlagFrom" value="D" checked="${(availableWithFlagFrom ?: availableWithFlag) == 'D' ? true : false}" disabled="true"/>
		  &#160;<label for="nameAndAddress">Option D <br /> Name and Address</label>
		</td>
		<td>
			<g:textArea name="nameAndAddressFrom" value="${nameAndAddress}"  class="textarea" rows="4" readonly="readonly" />
		</td>
		<td>
		  <g:radio name="availableWithFlagTo" disabled="disabled" class="availableWithTo avialableWithB"  value="D" checked="${availableWithFlagTo == 'D' ? true : false}"/>
		  &#160;<label for="availableNameAndAddressIERadioTo">Option D <br /> Name and Address</label>
		</td>
		<td>
		  <g:textArea name="nameAndAddressTo" value="${nameAndAddressTo}" class="textarea" rows="4" />
		  <input type="button" class="popup_btn_bottom" id="popup_btn_bank_address" />
		</td>
	</tr>
	<tr>
<%--		<td>--%>
<%--			<g:checkBox name="availableBySwitchDisplay" />--%>
<%--			<g:hiddenField name="availableBySwitch" value="${availableBySwitch ?: 'off'}" />--%>
<%--		</td>		  		--%>
		<td class="label_width" colspan="2"><span class="field_label">By...</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
		  <tfs:availableBy name="availableByFrom" disabled="true" class="select_dropdown" value="${availableByFrom ?: availableBy}" />
		<td><%-- <span class="right_indent">To:</span> --%></td>
		<td>
<%--			<tfs:availableBy name="availableByTo" class="select_dropdown" value="${availableByTo}" />--%>
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">Drawee</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
		  <g:textField name="draweeFrom" value="${draweeFrom ?: drawee}" class="input_field" readonly="readonly" />
		</td>
		<td><%-- <span class="right_indent">To:</span>--%></td>
		<td>
		 <%-- <g:textField name="draweeTo" class="input_field" value="${draweeTo}" />--%>
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">Tenor of Draft (Narrative)</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
		  <g:textArea name="tenorOfDraftNarrativeFrom" value="${tenorOfDraftNarrativeFrom ?: tenorOfDraftNarrative}"  class="textarea" readonly="readonly" rows="4" />
		</td>
		<td><%--<span class="right_indent">To:</span>--%></td>
		<td>
		  <%--<g:textArea name="tenorOfDraftNarrativeTo" value="${tenorOfDraftNarrativeTo}" class="textarea" rows="4"  />
		  <input type="button" class="popup_btn_bottom" id="popup_btn_tenor_draft">--%>
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">Mixed Payment Details</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textArea name="mixedPaymentDetailsFrom" value="${mixedPaymentDetailsFrom ?: mixedPaymentDetails}" class="textarea" readonly="readonly" rows="4" />
               </td>
			
		<td><%--<span class="right_indent">To:</span>--%></td>
		<td>
		      <%--  <g:textArea name="mixedPaymentDetailsTo" value="${mixedPaymentDetailsTo}" class="textarea" rows="5" />
			<input type="button" class="popup_btn_bottom" id="popup_btn_mixed_payments_details">--%>
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label">Deferred Payment Details</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textArea name="deferredPaymentDetailsFrom" value="${deferredPaymentDetailsFrom ?: deferredPaymentDetails}"  class="textarea" readonly="readonly" rows="4" />

	       </td>
		<td><%--<span class="right_indent">To:</span>--%></td>
		<td>
			<%--
			<g:textArea name="deferredPaymentDetailsTo" value="${deferredPaymentDetailsTo}" class="textarea" rows="4" />
			<a href="javascript:void(0)" class="popup_btn_bottom" id="popup_btn_deferred_payments_details">Deferred Payment</a>
			--%>
		</td>
	</tr>      
    <tr>
		<td>
			<g:checkBox name="countryCodeSwitchDisplay" />
			<g:hiddenField name="countryCodeSwitch" value="${countryCodeSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Country Code</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td><g:textField name="countryCodeFrom" value="${countryCodeFrom ?: countryCode}" class="input_field" readonly="readonly" /></td>
		<td><span class="right_indent">To: <span class="countryCodeToAsterisk">*</span></span></td>
		<td><input class="tags_country select2_dropdown bigdrop" name="countryCodeTo" id="countryCodeTo" /></td>
	</tr>
	<tr><td colspan="6"> &#160;</td></tr>
	<tr>
		<td>
			<g:checkBox name="partialShipmentSwitchDisplay" />
			<g:hiddenField name="partialShipmentSwitch" value="${partialShipmentSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">Partial Shipment</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td><g:textField name="partialShipmentFrom" value="${partialShipmentFrom ?: partialShipment}" class="input_field" readonly="readonly" /></td>
		<td><span class="right_indent">To: <span class="partialShipmentToAsterisk">*</span></span></td>
		<td><g:select name="partialShipmentTo" value="${partialShipmentTo}" from="${['ALLOWED', 'NOT ALLOWED']}" keys="${['ALLOWED','NOT ALLOWED']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" /></td>
	</tr>
	<tr>
		<td>
			<g:checkBox name="transShipmentSwitchDisplay" />
			<g:hiddenField name="transShipmentSwitch" value="${transShipmentSwitch ?: 'off'}" />
		</td>
		<td class="label_width"><span class="field_label">TransShipment</span></td>
		<td><span class="right_indent">&#160;</span></td>
		<td>
			<g:textField name="transShipmentFrom" value="${transShipmentFrom ?: transShipment}" class="input_field" readonly="readonly" />
		</td>
		<td><span class="right_indent">To: <span class="transShipmentToAsterisk">*</span></span></td>
		<td>
			<g:select name="transShipmentTo" value="${transShipmentTo}" from="${['ALLOWED', 'NOT ALLOWED']}" keys="${['ALLOWED','NOT ALLOWED']}" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" />
		</td>
	</tr>
	<tr><td colspan="6"> &#160;</td></tr>
	
	<%--	<tr>--%>
<%--		<td>--%>
<%--		   <g:checkBox name="placeOfTakingDispatchOrReceiptSwitchDisplay" />--%>
<%--                  <g:hiddenField name="placeOfTakingDispatchOrReceiptSwitch" value="${placeOfTakingDispatchOrReceiptSwitch ?: 'off'}" />--%>
<%--		</td>--%>
<%--		<td><span class="field_label">Place of Taking in Charge / Dispatch from... / Place of Receipt</span></td>--%>
<%--		<td><span class="right_indent">&#160;</span></td>--%>
<%--		<td>--%>
<%--		   <g:textArea name="placeOfTakingDispatchOrReceiptFrom" value="${placeOfTakingDispatchOrReceiptFrom ?: placeOfTakingDispatchOrReceipt}"  class="textarea" readonly="readonly" rows="4" />--%>
<%--		</td>--%>
<%--		<td><span class="right_indent">To:</span></td>--%>
<%--		<td>--%>
<%--		   <g:textArea name="placeOfTakingDispatchOrReceiptTo" value="${placeOfTakingDispatchOrReceiptTo}" class="textarea" rows="4" /></td>--%>
<%--	</tr>--%>
	
<%--	<tr>--%>
<%--		<td rowspan="2" valign="middle"><g:checkBox name="portOfLoadingOrDepartureSwitchDisplay" />--%>
<%--                  <g:hiddenField name="portOfLoadingOrDepartureSwitch" value="${portOfLoadingOrDepartureSwitch ?: 'off'}" /></td>--%>
<%--		<td rowspan="2" valign="middle"><span class="field_label">Port of Loading/<br/>Airport of Departure</span></td>--%>
<%--		<td><span class="right_indent">&#160;</span></td>--%>
<%--			<td>--%>
<%--		   <g:textArea name="portOfLoadingOrDepartureFrom" value="${portOfLoadingOrDepartureFrom ?: portOfLoadingOrDeparture}" class="textarea" readonly="readonly" rows="4" />--%>
<%--		</td>		--%>
<%--		<td rowspan="2" valign="middle"><span class="right_indent">To:</span></td>--%>
<%--		<td>--%>
<%--		   <g:textArea name="portOfLoadingOrDepartureTo" value="${portOfLoadingOrDepartureTo}" class="textarea" rows="4"/></td>--%>
<%--	</tr>--%>
	
<%--	<tr>		--%>
<%--		<td><span class="right_indent">&#160;</span></td>--%>
<%--		<td>--%>
<%--		   <g:textField name="bspCountryCodeFrom" value="${bspCountryCodeFrom ?: bspCountryCode}" class="input_field" readonly="readonly"/>--%>
<%--		</td>--%>
<%--		--%>
<%--		<td>--%>
<%--		   <input class="tags_country select2_dropdown bigdrop" name="bspCountryCodeTo" id="bspCountryCodeTo" />--%>
<%--		</td>--%>
<%--	</tr>	--%>

<%--	<tr>--%>
<%--		<td>--%>
<%--		  <g:checkBox name="portOfDischargeOrDestinationSwitchDisplay" />--%>
<%--                  <g:hiddenField name="portOfDischargeOrDestinationSwitch" value="${portOfDischargeOrDestinationSwitch ?: 'off'}" />--%>
<%--		</td>--%>
<%--		<td>--%>
<%--			<span class="field_label">Port of Discharge/<br/>Airport of Destination</span>--%>
<%--		</td>--%>
<%--		<td><span class="right_indent">&#160;</span></td>--%>
<%--		<td>--%>
<%--		  <g:textArea name="portOfDischargeOrDestinationFrom" value="${portOfDischargeOrDestinationFrom ?: portOfDischargeOrDestination}"  class="textarea" readonly="readonly" rows="4" />--%>
<%--		</td>		--%>
<%--		<td><span class="right_indent">To:</span></td>--%>
<%--		<td>--%>
<%--		  <g:textArea name="portOfDischargeOrDestinationTo" value="${portOfDischargeOrDestinationTo}" class="textarea" rows="4"  /></td>--%>
<%--	</tr>	--%>
	
<%--	<tr>--%>
<%--		<td>--%>
<%--		  <g:checkBox name="placeOfFinalDestinationSwitchDisplay" />--%>
<%--                  <g:hiddenField name="placeOfFinalDestinationSwitch" value="${placeOfFinalDestinationSwitch ?: 'off'}" />--%>
<%--		</td>--%>
<%--		<td><span class="field_label">Place of Final Destination/<br/>For Transportation to.../<br/>Place of Delivery</span></td>--%>
<%--		<td><span class="right_indent">&#160;</span></td>--%>
<%--		<td>--%>
<%--		  <g:textArea name="placeFinalDestinationFrom" value="${placeFinalDestinationFrom ?: placeOfFinalDestination}" class="textarea" readonly="readonly" rows="4" />--%>
<%--		</td>		--%>
<%--		<td><span class="right_indent">To:</span></td>--%>
<%--		<td>--%>
<%--		  <g:textArea name="placeOfFinalDestinationTo" value="${placeOfFinalDestinationTo}" class="textarea" rows="4" /></td>--%>
<%--	</tr>	--%>
	
	<tr>
		<td>
			<g:checkBox name="placeOfTakingDispatchOrReceiptSwitchDisplay" />
			<g:hiddenField name="placeOfTakingDispatchOrReceiptSwitch" value="${placeOfTakingDispatchOrReceiptSwitch ?: 'off'}" />
		</td>
        <td class="label_width"><p class="field_label">Place of Taking in Charge/Dispatch from.../Place of Receipt</p></td>
        <td/>
        <td><g:textArea name="placeOfTakingDispatchOrReceiptFrom" value="${placeOfTakingDispatchOrReceiptFrom ?: placeOfTakingDispatchOrReceipt}" class="textarea" rows="4" readonly="readonly"/></td>
    	<td><span class="right_indent">To: <span class="placeOfTakingDispatchOrReceiptToAsterisk">*</span></span></td>
        <td><g:textArea name="placeOfTakingDispatchOrReceiptTo" value="${placeOfTakingDispatchOrReceiptTo}" class="textarea" rows="4" readonly="readonly" maxlength="65"/></td>
    </tr>
     <tr>
    	
    </tr>
    <tr>
    	<td>
    		<g:checkBox name="portOfLoadingOrDepartureSwitchDisplay" />
			<g:hiddenField name="portOfLoadingOrDepartureSwitch" value="${portOfLoadingOrDepartureSwitch ?: 'off'}" />
		</td>
        <td class="label_width"><p class="field_label">Port of Loading/Airport of<br/>Departure</p></td>
        <td/>
        <td><g:textArea name="portOfLoadingOrDepartureFrom" value="${portOfLoadingOrDepartureFrom ?: portOfLoadingOrDeparture}" class="textarea" rows="4" readonly="readonly"/></td>
		<td><span class="right_indent">To: <span class="portOfLoadingOrDepartureTo">*</span></span></td>
		<td><g:textArea name="portOfLoadingOrDepartureTo" value="${portOfLoadingOrDepartureTo}" class="textarea" rows="4" readonly="readonly" maxlength="65"/></td>
    </tr>
	<tr>
    	<td class="label_width" colspan="2"><span class="field_label">BSP Country Code</span></td>
		<td/>
		<td><g:textField name="bspCountryCodeFrom" value="${bspCountryCodeFrom ?: bspCountryCode}" class="input_field" readonly="readonly"/></td>
		<td><span class="right_indent">To: <span class="bspCountryCodeToAsterisk clear_font">*</span></span></td>
        <td><input class="tags_country select2_dropdown bigdrop" name="bspCountryCodeTo" id="bspCountryCodeTo" /></td>
	</tr>
    <tr>
    	<td>
			<g:checkBox name="portOfDischargeOrDestinationSwitchDisplay" />
			<g:hiddenField name="portOfDischargeOrDestinationSwitch" value="${portOfDischargeOrDestinationSwitch ?: 'off'}" />
		</td>
        <td class="label_width"><p class="field_label">Port of Discharge/Airport<br/>of Destination</p></td>
		<td/>
        <td><g:textArea name="portOfDischargeOrDestinationFrom" value="${portOfDischargeOrDestinationFrom ?: portOfDischargeOrDestination}" class="textarea" rows="4" readonly="readonly"/></td>
    	<td><span class="right_indent">To: <span class="portOfDischargeOrDestinationToAsterisk">*</span></span></td>
        <td><g:textArea name="portOfDischargeOrDestinationTo" value="${portOfDischargeOrDestinationTo}" class="textarea" rows="4" readonly="readonly" maxlength="65"/></td>
    </tr>
    <tr>
    	<td>
			<g:checkBox name="placeOfFinalDestinationSwitchDisplay" />
			<g:hiddenField name="placeOfFinalDestinationSwitch" value="${placeOfFinalDestinationSwitch ?: 'off'}" />
		</td>
        <td class="label_width"><p class="field_label">Place of Final Destination/For Transportation to.../<br/>Place of Delivery</p></td>
		<td/>
        <td><g:textArea name="placeFinalDestinationFrom" value="${placeFinalDestinationFrom ?: placeOfFinalDestination}" class="textarea" rows="4" readonly="readonly"/></td>
		<td><span class="right_indent">To: <span class="placeOfFinalDestinationToAsterisk">*</span></span></td>
        <td><g:textArea name="placeOfFinalDestinationTo" value="${placeOfFinalDestinationTo}" class="textarea" readonly="readonly" rows="4" maxlength="65"/></td>
    </tr>
</table>
<br/>
<br/>
</g:if>
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:if test="${serviceType == 'Amendment' }">
<g:render template="../commons/popups/tenor_of_drafts_popup" />
</g:if>
<g:render template="../commons/popups/view_related_lc_popup" />
<g:render template="../commons/popups/exporter_cb_code_popup" />
<g:render template="../commons/popups/additional_amounts_covered_popup" />
<g:render template="../commons/popups/deferred_payment_details_popup" />
<g:render template="../commons/popups/mixed_payment_details_popup" />

<script>
    $(document).ready(function() {
        var confirmationInstructionsFlag = '${confirmationInstructionsFlag}';
        $("#countryCodeTo").setBankDropdown($(this).attr("id")).select2('data',{id: 'ANY BANK'});
        //$("#countryCodeTo").removeAttr("disabled");
        //$("#countryCodeTo").removeAttr("readonly");
        if (confirmationInstructionsFlag == "N" || confirmationInstructionsFlag == "M") {

            if(!$("#exporterName").val()) {
                $("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: 'ANY BANK'});
                $("#availableWithTo").setBankDropdown($(this).attr("id")).select2('data',{id: 'ANY BANK'});
            } else {
                $("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWith}'});
                $("#availableWithTo").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWithTo}'});
            }

            $("#availableWith").change(function(){
                if($("input[name=availableWithFlag]:checked").val() == 'D'){
            		$("#nameAndAddress").val($(this).select2('data').label);
                }
            });

            if(confirmationInstructionsFlag == "N") {
                $("#drawee").val("${grailsApplication.config.tfs.constants.sender.address}");
                $("input[name=availableWithFlag]").removeAttr("disable");
            }
        } else {
            $("#availableWithTo").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWithTo}'});

            $("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${destinationBank ?: availableWith}'});
            $("#availableWith").select2("disable");
            if('${availableWith ?: destinationBank}'){
                $.post(autoCompleteBankUrl, {starts_with: '${availableWith ?: destinationBank}'}, function(data){
                	$("#nameAndAddress").val(data.results[0].label);
                });
            }
            $("#drawee").val(($("#availableWith").val().length > 0) ? $("#availableWith").select2('data').id : "");

            if($("#draweeFrom").length > 0) {
                $("#draweeFrom").val($("#availableWith").select2('data').label)
            }
        }

        $("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
        $("#bspCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCode}'});
        $("#bspCountryCodeTo").setCountryDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCodeTo}'});

        $("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
        $("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});

        $("#exporterCbCodeTo").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCodeTo}'});

        $("#importerCbCode").on("change", function(e) {
           $("#importerName").val($("#importerCbCode").select2('data').label)
           $("#importerAddress").val($("#importerCbCode").select2('data').address)

           $("#importerCifNumber").val($("importerCbCode").select2('data').cifNumber);
           onImporterCbCodeCheck();
           if($("#importerNameFrom").length > 0) {
               $("#importerNameFrom").val($("#importerCbCode").select2('data').label)
           }

           if($("#importerAddressFrom").length > 0) {
               $("#importerAddressFrom").val($("#importerCbCode").select2('data').label)
           }
        });
        onImporterCbCodeCheck();
        $("#exporterCbCode").on("change", function(e) {
            $("#exporterName").val($("#exporterCbCode").select2('data').label)
            $("#exporterAddress").val($("#exporterCbCode").select2('data').address)
        });

        $("#exporterCbCodeTo").on("change", function(e) {
            $("#exporterNameTo").val($("#exporterCbCodeTo").select2('data').label)
            $("#exporterAddressTo").val($("#exporterCbCodeTo").select2('data').address)
        });
    });

    function onImporterCbCodeCheck(){
        if($("#importerCifNumber").length > 0){
	    	if($("#importerCbCode").val()){
	     	   $("#importerCifNumber").toggleClass("required", false);
	        } else {
	     	   $("#importerCifNumber").toggleClass("required", true);
	        }
        }
    }
    var availableWith = '${availableWith}';
</script>
