<%@ page import="net.ipc.utils.DateUtils" %>

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
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="productCurrency" value="${productCurrency ?: uaLoanCurrency}"/>
<g:hiddenField name="productAmount" value="${productAmount ?: uaLoanAmount}" />
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>


<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span></td>
		<td class="input_width"> <g:textField name="etsNumber" value="${etsNumber}" class="input_field" readonly="readonly"/></td>
		<td class="label_width"><span class="field_label">eTS Date </span></td>
		<td class="input_width"><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Document Number</span></td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
		<td><span class="field_label">Negotiation Number</span></td>
		<td><g:textField name="negotiationNumber" class="input_field" readonly="readonly" value="${negotiationNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Issue Date</span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
		<td><span class="field_label">DMLC-DUA Loan Currency</span></td>
		<td>
            %{--<g:textField name="uaLoanCurrency" class="input_field" readonly="readonly" value="${uaLoanCurrency}"/>--}%
            <g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/>
        </td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC-DUA Loan Amount</span></td>
		<td>
            %{--<g:textField name="uaLoanAmount" class="input_field_right numericCurrency" readonly="readonly" value="${uaLoanAmount}"/>--}%
            <g:textField name="amount" class="input_field_right numericCurrency" readonly="readonly" value="${amount}"/>
        </td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>

    <tr>
        <td><span class="field_label">DMLC Amount </span></td>
        <td><g:textField name="lcAmount" class="input_field_right lc_amount numericCurrency" value="${lcAmount}" readonly="readonly"/></td>
        <td><span class="field_label">DMLC Currency </span></td>
        <td><g:textField name="lcCurrency" class="input_field currency" value="${lcCurrency}" readonly="readonly"/></td>
    </tr>

    %{--removed as of 18.Jul.2013--}%
	%{--<tr>--}%
		%{--<td><span class="field_label">Negotiation Facility Type</span></td>--}%
		%{--<td>--}%
			%{--<g:select from="${['FD5','FTF']}" keys="${['FD5', 'FTF']}" noSelection="${['':'SELECT ONE...']}" name="negotiationFaciltyType" class="select_dropdown" value="${negotiationFaciltyType}"/>--}%
		%{--</td>--}%
		%{--<td><span class="field_label">Negotiation Facility ID</span></td>--}%
		%{--<td>--}%
			%{--<g:textField name="negotiationFacilityId" value="${negotiationFacilityId}" class="input_field numberFormat-11"/>--}%
			%{--<a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>--}%
		%{--</td>--}%
	%{--</tr>--}%
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/facility_id_popup"/>
<g:javascript src="popups/dialog_facility_id.js" />