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

<%-- 
(revision)
    (revision)
    Reference Number: ITDJCH-2018-03-001
    Reference Description: Add new fields on screen of different modules to comply with the requirements of ITRS.
    [Revised by:] Jaivee Hipolito
    [Revised date:] 03/22/2018
    Program [Revision:] add new Fields TIN, Importer Code. Set tin number field name to tempTinNumber to prevent saving of 2 tin numbers.
    PROJECT: Groovy Server Pages (GSP)
    MEMBER TYPE  : WEB
    Project Name: _basic_details_tab.gsp
--%>

<%-- 
(revision)
    [Modified by:] Rafael Ski Poblete
    [Modified date:] 08/28/2018
  	[Details] Changed formOfDocumentaryCredit dropdown values.
  			  Rearranged fields.
  			  Added Other Place of Expiry field.
  			  Added Mixed Payment Details field.
  			  Added Requested Confirmation Party field and JQuery Validations.
--%>

<g:javascript src="utilities/dataentry/opening/basic_details_utility.js"/>
<g:javascript src="popups/tenor_of_drafts_popup.js" />
<g:javascript src="popups/dialog_facility_id.js" />
<g:javascript src="js-temp/validation_FXLC_Opening_dataentry.js"/>

<g:javascript src="utilities/commons/ie_details_utility.js"/>
<g:javascript src="utilities/dataentry/commons/byDropdownFunction.js" />
<g:javascript src="popups/view_related_lc_popup.js" />
<g:javascript src="popups/additional_amounts_covered_popup.js" />

<%-- Auto Complete --%>
%{--<g:javascript src="utilities/commons/autocomplete_utility.js"/>--}%

<%@ page import="net.ipc.utils.DateUtils" %>
<g:javascript src="popups/cif_normal_search_popup.js"/>

<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="documentSubType1" value="${documentSubType1}" />
<g:hiddenField name="documentSubType2" value="${documentSubType2}" />

<g:hiddenField name="draftStatus" value="${draftStatus}" />

<%--for AMLA--%>
<g:if test="${documentSubType1?.equalsIgnoreCase('CASH')}">
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
<%--	<g:hiddenField name="amlaCasaFlagAccountNo" value="${amlaCasaFlagAccountNo}"/>--%>
	<g:hiddenField name="amlaCasaFlagFxCurrency" value="${amlaCasaFlagFxCurrency}"/>
	<g:hiddenField name="amlaRemittanceFlagFxCurrency" value="${amlaRemittanceFlagFxCurrency}"/>
</g:if>

<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="overAvailment" value="${overAvailment}" />
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<g:hiddenField name="oldDescriptionOfGoods" value="${oldDescriptionOfGoods ?: generalDescriptionOfGoods}"/>

<g:hiddenField name="relatedLcDescriptionOfGoods" value="${relatedLcDescriptionOfGoods}"/>
<g:hiddenField name="relatedRequiredDocumentsList" value="${relatedRequiredDocumentsList}" />
<g:hiddenField name="relatedAddedDocumentsList" value="${relatedAddedDocumentsList }" />
<g:hiddenField name="relatedAdditionalConditionsList" value="${relatedAdditionalConditionsList }" />
<g:hiddenField name="relatedAddedAdditionalConditionsList" value="${relatedAddedAdditionalConditionsList }" />

<table class="tabs_forms_table">
	<tr>
		<td class="label_width"><span class="field_label">eTS Number</span> </td>
		<td class="input_width"><g:textField name="etsNumber" class="input_field" readonly="readonly"  value="${etsNumber}"/> </td>
		<td class="label_width"><span class="field_label"> eTS Date </span> </td>
		<td><g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> Main CIF Number </span></td>
		<td><g:textField name="mainCifNumber" class="input_field numericString" readonly="readonly" value="${mainCifNumber}"/></td>
		<td><span class="field_label"> Document Number </span> </td>
		<td><g:textField name="documentNumber" class="input_field" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> Processing Unit Code </span> </td>
		<td><g:textField name="processingUnitCode" class="input_field" readonly="readonly" value="${processingUnitCode}"/></td>
		<td><span class="field_label"> Main CIF Name </span></td>
		<td><g:textField name="mainCifName" class="input_field" readonly="readonly" value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">Importer Code</span></td>
		<td class="input_width"> <g:textField class="input_field" name="participantCode" value="${participantCode?:participantCode.toString()}" maxlength="10"/> </td>
		<td class="label_width"> <span class="field_label">TIN <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>
		<td><g:textField name="type" class="input_field" value="${documentSubType1}" readonly="readonly" /></td>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Facility Type </span></td>
		<td><g:textField name="facilityType" class="input_field" value="${facilityType ?: 'FCN'}" readonly="readonly" /></td>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="datepicker_field" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td>
			<g:textField name="currency" class="input_field" value="${currency}" readonly="readonly"/>
		</td>
		<td><span class="field_label"> Tenor </span></td>
		<td><g:textField name="tenor" class="input_field" value="${tenor}" readonly="readonly" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Amount </span></td>
		<td><g:textField name="amount" class="input_field_right numberFormat-15-2 numericCurrency" readonly="readonly" value="${amount}"/></td>
		<td> <span class="field_label"> Form of Documentary Credit<span class="asterisk">*</span> </span> </td>
		<td> 
			<g:select name="formOfDocumentaryCredit" from="${['IRREVOCABLE', 'IRREVOCABLE TRANSFERABLE', 'IRREVOCABLE STANDBY', 'IRREVOC TRANS STANDBY']}" keys="${['I', 'IT', 'IS', 'ITS']}" noSelection="['':'SELECT ONE...']" value="${formOfDocumentaryCredit ?: 'I'}" class="select_dropdown required" />
		</td>
	</tr>
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
		<g:if test="${documentSubType1!='CASH'&&documentClass!='LC'}">
			<td><span class="field_label"> Facility ID </span></td>
			<td><g:textField name="facilityId" class="input_field" readonly="readonly" value="${facilityId}"/>
				<a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>
			</td>
		</g:if>
		<td></td>
		<td>
			<g:radioGroup name="individualCorporateFlag" id="individualCorporateFlag" labels="['Individual', 'Corporate']" values="['I','C']" value="${individualCorporateFlag?:'C'}">
				<label>${it.radio} ${it.label} &#160;&#160;</label>
			</g:radioGroup>
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
		<td><g:textField name="importerName" class="input_field required" value="${importerName ?: longName}" maxlength="60"/></td>
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
			<g:textArea name="exporterAddress" value="${exporterAddress}" class="textarea required" readonly="readonly" rows="2" />
			<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_exporter_bank_address">...</a></span>
		</td>
	</tr>
	<tr>
	<tr>
		<td><span class="field_label"> FXLC Expiry Date </span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
		<td><span class="field_label"> Confirmation Instructions: Confirmed? </span></td>
		<td>
			<g:radioGroup name="confirmationInstructionsFlag" id="confirmationInstructionsFlag" labels="['Yes', 'No', 'May Add']" values="['Y', 'N', 'M']" value="${confirmationInstructionsFlag}">
				<label>${it.radio} ${it.label} &#160;&#160;</label>
			</g:radioGroup>
		</td>
	</tr>
		<td><span class="field_label"> Expiry Country Code<span class="asterisk">*</span> </span></td>
		<td>
            <%--<g:select name="expiryCountryCode" value="${expiryCountryCode}" from="${['BSP CODE 1', 'BSP CODE 2', 'BSP CODE 3'] }" keys="${['BSP_CODE1', 'BSP_CODE2', 'BSP_CODE3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" /> --%>
            
            <%-- Auto Complete --%> 
        	<input class="tags_country select2_dropdown bigdrop required" name="expiryCountryCode" id="expiryCountryCode" value="${expiryCountryCode}" />
        </td>
        	<td><span class="field_label"> Requested Confirmation Party</span></td>
		<td>
			<input class="tags_bank select2_dropdown bigdrop" name="requestedConfirmationParty" id="requestedConfirmationParty" />
        </td>
		
	</tr>
	<tr>
		<td><span class="field_label"> Expiry Country Name<span class="asterisk">*</span> </span></td>
		<td><g:textField value="${expiryCountryLabel}" name="expiryCountryLabel" class="input_field required" maxlength="25"/></td>
		<td class="label_width"><span class="field_label">Country Code <span class="asterisk">*</span></span></td>
            <td><input class="tags_country select2_dropdown bigdrop required" name="countryCode" id="countryCode" /></td>
	</tr>
	<tr>
		<td><span class="field_label"> Other Place of Expiry </span></td>
		<td><g:textArea name="otherPlaceOfExpiry"  value="${otherPlaceOfExpiry}" class="textarea" readonly="readonly" rows="4" />
				<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_otherPlaceOfExpiry">...</a></span>
	</tr>
	<tr>
		<td><span class="field_label"> Destination Bank<span class="asterisk">*</span> </span></td>
		<td>
            <%-- <g:select name="destinationBank" from="${['DESTINATION BANK 1', 'DESTINATION BANK 2', 'DESTINATION BANK 3']}" keys="${['DESTINATIONBANK1', 'DESTINATIONBANK2', 'DESTINATIONBANK3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" value="${destinationBank}"/> --%>
            
            <%-- Auto Complete --%>
			<input class="tags_bank select2_dropdown bigdrop required" name="destinationBank" id="destinationBank" />
        </td>
	</tr>
	<tr>
		<td> <span class="field_label"> Applicable Rules<span class="asterisk">*</span> </span> </td>
		<td> 
		<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
			<g:select name="applicableRules" from="${['EUCP LATEST VERSION','EUCPURR LATEST VERSION', 'ISP LATEST VERSION', 'OTHR', 'UCP LATEST VERSION', 'UCPURR LATEST VERSION']}" noSelection="['':'SELECT ONE...']" keys="${['EUCP','EURR','ISP', 'OTHR', 'UCP', 'UCUR']}" value="${applicableRules ?: 'UCP'}" class="select_dropdown required" />
		</g:if>
		<g:else>
			<g:select name="applicableRules" from="${['INTERNATION STANDBY PRACTICES','NONE', 'OTHR', 'UNIFORM RULES FOR DEMAND GUARANTEES']}" noSelection="['':'SELECT ONE...']" keys="${['ISPR','NONE', 'OTHR', 'URDG']}" value="${applicableRules ?: 'UCP'}" class="select_dropdown required" />
		</g:else>
		</td>
		<td><span class="field_label"> Price Term (Code) </span></td>
		<td>
            <tfs:priceTerm id="priceTerm" class="select_dropdown input_thirtyFive" name="priceTerm" value="${priceTerm}" />
        </td>
	</tr>
	<tr>
		<td><span class="field_label othr_label"> If 'OTHR': Other Rule </span></td>
		<td><g:textArea maxlength="30" name="otherRule" class="input_field othr_field" value="${otherRule}" rows="4"/></td>
		<td><span class="field_label"> Price Term(Narrative) </span></td>
		<td><g:textArea maxlength="3000" name="priceTermNarrative" class="input_field" value="${priceTermNarrative ?: otherPriceTerm}" rows="4" /></td>
	</tr>
	<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
		<tr>
			<td class="label_width"><span class="field_label">Positive Tolerance Limit</span></td>
			<td><g:textField maxlength="19" name="positiveToleranceLimit" value="${positiveToleranceLimit}" class="input_field numericCurrency"  /></td>
			<td><span class="field_label">Negative Tolerance Limit</span></td>
			<td><g:textField maxlength="19" name="negativeToleranceLimit" value="${negativeToleranceLimit}" class="input_field numericCurrency"  /></td>
		</tr>
		<tr>
			<td class="label_width"><span class="field_label">Maximum Credit Amount</span></td>
			<td><g:textField name="maximumCreditAmount" value="${maximumCreditAmount ?: 'NOT EXCEEDING'}" class="input_field" readonly="readonly" /></td>
			<td><p class="field_label">Additional Amounts<br />Covered</p></td>
			<td>
				<g:textArea maxlength="70" name="additionalAmountsCovered"  value="${additionalAmountsCovered}" class="textarea" readonly="readonly" rows="4" />
				<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_additional_amounts_covered">...</a></span>
			</td>
		</tr>
	</g:if>
	<tr>
		<td class="label_width"><span class="field_label">Available With <span class="asterisk">*</span></span></td>
		<td/>
		<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
            <td><span class="field_label">By... <span class="asterisk">*</span></span></td>
            <td>
                <tfs:availableBy id="availableByDisplay" name="availableByDisplay" class="select_dropdown required" value="${availableBy}" />
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
		<td colspan="3">
			<%-- <g:textField name="identifierCode" class="input_field" value="${identifierCode}" readonly="readonly" /> --%>
			<input class="tags_bank select2_dropdown bigdrop" name="availableWith" id="availableWith" />
			<g:hiddenField name="availableWithLabel" value="${availableWithLabel ?: ''}" />
		</td>
	</tr>
	<tr>
		<td class="label_width">
			<g:radio name="availableWithFlag" class="availableWithB" value="D"  checked="${availableWithFlag == 'D' ? 'checked' : false}" />
			&#160;<span class="field_label">Option D - <br/>Name and Address</span>
		</td>
		<td><g:textArea name="nameAndAddress" value="${nameAndAddress ?: 'ANY BANK'}" class="textarea" readonly="readonly" rows='4'/>
		<a href="javascript:void(0)" class="search_btn bank_address_popup" id="popup_btn_bank_address">...</a>
		</td>
            <g:if test="${documentSubType2?.equalsIgnoreCase('USANCE')}">
				<td><span class="field_label">Tenor of Draft <span class="asterisk">* </span><br /> (Narrative)</span></td>
            	<td><g:textArea name="tenorOfDraftNarrative" class="textarea required" rows="4" value="${(tenor?.equalsIgnoreCase("SIGHT")) ? 'DRAFT AT SIGHT' : tenorOfDraftNarrative}" /></td>  	
        	</g:if>
        	<g:else>
				<td><span class="field_label">Tenor of Draft (Narrative)</span></td>
            	<td><g:textArea name="tenorOfDraftNarrative" class="textarea" rows="4" readonly="readonly" value="${(tenor?.equalsIgnoreCase("SIGHT")) ? 'DRAFT AT SIGHT' : tenorOfDraftNarrative}" /></td>
        	</g:else>
	</tr>
	<g:if test="${!documentSubType1?.equalsIgnoreCase('STANDBY')}">
        <tr class="vtop label_width field_hide drawee">
            <td><span class="field_label">Drawee</span></td>
            <td><g:textField name="drawee" value="${drawee}" class="input_field" readonly="readonly" /></td>
       		<g:if test="${documentSubType2?.equalsIgnoreCase('USANCE')}">
       			<td class="label_width"> <span class="field_label"> If Usance: Tenor of Draft <span class="asterisk">* </span><br /> (usance period) </span> </td>
				<td class="input_width"> <g:textField class="input_field_short numericWholeQuantity required" name="usancePeriod" value="${usancePeriod}" readonly="readonly"/> DAYS </td>
        	</g:if>
        </tr>
		<tr>
		<td><span class="field_label">Mixed Payment Details</span></td>
            <td>
                <g:textArea name="mixedPaymentDetails" value="${mixedPaymentDetails}" class="textarea" readonly="readonly" rows="4" />
                <a href="javascript:void(0)" class="search_btn" id="popup_btn_mixed_payment_details">...</a>
           </td>
            <td><span class="field_label"> Negotiation/Deferred Payment Details </span></td>
           	<td><g:textArea name="deferredPaymentDetails" class="textarea" rows="4" readonly="readonly" value="${deferredPaymentDetails}" />
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_deferred_payment_details">...</a>
           </td>
		</tr>
	</g:if>      	
</table>
<br />

<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/tenor_of_drafts_popup" />
<g:render template="../commons/popups/facility_id_popup" />
<g:render template="../commons/popups/view_related_lc_popup" />
<g:render template="../commons/popups/additional_amounts_covered_popup" />

<script type="text/javascript">
$(document).ready(function() {
    $('#requestedConfirmationParty').val($('#destinationBank').val());
	$('#tempTinNumber').change(function() {
        $('#tinNumber').val($('#tempTinNumber').val().trim());
    });

	if($("#overAvailment").val() == "NOTE: Transaction has been rejected."){
    	$("#overAvailment").val(" ");
    	$(".overAvailment").html(" ");
    }
	%{--$("#expiryCountryCode").select2('data',{id: '${expiryCountryCode}'});--}%
	
	%{--$("#destinationBank").select2('data',{id: '${destinationBank}'});--}%
	$("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${destinationBank}'});
	$("#requestedConfirmationParty").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${requestedConfirmationParty}'});
	%{--$("#expiryCountryCode").select2('data',{id: '${expiryCountryCode}'});--}%
	$("#expiryCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${expiryCountryCode}'})
	.on("change",function(e){
		if("" == e.val){
			$("#expiryCountryLabel").val("");
		}else{
			$("#expiryCountryLabel").val($.trim($(this).select2('data').label));
		}
	});
	
	$("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWith}'})
	.on("change",function(e){
		if("" == e.val){
			$("#availableWithLabel").val("");
		}else{
			$("#availableWithLabel").val($.trim($(this).select2('data').label));
		}
	});
	$("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
	$("#bspCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCode}'});
	$("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
	$("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
	
	onChangeConfirmationInstruction();
	$("input[type=radio][name=confirmationInstructionsFlag]").change(function() {
		onChangeConfirmationInstruction();
		if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y") {
			$("input[type=radio][name=availableWithFlag][value=A]").attr("checked", "checked").change();
			$("#availableWith").select2('data',{id: null});
			$("#availableWithLabel").val($.trim($("#destinationBank").select2('data').label));
			$("#drawee").val($("#availableWith").val());
		}
		else {
			$("input[type=radio][name=availableWithFlag][value=D]").attr("checked", "checked").change();
			$("#availableWith").select2('data',{id: null});
			$("#nameAndAddress").val("ANY BANK");
		}
	});

	$("#destinationBank").change(function() {
		if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y"
			&& $("input[type=radio][name=availableWithFlag]:checked").val() == "A") {
			$("#availableWith").select2('data',{id: $("#destinationBank").select2('data').id});
			$("#availableWithLabel").val($.trim($("#destinationBank").select2('data').label));
			$("#drawee").val($("#availableWith").val());
			$("#requestedConfirmationParty").select2('data',{id: $("#destinationBank").select2('data').id});
		}
	});
	
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
	
});
	
function onChangeConfirmationInstruction() {
	if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y") {
		$("#requestedConfirmationParty").select2('data',$("#destinationBank").select2('data'));
		if($("input[type=radio][name=availableWithFlag]:checked").val() == undefined) {
			$("input[type=radio][name=availableWithFlag][value=A]").attr("checked", "checked").change();
		}
		$("#drawee").val($("#availableWith").val());

		$("#requestedConfirmationParty").select2("enable");
	}
	else if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "N") {
		$("#requestedConfirmationParty").select2("disable");
		$("#requestedConfirmationParty").select2('data',null);
		if($("input[type=radio][name=availableWithFlag]:checked").val() == undefined) {
			$("input[type=radio][name=availableWithFlag][value=D]").attr("checked", "checked").change();
		}
		$("#drawee").val("${grailsApplication.config.tfs.constants.sender.address + grailsApplication.config.tfs.constants.sender.suffix}");
	}else{
		if($("input[type=radio][name=availableWithFlag]:checked").val() == undefined) {
			$("input[type=radio][name=availableWithFlag][value=D]").attr("checked", "checked").change();
		}
		$("#drawee").val("${grailsApplication.config.tfs.constants.sender.address + grailsApplication.config.tfs.constants.sender.suffix}");
		$("#requestedConfirmationParty").select2("enable"); 
		$("#requestedConfirmationParty").select2('data',$("#destinationBank").select2('data'));
	}
}

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