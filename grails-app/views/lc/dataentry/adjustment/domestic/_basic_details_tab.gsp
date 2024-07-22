<g:javascript src="utilities/dataentry/adjustment/basic_details_utility.js"/>
<%@ page import="net.ipc.utils.DateUtils" %>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />
<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />
<g:hiddenField name="longNameTo" value="${longNameTo}" />
<g:hiddenField name="address1To" value="${address1To}" />
<g:hiddenField name="address2To" value="${address2To}" />
<g:hiddenField name="productAmount" value="${productAmount}"/>
<g:hiddenField name="expiryDate" value="${expiryDate}" />
<g:hiddenField name="standbyTaggingAdjustment" value="NO" />
<g:hiddenField name="standbyTaggingOriginalValue" value="${originalStandbyTagging}" />
<g:hiddenField name="standbyTaggingTo" value="${standbyTagging}" />

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
<g:hiddenField name="amlaCasaFlagFxCurrency" value="${amlaCasaFlagFxCurrency}"/>
<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>

<g:each in="${exchange}" var="temp" status="i">
    <g:if test="${temp.rate_description.contains('BOOKING')}">
        %{--<g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>--}%
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>
<g:each in="${urrrates}" var="temp" status="i">
    <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
</g:each>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width" colspan="2">
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label">Transaction Number</span>
            </g:if>
            <g:else>
                <span class="field_label">eTS Number</span>
            </g:else>

        </td>
		<td class="input_width" colspan="2"><g:textField name="etsNumber" class="input_field" readonly="readonly" value="${tradeServiceReferenceNumber ?: serviceInstructionId}"/></td>
		<td colspan="2">
            <g:if test="${(session.dataEntryModel.tsdInitiated != null || session.dataEntryModel.tsdInitiated != undefined) || session.dataEntryModel.tsdInitiated == true}">
                <span class="field_label"> Transaction Date </span>
            </g:if>
            <g:else>
                <span class="field_label"> eTS Date </span>
            </g:else>
        </td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label"> DMLC Issue Date </span></td>
		<td class="input_width" colspan="2"><g:textField name="issueDate" class="input_field" value="${issueDate}" readonly="readonly"/></td>
		<td class="label_width" colspan="2"><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td colspan="2"><span class="field_label">Processing Unit Code</span></td>
		<td colspan="2"><g:textField name="processingUnitCode" class="input_field" value="${processingUnitCode}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td><span class="field_label">CIF Number</span></td>
		<td><g:if test="${!tsdInitiated}"><span class="field_label">From:</span></g:if></td>
		<td><g:textField id="cifNumberFrom" name="cifNumberFrom" class="input_field" readonly="readonly" value="${cifNumberFrom ?: cifNumber}"/>
			<g:hiddenField name="accountOfficerTo" value="${accountOfficerTo}"/>
            <g:hiddenField name="ccbdBranchUnitCodeTo" value="${ccbdBranchUnitCodeTo}"/>
            <g:hiddenField name="allocationUnitCodeTo" value="${allocationUnitCodeTo}"/>
            <g:hiddenField name="officerCodeTo" value="${officerCodeTo}"/>
            <g:hiddenField name="exceptionCodeTo" value="${exceptionCodeTo}"/></td>
		<g:if test="${!tsdInitiated}">
		<td colspan="3"><span class="field_label right_indent">To:</span></td>
		<td><g:textField id="cifNumberTo" name="cifNumberTo" class="input_field" readonly="readonly" value="${cifNumberTo}"/></td>
		</g:if>
	</tr>
	<tr>
		<td colspan="2"><span class="field_label">CIF Name</span></td>
		<td><g:textField name="${tsdInitiated ? 'cifName': 'cifNameTo'}" value="${tsdInitiated ? cifName: (cifNameTo ?: cifName)}" class="input_field" readonly="readonly"/></td>
	</tr>
	<g:if test="${!documentSubType1?.equalsIgnoreCase('CASH')}">
		<tr>
			<td><span class="field_label">Main CIF Number</span></td>
			<td><g:if test="${!tsdInitiated}"><span class="field_label">From:</span></g:if></td>
			<td><g:textField name="mainCifNumberFrom" class="input_field" readonly="readonly" value="${mainCifNumberFrom ?: mainCifNumber}"/></td>
			<g:if test="${!tsdInitiated}">
			<td colspan="3"><span class="field_label right_indent">To:</span></td>
			<td><g:textField name="mainCifNumberTo" class="input_field textFormat-7" readonly="readonly" value="${mainCifNumberTo}"/></td>
			</g:if>
		</tr>
		<tr>
			<td><span class="field_label">Main CIF Name</span></td>
			<td><span class="field_label">From:</span></td>
			<td><g:textField name="mainCifNameFrom" value="${mainCifNameFrom ?: mainCifName}" class="input_field textFormat-20" type="text" readonly="readonly"/></td>
			<td colspan="3"><span class="field_label right_indent">To:</span></td>
			<td><g:textField name="mainCifNameTo" value="${mainCifNameTo}" class="input_field textFormat-20" type="text" readonly="readonly"/></td>
		</tr>
	</g:if>
	<g:if test="${documentSubType1 == 'REGULAR'}">
		<tr>
			<td><span class="field_label">Partial Cash Settlement</span></td>
			<td>
				<%-- <g:checkBox name="partialCashSettlementAmountCheckBox"/>--%>
				<span class="right_indent">
					<g:checkBox name="partialCashSettlementFlagBox" checked="${partialCashSettlementFlag.equals("partialCashSettlementEnabled") ? true : false}"/>
					<g:hiddenField name="partialCashSettlementFlag" value="${partialCashSettlementFlag}" />
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2"><span class="field_label single_indent">Cash LC Amount</span></td>
			<td><g:textField name="cashAmount" class="input_field_right numericCurrency" readonly="readonly" value="${cashAmount}"/></td>
		</tr>
	</g:if>
	<g:if test="${documentSubType1 != 'CASH'}">
	<tr>
		<td><span class="field_label">Facility ID</span></td>
		<td><g:if test="${!tsdInitiated}"><span class="field_label">From:</span></g:if></td>
		<td><g:textField name="facilityIdFrom" class="input_field" value="${facilityIdFrom ?: facilityId}" readonly="readonly" /></td>
		<g:if test="${!tsdInitiated}">
		<td colspan="3"><span class="field_label right_indent">To:</span></td>
		<td><g:textField name="facilityIdTo" class="input_field" value="${facilityIdTo}" readonly="readonly"/></td>
		</g:if>
	</tr>
	</g:if>
	<tr>
		<td colspan="2"><span class="field_label">DMLC Currency</span></td>
		<td colspan="2"><g:textField name="currency" class="input_field" value="${currency}" readonly="readonly"/></td>
		<td colspan="2"><span class="field_label"> OS/DMLC Amount</span></td>
		<td><g:textField name="outstandingBalance" class="input_field_right numericCurrency"  value="${outstandingBalance}" readonly="readonly"/></td>
	</tr>
	<tr>
		<td colspan="2"><span class="field_label">Tenor</span></td>
		<td><g:textField name="tenor" class="input_field" value="${tenor}" readonly="readonly"/></td>
	</tr>
    <g:if test="${documentSubType1?.equalsIgnoreCase("STANDBY")}">
        <tr>
            <td class="valign_top" colspan="2"><span class="field_label">Purpose of Standby DMLC</span></td>
            <td colspan="2"><g:textArea class="textarea" rows="4" name="purposeOfStandby" value="${purposeOfStandby}"/></td>
        </tr>
        <tr>
            <td colspan="2"><span class="field_label">Tagging of Standby DMLC</span></td>
            <td>
                %{--<g:radioGroup name="standbyTagging" value="${standbyTagging}" labels="['Yes','No']" values="['Y', 'N']">--}%
                     %{--${it.radio}&#160;<g:message code="${it.label}" />--}%
                %{--</g:radioGroup>--}%
<%--                <g:radioGroup name="standbyTagging" labels="['Performance', 'Financial']" values="['PERFORMANCE','FINANCIAL']" value="${standbyTagging}">--%>
<%--                    ${it.radio} ${it.label} &#160;&#160;--%>
<%--                </g:radioGroup>--%>
					<g:radioGroup class="required" name="standbyTagging" labels="['Performance','Financial']" values="['PERFORMANCE','FINANCIAL']" value="${standbyTagging}" >
                		${it.radio}<g:message code="${it.label}" />&#160;&#160;
                	</g:radioGroup>
            </td>
        </tr>
    </g:if>
</table>
<br/><br/>
<g:render template="../layouts/buttons_for_grid_wrapper" />