<%--
(revision)
	SCR/ER Number: SCR# IBD-15-1125-01
	SCR/ER Description: Added Fields for Buyer and Seller Info 
	[Revised by:] Jonh Henry Santos Alabin
	[Date revised:] 1/12/2017
	Member Type: Groovy Server Pages
	Project: WEB
	Project Name: _nature_amendments_tab.gsp
--%>

<g:javascript src="utilities/ets/commons/nature_of_amendment_utility.js" />
<script type="text/javascript">
    var sessionUserRole = '${session['userrole']['id']}';
    var documentNumber = $("#amountTo").val();

</script>
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="natureOfAmendment" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>
<g:hiddenField name="currency" value="${currency}"/>
<g:hiddenField name="processingDate" value="${etsDate}"/>
<%--added by henry --%>
<g:hiddenField name="applicantName" value="${applicantName}" />
<g:hiddenField name="applicantAddress" value="${applicantAddress}" />
<g:hiddenField name="beneficiaryName" value="${beneficiaryName}" />
<g:hiddenField name="beneficiaryAddress" value="${beneficiaryAddress}" />
<g:hiddenField name="importerName" value="${importerName}" />
<g:hiddenField name="importerAddress" value="${importerAddress}" />
<g:hiddenField name="exporterName" value="${exporterName}" />
<g:hiddenField name="exporterAddress" value="${exporterAddress}" />
<table class="tabs_forms_table">
	<tr>
        <td>
                <span class="field_label"><label for="amountSwitchDisplay">
                    <g:checkBox name="amountSwitchDisplay" />&#160;LC Amount</label>
                    <g:hiddenField name="amountSwitch" value="${amountSwitch ?: 'off'}" />
                </span>
        </td>
		<td>
                <g:if test="${'CLOSED'.equals(productStatus)}">
			        <g:radioGroup name="lcAmountFlagDisplay" labels="['Increase']" value="${lcAmountFlag}" values="['INC']" disabled="disabled">
	    			    <label>${it.radio} ${it.label} &#160;&#160;</label>
    			    </g:radioGroup>
                </g:if>
                <g:else>
                    <g:radioGroup name="lcAmountFlagDisplay" labels="['Increase', 'Decrease']" value="${lcAmountFlag}" values="['INC','DEC']" disabled="disabled">
                        <label>${it.radio} ${it.label} &#160;&#160;</label>
                    </g:radioGroup>
                </g:else>
                <g:hiddenField name="lcAmountFlag" value="${lcAmountFlag}" />
        </td>
	</tr>
	<tr>
		<td>
                <span class="right_indent"> &#160;</span>
        </td>
		<td>
<%--            <g:textField name="outstandingBalance" value="${outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly"/>--%>
            <g:textField name="amountFrom" value="${productAmount ?: amount}" class="input_field_right numericCurrency" readonly="readonly"/>
        </td>
		<td><span class="right_indent">To :&#160;</span></td>
		<td>
            <g:textField name="amountTo" id="amountTo" class="input_field_right numericCurrency" readonly="readonly" value="${amountTo}"/>
            %{--<g:textField name="amountTo2" id="amountTo2" class="input_field_right numericCurrency" readonly="readonly" value="${amountTo}"/>--}%
            <g:if test="${documentSubType1?.equalsIgnoreCase("CASH")}">
                <g:hiddenField name="cashAmount" value="${cashAmount}" />
            </g:if>
        </td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span>Outstanding Amount:</span></td>
		<td>&#160;</td>
		<td><g:textField name="originalAmount" value="${outstandingBalance}" class="input_field_right numericCurrency" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<tr>
        <td>
                <span class="field_label"><label for="expiryDateSwitchDisplay">
                    <g:checkBox name="expiryDateSwitchDisplay" />&#160;Expiry Date</label>
                    <g:hiddenField name="expiryDateSwitch" value="${expiryDateSwitch ?: 'off'}" />
                </span>
        </td>
		<td>
                <g:radioGroup name="expiryDateFlagDisplay" labels="['Extend', 'Reduce']" value="${expiryDateFlag}" values="['EXT','RED']" disabled="disabled">
                    ${it.radio} ${it.label} &#160;&#160;&#160;&#160;&#160;
                </g:radioGroup>
                <g:hiddenField name="expiryDateFlag" value="${expiryDateFlag}" />
		</td>
	</tr>
	<tr>
		<td>
                <span class="right_indent">&#160;</span>
        </td>
		<td><g:hiddenField name="expiryDate" value="${originalExpiryDate ?: expiryDate}" /><g:textField name="originalExpiryDate" class="input_field" value="${originalExpiryDate ?: expiryDate}" readonly="readonly"/></td>
		<td><span class="right_indent">To :&#160;</span></td>
		<td><g:textField name="expiryDateTo" class="datepicker_field" value="${expiryDateTo}"/></td>
	</tr>
	<tr>
		<td>&#160;</td>
		<td><span>Number of Days Extended/Reduced :</span></td>
		<td>&#160;</td>
		<td><g:textField name="expiryDateModifiedDays" value="${expiryDateModifiedDays}" class="input_field" readonly="readonly"/></td>
	</tr>
	<tr><td>&#160;</td></tr>
	<g:if test="${ documentSubType1 == 'REGULAR'}">
	<tr>
		<td>
            <label for="tenorSwitchDisplay">
<%--            	<g:if test="${tenor.equalsIgnoreCase('SIGHT')}">--%>
                    <g:checkBox name="tenorSwitchDisplay" />
<%--                </g:if>--%>
<%--                <g:else>--%>
<%--                    <g:checkBox name="tenorSwitchDisplay" disabled="true"/>--%>
<%--                </g:else>--%>
                &#160;Change in Tenor</label><span class="right_indent">&#160;
                <g:hiddenField name="tenorSwitch" value="${tenorSwitch ?: 'off'}" />
            </span>
        </td>
		<td><g:textField name="originalTenor" class="input_field" readonly="readonly" value="${originalTenor ?: tenor}" /></td>
		<td><span class="right_indent">To :&#160;</span></td>
		<td>
            <g:textField name="tenorTo" class="input_field" readonly="readonly" value="${tenorTo}"/>
        </td>
	</tr>
    <tr>
        <td>
            &#160;
        </td>
        <td>
            <span class="right_indent">Tenor of Draft (usance period):</span>
        </td>
        <td>
            &#160;
        </td>
        <td>
            <g:textField maxlength="19" class="input_field_short numericWholeQuantity" name="usancePeriodTo" readonly="readonly" value="${usancePeriodTo ?: usancePeriod}"/> DAYS
        </td>
    </tr>
	<tr>
		<td>
            &#160;
        </td>
		<td>
            <span class="right_indent">Tenor of Draft (narrative):</span>
        </td>
		<td>&#160;</td>
		<td>
            <g:textArea maxlength="105" class="textarea" name="tenorOfDraftNarrativeTo" readonly="readonly" value="${tenorOfDraftNarrativeTo ?: tenorOfDraftNarrative}" maxlength="105"/>
        </td>
	</tr>
	<tr><td>&#160;</td></tr>
	</g:if>
	<g:if test="${ documentType == 'FOREIGN'}">
	<tr>
		<td><span class="field_label">
            <label for="confirmationInstructionsFlagSwitchDisplay">
                <g:checkBox name="confirmationInstructionsFlagSwitchDisplay"/>&#160;Change in Confirmation
                <g:hiddenField name="confirmationInstructionsFlagSwitch" value="${confirmationInstructionsFlagSwitch ?: 'off'}" />
            </label></span><span class="right">&#160;</span>
        </td>
		<td><g:textField name="originalConfirmationInstructionsFlag" value="${(confirmationInstructionsFlag == 'N' ||confirmationInstructionsFlag == 'NO' ) ? 'NO' : (confirmationInstructionsFlag == 'Y'||confirmationInstructionsFlag == 'YES') ? 'YES' : 'MAY ADD'}" class="input_field" readonly="readonly" /></td>
		<td><span class="right_indent">To :&#160;</span></td>
		<td>
            <g:select name="confirmationInstructionsFlagTo" from="${['YES', 'NO', 'MAY ADD']}" values="['Y','N','M']" noSelection="${['':'SELECT ONE...']}" class="select_dropdown" disabled="true" value="${confirmationInstructionsFlagTo}"/>
        </td>
	</tr>
	<tr><td>&#160;</td></tr>
	</g:if>
	<tr>
		<td><span class="field_label"><label for="narrativeSwitchDisplay">
            <g:checkBox name="narrativeSwitchDisplay"/></label>Narrative</span>
            <g:hiddenField name="narrativeSwitch" value="${narrativeSwitch ?: 'off'}" />
        </td>
		<td colspan="5" id="amendment_narrative_td">
<%--		<g:textArea name="narrative" value="${narrative}" class="textarea_long full_width" readonly="readonly"/>--%>
			<div><g:textArea name="narrative" class="amendment_narrative" value="${narrative}" style="text-transform: uppercase;" readonly="readonly" maxlength="1750"/></div>
		</td>
	</tr>
	<%--added by henry --%>
	<%--Buyer Info --%>
	<g:if test="${documentType == 'DOMESTIC' && documentSubType1 == 'STANDBY' && documentClass == 'LC' }">
     	<tr>
			<td class="valign_top">
				<g:checkBox name="applicantNameSwitchDisplay" value="${applicantNameSwitchDisplay}"/>
				<g:hiddenField name="applicantNameSwitch" value="${applicantNameSwitch ?: 'off'}" />
				<label class="field_label" for="applicantNameSwitchDisplay">Buyer Name</label>
			</td>
			<td><g:textArea name="applicantName" value="${applicantName}" class="textarea" readonly="readonly" rows="2"/></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="applicantNameToAsterisk">*</span></span></td>
			<td><g:textArea name="applicantNameTo" value="${applicantNameTo}" class="textarea" readonly="readonly" rows="2" maxlength="60"/></td>			
		</tr>
		<tr>
			<td class="valign_top">
				<g:checkBox name="applicantAddressSwitchDisplay" value="${applicantAddressSwitchDisplay}"/>
				<g:hiddenField name="applicantAddressSwitch" value="${applicantAddressSwitch ?: 'off'}" />
				<label class="field_label" for="applicantAddressSwitchDisplay">Buyer Address</label>
			</td>
			<td><g:textArea name="applicantAddress" value="${applicantAddress}" class="textarea" readonly="readonly" rows="4" /></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="applicantAddressToAsterisk">*</span></span></td>
			<td><g:textArea name="applicantAddressTo" value="${applicantAddressTo}" class="textarea" readonly="readonly" rows="4" maxlength="160"/></td>	
		</tr>
		
		<tr>
			<td class="valign_top">
				<g:checkBox name="beneficiaryNameSwitchDisplay" value="${beneficiaryNameSwitchDisplay}"/>
				<g:hiddenField name="beneficiaryNameSwitch" value="${beneficiaryNameSwitch ?: 'off'}" />
				<label class="field_label" for="beneficiaryNameSwitchDisplay">Seller Name</label>
			</td>
			<td><g:textArea name="beneficiaryName" value="${beneficiaryName}" class="textarea" readonly="readonly" rows="2"/></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="beneficiaryNameToAsterisk">*</span></span></td>
			<td><g:textArea name="beneficiaryNameTo" value="${beneficiaryNameTo}" class="textarea" readonly="readonly" rows="2" maxlength="60"/></td>			
		</tr>
		<tr>
			<td class="valign_top">
				<g:checkBox name="beneficiaryAddressSwitchDisplay" value="${beneficiaryAddressSwitchDisplay}"/>
				<g:hiddenField name="beneficiaryAddressSwitch" value="${beneficiaryAddressSwitch ?: 'off'}" />
				<label class="field_label" for="beneficiaryAddressSwitchDisplay">Seller Address</label>
				
			</td>
			<td><g:textArea name="beneficiaryAddress" value="${beneficiaryAddress}" class="textarea" readonly="readonly" rows="4" /></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="beneficiaryAddressToAsterisk">*</span></span></td>
			<td><g:textArea name="beneficiaryAddressTo" value="${beneficiaryAddressTo}" class="textarea" readonly="readonly" rows="4" maxlength="160"/></td>	
		</tr>
	</g:if>
	
	<g:elseif test="${documentType == 'FOREIGN' && documentSubType1 == 'STANDBY' && documentClass == 'LC' }">
		<tr>
			<td class="valign_top">
				<g:checkBox name="importerNameSwitchDisplay" value="${importerNameSwitchDisplay}"/>
				<g:hiddenField name="importerNameSwitch" value="${importerNameSwitch ?: 'off'}" />
				<label class="field_label" for="importerNameSwitchDisplay">Importer Name</label>
			</td>
			<td><g:textArea name="importerName" value="${importerName}" class="textarea" readonly="readonly" rows="2"/></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="importerNameToAsterisk">*</span></span></td>
			<td><g:textArea name="importerNameTo" value="${importerNameTo}" class="textarea" readonly="readonly" rows="2" maxlength="60"/></td>			
		</tr>
		<tr>
			<td class="valign_top">
				<g:checkBox name="importerAddressSwitchDisplay" value="${importerAddressSwitchDisplay}"/>
				<g:hiddenField name="importerAddressSwitch" value="${importerAddressSwitch ?: 'off'}" />
				<label class="field_label" for="importerAddressSwitchDisplay">Importer Address</label>
			</td>
			<td><g:textArea name="importerAddress" value="${importerAddress}" class="textarea" readonly="readonly" rows="4" /></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="importerAddressToAsterisk">*</span></span></td>
			<td><g:textArea name="importerAddressTo" value="${importerAddressTo}" class="textarea" readonly="readonly" rows="4" maxlength="160"/></td>	
		</tr>
		
		<tr>
			<td class="valign_top">
				<g:checkBox name="exporterNameSwitchDisplay" value="${exporterNameSwitchDisplay}"/>
				<g:hiddenField name="exporterNameSwitch" value="${exporterNameSwitch ?: 'off'}" />
				<label class="field_label" for="exporterNameSwitchDisplay">Exporter Name</label>
			</td>
			<td><g:textArea name="exporterName" value="${exporterName}" class="textarea" readonly="readonly" rows="2"/></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="exporterNameToAsterisk">*</span></span></td>
			<td><g:textArea name="exporterNameTo" value="${exporterNameTo}" class="textarea" readonly="readonly" rows="2" maxlength="60"/></td>			
		</tr>
		<tr>
			<td class="valign_top">
				<g:checkBox name="exporterAddressSwitchDisplay" value="${exporterAddressSwitchDisplay}"/>
				<g:hiddenField name="exporterAddressSwitch" value="${exporterAddressSwitch ?: 'off'}" />
				<label class="field_label" for="exporterAddressSwitchDisplay">Exporter Address</label>
				
			</td>
			<td><g:textArea name="exporterAddress" value="${exporterAddress}" class="textarea" readonly="readonly" rows="4" /></td>
			<td class="valign_top"><span class="field_label right_indent">To:<span class="exporterAddressToAsterisk">*</span></span></td>
			<td><g:textArea name="exporterAddressTo" value="${exporterAddressTo}" class="textarea" readonly="readonly" rows="4" maxlength="160"/></td>	
		</tr>
	
	<%-- End of Buyer and Seller INFO --%>
	<tr><td>&#160;</td></tr>
	<tr>
		<td />
		<td colspan="2"><span class="field_label">Collect Advance Corres<br />Charges from Applicant</span></td>
		<td>
			<g:radioGroup name="advanceCorresChargesFlag" labels="['Yes', 'No']" value="${advanceCorresChargesFlag}" values="['Y', 'N']">
				<label>${it.radio} ${it.label}</label> &#160;&#160;
			</g:radioGroup>
		</td>
	</tr>
	</g:elseif>
</table>
<br /><br />
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
    $(document).ready(function() {
        %{--$("#advisingBank").select2('data',{id: '${advisingBank}'});--}%
        $("#advisingBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${advisingBank}'});

        $("#narrative").limitCharAndLines(35, 50);
    });
</script>