<%-- 
(revision)
    SCR/ER Number: SCR_IBD-17-1122-01
    SCR/ER Description: Changes on screen
    [Revised by:] Jaivee Hipolito
    [Date revised:] 12/11/2017
    Program [Revision] Details: Change O/S DMLC Balance to Outstanding LC Amount,
            O/S LC - Cash(added), O/S LC – Regular(added), Outstanding LC Amount(added)),
            Remove condition of Outstanding LC Amount if totalIcAmount is 0.
    Member Type: Groovy Server Pages (GSP)
    Project: WEB
    Project Name: _basic_details_tab.gsp
    
    SCR/ER Number: 
    SCR/ER Description: Negotiation Discrepancy
    [Revised by:] Cedrick C. Nungay
    [Date revised:] 09/28/2017
    Program [Revision] Details: Renamed Discrepancy label to IC Number and
                                removed required validation on IC Number.
    Member Type: Groovy Server Pages (GSP)
    Project: WEB
    Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="temp_validation/validation_negotiation.js" />
<g:render template="../commons/popups/facility_id_popup"/>
<g:javascript src="popups/dialog_facility_id.js" />
<g:javascript src="jquery.limit-1.2.source.js"/>


<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>

<g:hiddenField name="loanCheck" value="${loanCheck}"/>
<g:hiddenField name="standbyTagging" value="${standbyTagging}"/>

<g:hiddenField name="mainCifName" value="${mainCifName}" />
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}" />

<%-- For AMLA --%>
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
        <g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
    </g:if>
    <g:else>
        <g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
    </g:else>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"> <span class="field_label"> Document Number </span></td>
		<td class="input_width"> <g:textField name="documentNumber" class="input_field" readonly="readonly" value="${lcNumber}"/></td>
		<td class="label_width"> <span class="field_label"> Shipment Number </span></td>
		<td><g:textField name="shipmentNumber" class="input_field" readonly="readonly" value="${shipmentNumber ?: '1'}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">eTS Number <span class="asterisk">*</span></span></td>
		<td><g:textField name="etsNumber" class="input_field required" readonly="readonly" value="${etsNumber}"/></td>
		<td><span class="field_label"> eTS Date </span></td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
		
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Type </span></td>
		<td><g:textField name="type" class="input_field" value="${type}" readonly="readonly"/>	</td>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> DMLC Currency </span></td>
		<td><g:textField name="originalCurrency" class="input_field" readonly="readonly" value="${originalCurrency ?: currency}"/></td>
		<td><span class="field_label"> Outstanding LC Amount</span><br /><span class="field_label">(before IC Negotiation)</span></td>
        <td><g:textField name="outstandingBalance" class="input_field_right numericCurrency" value="${outstandingBalance}" readonly="readonly" /></td>
	</tr>
	<tr>
        <td><span class="field_label"> DMLC Amount </span></td>
        <td><g:textField name="originalAmount" class="input_field_right numericCurrency" readonly="readonly" value="${originalAmount ?: amount}"/></td>
        <g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
			<td><span class="field_label">O/S LC - Cash</span></td>
	        <td><g:textField name="cashAmount" value="${cashAmount}" class="input_field_right numericCurrency" readonly="readonly" /></td>
	    </g:if>
	</tr>
	<tr>
	   <td><span class="field_label"> Negotiation Number </span></td>
       <td><g:textField name="negotiationNumber" class="input_field" readonly="readonly" value="${negotiationNumber}"/></td>
       <g:if test="${documentSubType1?.equalsIgnoreCase('CASH') || documentSubType1?.equalsIgnoreCase('REGULAR')}">
		   <td><span class="field_label">O/S LC – Regular</span></td>
	       <td><g:textField name="cashAmountRegular" value="${(outstandingBalance != null ? outstandingBalance as double : 0.0)-(cashAmount != null ? cashAmount as double : 0.0)}" class="input_field_right numericCurrency cashAmountRegular" readonly="readonly" /></td>
       </g:if>
	</tr>
	<tr>
		<td><span class="field_label">IC Number</span></td>
        <td><g:textField name="icNumber" class="input_field" readonly="readonly" value="${icNumber}"/></td>
        <td><span class="field_label" id="outstandingBalanceLessIcLabel">Outstanding LC Amount</span><br /><span class="field_label">(after IC Negotiation)</span></td>
        <td><g:textField id="outstandingBalanceLessIc" name="outstandingBalanceLessIc" class="input_field_right amountFormat numericCurrency" readonly="readonly" value="${outstandingBalanceLessIc}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Type <span class="asterisk">*</span></span></td>
		<td>
            <g:select name="negotiationType" id="negotiationType" class="select_dropdown negotiationType required" from="${['DBP', 'DUA', 'DCL', 'DTR']}" noSelection="['':'Select One...']" 
            value="${negotiationType ?: (documentSubType1 == 'CASH') ? 'DCL' : (loanCheck.toString().contains('TR_LOAN')) ? 'DTR' : (loanCheck.toString().contains('UA_LOAN')) ? 'DUA' : (loanCheck.toString().contains('IB_LOAN')) ? 'DBP' : 'DCL'}"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Currency </span></td>
		<td><g:textField name="negotiationCurrency" class="input_field currency" value="${negotiationCurrency}" readonly="readonly" /></td>
<%--		<g:if test="${!documentSubType1?.equalsIgnoreCase('CASH')}">	--%>
<%--			<td><span class="field_label"> Negotiation Facility Type/ID </span></td>--%>
<%--			<td>--%>
<%--				<g:textField name="negotiationFacilityId" class="input_field" readonly="readonly" value="${negotiationFacilityId}"/>--%>
<%--				<span class="field_label"><a href="javascript:void(0)" class="search_btn2 popup_btn_facility"></a></span>--%>
<%--			</td>--%>
<%--		</g:if>--%>
	</tr>
	<tr>
		<td><span class="field_label"> Negotiation Amount</span></td>
		<td><g:textField name="negotiationAmount" class="input_field_right numericCurrency" readonly="readonly" value="${negotiationAmount}"/></td>
		<td><span class="field_label"> Amount Due For Payment </span></td>
		<td><g:textField name="overdrawnAmount" class="input_field numericCurrency" readonly="readonly" value="${overdrawnAmount}"/></td>
	</tr>
	%{--<tr>--}%
		%{--<td><span class="field_label"> Outstanding MD Balance </span></td>--}%
		%{--<td><g:textField name="outstandingMdBalance" class="input_field_right" readonly="readonly" value="${outstandingMdBalance}"/></td>--}%
	%{--</tr>--}%
	<tr>
		<td><span class="field_label">Negotiation Date</span></td>
		<td><g:textField class="datepicker_field" name="negotiationDate" value="${negotiationDate ?: negotiationValueDate ?: DateUtils.shortDateFormat(new Date())}" /></td>
	</tr>
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />
