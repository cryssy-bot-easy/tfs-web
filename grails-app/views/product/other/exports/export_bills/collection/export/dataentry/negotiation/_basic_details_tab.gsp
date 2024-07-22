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
SCR/ER Number: 
SCR/ER Description: The draft amount in Set-up NonLC Details tab should be extracted
from Nego Amount in Basic Details tab. (Redmine# 3734)
[Revised by:] Robin C. Rafael
[Date deployed:] 
Program [Revision] Details: Change the draft amount value equal to the Nego amount when saving basic details tab.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
		1. EBC Nego - Importer Address should follow the template for beneficiary address (Redmine# 4125)
		2. EBP Negotiation - E-TS Inquiry and Data Entry Inquiry and EBP Settlement Inquiry Screens (Redmine# 4158)
		3. EBC NEGO DATA ENTRY - MT GENERATION (Redmine# 4200)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 01/26/2017 (tfs-web Rev# 7350)
		1. 02/21/2017 (tfs-web Rev# 7406)
		3. 04/04/2017 (tfs-web Rev# 7460)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Added an ellipsis button for Importer Address.
		2. Added a condition that validates if viewed in inquiry.
		3. Added validation for toggling of 'Generate MT'.
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
    Program [Revision:] add new Fields TIN, Exporter Code, Particulars and their behavior. Set tin number field name to tempTinNumber to prevent saving of 2 tin numbers.
    PROJECT: WEB
    MEMBER TYPE  : Groovy
    Project Name: _basic_details_tab.gsp
    
    (revision)
    Modified by: Rafael Ski Poblete
    Date : 7/26/18
    Description : Changed sender to receiver and charges narrative fields into popup instead of normal textarea to set right delimiter.
 --%>

<%@ page import="net.ipc.utils.DateUtils" %>
<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="stat" value="${statusAction}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="form" value="basicDetails" />
			
<g:hiddenField name="mainCifNumber" value="${mainCifNumber}"/>
<g:hiddenField name="mainCifName" value="${mainCifName}"/>
<g:hiddenField name="cwtFlag" value="${cwtFlag}"/>

<g:hiddenField name="processingUnitCode" value="${session.unitcode}"/>
<g:each in="${exchange}" var="temp" status="i">
	<g:if test="${!temp.rate_description.contains('BOOKING')}">
		<g:hiddenField name="${temp.rates}" value="${temp.pass_on_rate}"/>
	</g:if>
	<g:else>
		<g:hiddenField name="USD-PHP_urr" value="${temp.pass_on_rate}"/>
	</g:else>
</g:each>

<table class="tabs_forms_table">
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Generate MT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="mtFlag" class="mtFlag" labels="['Yes','No']" values="[1, 0]" value="${mtFlag ?: 0}">
		        ${it.radio}&#160;<g:message code="${it.label}" />
		    </g:radioGroup>
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Process Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="processDate" readonly="readonly" value="${processDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Invoice Number </span> </td>
		<td class="input_width"> <g:textField maxlength="20" class="input_field" name="invoiceNumber" value="${invoiceNumber}"/> </td>
	</tr>
    <tr>
        <td class="label_width" colspan="2"> <span class="field_label"> Payment Mode<span class="asterisk">*</span></span> </td>
        <td class="input_width">
            <g:select class="select_dropdown required" name="paymentMode" from="['LC','DP','DA','OA','DR']" noSelection="['':'SELECT ONE...']" value="${paymentMode}"/>
        </td>
    </tr>
    <tr>
        <td class="label_width" colspan="2"> <span class="field_label"> EXLC Advice Number </span> </td>
        <td class="input_width">
            <g:textField class="select2_dropdown bigdrop" name="exlcAdviseNumber" value="" />
            <g:hiddenField maxlength="100" name="issuingBankName" value="${issuingBankName}" />
            <g:hiddenField name="reimbursingBankCodeHidden" value="${reimbursingBankCodeHidden}" /><%-- created by max add dummy field for saving reimbursingBankCode from first advising for redmine 3678--%>
        </td>
    </tr>
	
<%-- Added Exporter CB Code for Issue# 4316 --%>
	<tr>
		<td class="label_width" colspan="2">
			<span class="field_label"> Exporter CB code<%-- <br />(if without CIF No.)<span class="asterisk">*</span>--%></span>
		</td>
		<td class="input_width" colspan="2">
			<g:textField class="input_field" name="exporterCbCode" id ="exporterCbCode" readonly="readonly" value="${exporterCbCode}" />
<%--            <input class="tags_cbcode select2_dropdown bigdrop" name="exporterCbCode" id="exporterCbCode" readonly="readonly" disabled="disabled"/>--%>
<%--            <g:hiddenField name="exporterCbCodeCheck" value="${exporterCbCodeCheck}" />--%>
        </td>
	</tr>
<%-- End of Issue# 4316 --%>

	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Exporter Name (Drawer) </span> </td>
		<td class="input_width"> <g:textField maxlength="100" class="input_field" name="sellerName" id ="sellerName" value="${sellerName}" maxlength="60"/> </td>
	</tr>
	<tr>
	    <td colspan="2"> <span class="field_label">TIN</span> </td>
        <td><g:textField class="input_field" name="tempTinNumber" value="${tinNumber}" maxLength="20"/> </td>
    <tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label">Exporter Code</span></td>
            <td class="input_width"> <g:textField class="input_field" name="participantCode"id="participantCode" value="${participantCode}" maxlength="10"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2" > <span class="field_label">Particulars</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="particularsLabel" id="particularsLabel" />
            <g:hiddenField name="particulars" value="${particulars}" />
        </td>
	</tr>
	<tr>
        <td class="label_width" colspan="2"><span class="field_label"> Drawee <span class="asterisk hasLC" >*</span></span></td>
		<td class="inpute_width"> <g:textField maxlength="100" name="drawee" class="input_field " value="${drawee }" id = "drawee" /> </td>    
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Importer Name <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField maxlength="100" class="input_field required" name="buyerName" value="${buyerName}" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Importer Address <span class="asterisk">*</span> </span> </td>
	<%-- added ellipsis button for Issue# 4125 of Deffered Issues --%>
		<td class="input_width">
			<g:textArea name="buyerAddress" value="${buyerAddress}" class="textarea required" rows="4" readonly="readonly"/>
			<span class="float_right">
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
			</span>
		</td>
	<%-- end of Issue# 4125	--%>
	
	<%-- ad "required on class so that importer address became mandatory"  MAX--%>
		<%-- <td class="input_width"> <g:textArea maxlength="100" class="textarea required" name="buyerAddress" value="${buyerAddress}" rows="4"/> </td>--%>
	<%-- endof max validation--%>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Date </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field" name="negotiationDate" value="${negotiationDate ?: DateUtils.shortDateFormat(new Date())}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Currency<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
            <input class="tags_currency select2_dropdown bigdrop required" name="currency" id="currency" />
        </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Amount<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency required" name="amount" value="${amount}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2">
			<span class="field_label"> Additional Amount Claimed <br />(in Negotiation Currency) </span>
		</td>
		<%-- validation of MAX, add a condition if null make default value to zero
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="additionalAmountClaimed" value="${additionalAmountClaimed}"/> </td>--%>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="additionalAmountClaimed" value="${additionalAmountClaimed ?: '0.00'}"/> </td>
          <%--end of MAX validation --%>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Charges <br />(in Negotiation Currency) </span></td>
		<td class="td1"> Code </td>
		<td class="input_width">
            <tfs:chargesInNegoCcy class="select_dropdown" name="chargeCode" value="${chargeCode}" />
        </td>
	</tr>
	<tr>
		<td/>
		<td class="td1"> Amount </td>
		<%-- validation of MAX, add a condition if null make default value to zero
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="chargeAmount" value="${chargeAmount}" /> </td>--%>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="chargeAmount" value="${chargeAmount  ?: '0.00'}" /> </td>
	  <%--end of MAX validation --%>
	</tr>
    <tr>
    	<td/>
        <td class="td1"> Narrative </td>
        <td class="input_width"> <g:textArea maxlength="50" class="textarea" name="chargeNarrative" value="${chargeNarrative}" rows="4" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="popup_btn_charge_narrative_mt742">...</a>
		</td>
    </tr>
	<tr>
		<td class="label_width" colspan="2">
			<span class="title_label"> Total Amount Claimed <br />(in Negotiation Currency)<span class="asterisk">*</span></span>
			<g:hiddenField name="totalAmountClaimedComplete" value="${totalAmountClaimedComplete}" class="required" />
		</td>
	</tr>
	
    <tr>
        <td class="label_width" rowspan="4"> <g:radio name="totalAmountClaimedFlag" value="A" checked="${totalAmountClaimedFlag == 'A' ? true : false}"/> <span class="field_label"> Option A </span> </td>
    </tr>
    <tr>
		<td class="td1">Claimed Date</td>
		<td><g:textField class="input_field" name="totalAmountClaimedDate" readonly="readonly" value="${totalAmountClaimedDate}"/></td>
	</tr>
	<tr>
		<td class="td1">Currency</td>
		<td><g:textField class="input_field" name="totalAmountClaimedCurrencyA" id="totalAmountClaimedCurrencyA" readonly="readonly"/></td>
	</tr>
	<tr>
		<td class="td1">Amount Claimed</td>
		<td><g:textField class="input_field_right numericCurrency" name="totalAmountClaimedA" readonly="readonly" value="${totalAmountClaimedA}"/></td>
	</tr>
   	<!-- Start Henry #4219-->
	 <tr>
        <td class="label_width" rowspan="4"> <g:radio name="totalAmountClaimedFlag" value="B" checked="${totalAmountClaimedFlag == 'B' ? true : false}" data-orig="${totalAmountClaimedFlag}"/> <span class="field_label"> Option B </span> </td>
    </tr>
    <tr> &nbsp;</tr>
	<tr>
		<td class="td1">Currency</td>
		<td>
            <g:textField class="input_field" name="totalAmountClaimedCurrencyB" id="totalAmountClaimedCurrencyB" readonly="readonly"/>
        </td>
	</tr>
	<tr>
		<td class="td1">Amount Claimed</td>
		<td><g:textField class="input_field_right numericCurrency" name="totalAmountClaimedB" readonly="readonly" value="${totalAmountClaimedB}" data-orig="${totalAmountClaimedB}"/></td>
	</tr>
	<!-- End #4219-->

	<tr>
		<td class="label_width" colspan="2"> <span class="title_label"> Account with Bank <br/>(Correspondent Bank) <span class="asterisk hasMt">*</span> </span>
		<g:hiddenField name="corresBankComplete" value="${corresBankComplete}" class="required" /></td>

	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="A" checked="${corresBankFlag == 'A' ? true : false}"/> <span class="field_label"> Option A - Swift Code </span></td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop" name="corresBankCode" id="corresBankCode" />
        </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="B" checked="${corresBankFlag == 'B' ? true : false}"/> <span class="field_label"> Option B - Location </span></td>
		<td class="input_width">
            <g:textField maxlength="35" class="input_field" name="corresBankLocation" readonly="readonly" value="${corresBankLocation}" />
	    </td>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="D" checked="${corresBankFlag == 'D' ? true : false}"/> <span class="field_label"> Option D - Name and Address </span></td>
		<td class="input_width"> <g:textArea maxlength="140" lass="textarea" name="corresBankNameAndAddress" readonly="readonly" value="${corresBankNameAndAddress}" rows="4"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="title_label"> Beneficiary Bank <br/> (Correspondent Bank - Account Number) <span class="asterisk hasMt">*</span> </span>
		<g:hiddenField name="corresBankAccountNumberComplete" value="${corresBankAccountNumberComplete}" class="required" /></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankAccountFlag" value="A" checked="${corresBankAccountFlag == 'A' ? true : false}"/> <span class="field_label"> Option A - Swift Code </span></td>
		<td class="input_width">
<%--            <g:textField class="input_field" name="corresBankAccountCode" id="corresBankAccountCode" readonly="readonly" />--%>
            <input class="tags_cbcode select2_dropdown bigdrop" name="corresBankAccountCode" id="corresBankAccountCode" />
	    </td>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankAccountFlag" value="D" checked="${corresBankAccountFlag == 'D' ? true : false}"/> <span class="field_label"> Option D - Name and Address </span></td>
		<td class="input_width">
            <g:textArea maxlength="140" class="textarea" name="corresBankAccountNameAndAddress" readonly="readonly" value="${corresBankAccountNameAndAddress}" rows="4"/>
        </td>
	</tr>
    <tr>
        <td class="label_width" colspan="2"><span class="field_label">Account Type<span class="asterisk hasMt hasAccount">*</span></span></td>
        <td>
            <input type="radio" disabled="disabled" id="accountType" name="accountType" value="RBU" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" disabled="disabled" id="accountType" name="accountType" value="FCDU" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
            <g:hiddenField name="accountTypeCheck" value="${accountTypeCheck}" class="required" />
        </td>
    </tr>
    <tr>
        <td class="label_width" colspan="2"><span class="field_label">Account Number<span class="asterisk hasMt hasAccount">*</span></span></td>
        <td>
        	<input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" />
            <input type="hidden" id="tempfcdu" name="tempfcdu" value="${tempfcdu}"/>
        	<input type="hidden" id="temprbu" name="temprbu" value="${temprbu}">
        	<input type="hidden" id="tempfcdugl" name="tempfcdugl" value="${tempfcdugl}"/>
        	<input type="hidden" id="temprbugl" name="temprbugl" value="${temprbugl}">
        </td>
    </tr>
    <tr>
        <td class="label_width" colspan="2"><span class="field_label">GL Bank Code</span></td>
        <td><g:textField id="glCode" name="glCode" value="${glCode}" class="input_field" readonly="readonly" /></td>
    </tr>
	<tr>
	<%--MAX-- separate class asterisk and hasMt to validate country code to become mandatory  as of 04/04/2016 redmine 3705--%>
		<td class="label_width" colspan="2"> <span class="field_label"> Country Code<span class="asterisk">*</span></span> </td>
	<%-- end of max redmine 3705--%>
		<td class="input_width">
            <input class="tags_country select2_dropdown bigdrop required" name="countryCode" id="countryCode" />
        </td>
	</tr>
	<tr>
		<td class="label_width valign_top" colspan="2">
			<span class="field_label"> Sender to Receiver Information </span>
		</td>
		<td>
			<tfs:senderToReceiverType1 name="senderToReceiver" class="newSenderToReceiver" value="${senderToReceiver}"/>
		</td>
	</tr>
	<tr>
		<td colspan="2">&#160;</td>
		<td class="label_width">
			<g:textArea maxlength="350" class="textarea" name="senderToReceiverInformation" value="${senderToReceiverInformation}" rows="6" readonly="readonly"/>
			<a href="javascript:void(0)" class="search_btn" id="new_sender_info">...</a>
		</td>
	</tr>
</table>

<table class="buttons_for_grid_wrapper saveButtonsContainer">
    <tr>
        <td><input type="button" id="saveConfirmBasicDetails" class="input_button" value="Save" /></td>
    </tr>
    <tr>
        <td><input type="button" id="cancelConfirmBasicDetails" class="input_button_negative" value="Cancel" /></td>
    </tr>
</table>

<script type="text/javascript">

var glCode = "";
var corresBankCurrency = "";
var corresBankName = "";
var tempfcdu = "";
var temprbu = "";
var tempfcdugl = "";
var temprbugl = "";

function totalAmountClaimedFlagChange() {
    var totalAmountClaimedFlag = $("input[name=totalAmountClaimedFlag]:checked").val();

    if (totalAmountClaimedFlag == "A") {
        $("#totalAmountClaimedDate").removeClass("input_field");
        $("#totalAmountClaimedDate").addClass("datepicker_field");
        createDatePicker($("#totalAmountClaimedDate"));
		
        $("#totalAmountClaimedCurrencyA").select2("enable");

        $("#totalAmountClaimedCurrencyB").select2("disable");
        $("#totalAmountClaimedCurrencyB").select2('data',{id: null});
        computeTotalAmountClaimed();
        if($("#totalAmountClaimedDate").val() != "" && $("#totalAmountClaimedCurrencyA").val() != "" && $("#totalAmountClaimedA").val() != ""){
        	$("#totalAmountClaimedComplete").val("true");
        }else{
        	$("#totalAmountClaimedComplete").val("");
        }
    } else if (totalAmountClaimedFlag == "B") {
        $("#totalAmountClaimedDate").val("");
		
        computeTotalAmountClaimed();

        $("#totalAmountClaimedDate").datepicker("destroy");
        $("#totalAmountClaimedDate").removeClass("datepicker_field");
        $("#totalAmountClaimedDate").addClass("input_field");

        $("#totalAmountClaimedCurrencyB").select2("enable");
        $("#totalAmountClaimedCurrencyA").select2("disable");
        $("#totalAmountClaimedCurrencyA").select2('data',{id: null});
        if($("#totalAmountClaimedCurrencyB").val() != "" && $("#totalAmountClaimedB").val() != ""){
        	$("#totalAmountClaimedComplete").val("true");
        }else{
        	$("#totalAmountClaimedComplete").val("");
        }
    } else {
        $("#totalAmountClaimedDate").datepicker("destroy");
        $("#totalAmountClaimedA").val("");
        $("#totalAmountClaimedB").val("");

        $("#totalAmountClaimedCurrencyB").select2("disable");
        $("#totalAmountClaimedCurrencyA").select2("disable");
    }
}

function corresBankFlagChange() {
    var corresBankFlag = $("input[name=corresBankFlag]:checked").val();
    if (corresBankFlag == "A") {
        $("#corresBankCode").select2("enable");
        $("#corresBankLocation").val("");
        $("#corresBankLocation").attr("readonly", "readonly");
        $("#corresBankNameAndAddress").val("");
        $("#corresBankNameAndAddress").attr("readonly", "readonly");
        $("#accountTypeCheck").toggleClass("required", true);
        $("#depositoryAccountNumber").toggleClass("required", true);
        $(".hasAccount").text("*");
    } else if (corresBankFlag == "B") {
        $("#corresBankCode").select2("data", null);
        $("#corresBankCode").select2("disable");
        $("#corresBankLocation").removeAttr("readonly");
        $("#corresBankNameAndAddress").val("");
        $("#corresBankNameAndAddress").attr("readonly", "readonly");
        $("#accountTypeCheck").toggleClass("required", false);
        $("#depositoryAccountNumber").toggleClass("required", false);
        $(".hasAccount").text("");
        clearAccountDetails();
    } else if (corresBankFlag == "D") {
        $("#corresBankCode").select2("data", null);
        $("#corresBankCode").select2("disable");
        $("#corresBankLocation").val("");
        $("#corresBankLocation").attr("readonly", "readonly");
        $("#corresBankNameAndAddress").removeAttr("readonly");
        $("#accountTypeCheck").toggleClass("required", false);
        $("#depositoryAccountNumber").toggleClass("required", false);
        $(".hasAccount").text("");
        clearAccountDetails();
    } else {
        $("#corresBankCode").select2("data", null);
        $("#corresBankCode").select2("disable");
        $("#corresBankLocation").val("");
        $("#corresBankLocation").attr("readonly", "readonly");
        $("#corresBankLocation").val("");
        $("#corresBankLocation").attr("readonly", "readonly");
        $("#accountTypeCheck").toggleClass("required", false);
        $("#depositoryAccountNumber").toggleClass("required", false);
        $(".hasAccount").text("");
        clearAccountDetails();
    }
}

function onTotalAmountClaimedCheck() {
	if(($("#totalAmountClaimedDate").val() != "" && $("#totalAmountClaimedCurrencyA").val() != "") || $("#totalAmountClaimedCurrencyB").val() != "") {
		$("#totalAmountClaimedComplete").val("true");
	} else {
		$("#totalAmountClaimedComplete").val("");
	}
}

function onCorresBankCheck() {
	if($("#corresBankCode").val() != "" || $("#corresBankLocation").val() != "" || $("#corresBankNameAndAddress").val() != ""){
		$("#corresBankComplete").val("true");
	} else {
		$("#corresBankComplete").val("");
	}
}

function onCorresBankAccountNumberCheck() {
	if($("#corresBankAccountCode").val() != "" || $("#corresBankAccountNameAndAddress").val() != ""){
			$("#corresBankAccountNumberComplete").val("true");
	} else {
		$("#corresBankAccountNumberComplete").val("");
	}
}

function onAccountTypeCheck() {
	if($("input[name='accountType']:checked").val()){
		$("#accountTypeCheck").val("true");
	} else {
		$("#accountTypeCheck").val("");
	}
}

function clearAccountDetails() {
    $("#glCode").val("");
    $("#corresBankCurrency").val("");
    $("#corresBankName").val("");
    $("#tempfcdu").val("");
    $("#temprbu").val("");

    $("#depositoryAccountNumber").val("");
    $("input[name=accountType]").removeAttr("checked");
    $("input[name=accountType]").attr("disabled", "disabled");
}

function setupAccountDetails() {
    $("#glCode").val(glCode);
    $("#corresBankCurrency").val(corresBankCurrency);
    $("#corresBankName").val(corresBankName);
    $("#tempfcdu").val(tempfcdu);
    $("#temprbu").val(temprbu);

	if(tempfcdu){
    	$("input[name=accountType][value=FCDU]").removeAttr("disabled");
    }
	if(temprbu){
    	$("input[name=accountType][value=RBU]").removeAttr("disabled");
    }
}

function corresBankAccountFlagChange() {
    var corresBankAccountFlag = $("input[name=corresBankAccountFlag]:checked").val();
	
    if (corresBankAccountFlag == "A") {
        $("#corresBankAccountCode").select2("enable");
        $("#corresBankAccountNameAndAddress").val("");
        $("#corresBankAccountNameAndAddress").attr("readonly", "readonly");
    } else if (corresBankAccountFlag == "D") {
        $("#corresBankAccountCode").select2("data", null);
        $("#corresBankAccountCode").val("");
        $("#corresBankAccountCode").select2("disable");
        $("#corresBankAccountNameAndAddress").removeAttr("readonly");
    } else {
        $("#corresBankAccountCode").select2("data", null);
        $("#corresBankAccountCode").val("");
        $("#corresBankAccountCode").select2("disable");
        $("#corresBankAccountNameAndAddress").attr("readonly", "readonly");
    }
}

function computeTotalAmountClaimed() {

    var totalAmountClaimedFlag = $("input[name=totalAmountClaimedFlag]:checked").val();

    var amount = 0;
    var additionalAmountClaimed = 0;
    var chargesAmount = 0;

    if ($("#amount").val()) {
        amount = parseFloat($("#amount").val().replace(/,/g,""));
    }

    if ($("#additionalAmountClaimed").val()) {
        additionalAmountClaimed = parseFloat($("#additionalAmountClaimed").val().replace(/,/g,""));
    }

    if ($("#chargeAmount").val()) {
        chargesAmount = parseFloat($("#chargeAmount").val().replace(/,/g,""));
    }

    if (totalAmountClaimedFlag == "A") {
    	$("#totalAmountClaimedCurrencyB").val("");
        $("#totalAmountClaimedB").val("");
        var totalAmountClaimed = (amount + additionalAmountClaimed) - chargesAmount;
		
    	$("#totalAmountClaimedCurrencyA").val($("#currency").val());
        $("#totalAmountClaimedA").val(formatCurrency(totalAmountClaimed));
    } else if (totalAmountClaimedFlag == "B") {
    	$("#totalAmountClaimedCurrencyA").val("");
        $("#totalAmountClaimedA").val("");
        var totalAmountClaimed = (amount + additionalAmountClaimed) - chargesAmount;

    	$("#totalAmountClaimedCurrencyB").val($("#currency").val());
        $("#totalAmountClaimedB").val(formatCurrency(totalAmountClaimed));
	}
}


function onCorresBankLoad() {
	if ($("#corresBankAccountCode").val()){
		$("input[name=accountType]").removeAttr("disabled");
	}
}

function onChangePaymentModeEB() {
    if ($("#paymentMode").val() != "LC") {
        $("#exlcAdviseNumber").select2("data", null);
        $("#exlcAdviseNumber").parents("tr").hide();
        $("#drawee").removeClass("required");
        $(".hasLC").text("");
        
        
        if($(".mtFlag").filter(":checked").val() == "1"){
        	$(".mtFlag").filter(":checked").removeAttr("checked");
        	$(".mtFlag").filter("[value=0]").attr("checked","checked");
        }
        
        $(".mtFlag").attr("disabled","disabled");
        $(".mtFlag").change();
        $("#sellerName").removeAttr("readonly");
    } else {
        $(".hasLC").text("*");
        $("#drawee").addClass("required");
    	$("#exlcAdviseNumber").parents("tr").show();
        $(".mtFlag").removeAttr("disabled");
    }}

var autoCompleteExportAdvisingUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteExportAdvising")}';

$(document).ready(function() {
	var participantCode = $('#participantCode').val(),
        cifNumber = $('#cifNumber').val(),
        particulars = $('#particulars').val(),
        splittedParticulars;
    
    if ($("#cifNumber").length > 0) {
        $("#cifNumber").change(function() {
            $("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});
            $("#exlcAdviseNumber").select2("data", null);

            $('#tempTinNumber').val($('#tinNumber').val());

            $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
                if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                    $('#participantCode').val(data.results[0].id);
                }
            });
        });
    } else {
        $('#cifNumber').change(function() {
	        $('#tempTinNumber').val($('#tinNumber').val());
	
	        $.get(autoCompleteParticipantCodeUrl, {starts_with: $('#cifNumber').val()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $('#participantCode').val(data.results[0].id);
	            }
	        });
	    });
    }
    
    if ('${statusAction}'.toUpperCase() === "APPROVE") {
    	$("#exlcAdviseNumber").attr("disabled", "disabled");
    }

    $("#currency").setCurrencyDropdownForeign($(this).attr("id")).select2('data',{id: '${currency}'});
    $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});
    $("#corresBankAccountCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankAccountCode}'});

    //$("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});

    $("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
    $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: '${particularsLabel}'});

    $('#tempTinNumber').change(function() {
        $('#tinNumber').val($('#tempTinNumber').val());
    });
    
    $("#particularsLabel").change(function() {
        splittedParticulars = $(this).val().split("-");
        if(splittedParticulars.length > 0) {
            $('#particulars').val(splittedParticulars[0].toString().trim());
        }
    });
    
    if(particulars) {
        $.get(autoCompleteParticularsUrl, {starts_with: particulars.toString().trim()}, function(data) {
            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
                $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
            }
        });
    }
    
    
    // extract from EBC
    

    $("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});

    if ($("#exlcAdviseNumber").val()) {
        $("#currency").select2("disable");
    }

    $("#exlcAdviseNumber").change(function(e) {
        var id = "";
        var currency = "";
        var amount = "";
        var buyerName = "";
        var buyerAddress = "";
        var sellerName = "";
        var sellerAddress = "";
        var cbCode = "";
        var cif;

        if (e.target.value != "") {
            id = $("#exlcAdviseNumber").select2('data').documentNumber;
            currency = $("#exlcAdviseNumber").select2('data').currency;
            amount = $("#exlcAdviseNumber").select2('data').amount;
            buyerName = $("#exlcAdviseNumber").select2('data').buyerName;
            buyerAddress = $("#exlcAdviseNumber").select2('data').buyerAddress;
            sellerName = $("#exlcAdviseNumber").select2('data').sellerName;
            sellerAddress = $("#exlcAdviseNumber").select2('data').sellerAddress;
            cbCode = $("#exlcAdviseNumber").select2('data').cbCode;
            cif = $("#exlcAdviseNumber").select2('data').cif;
            
            console.log("data of exlcAdviseNumber: ")
            console.log($("#exlcAdviseNumber").select2('data'))
            
            $("#currency").select2("data", {id: currency});
            $("#currency").select2("disable");
            $("#amount").val(amount);
            $("#sellerName").val(sellerName);
            $("#sellerAddress").val(sellerAddress);
            $("#buyerName").val(buyerName);
            $("#buyerAddress").val(buyerAddress).text(buyerAddress);
            $("#exporterCbCode").select2("disable"); //additional validation of max,make field protected/not editable
            $("#sellerName").attr("readonly", "readonly");

            if (cif) {
                $("#cifNumber").val(cif.cifNumber);
                $("#cifName").val(cif.cifName);
                $("#accountOfficer").val(cif.accountOfficer);
                $("#ccbdBranchUnitCode").val(cif.ccbdBranchUnitCode);

                $("#cifNumberParam").val(cif.cifNumber);
                $("#cifNameParam").val(cif.cifName);
                $("#accountOfficerParam").val(cif.accountOfficer);
                $("#ccbdBranchUnitCodeParam").val(cif.ccbdBranchUnitCode);
                $("#exporterCbCode").val(cif.exporterCbCode);
                $("#mainCifNumber").val(cif.mainCifNumber);
                $("#mainCifName").val(cif.mainCifName);
                console.log("allocationUnitCode: " + cif.allocationUnitCode);
                $("#allocationUnitCode").val(cif.allocationUnitCode);
                $("#allocationUnitCodeParam").val(cif.allocationUnitCode);
                console.log("allocationUnitCode value: " + $("#allocationUnitCode").val())
            }

            if (cbCode) {
                $("#exporterCbCode").select2("data", {id: cbCode});
            }

            $("#paymentMode").val("LC");

            var changeUrl = '${g.createLink(controller: "exportBillsPurchase", action: "getExportAdvising")}';

            $.get(changeUrl, {exlcNumber: $("#exlcAdviseNumber").val()}, function(exportAdvising) {

				console.log("exportAdvising: ")
				console.log(exportAdvising);
                $("#adviseNumber").val($("#exlcAdviseNumber").val());
                $("#lcNumber").val(exportAdvising.lcNumber);
                $("#lcIssueDate").val(exportAdvising.lcIssueDate);
                $("#lcType").val(exportAdvising.lcType);
                $("#lcTenor").val(exportAdvising.lcTenor);
                $("#usanceTerm").val(exportAdvising.usanceTerm);
                $("#lcCurrency").val(exportAdvising.lcCurrency);
                $("#lcAmount").val(formatCurrency(exportAdvising.lcAmount));
                $("#lcExpiryDate").val(exportAdvising.lcExpiryDate);

                $("#issuingBankCode").val(exportAdvising.issuingBank);
                $("#issuingBankName").val(exportAdvising.issuingBankName);
                $("#issuingBankAddress").val(exportAdvising.issuingBankAddress);
				$("#reimbursingBankCodeHidden").val(exportAdvising.reimbursingBankCode); //created by max to save reimbursing bank
                $("#reimbursingBankCode").val(exportAdvising.reimbursingBankCode);
            })
        } else {
            $("#currency").select2("data", null);
            $("#currency").select2("enable");
            $("#amount").val("");
            $("#sellerName").val("");
            $("#buyerName").val("");
            $("#buyerAddress").val("").text("");

            $("#cifNumber").val("");
            $("#cifName").val("");
            $("#accountOfficer").val("");
            $("#ccbdBranchUnitCode").val("");

            $("#exporterCbCode").select2("data", null);
            $("#paymentMode").val("");
            $("#exporterCbCode").select2("enable"); //additional validation of max,make field protected/not editable
            $("#sellerName").removeAttr("readonly");
            
        }
    });

	<%--
	$("#totalAmountClaimedCurrencyA").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${totalAmountClaimedCurrencyA}'});
    $("#totalAmountClaimedCurrencyB").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${totalAmountClaimedCurrencyB}'});
	--%>

    $("input[name=totalAmountClaimedFlag]").click(totalAmountClaimedFlagChange);
    totalAmountClaimedFlagChange();

    $("input[name=corresBankFlag]").click(corresBankFlagChange);
    corresBankFlagChange();

    $("input[name=corresBankAccountFlag]").click(corresBankAccountFlagChange);
    corresBankAccountFlagChange();

    $("#corresBankCode").on("change", function(e) {
    	var data = $("#corresBankCode").select2('data');
	if(data != null){
        $("#glCode").val(data.glcode);
        $("#corresBankCurrency").val(data.currency);
        $("#corresBankName").val(data.label);
        $("#tempfcdu").val(data.fcduAccount);
        $("#temprbu").val(data.rbuAccount);
        $("#tempfcdugl").val(data.glcodefcdu);
        $("#temprbugl").val(data.glcoderbu);

        $("#accountType[value=RBU]").attr('disabled',false).attr('checked', false);
        $("#accountType[value=FCDU]").attr('disabled',false).attr('checked', false);
        $("#depositoryAccountNumber").val('');
    }else{
        $("#glCode").val('');
        $("#corresBankCurrency").val('');
        $("#corresBankName").val('');
        $("#tempfcdu").val('');
        $("#temprbu").val('');
        $("#tempfcdugl").val('');
        $("#temprbugl").val('');
    }
    if($("#temprbugl").val() && $("#tempfcdugl").val()){
    	$("#accountType[value=RBU]").attr('checked',true);
        $("#accountType[value=RBU]").click();
    }else {
    if(!$("#temprbugl").val()) {
        $("#accountType[value=RBU]").attr('disabled',true).attr('checked', false);
        $("#accountType[value=FCDU]").attr('checked',true);
        $("#accountType[value=FCDU]").click();
    }

    if(!$("#tempfcdugl").val()) {
        $("#accountType[value=FCDU]").attr('disabled',true).attr('checked', false);
        $("#accountType[value=RBU]").attr('checked',true);
        $("#accountType[value=RBU]").click();
    }
    }
    });
    
    $("#totalAmountClaimedFlag, #totalAmountClaimedDate, #totalAmountClaimedCurrencyA, #totalAmountClaimedCurrencyB").each(function(){
    	$(this).change(onTotalAmountClaimedCheck);
    });
    onTotalAmountClaimedCheck();
    
    $("#corresBankCode, #corresBankLocation, #corresBankNameAndAddress").each(function(){
    	$(this).change(onCorresBankCheck);
    });
    
    onCorresBankCheck();
    
   	$("#corresBankAccountNameAndAddress, #corresBankAccountCode").change(onCorresBankAccountNumberCheck);
    onCorresBankAccountNumberCheck();


    $("input[name='accountType']").on("click", function(e) {
        if($("input[name='accountType']:checked").val() == 'RBU') {
            $("#depositoryAccountNumber").val($("#temprbu").val());
            $("#glCode").val($("#temprbugl").val());
        } else {
            $("#depositoryAccountNumber").val($("#tempfcdu").val());
            $("#glCode").val($("#tempfcdugl").val());
        }
        onAccountTypeCheck();
    });
    onAccountTypeCheck();

    $("#amount, #additionalAmountClaimed, #chargeAmount").change(computeTotalAmountClaimed);

    // REDMINE ISSUE 3734 (ROBIN)
    $("#saveConfirmBasicDetails").click(function() {
    	$('#draftAmount').val($('#amount').val());
    	if(validateExportTab("#basicDetailsTabForm") > 0){
	    		triggerAlertMessage(val_msg);
    	} else {
        	mCenterPopup($("#loading_div"), $("#loading_bg"));
        	mLoadPopup($("#loading_div"), $("#loading_bg"));
            // $("#basicDetailsTabForm").submit();
            //changed the submit form with the tech to submit 2 forms
            $.post($("#basicDetailsTabForm").attr("action"), $("#basicDetailsTabForm").serialize(), function() {
            	$.post($("#setupNonLcDetailsTabForm").attr("action"), $("#setupNonLcDetailsTabForm").serialize(), function() {
                	document.location.reload(); 	
                });
            });
    	}
    });
    // REDMINE 3734 (ROBIN) end

    $("#cancelConfirmBasicDetails").click(function() {
    	$(".saveAction").hide();
       	$(".cancelAction").show();
        mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
    });

	// For CIF CB CODE
    $("#cifSearchSelect").click(function() {
      	var data = $("#grid_list_cif").jqGrid("getRowData");
       	console.log(data[0].cbCode);
     	$("#exporterCbCode").val(data[0].cbCode);
    });
	
    $("#paymentMode").change(onChangePaymentModeEB);
    onChangePaymentModeEB();
    
    onCorresBankLoad();
    
	//remove required classes on fields if no MT to generate
	$(".mtFlag").change(function(){
		if($(this).filter(":checked").val() == "0" || $(".mtFlag").attr("disabled") == "disabled"){
	//		$(".hasMt").text("");
			$("#totalAmountClaimedComplete").removeClass("required");
			$("#totalAmountClaimedComplete").siblings('[class="title_label"]').children().text("");
	//		$("#corresBankComplete").removeClass("required");
	//		$("#corresBankAccountNumberComplete").removeClass("required");
	//		$("#accountTypeCheck").removeClass("required");
	//		$("#depositoryAccountNumber").removeClass("required");
	//		$("#countryCode").removeClass("required"); //commented by MAX for redmine 3705
		}else{
	//		$(".hasMt").text("*");
			$("#totalAmountClaimedComplete").addClass("required");
			$("#totalAmountClaimedComplete").siblings('[class="title_label"]').children().text("*");
	//		$("#corresBankComplete").addClass("required");
	//		$("#corresBankAccountNumberComplete").addClass("required");
	//		$("#accountTypeCheck").addClass("required");
	//		$("#depositoryAccountNumber").addClass("required");
	//		$("#countryCode").addClass("required"); //commented by MAX for redmine 3705
		}
	});
	
	$(".mtFlag").change();
});
    
</script>

