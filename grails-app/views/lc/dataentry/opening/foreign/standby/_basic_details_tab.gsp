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

<g:javascript src="utilities/dataentry/opening/basic_details_utility.js"/>
<g:javascript src="popups/dialog_facility_id.js" />
<g:javascript src="js-temp/validation_FXLC_Opening_dataentry.js"/>

<g:javascript src="utilities/commons/ie_details_utility.js"/>
<g:javascript src="utilities/dataentry/commons/byDropdownFunction.js" />
<g:javascript src="popups/view_related_lc_popup.js" />

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

<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}"/>
<g:hiddenField name="overAvailment" value="${overAvailment}" />
<g:if test="${reverseDE}">
<g:hiddenField name="reversalDENumber" value="${reversalDENumber}"/>
</g:if>

<table class="tabs_forms_table">
	<tr>
		<td> <span class="field_label"> eTS Date </span> </td>
		<td class="column_width"> <g:textField name="etsDate" class="input_field" readonly="readonly" value="${etsDate}"/> </td>
	</tr>
	<tr>
		<td class="label_width"> <span class="field_label">eTS Number</span> </td>
		<td class="input_width"> <g:textField name="etsNumber" class="input_field" readonly="readonly"  value="${etsNumber}"/> </td>
		<td class="label_width"> <span class="field_label"> Document Number </span> </td>
		<td class="input_width"> <g:textField name="documentNumber" class="input_field textFormat-20" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td><span class="field_label"> Main CIF Number </span></td>
		<td><g:textField name="mainCifNumber" class="input_field numericString" readonly="readonly" value="${mainCifNumber}"/></td>
		<td><span class="field_label"> Main CIF Name </span></td>
		<td><g:textField name="mainCifName" class="input_field" readonly="readonly" value="${mainCifName}"/></td>
	</tr>
	<tr>
		<td> <span class="field_label"> Processing Unit Code </span> </td>
		<td> 
			<g:textField name="processingUnitCode" class="input_field" value="${processingUnitCode}" readonly="readonly"/>
		</td>
		<td><span class="field_label"> Process Date </span></td>
		<td><g:textField name="processDate" class="input_field" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Type </span></td>
		<td><g:textField name="type" class="input_field textFormat-10" value="${documentSubType1}" readonly="readonly" /></td>
		<td><span class="field_label"> FXLC Expiry Date </span></td>
		<td><g:textField name="expiryDate" class="input_field" readonly="readonly" value="${expiryDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label">Purpose of FXLC Standby<span class="asterisk">*</span></span></td>
		<td><g:textArea maxlength="400" name="purposeOfStandby" class="input_field textFormat-60 required" value="${purposeOfStandby}" rows="4"/></td>
		<td><span class="field_label"> Further Identification<span class="asterisk">*</span> </span></td>
		<td><g:select name="furtherIdentification" class="select_dropdown required" from="['ISSUE', 'REQUEST']" noSelection="${['':'SELECT ONE...']}" value="${furtherIdentification ?: 'ISSUE'}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Tagging<span class="asterisk">*</span> </span></td>
		<td>
			<g:radioGroup class="required" name="standbyTagging" labels="['Performance', 'Financial']" values="['PERFORMANCE','FINANCIAL']" value="${standbyTagging}">
				${it.radio} ${it.label} &#160;&#160;
			</g:radioGroup>
		</td>
		<td><span class="field_label"> FXLC Issue Date </span></td>
		<td><g:textField name="issueDate" class="datepicker_field date" value="${issueDate}"/></td>
	</tr>
	<tr>
		<td><span class="field_label"> Facility Type </span></td>
		<td><g:textField name="facilityType" class="input_field textFormat-3" value="${facilityType}" readonly="readonly" /></td>
		<td><span class="field_label"> Facility ID </span></td>
		<td><g:textField name="facilityId" class="input_field" readonly="readonly" value="${facilityId}"/>
			<a href="javascript:void(0)" class="search_btn popup_btn_facility" id="facility_lookup"> Search/Look-up Button </a>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Currency </span></td>
		<td>
			<g:textField name="currency" class="input_field" value="${currency}" readonly="readonly"/>
		</td>
	</tr>
	<tr>
		<td><span class="field_label"> FXLC Amount </span></td>
		<td><g:textField name="amount" class="input_field_right numericCurrency" value="${amount}" readonly="readonly"/></td>
		<td><span class="field_label"> Confirmation Instructions: Confirmed? </span></td>
		<td>
			<g:radioGroup name="confirmationInstructionsFlag" id="confirmationInstructionsFlag" labels="['Yes', 'No', 'May Add']" values="['Y', 'N', 'M']" value="${confirmationInstructionsFlag}">
				${it.radio} ${it.label} &#160;&#160;
			</g:radioGroup>
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
			<g:textArea name="exporterAddress" value="${exporterAddress}" class="textarea required" readonly="readonly" rows="2" />
			<span class="float_right"><a href="javascript:void(0)" class="search_btn" id="popup_btn_exporter_bank_address">...</a></span>
		</td>
	</tr>
	<tr>
		<td> <span class="field_label"> Expiry Country Code<span class="asterisk">*</span> </span> </td>
		<td> 
			<%-- <g:select name="expiryCountryCode" value="${expiryCountryCode}" from="${['BSP CODE 1', 'BSP CODE 2', 'BSP CODE 3'] }" keys="${['BSP_CODE1', 'BSP_CODE2', 'BSP_CODE3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" /> --%>
			
			<%-- Auto Complete --%> 
        	<input class="tags_country select2_dropdown bigdrop required" name="expiryCountryCode" id="expiryCountryCode" />
            <g:hiddenField name="expiryCountry" value="${expiryCountry}" />
		</td>
		<td> <span class="field_label"> Form of Documentary Credit<span class="asterisk">*</span> </span> </td>
		<td> 
            %{--<tfs:formOfDocumentaryCredit name="formOfDocumentaryCredit" class="select_dropdown" value="${formOfDocumentaryCredit}" />--}%
            <g:select name="formOfDocumentaryCredit" from="${['IRREVOCABLE', 'REVOCABLE', 'IRREVOCABLE TRANSFERABLE', 'REVOCABLE TRANSFERABLE']}" keys="${['I', 'R', 'IT', 'RT']}" noSelection="['':'SELECT ONE...']" value="${formOfDocumentaryCredit ?: 'I'}" class="select_dropdown required" />
		</td>
	</tr>
	<tr>
		<td> <span class="field_label"> Destination Bank<span class="asterisk">*</span> </span> </td>
		<td> 
			<%-- <g:select name="destinationBank" from="${['DESTINATION BANK 1', 'DESTINATION BANK 2', 'DESTINATION BANK 3']}" keys="${['DESTINATIONBANK1', 'DESTINATIONBANK2', 'DESTINATIONBANK3']}" noSelection="['':'SELECT ONE...']" class="select_dropdown" value="${destinationBank}"/> --%>
			
			<%-- Auto Complete --%> 
        	<input class="tags_bank select2_dropdown bigdrop required" name="destinationBank" id="destinationBank" />
		</td>
		<td> <span class="field_label"> Applicable Rules<span class="asterisk">*</span> </span> </td>
		<td> 
            %{--<tfs:applicableRules name="applicableRules" class="select_dropdown" value="${applicableRules}" />--}%
            <g:select name="applicableRules" from="${['NONE','ISPR','OTHR','URDG']}" noSelection="['':'SELECT ONE...']" keys="${['NONE','ISPR','OTHR','URDG']}" value="${applicableRules ?: 'ISPR'}" class="select_dropdown required" />
		</td>
	</tr>
	<tr><td><br/></td></tr>
	<tr>
		<td class="label_width"><span class="field_label">Available With <span class="asterisk">*</span></span></td>
		<td/>
	</tr>
	<tr>
		<td class="label_width">
            <g:hiddenField name="availableWithFlagValue" value="${availableWithFlag}" />
			<g:radio name="availableWithFlag" class="availableWithA" value="A"  checked="${availableWithFlag == 'A' ? 'checked' : false}" />
			&#160;<span class="field_label">Option A - <br/>Identifier Code</span>
		</td>
		<td colspan="3"><input class="tags_bank select2_dropdown bigdrop required" name="availableWith" id="availableWith" /></td>
	</tr>
	<tr>
		<td class="label_width">
			<g:radio name="availableWithFlag" class="availableWithB" value="D"  checked="${availableWithFlag == 'D' ? 'checked' : false}" />
			&#160;<span class="field_label">Option D - <br/>Name and Address</span>
		</td>
		<td>
			<g:textArea name="nameAndAddress" value="${nameAndAddress}" class="textarea" readonly="readonly" rows="4"/>
			<a href="javascript:void(0)" class="search_btn bank_address_popup" id="popup_btn_bank_address">...</a>
		</td>
		<td><span class="field_label"> If 'OTHR': Other Rule </span></td>
		<td><g:textArea maxlength="30" name="otherRule" class="textarea othr_field" value="${otherRule}" rows="4"/></td>
	</tr>	
	<tr>
		<td class="label_width"><span class="field_label"> Sender to Receiver </span><br /><span class="field_label"> Information </span></td>
		<td class="input_width">
			<tfs:senderToReceiverType1 name="senderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td class="label_width"/>
		<td class="input_width">
			<g:textArea maxlength="210" name="senderToReceiverInformation" class="textarea" rows="4" value="${senderToReceiverInformation}"/>
		</td>
	</tr>
</table>
<br />
<g:render template="../layouts/buttons_for_grid_wrapper" />
<g:render template="../commons/popups/facility_id_popup" />

<script type="text/javascript">
$(document).ready(function() {
	if($("#overAvailment").val() == "NOTE: Transaction has been rejected."){
    	$("#overAvailment").val(" ");
    	$(".overAvailment").html(" ");
    }
	%{--$("#expiryCountryCode").select2('data',{id: '${expiryCountryCode}'});--}%
	$("#expiryCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${expiryCountryCode}'});

	$("#expiryCountryCode").on("change", function(e) {
		$("#expiryCountry").val($("#expiryCountryCode").select2('data').label)
	});

	%{--$("#destinationBank").select2('data',{id: '${destinationBank}'});--}%
	$("#destinationBank").setRmaBankDropdown($(this).attr("id")).select2('data',{id: '${destinationBank}'});

	$("#availableWith").setBankDropdown($(this).attr("id")).select2('data',{id: '${availableWith}'});
	$("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
	$("#bspCountryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${bspCountryCode}'});
	$("#importerCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${importerCbCode}'});
	$("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});

	onChangeConfirmationInstruction();
	$("input[type=radio][name=confirmationInstructionsFlag]").change(function() {
		onChangeConfirmationInstruction();
		if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y") {
			$("input[type=radio][name=availableWithFlag][value=A]").attr("checked", "checked").change();
			$("#availableWith").select2('data',{id: $("#destinationBank").select2('data').id});
			$("#nameAndAddress").val('${nameAndAddress}');
		}
		else {
			$("input[type=radio][name=availableWithFlag][value=D]").attr("checked", "checked").change();
			$("#availableWith").select2('data',{id: null});
			$("#nameAndAddress").val("ANY BANK");
		}
	});

	$("#destinationBank").change(function() {
		if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y") {
			$("#availableWith").select2('data',{id: $("#destinationBank").select2('data').id});
			$("#drawee").val($("#availableWith").val());
		}
	});

	$("#availableWith").change(function() {
		if($("input[type=radio][name=confirmationInstructionsFlag]:checked").val() == "Y") {
			$("#drawee").val($("#availableWith").val());
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
		if($("input[type=radio][name=availableWithFlag]:checked").val() == undefined) {
			$("input[type=radio][name=availableWithFlag][value=A]").attr("checked", "checked").change();
		}
	} else{	
		if($("input[type=radio][name=availableWithFlag]:checked").val() == undefined) {
			$("input[type=radio][name=availableWithFlag][value=D]").attr("checked", "checked").change();
		}
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
