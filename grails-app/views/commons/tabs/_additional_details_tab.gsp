<%--
(revision)
	SCR/ER Number: SCR# IBD-15-1125-01
	SCR/ER Description: Added Fields for Buyer Info 
	[Revised by:] Jonh Henry Santos Alabin
	[Date revised:] 1/12/2017
	Member Type: Groovy Server Pages
	Project: WEB
	Project Name: _additional_details_tab.gsp
--%>
<%@ page import="net.ipc.utils.NumberUtils" %>
<g:javascript src="utilities/dataentry/commons/display_amendment_tabs.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="additionalDetails" />

<g:hiddenField name="etsNumber" value="${serviceInstructionId ?: etsNumber}"/>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="documentNumber" value="${documentNumber}"/>


<%-- For Other serviceType --%>
<%-- <g:if test="${serviceType != 'Amendment' }"> --%>
<g:if test="${ serviceType == 'Opening' }">
<table>
	<tr>
		<td class="label_width"><span class="field_label"> By... </span></td>						
		<td class="input_width"><g:select class="select_dropdown" value="${availableBy}" name="availableBy" noSelection="[ '':'SELECT ONE...']" from="${['BY ACCEPTANCE','BY NEGOTIATION','BY PAYMENT']}" keys="${['A','N','P']}" /></td>
	</tr>
	<tr>					
		<td><span class="field_label"> Tenor </span></td>
		<td><g:textField class="input_field" name="tenor" readonly="readonly" value="${tenor}"/></td>
	</tr>
	<tr>
		<td><p class="field_label"> If Usance: Tenor of Draft<br />(usance period) </p></td>
		<td><g:textField class="right input_field_short numericWholeQuantity" name="usancePeriod" value="${usancePeriod}" readonly="readonly"/> DAYS </td>
		<td rowspan="2" valign="top">Tenor of Draft<br/>(narrative)</td>
		<td rowspan="2"><g:textArea class="textarea" name="tenorOfDraftNarrative" value="${tenorOfDraftNarrative}" rows="4" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> If Sight: Tenor of Draft </span></td>					
		<td><g:textField class="input_field" name="tenorOfDraft" value="DRAFT AT SIGHT" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Partial Delivery <span class="asterisk">* </span></span></td>
		<td>
            <%--<g:radio name="partialDelivery" value="Allowed" /> <label for="partialDelivery">Allowed</label>--%>
			<%--<g:radio name="partialDelivery" value="Not Allowed" /> <label for="partialDelivery">Not Allowed</label>--%>
            <g:radioGroup class="required" values="${['ALLOWED', 'NOT_ALLOWED']}" labels="${['Allowed', 'Not Allowed']}" name="partialDelivery" id="partialDelivery" value="${partialDelivery}">
                <label>${it.radio}&#160;${it.label}</label>
            </g:radioGroup>
        </td>
	</tr>
	<tr>
		<td><p class="field_label"> Place of taking in charge/<br />Dispatch from/Place of Receipt </p></td>
		<td colspan="4"><g:textArea class="input_field_auto" name="placeOfReceipt" value="${placeOfReceipt}" /></td>
	</tr>
	<tr>
		<td><p class="field_label"> Place of final destination/For<br />transportation to/Place of Delivery </p></td>
		<td colspan="4"><g:textArea class="input_field_auto" name="placeOfDelivery" value="${placeOfDelivery}" /></td>
	</tr>
</table>
</g:if>

<%-- For Amendment Only --%>
<g:if test="${serviceType == 'Amendment' }">
	<table class="tabs_forms_table">
        <g:if test="${!tsdInitiated}">
			<tr>
				<td class="label_width">
					<g:checkBox name="expiryDateSwitchDisplay" disabled="${!tsdInitiated}"/>
					<g:hiddenField name="expiryDateSwitch" value="${expiryDateSwitch ?: 'off'}" />
					<label class="field_label" class="field_label" for="expiryDateSwitchDisplay">DMLC Expiry Date</label>
				</td>
				<td class="input_width"><g:textField name="expiryDate" value="${expiryDate}" class="input_field" readonly="readonly" /></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:textField name="expiryDateTo" value="${expiryDateTo}" class="input_field" readonly="readonly" /></td>
			</tr>
			<tr>
				<td>
					<g:if test="${(session.dataEntryModel.tsdInitiated == null || session.dataEntryModel.tsdInitiated == undefined) || session.dataEntryModel.tsdInitiated == false || session.dataEntryModel.tsdInitiated == ""}">
						<g:checkBox name="amountSwitchDisplay" disabled="true"/>
					</g:if>
					<g:else>
						<g:checkBox name="amountSwitchDisplay" />
					</g:else>
	
					<g:hiddenField name="amountSwitch" value="${amountSwitch ?: 'off'}" />
					<label class="field_label" for="amountSwitchDisplay">DMLC Amount</label>
				</td>
				<td><g:textField name="amountFrom" value="${amountFrom ?: NumberUtils.currencyFormat(new Double(outstandingBalance))}" class="input_field_right" readonly="readonly" /></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:textField name="amountTo" value="${amountTo ? NumberUtils.currencyFormat(new Double(amountTo)) : amountTo}" class="input_field_right ${tsdInitiated ? "numericCurrency" : ""}" readonly="readonly" /></td>
			</tr>
			<tr>
				<td colspan="2"/>
				<td><span class="field_label">Original LC Amount</span></td>
				<td><g:textField name="originalAmount" value="${originalAmount ?: amount}" class="input_field_right numericCurrency" readonly="readonly"/></td>
			</tr>
        </g:if>
		<g:if test="${!documentSubType1?.equalsIgnoreCase('Standby')}">
			<tr>
				<td class="label_width">
					<g:checkBox name="availableBySwitchDisplay" value="${availableBySwitchDisplay}"/>
					<g:hiddenField name="availableBySwitch" value="${availableBySwitch ?: 'off'}" />
					<label class="field_label" for="availableBySwitchDisplay">By...</label>
				</td>
				<td><g:textField name="availableBy" value="${availableBy.equals("A") ? "BY ACCEPTANCE" :
	                                                         availableBy.equals("D") ? "BY DEFAULT PAYMENT" :
	                                                         availableBy.equals("M") ? "BY MIXED PAYMENT" :
	                                                         availableBy.equals("N") ? "BY NEGOTIATION" :
	                                                         availableBy.equals("P") ? "BY PAYMENT" : availableBy}" class="input_field" readonly="readonly"/></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:select name="availableByTo" value="${availableByTo}" from="${['BY ACCEPTANCE', 'BY NEGOTIATION', 'BY PAYMENT']}" keys="${['A', 'N', 'P']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" disabled="true"/></td>
			</tr>
			<tr>
				<td class="label_width">
					<g:checkBox name="partialDeliverySwitchDisplay" value="${partialDeliverySwitchDisplay}"/>
                    %{--<g:checkBox name="partialDeliverySwitchDisplay" checked="${'on'.equals(partialDeliverySwitch) ? }" />--}%
					<g:hiddenField name="partialDeliverySwitch" value="${partialDeliverySwitch ?: 'off'}" />
					<label class="field_label" for="partialDeliverySwitchDisplay">Partial Delivery</label>
				</td>
				<td><g:textField name="partialDelivery" value="${partialDelivery}" class="input_field" readonly="readonly" /></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:select name="partialDeliveryTo" value="${partialDeliveryTo}" from="${['ALLOWED', 'NOT ALLOWED']}" keys="${['ALLOWED','NOT_ALLOWED']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" disabled="true"/></td><%-- the value attr made this select field multiselect --%>
			</tr>
			</g:if>
			<tr>
				<td>
					%{--<g:checkBox name="tenorSwitchDisplay" disabled="true"/>--}%
                    <g:checkBox name="tenorSwitchDisplay" disabled="true"/>
                    <g:hiddenField name="tenorSwitch" value="${tenorSwitch ?: 'off'}" />
					<span class="field_label">Change in Tenor :</span>
				</td>
				<td><g:textField name="originalTenor" value="${originalTenor ?: tenor}" class="input_field" readonly="readonly" /></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:textField name="tenorTo" class="input_field" readonly="readonly" value="${tenorTo}"/></td>		
			</tr>
			<tr>
				<td>%{--<span class="field_label">Usance Period :</span>--}% &nbsp;</td>
				<td>%{--<g:textField name="tenorOfDraft" value="${tenorOfDraftNarrativeTo ?: tenorOfDraft}" class="input_field" readonly="readonly"/>--}% &nbsp;</td>
                <td><span class="field_label">Usance Period :</span></td>
                <td><g:textField name="usancePeriodTo " value="${usancePeriodTo}" class="input_field numericWholeQuantity" readonly="readonly"/></td>
			</tr>
			<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			<tr><td>&#160;</td></tr>
			<tr>
				<td>
					<g:checkBox name="confirmationInstructionsFlagSwitchDisplay" value="${confirmationInstructionsFlagSwitchDisplay}" disabled="true"/>
                    <g:hiddenField name="confirmationInstructionsFlagSwitch" value="${confirmationInstructionsFlagSwitch ?: 'off'}" />
					<span class="field_label">Confirmation Instruction</span>
					<span class="field_label right_indent">&#160;</span>
				</td>
				<td><g:textField name="confirmationInstruction" value="${confirmationInstructionTo ?: confirmationInstruction}" class="input_field" readonly="readonly" /></td>
				<td><span class="field_label right_indent">To:</span></td>
				<td><g:textField name="confirmationInstructionTo" value="${confirmationInstructionTo}" class="input_field" readonly="readonly" /></td>
			</tr>
		</g:if>
		<tr><td>&#160;</td></tr>
		<%--Added by Henry Buyer Info --%>
		<g:if test="${ documentType == 'DOMESTIC' && documentSubType1 == 'STANDBY' && documentClass == 'LC' }">
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
		
		</g:if>
		<%--Added by Henry Buyer Info --%>
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
		</table>
</g:if>
<br />
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:if test="${tsdInitiated}">
<script type="text/javascript">
	var tsdInitiated = '${tsdInitiated}'
	$(function(){
		$("#amountTo").focus(function(){
			if($(this).attr("readonly") == "readonly"){
				$(this).blur();
			}
		});
	});
</script>
</g:if>