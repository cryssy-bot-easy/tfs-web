<%--
	(revision)
	SCR/ER Number: *none*
	SCR/ER Description: Negotiation Discrepancy Module
	[Revised by:] Rafael T. Poblete
	[Date revised:] 7/19/2017
	[Date deployed:] 
	Program [Revision] Details: Adjusted the Negotiating Bank's Reference Number from 21 to 16. Removed the dropdown part of Sender to Receiver Information. Ellipses button Created on the narrative field and when the button was clicked, pop-up the screen where the narrative will be inputted, 6 x 35 is the maximum length of the field. 
	Member Type: Groovy Server Pages (GSP)
	Project: WEB
	Project Name: _basic_details_tab.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy Module
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 19, 2017
	[Date deployed:]
	Program [Revision] Details: Added onblur function for field Negotiation Amount to check for zero or negative values.
								Imported js file which has the functions needed for FX Nego Discrepancy.
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
	Program [Revision] Details: Added new field IC Date. Transferred common function to a JS file.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details_tab.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 27, 2017
	[Date deployed:]
	Program [Revision] Details: Added new field IC Date. Transferred common function to a JS file.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details_tab.gsp
--%>

<%--
 	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy
	[Created by:] John Patrick C. Bautista
	[Date revised:] 09/18/2017
	Program [Revision] Details: Added script upon on change of Disposal of Documents dropdown field.
	PROJECT: WEB
	MEMBER TYPE  : Groovy Server Pages (GSP)
	Project Name: _basic_details_tab.gsp
--%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="utilities/ets/commons/basic_details.js" />

<g:javascript src="js-temp/validation_negotiation_discrepancy.js" />

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="lcNegoDiscrepancyFlag" value="true" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="tsdInitiated" value="${tsdInitiated}" />

<g:hiddenField name="expiredStatus" value="${expiredStatus}" />

<g:hiddenField name="totalRegularAmount" value="${totalRegularAmount}" />
<g:hiddenField name="totalCashAmount" value="${totalCashAmount}" />

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
		<td><span class="field_label">IC Number</span></td>
		<td><g:textField name="icNumber" class="input_field" readonly="readonly" value="${icNumber}"/></td>
	</tr>
	<tr>
	<tr>
		<td><span class="field_label">IC Date<span class="asterisk">*</span></span></td>
		<td><g:textField name="icDate" class="datepicker_field3 required" readonly="readonly" value="${icDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Issue Date</span></td>
		<td><g:textField name="issueDate" class="input_field" readonly="readonly" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Expiry Date</span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">FXLC Currency</span></td>
		<td><g:textField name="currency" class="input_field" readonly="readonly" value="${currency}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Original FXLC Amount</span></td>
		<td><g:textField name="originalAmount" class="input_field_right numericCurrency" readonly="readonly" value="${originalAmount}"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">O/S FXLC Amount</span><br/><span class="field_label">(before this Negotiation)</span></td>
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
	<tr>
		<td><span class="field_label">Negotiation Bank <span class="asterisk">*</span> </span></td>
        <td>
        	<%-- <g:select name="negotiationBank" value="${negotiationBank}" from="${['NEGOTIATION BANK 1', 'NEGOTIATION BANK 2', 'NEGOTIATION BANK 3']}" keys="${['NEGOBANK1', 'NEGOBANK2', 'NEGOBANK3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" /> --%>
        	
        	<%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop required" name="negotiationBank" id="negotiationBank" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label">Negotiating Bank's Reference <br/> Number <span class="asterisk">*</span> </span></td>
		<td><g:textField maxlength="16" name="negotiatingBanksReferenceNumber" value="${negotiatingBanksReferenceNumber}" onkeypress="return isAlphaNumericKey2(event)" class="input_field required" /></td>
	</tr>
	<tr>
		<%-- Modified By Rafael --%>
		<td class="label_width"><span class="field_label">Sender to Receiver</span><br/><span class="field_label">Information</span></td>
		<td>
			<g:hiddenField name="senderToReceiver" value=""/>
			<g:textArea name="senderToReceiverInformation" rows="6" class="textarea" value="${senderToReceiverInformation}" readonly="readonly"></g:textArea> 
			<span style="margin-right: 10px;">
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_sender_to_receiver_information">...</a>
			</span>
		</td>
		<%--END Modified By Rafael --%>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Disposal Of Documents<span class="asterisk">*</span></span></td>
		<td class="input_width"><tfs:disposalOfDocuments name="disposalOfDocuments" value="${disposalOfDocuments}" class="required"/></td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label">Narrative<span class="asterisk">*</span></span></td>
		<td>
			<g:textArea maxlength="210" name="disposalOfDocumentsText" rows="3" class="textarea required" value="${disposalOfDocumentsText}" readonly="readonly"></g:textArea> 
			<span style="margin-right: 10px;">
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_disposal_of_documents">...</a>
			</span> 
		</td>
	</tr>
	
</table>
<g:render template="../layouts/buttons_for_grid_wrapper" />

<script>
	$(document).ready(function() {
		
		<%-- $("#negotiationBank").select2('data',{id: '${negotiationBank}'});--%>
		<%-- $("#negotiationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${negotiationBank ?: defaultNegotiationBankForNegoDiscrepancy}'});--%>
	    $("#negotiationBank").setBankDropdown($(this).attr("id")).select2('data',{id: '${negotiationBank}'});
	    
		validateDiscrepancyTab();

	    $("#disposalOfDocuments").change(function(){
			var disposalCode = $('#disposalOfDocuments option:selected').text();
			var disposalTextArea = $('textarea#disposalOfDocumentsText').val();
			if( disposalTextArea != "" ){
				var div = $("#popup_narrative_confirmation"); 
				var bg = $("#confirmation_background_tab");
				mCenterPopup(div, bg);
				mLoadPopup(div, bg);
				if( $("#btnNarrativeYes").val() != undefined ){	
					$("#btnNarrativeYes").click(function(){
						$('textarea#disposalOfDocumentsText').val("");
						mDisablePopup(div, bg);
					});
				} 
				if( $("#btnNarrativeNo").val() != undefined ){	
					$("#btnNarrativeNo").click(function(){
						if( disposalTextArea != "" ){
							var disposalSplit = disposalTextArea.split('/');
							$("#disposalOfDocuments").val(disposalSplit[1]);
							mDisablePopup(div, bg);
						} 
					});
				} 
			}
		});
		
	});
</script>