<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy Module
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 19, 2017
	[Date deployed:]
	Program [Revision] Details: Added onblur function for field Negotiation Amount to check for zero or negative values.
								Imported js file which has the functions needed for DM Nego Discrepancy.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details_tab.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 27, 2017
	[Date deployed:]
	Program [Revision] Details: Added maxlength for CIF Address. Transferred common function to a JS file.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date revised:] 09/15/2017
	Program [Revision] Details: Added hidden field for Expired Status.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%
<g:javascript src="js-temp/validation_negotiation_discrepancy.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />

<g:hiddenField name="expiredStatus" value="${expiredStatus}" />

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
		<td class="label_width"><span class="field_label">Document Number</span></td>
		<td class="input_width"><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Process Date</span></td>
		<td class="input_width"><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td class="valign_top"><span class="field_label">CIF Address <span class="asterisk">*</span></span></td>
		<td><g:textArea name="cifAddress" rows="3" maxlength="150" class="textarea required" value="${cifAddress ?: (address1 + "\n" + address2)}"></g:textArea> </td>
	</tr>
	<tr>
		<td><span class="field_label">IC Number</span></td>
		<td><g:textField name="icNumber" class="input_field" readonly="readonly" value="${icNumber}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Issue Date</span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Expiry Date</span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">DMLC Currency</span></td>
		<td><g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Original DMLC Amount</span></td>
		<td><g:textField name="originalAmount" class="input_field_right numericCurrency" readonly="readonly" value="${originalAmount}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">O/S DMLC Amount</span><br/><span class="field_label">(before this Negotiation)</span></td>
		<td class="input_width"><g:textField name="outstandingBalance" class="input_field_right numericCurrency" readonly="readonly" value="${outstandingBalance}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Negotiation Currency</span></td>
		<td class="input_width"><g:textField name="negotiationCurrency" class="input_field" readonly="readonly" value="${negotiationCurrency ?: currency}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Negotiation Amount <span class="asterisk">*</span></span></td>
		<td class="input_width"><g:textField name="negotiationAmount" class="input_field_right numericCurrency required" value="${negotiationAmount}" onblur="validateNegoAmt();" /></td>
	</tr>
	<%--<tr>
		<td><span class="field_label">Negotiation Bank</span></td>
		<td>
			 <g:select name="negotiationBank" value="${negotiationBank}" from="${['NEGOTIATION BANK 1', 'NEGOTIATION BANK 2', 'NEGOTIATION BANK 3']}" keys="${['NEGOBANK1', 'NEGOBANK2', 'NEGOBANK3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" /> 
		
			 Auto Complete 
			<input class="tags_bank select2_dropdown bigdrop" name="negotiationBank" id="negotiationBank" />
		</td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiating Bank's Ref. Number</span></td>
		<td><g:textField name="negotiationBankRefNumber" value="${negotiationBankRefNumber}" class="input_field" /></td>
	</tr>
	<tr>
		<td class="vtop"><span class="field_label">Sender to Receiver Information</span></td>
		<td><g:textArea name="senderToReceiverInformation" value="${senderToReceiverInformation}" rows="3" class="textarea" ></g:textArea> </td>
	</tr>
--%></table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
	$(document).ready(function() {
		<%-- $("#negotiationBank").select2('data',{id: '${negotiationBank}'});--%>
		<%-- $("#negotiationBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiationBank}'});--%>
        $("#negotiationBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiationBank}'});
        
		validateDiscrepancyTab();
	});
</script>