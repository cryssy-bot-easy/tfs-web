<%--//	PROLOGUE:
	(revision)
	SCR/ER Number: 
	SCR/ER Description: redmine 3705 - EBC/EBP Nego - Country Code - Mandatory Field
	[Revised by:] Maximo Brian Lulab
	[Date revised:] 04/04/2016
	Program [Revision] Details: To validate on input of country code to make field mandatory.
	Date deployment: 3/15/2016 
	Member Type: GSP
	Project: WEB
	Project Name: _basic_details_tab.gsp
 --%>
<%@ page import="net.ipc.utils.DateUtils" %>
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
SCR/ER Description: Tenor Term and Collecting Bank's Name in Set-up NonLC Details tab of EBP NEGO,
be extracted from EBC Nego (Redmine# 3739)
[Revised by:] Robin C. Rafael
[Date deployed:]
Program [Revision] Details: Added a hidden field to get the nego number for data extraction
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _basic_details_tab.gsp
--%>

<%-- 
(revision)
	SCR/ER Number: 
	SCR/ER Description:
		1. EBC Nego - Importer Address should follow the template for beneficiary address (Redmine# 4125)
		2. There is EXPORTERCBCODE in EBC Nego but none in EBP Nego (Redmine# 4136) 
		3. EBP Negotiation Importer Address (Redmine# 4139)
		4. EBP Negotiation - E-TS Inquiry and Data Entry Inquiry and EBP Settlement Inquiry Screens (Redmine# 4158)
		5. EBP Negotiation - Corres Bank (Redmine# 4178)
		6. Tab validation (Redmine# 4196)
		7. EBC NEGO DATA ENTRY - MT GENERATION (Redmine# 4200)
	[Revised by:] Brian Harold A. Aquino
	[Date revised:] 
		1. 01/26/2017 (tfs-web Rev# 7350)
		2. 01/26/2017 (tfs-web Rev# 7356)
		3. 02/08/2017 (tfs-web Rev# 7357)
		4. 02/21/2017 (tfs-web Rev# 7406)
		5. 03/03/2017 (tfs-web Rev# 7421)
		6. 04/03/2017 (tfs-web Rev# 7433)
		7. 04/04/2017 (tfs-web Rev# 7460)
	[Date deployed:] 06/16/2017
	Program [Revision] Details: 
		1. Added an ellipsis button for Importer Address.
		2. Added an Exporter CB Code dropdown list.
		3. Importer Address name was changed from importerAddress to buyerAddress, same procedure for the value.
		4. Added a condition that validates if viewed in inquiry.
		5. Corres Bank and Corres Bank Account was set to mandatory field.
		6. Added 'data-orig' attribute in every input field.
		7. Added validation for toggling of 'Generate MT'.
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
    [Revised date:] 03/20/2018
    Program [Revision:] add new Fields TIN, Exporter Code, Particulars and their behavior. Add temporary name tempTinNumber to prevent having 2 tinNumber.
    PROJECT: WEB
    MEMBER TYPE  : WEB
    Project Name: _basic_details_tab.gsp
    
    (revision)
    Modified by: Rafael Ski Poblete
    Date : 7/26/18
    Description : Changed sender to receiver and charges narrative fields into popup instead of normal textarea to set right delimiter.
--%>

<g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
<g:hiddenField name="serviceType" value="${serviceType}" />
<g:hiddenField name="documentType" value="${documentType}" />
<g:hiddenField name="documentClass" value="${documentClass}" />
<g:hiddenField name="referenceType" value="${referenceType}" />
<g:hiddenField name="stat" value="${statusAction}" />
<g:hiddenField name="form" value="basicDetails" />

<g:hiddenField name="processingUnitCode" value="${processingUnitCode}"/>
<table class="tabs_forms_table">
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Generate MT? </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="mtFlag" class="mtFlag" labels="['Yes','No']" values="[1, 0]" value="${mtFlag ?: 0}" data-orig="${mtFlag ?: 0}" >
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
		<td class="input_width"> <g:textField class="input_field" name="invoiceNumber" value="${invoiceNumber}" data-orig="${invoiceNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Payment Mode </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="paymentMode" from="['LC','DP','DA','OA','DR']" noSelection="['':'SELECT ONE...']" value="${paymentMode}" data-orig="${paymentMode}"/> </td>
		<g:hiddenField name="paymentMode" id="paymentModeHidden" value="${paymentMode}" disabled="true"/>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="documentNumber" readonly="readonly" value="${documentNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Date <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="datepicker_field required" name="negotiationDate" value="${negotiationDate ?: DateUtils.shortDateFormat(new Date())}" data-orig="${negotiationDate}" /> </td>
		<g:hiddenField name="valueDate" value="${negotiationDate ?: valueDate}" />
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> e-TS Number <span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" readonly="readonly" name="etsNumber" value="${serviceInstructionId ?: etsNumber}" data-orig="${serviceInstructionId ?: etsNumber}" /> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> e-TS Date </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="etsDate" readonly="readonly" value="${etsDate}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Main CIF Number </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifNumber" readonly="readonly" value="${mainCifNumber}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Main CIF Name </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="mainCifName" readonly="readonly" value="${mainCifName}"/> </td>
	</tr>
	
<%-- Added Exporter CB Code for Issue# 4316 --%>
	<tr>
		<td class="label_width" colspan="2">
			<span class="field_label"> Exporter CB code<%-- <br />(if without CIF No.)<span class="asterisk">*</span>--%></span>
		</td>
		<td class="input_width" colspan="2">
			<g:textField class="input_field" name="exporterCbCode" id="exporterCbCode" readonly="readonly" value="${exporterCbCode}"/>
<%--            <input class="tags_cbcode select2_dropdown bigdrop cbcodeDd" name="exporterCbCode" id="exporterCbCode" readonly="readonly" disabled="disabled" data-orig="${exporterCbCode}"/>--%>
<%--            <g:hiddenField name="exporterCbCodeCheck" value="${exporterCbCodeCheck}" />--%>
        </td>
	</tr>
<%-- End of Issue# 4316 --%>
	
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Exporter Name (Drawer)<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="sellerName" value="${sellerName}" data-orig="${sellerName}" maxlength="60"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top" colspan="2"><span class="field_label"> Exporter Address<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
			<g:textArea name="sellerAddress" value="${sellerAddress}" class="textarea required" data-orig="${sellerAddress}" rows="4"/>
		</td>
	</tr>
	<tr>
        <td colspan="2"> <span class="field_label">TIN <span class="asterisk">*</span></span> </td>
        <td><g:textField class="input_field required" name="tempTinNumber" value="${tinNumber}" data-orig="${tinNumber}" maxLength="20"/> </td>
    <tr>
    <tr>
        <td class="label_width" colspan="2"> <span class="field_label">Exporter Code</span></td>
            <td class="input_width"> <g:textField class="input_field" name="participantCode"id="participantCode" value="${participantCode}" data-orig="${participantCode}" maxlength="10"/> </td>
    </tr>
    <tr>
        <td class="label_width" colspan="2" > <span class="field_label">Particulars</span> </td>
        <td class="input_width">
            <%-- Auto Complete --%>
            <input class="select2_dropdown" name="particularsLabel" id="particularsLabel" data-orig="${particularsLabel}"/>
            <g:hiddenField name="particulars" id="particulars" value="${particulars}" data-orig="${particulars}"/>
        </td>
    </tr>
	<tr>
		<td class="label_width" colspan="2"><span class="field_label"> Drawee </span></td>
		<td class="inpute_width"> <g:textField maxlength="100" name="drawee" class="input_field" value="${drawee}" data-orig="${drawee}" /> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Importer Name<span class="asterisk">*</span> </span> </td>
		<td class="input_width"> <g:textField class="input_field required" name="buyerName" value="${buyerName}" data-orig="${buyerName}" maxlength="100"/> </td>
	</tr>
	<tr>
		<td class="label_width valign_top" colspan="2"><span class="field_label"> Importer Address<span class="asterisk">*</span> </span> </td>
	<%-- added ellipsis button for Issue# 4125 of Deffered Issues --%>
		<td class="input_width">
			<g:textArea name="buyerAddress" value="${buyerAddress}" class="textarea required" rows="4" data-orig="${buyerAddress}" readonly="readonly"/>
			<span class="float_right">
				<a href="javascript:void(0)" class="search_btn" id="popup_btn_importer_bank_address">...</a>
			</span>
		</td>
	<%-- end of Issue# 4125	--%>
	
<%-- old code --%>
<%--		<td class="input_width">--%>
<%--			<g:textArea name="buyerAddress" value="${buyerAddress}" class="textarea required" rows="4"/>--%>
<%--		</td>--%>
	</tr>
    <tr>
        <td class="label_width" colspan="2"> <span class="field_label"> EXLC Advice Number </span> </td>
        <td class="input_width">
            <g:textField class="select2_dropdown bigdrop exlcDd" name="exlcAdviseNumber" value="" data-orig="${exlcAdviseNumber}" />
        </td>
    </tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> EB Facility Type </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="bpFacilityType" keys="['FBE', 'FEB']" from="['Export Bills Purchased', 'Export Bills Purchased Discounted']" noSelection="['':'SELECT ONE...']" value="${bpFacilityType}" data-orig="${bpFacilityType}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> With Outstanding EBC?<span class="asterisk">*</span> </span> </td>
		<td class="input_width">
		  	<g:radioGroup name="withBcFlag" labels="['Yes','No']" values="[1,0]" value="${withBcFlag}" data-orig="${withBcFlag}">
		        ${it.radio}<g:message code="${it.label}" /> &#160; &#160; &#160;
		    </g:radioGroup>
		    <g:hiddenField name="withBcFlagCheck" data-orig="withBcFlagCheck" class="required" />
		</td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label small_margin_left"> If Yes: Negotiation Number </span> </td>
		<td class="input_width"> <g:select class="select_dropdown" name="negotiationNumber" from="" noSelection="['':'SELECT ONE...']" value="${negotiationNumber}" data-orig="${negotiationNumber}"/> </td>
		<%-- REDMINE 3739 (ROBIN) --%>
		<g:hiddenField name="oldNegotiationNumber" value="${negotiationNumber}" data-orig="${negotiationNumber}" />
		<%-- REDMINE 3739 (ROBIN) end --%>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label small_margin_left"> EBC Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field" name="bcCurrency" readonly="readonly" value="${bcCurrency}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label small_margin_left"> EBC Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="bcAmount" readonly="readonly" value="${bcAmount}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Currency </span> </td>
		<td class="input_width"> <g:textField class="input_field currDd" name="currency" readonly="readonly" value="${currency}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="field_label"> Negotiation Amount </span> </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="amount" readonly="readonly" value="${amount}"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2">
			<span class="field_label"> Additional Amount Claimed <br />(in Negotiation Currency) </span>
		</td>
		<td class="input_width">
            <g:textField class="input_field_right numericCurrency" name="additionalAmountClaimed" value="${additionalAmountClaimed ?: '0.00'}" data-orig="${additionalAmountClaimed}"/>
        </td>
	</tr>
	<tr>
		<td class="label_width"><span class="field_label"> Charges <br />(in Negotiation Currency) </span></td>
		<td class="td1"> Code </td>
		<td class="input_width">
            <tfs:chargesInNegoCcy class="select_dropdown" name="chargeCode" value="${chargeCode}" data-orig="${chargeCode}" />
        </td>
	</tr>
	<tr>
		<td/>
		<td class="td1"> Amount </td>
		<td class="input_width"> <g:textField class="input_field_right numericCurrency" name="chargeAmount" value="${chargeAmount ?: '0.00'}" data-orig="${chargeAmount}" /> </td>
	</tr>
    <tr>
    	<td/>
        <td class="td1"> Narrative </td>
        <td class="input_width"> <g:textArea class="textarea" name="chargeNarrative" value="${chargeNarrative}" data-orig="${chargeNarrative}" rows="4" readonly="readonly"/>
    	<a href="javascript:void(0)" class="search_btn" id="popup_btn_charge_narrative_mt742">...</a> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2">
			<span class="title_label"> Total Amount Claimed <br />(in Negotiation Currency)<span class="asterisk hasMt">*</span> </span>
			<g:hiddenField name="totalAmountClaimedComplete" value="${totalAmountClaimedComplete}" class="required" data-orig="${totalAmountClaimedComplete}" />
		</td>
	</tr>
    <tr>
        <td class="label_width" rowspan="4"> <g:radio name="totalAmountClaimedFlag" value="A" checked="${totalAmountClaimedFlag == 'A' ? true : false}" data-orig="${totalAmountClaimedFlag}"/> <span class="field_label"> Option A </span> </td>
    </tr>
    <tr>
		<td class="td1">Claimed Date</td>
		<td><g:textField class="input_field" name="totalAmountClaimedDate" readonly="readonly" value="${totalAmountClaimedDate}" data-orig="${totalAmountClaimedDate}"/></td>
	</tr>
	<tr>
		<td class="td1">Currency</td>
		<td>
            <input class="tags_currency select2_dropdown bigdrop currDd" name="totalAmountClaimedCurrencyA" id="totalAmountClaimedCurrencyA" data-orig="${totalAmountClaimedCurrencyA}" />
            %{--<input class="tags_currency select2_dropdown bigdrop" name="totalAmountClaimedCurrencyA" id="totalAmountClaimedCurrencyA" />--}%
        </td>
	</tr>
	<tr>
		<td class="td1">Amount Claimed</td>
		<td><g:textField class="input_field_right numericCurrency" name="totalAmountClaimedA" readonly="readonly" value="${totalAmountClaimedA}" data-orig="${totalAmountClaimedA}"/></td>
	</tr>
	<!-- Start Henry #4219-->
	 <tr>
        <td class="label_width" rowspan="4"> <g:radio name="totalAmountClaimedFlag" value="B" checked="${totalAmountClaimedFlag == 'B' ? true : false}" data-orig="${totalAmountClaimedFlag}"/> <span class="field_label"> Option B </span> </td>
    </tr>
    <tr> &nbsp;</tr>
	<tr>
		<td class="td1">Currency</td>
		<td>
            <input class="tags_currency select2_dropdown bigdrop currDd" name="totalAmountClaimedCurrencyB" id="totalAmountClaimedCurrencyB" data-orig="${totalAmountClaimedCurrencyB}" />
        </td>
	</tr>
	<tr>
		<td class="td1">Amount Claimed</td>
		<td><g:textField class="input_field_right numericCurrency" name="totalAmountClaimedB" readonly="readonly" value="${totalAmountClaimedB}" data-orig="${totalAmountClaimedB}"/></td>
	</tr>
	<!-- End #4219-->
    
	<tr>
		<td class="label_width" colspan="2"> <span class="title_label"> Correspondent Bank<span class="asterisk">*</span> </span> 
		<g:hiddenField name="corresBankComplete" value="${corresBankComplete}" class="required" data-orig="${corresBankComplete}" /></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="A" checked="${corresBankFlag == 'A' ? true : false}" data-orig="${corresBankFlag}"/> <span class="field_label"> Option A - Swift Code </span></td>
		<td class="input_width">
            <input class="tags_cbcode select2_dropdown bigdrop depoBankDd" name="corresBankCode" id="corresBankCode" data-orig="${corresBankCode}"/>
        </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="B" checked="${corresBankFlag == 'B' ? true : false}" data-orig="${corresBankFlag}"/> <span class="field_label"> Option B - Location </span></td>
		<td class="input_width">
            <g:textField class="input_field" name="corresBankLocation" readonly="readonly" value="${corresBankLocation}" data-orig="${corresBankLocation}" />
	    </td>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankFlag" value="D" checked="${corresBankFlag == 'D' ? true : false}" data-orig="${corresBankFlag}"/> <span class="field_label"> Option D - Name and Address </span></td>
		<td class="input_width"> <g:textArea class="textarea" name="corresBankNameAndAddress" readonly="readonly" value="${corresBankNameAndAddress}" data-orig="${corresBankNameAndAddress}" rows="4"/> </td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <span class="title_label"> Correspondent Bank - Account Number<span class="asterisk">*</span> </span> 
		<g:hiddenField name="corresBankAccountNumberComplete" value="${corresBankAccountNumberComplete}" class="required" data-orig="${corresBankAccountNumberComplete}" data-orig="${corresBankAccountNumberComplete}" /></td>
	</tr>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankAccountFlag" value="A" checked="${corresBankAccountFlag == 'A' ? true : false}" data-orig="${corresBankAccountFlag}"/> <span class="field_label"> Option A - Swift Code </span></td>
		<td class="input_width">
<%--            <g:textField class="input_field" name="corresBankAccountCode" id="corresBankAccountCode" readonly="readonly" />--%>
            <input class="tags_cbcode select2_dropdown bigdrop depoBankDd" name="corresBankAccountCode" id="corresBankAccountCode" data-orig="${corresBankAccountCode}" />
	    </td>
	<tr>
		<td class="label_width" colspan="2"> <g:radio name="corresBankAccountFlag" value="D" checked="${corresBankAccountFlag == 'D' ? true : false}" data-orig="${corresBankAccountFlag}"/> <span class="field_label"> Option D - Name and Address </span></td>
		<td class="input_width">
            <g:textArea class="textarea" name="corresBankAccountNameAndAddress" readonly="readonly" value="${corresBankAccountNameAndAddress}" data-orig="${corresBankAccountNameAndAddress}" rows="4"/>
        </td>
	</tr>
    <tr>
        <td class="label_width" colspan="2"><span class="field_label">Account Type<span class="asterisk hasMt hasAccount">*</span></span></td>
        <td>
            <input type="radio" disabled="disabled" id="accountType" name="accountType" value="RBU" data-orig="${accountType}" <g:if test="${accountType?.equalsIgnoreCase("RBU")}">checked</g:if>/>RBU
            <input type="radio" disabled="disabled" id="accountType" name="accountType" value="FCDU" data-orig="${accountType}" <g:if test="${accountType?.equalsIgnoreCase("FCDU")}">checked</g:if>/>FCDU
            <g:hiddenField name="accountTypeCheck" value="${accountTypeCheck}" class="required" data-orig="${accountTypeCheck}" />
        </td>
    </tr>
    <tr>
        <td class="label_width" colspan="2"><span class="field_label">Account Number<span class="asterisk hasMt hasAccount">*</span></span></td>
        <td>
        	<input id="depositoryAccountNumber" name="depositoryAccountNumber" value="${depositoryAccountNumber}" class="input_field required" readonly="readonly" data-orig="${depositoryAccountNumber}" />
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
		<td class="label_width" colspan="2"> <span class="field_label"> Country Code<span class="asterisk">*</span><span class="hasMt">*</span> </span> </td>
			<%-- end of max redmine 3705--%>
		<td class="input_width">
            <input class="tags_country select2_dropdown bigdrop required cntryDd" name="countryCode" id="countryCode" data-orig="${countryCode}" />
        </td>
	</tr>
	<tr>
		<td class="label_width valign_top" colspan="2">
			<span class="field_label"> Sender to Receiver Information </span>
		</td>
		<td class="input_width">
			<tfs:senderToReceiverType1 name="senderToReceiver" class="newSenderToReceiver"  value="${senderToReceiver}" data-orig="${senderToReceiver}"/>
        </td>
	</tr>
	<tr>
		<td class="label_width valign_top" colspan="2"/>
		<td class="input_width">
			<g:textArea class="textarea" name="senderToReceiverInformation" value="${senderToReceiverInformation}" data-orig="${senderToReceiverInformation ?: ''}" rows="6" readonly="readonly"/>
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


<script>
    var autoCompleteSettlementCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteSettlementCurrency')}';
    var glCode = "";
    var corresBankCurrency = "";
    var corresBankName = "";
    var tempfcdu = "";
    var temprbu = "";

    function totalAmountClaimedFlagChange() {
        var totalAmountClaimedFlag = $("input[name=totalAmountClaimedFlag]:checked").val();

        if (totalAmountClaimedFlag == "A") {
            $("#totalAmountClaimedDate").removeClass("input_field");
            $("#totalAmountClaimedDate").addClass("datepicker_field");
            createDatePicker($("#totalAmountClaimedDate"));

            $("#totalAmountClaimedCurrencyA").select2("enable");
            $("#totalAmountClaimedCurrencyA").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("#currency").val()});

            $("#totalAmountClaimedCurrencyB").select2("disable");
            computeTotalAmountClaimed();
        } else if (totalAmountClaimedFlag == "B") {
            $("#totalAmountClaimedDate").val("");

            computeTotalAmountClaimed();

            $("#totalAmountClaimedDate").datepicker("destroy");
            $("#totalAmountClaimedDate").removeClass("datepicker_field");
            $("#totalAmountClaimedDate").addClass("input_field");

            $("#totalAmountClaimedCurrencyB").select2("enable");
            $("#totalAmountClaimedCurrencyB").setCurrencyDropdown($(this).attr("id")).select2('data',{id: $("#currency").val()});
            $("#totalAmountClaimedCurrencyA").select2("disable");
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
            clearAccountDetails();
            $(".hasAccount").text("");
        } else if (corresBankFlag == "D") {
            $("#corresBankCode").select2("data", null);
            $("#corresBankCode").select2("disable");
            $("#corresBankLocation").val("");
            $("#corresBankLocation").attr("readonly", "readonly");
            $("#corresBankNameAndAddress").removeAttr("readonly");
            $("#accountTypeCheck").toggleClass("required", false);
            $("#depositoryAccountNumber").toggleClass("required", false);
            clearAccountDetails();
            $(".hasAccount").text("");
        } else {
            $("#corresBankCode").select2("data", null);
            $("#corresBankCode").select2("disable");
            $("#corresBankLocation").val("");
            $("#corresBankLocation").attr("readonly", "readonly");
            $("#corresBankLocation").val("");
            $("#corresBankLocation").attr("readonly", "readonly");
            $("#accountTypeCheck").toggleClass("required", false);
            $("#depositoryAccountNumber").toggleClass("required", false);
            clearAccountDetails();
            $(".hasAccount").text("");
        }
        $("#corresBankComplete").val("");
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
//            $("#corresBankAccountCode").val($("#corresBankCode").val());
            $("#corresBankAccountCode").select2("enable");
            //setupAccountDetails();
            $("#corresBankAccountNameAndAddress").val("");
            $("#corresBankAccountNameAndAddress").attr("readonly", "readonly");
//            onCorresBankAccountNumberCheck();
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

        if (totalAmountClaimedFlag == "A") {
            $("#totalAmountClaimedB").val("");
            var amount = parseFloat($("#amount").val().replace(/,/g,""));
            var additionalAmountClaimed = parseFloat($("#additionalAmountClaimed").val().replace(/,/g,""));
            var chargesAmount = parseFloat($("#chargeAmount").val().replace(/,/g,""));

            var totalAmountClaimed = (amount + additionalAmountClaimed) - chargesAmount;

            $("#totalAmountClaimedA").val(formatCurrency(totalAmountClaimed));
        } else if (totalAmountClaimedFlag == "B") {
            $("#totalAmountClaimedA").val("");
            var amount = parseFloat($("#amount").val().replace(/,/g,""));
            var additionalAmountClaimed = parseFloat($("#additionalAmountClaimed").val().replace(/,/g,""));
            var chargesAmount = parseFloat($("#chargeAmount").val().replace(/,/g,""));

            var totalAmountClaimed = (amount + additionalAmountClaimed) - chargesAmount;

            $("#totalAmountClaimedB").val(formatCurrency(totalAmountClaimed));        }
    }
    
	function onCorresBankLoad() {
		if ($("#corresBankAccountCode").val()){
			$("input[name=accountType]").removeAttr("disabled");
		}
	}

    function onWithBcFlagChange() {
	    $("#negotiationNumber").val("");
	    $("#negotiationNumber").attr("disabled", "disabled");
	    
	    var withBcFlag = $("input[name=withBcFlag]:checked").val();

	    if (withBcFlag == 1) {
	
	        var url = '${g.createLink(controller: "product", action: "retrieveAllCollections")}';
	        $.post(url, {cifNumber: $("#cifNumber").val(), exportBillType: 'EBC'}, function(data) {
	            $("#negotiationNumber").empty();
	            $("#negotiationNumber").append($('<option></option>').val("").html("SELECT ONE..."));
	
	            $.each(data.documentNumbers, function(idx, val) {
	                var option = "<option value="+val+">"+val+"</option>";
	
	                $("#negotiationNumber").append(option)
	            });
	
	            $("#negotiationNumber").removeAttr("disabled");

	            if ('${negotiationNumber}') {
	            	$("#negotiationNumber").val('${negotiationNumber}');

	            	if ($("#negotiationNumber").val() === '' && '${statusAction}'.toUpperCase() === "APPROVE") {
		            	var elem = document.getElementById('negotiationNumber');
		    			var opt = document.createElement("option");
		    			
		    			opt.text = '${negotiationNumber}';
						elem.add(opt);
						//brian
		                $("#negotiationNumber").val('${negotiationNumber}');
		                $("#negotiationNumber").attr("disabled", "disabled");
	            	}
	                setEbcAmount();
	            }
            }).error(function (){
            	$("input[name=withBcFlag][value=0]").attr("checked", "checked");
                triggerAlertMessage("No Outstanding EBC's found.");
                $("#outstandingBcAmount").parents("tr").hide();
	        });
	    } else {
            $("#outstandingBcAmount").parents("tr").hide();
//            $("#negotiationNumber").removeClass("required");
//            $(".withBcFlagAsterisk").text("");
//
//            $("#currency").select2("enable");
//            $("#bcCurrency, #bcAmount").val("");
//
//            $("select[name=paymentMode]").removeAttr("disabled");
//            $("input[name=paymentMode]").attr("disabled", "disabled");
        }
	    if (withBcFlag) {
	        $("#withBcFlagCheck").val("true");
	    } else {
	        $("#withBcFlagCheck").val("");
	    }
	    computeOutstandingBcAmount();
	}

    function setEbcAmount() {
        var negotiationNumber = $("#negotiationNumber").val();

        var url = '${g.createLink(controller: "product", action: "retrieveCollectionAmount")}';

        if (negotiationNumber) {
            $.post(url, {documentNumber: negotiationNumber}, function(data) {
            	$("#bcCurrency").val(data.currency);
            	
            	// 01132017 - Redmine 4122 set country code
	            var countryCode = data.countryCode;
	            if( countryCode != null ){
	            	$('#countryCode').select2('data', {id: data.countryCode});
	            }
	            
                $("#bcAmount").val(formatCurrency(data.amount));
                if('${amount}'.length == 0){
                	$("#amount").val(formatCurrency(data.amount));
                }

                $("select[name=paymentMode]").attr("disabled", "disabled");
                $("input[name=paymentMode]").removeAttr("disabled");
                $("#paymentMode, #paymentModeHidden").val(data.paymentMode);
                computeOutstandingBcAmount();
            });
        } else {
        	$("#bcCurrency").val("");
            $("#bcAmount").val("");

			$("select[name=paymentMode]").removeAttr("disabled");
            $("input[name=paymentMode]").attr("disabled", "disabled");
            $("#paymentMode").val("");
            computeOutstandingBcAmount();
        }
    }

    function computeOutstandingBcAmount(){0
        if($("#negotiationNumber").val()){
            if($("#amount").val().replace(/,/g , "") <= $("#bcAmount").val().replace(/,/g , "")){
            	$("#outstandingBcAmount").val(formatCurrency(parseFloat($("#bcAmount").val().replace(/,/g , "") - $("#amount").val().replace(/,/g , ""))));
            } else {
            	$("#outstandingBcAmount").val(formatCurrency(0));
            }
        } else {
        	$("#outstandingBcAmount").val('');
        }
    }

//    function totalAmountClaimedFlagChange() {
//        var totalAmountClaimedFlag = $("input[name=totalAmountClaimedFlag]:checked").val();
//
//        if (totalAmountClaimedFlag == "A") {
//            $("#totalAmountClaimed").val("");
//
//             $("#totalAmountClaimedDate").removeClass("input_field");
//            $("#totalAmountClaimedDate").addClass("datepicker_field");
//            createDatePicker($("#totalAmountClaimedDate"));
//            $("#totalAmountClaimed").attr("readonly", "readonly");
//        } else if (totalAmountClaimedFlag == "B") {
//            $("#totalAmountClaimedDate").val("");
//
//            $("#totalAmountClaimed").removeAttr("readonly");
//            $("#totalAmountClaimedDate").datepicker("destroy");
//            $("#totalAmountClaimedDate").removeClass("datepicker_field");
//            $("#totalAmountClaimedDate").addClass("input_field");
//        }
//    }

    function onChangePaymentMode() {
        if ($("#paymentMode").val() != "LC") {
            $("#exlcAdviseNumber").select2("data", null);
            $("#exlcAdviseNumber").parents("tr").hide();
            
            if($(".mtFlag").filter(":checked").val() == "1"){
	        	$(".mtFlag").filter(":checked").removeAttr("checked");
	        	$(".mtFlag").filter("[value=0]").attr("checked","checked");
	        }
	        
	        $(".mtFlag").attr("disabled","disabled");
	        $(".mtFlag").change();
        } else {
        	$("#exlcAdviseNumber").parents("tr").show();
        	$(".mtFlag").removeAttr("disabled");
        }
    }

	function onTotalAmountClaimedCheck() {
		if(($("#totalAmountClaimedDate").val() != "" && $("#totalAmountClaimedCurrencyA").val() != "") || $("#totalAmountClaimedCurrencyB").val() != "") {
			$("#totalAmountClaimedComplete").val("true");
		} else {
			$("#totalAmountClaimedComplete").val("");
		}
	}


    var autoCompleteExportAdvisingUrl = '${g.createLink(controller: "autoComplete", action: "autoCompleteExportAdvising")}';

    $(document).ready(function() {
        var particulars = $('#particulars').val(),
	        splittedParticulars;

        $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: '${particularsLabel}'});

        if ($("#cifNumber").length > 0) {
            $("#cifNumber").change(function() {
                $("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});
            });
        }

		if ('${statusAction}'.toUpperCase() === "APPROVE") {
			$("#exlcAdviseNumber").attr("disabled", "disabled");
		}
		
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
	        $('#particulars').val(particulars.toString().trim())
	        $.get(autoCompleteParticularsUrl, {starts_with: particulars.toString().trim()}, function(data) {
	            if(data !== null && data.success && data.result !== null && data.results.length > 0) {
	                $("#particularsLabel").setParticularsDropdown($(this).attr("id")).select2('data',{id: data.results[0].id});
	            }
	        });
	    }

        <%-- 01062017 Validation #7 in RM 4122 --%>
        if( $("#mtFlag").val != "" ){
	    var mtFlag = $('input[name=mtFlag]:checked').val(); 
	    	// If mtFlag is true, require correspondent bank (0 - no, 1 - yes)
			if( mtFlag == 1 ){
		 		$("#corresBankCode").addClass("required");
		    } else {
		      	$("#corresBankCode").removeClass("required");
		    }
        }
        
        $("#currency").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${currency}'});
        //$("#exporterCbCode").setCBCodeDropdown($(this).attr("id")).select2('data',{id: '${exporterCbCode}'});
        $("#corresBankCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankCode}'});
        $("#corresBankAccountCode").setDepositoryBankDropdown($(this).attr("id")).select2('data',{id: '${corresBankAccountCode}'});

        $("#corresBankAccountCode").on("change", function(e) {
            var data = $("#corresBankAccountCode").select2('data');
            if(data != null){
                $("#corresBankAccountNumberComplete").val("true");
            } else {
                $("#corresBankAccountNumberComplete").val("");
            }
        });

		$("#exlcAdviseNumber").setExportAdvisingNumber($(this).attr("id")).select2('data',{id: '${exlcAdviseNumber}'});

        if ($("#exlcAdviseNumber").val()) {
            $("#currency").select2("disable");
        }
		
		      
		$("#exlcAdviseNumber").change(function() {
            var changeUrl = '${g.createLink(controller: "exportBillsPurchase", action: "getExportAdvising")}';

            $.get(changeUrl, {exlcNumber: $("#exlcAdviseNumber").val()}, function(exportAdvising) {

                $("#adviseNumber").val($("#exlcAdviseNumber").val());
                $("#lcNumber").val(exportAdvising.lcNumber);
                $("#lcIssueDate").val(exportAdvising.lcIssueDate);
                $("#lcType").val(exportAdvising.lcType);
                $("#lcTenor").val(exportAdvising.lcTenor);
                $("#usanceTerm").val(exportAdvising.usanceTerm);
                $("#lcCurrency").val(exportAdvising.lcCurrency);
                $("#lcAmount").val(formatCurrency(exportAdvising.lcAmount));
                $("#lcExpiryDate").val(exportAdvising.lcExpiryDate);

                $("#issuingBankCode").val(exportAdvising.issuingBankCode);
                $("#issuingBankAddress").val(exportAdvising.issuingBankAddress);

                $("#reimbursingBankCode").val(exportAdvising.reimbursingBankCode);
            })
        });

        $("#countryCode").setCountryDropdown($(this).attr("id")).select2('data',{id: '${countryCode}'});
        $("input[name=withBcFlag]").click(onWithBcFlagChange);
        onWithBcFlagChange();

        $("#negotiationNumber").change(setEbcAmount);

        $("input[name=totalAmountClaimedFlag]").click(totalAmountClaimedFlagChange);
        totalAmountClaimedFlagChange();
		
        $("#saveConfirmBasicDetails").click(function() {
            if(validateExportTab("#basicDetailsTabForm") > 0){
                triggerAlertMessage(val_msg);
            } else {
            	mCenterPopup($("#loading_div"), $("#loading_bg"));
            	mLoadPopup($("#loading_div"), $("#loading_bg"));
                $("#basicDetailsTabForm").submit();
            }
        });

        $("#cancelConfirmBasicDetails").click(function() {
        	$(".saveAction").hide();
           	$(".cancelAction").show();
            mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
            mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        });


        computeOutstandingBcAmount();
        
        $("#totalAmountClaimedCurrencyA").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${totalAmountClaimedCurrencyA}'});
        $("#totalAmountClaimedCurrencyB").setCurrencyDropdown($(this).attr("id")).select2('data',{id: '${totalAmountClaimedCurrencyB}'});

        $("input[name=totalAmountClaimedFlag]").click(totalAmountClaimedFlagChange);
        totalAmountClaimedFlagChange();

        $("input[name=corresBankFlag]").click(corresBankFlagChange);
        corresBankFlagChange();

        $("input[name=corresBankAccountFlag]").click(corresBankAccountFlagChange);
        corresBankAccountFlagChange();
        
        $.post(autoCompleteDepositoryBankUrl, {starts_with: '${corresBankCode}'}, function(jsonData){
			if(jsonData.success){
				if(jsonData.total == 1){
					var data = jsonData.results[0];
					$("#corresBankCode").val(data.id);
					$("#glCode").val(data.glcode);
		        	$("#tempfcdu").val(data.fcduAccount);
		            $("#temprbu").val(data.rbuAccount);
		            $("#tempfcdugl").val(data.glcodefcdu);
		            $("#temprbugl").val(data.glcoderbu);

					if($("#temprbugl").val() && $("#tempfcdugl").val()){
			        	$("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").attr('checked',true);
			            $("#accountType[value=" + '${accountType ?: 'RBU'}'+ "]").click();
			        }else if (($("#temprbugl").val()) || ($("#tempfcdugl").val())){
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
				}
			}
		});
        
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
            /*if (e.target.value != "") {
                glCode = $("#corresBankCode").select2('data').glcode;
                corresBankCurrency = $("#corresBankCode").select2('data').currency;
                corresBankName = $("#corresBankCode").select2('data').label;
                tempfcdu = $("#corresBankCode").select2('data').fcduAccount;
                temprbu = $("#corresBankCode").select2('data').rbuAccount;
            } else {
                glCode = "";
                corresBankCurrency = "";
                corresBankName = "";
                tempfcdu = "";
                temprbu = "";
            }*/

            //setupAccountDetails();
            onCorresBankCheck();
        });
        
        $("#corresBankCode, #corresBankLocation, #corresBankNameAndAddress").each(function(){
        	$(this).change(onCorresBankCheck);
        });
        onCorresBankCheck();
        
       	$("#corresBankAccountNameAndAddress").change(onCorresBankAccountNumberCheck);
        onCorresBankAccountNumberCheck();
        
        $("input[name=accountType]").on("click", function(e) {
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
        
        onCorresBankLoad();

        $("#paymentMode").change(onChangePaymentMode);
        onChangePaymentMode();

	    $("#totalAmountClaimedFlag, #totalAmountClaimedDate, #totalAmountClaimedCurrencyA, #totalAmountClaimedCurrencyB").each(function(){
	    	$(this).change(onTotalAmountClaimedCheck);
	    });
	    onTotalAmountClaimedCheck();
        
		//remove required classes on fields if no MT to generate
		$(".mtFlag").change(function(){
			if($(this).filter(":checked").val() == "0" || $(".mtFlag").attr("disabled") == "disabled"){
				$(".hasMt").text("");
				$("#totalAmountClaimedComplete").removeClass("required");
				// $("#corresBankComplete").removeClass("required");
				// $("#corresBankAccountNumberComplete").removeClass("required");
				$("#accountTypeCheck").removeClass("required");
				$("#depositoryAccountNumber").removeClass("required");
			//	$("#countryCode").removeClass("required"); //commented by MAX for redmine 3705
			}else{
				$(".hasMt").text("*");
				$("#totalAmountClaimedComplete").addClass("required");
				// $("#corresBankComplete").addClass("required");
				// $("#corresBankAccountNumberComplete").addClass("required");
				$("#accountTypeCheck").addClass("required");
				$("#depositoryAccountNumber").addClass("required");
			//	$("#countryCode").addClass("required");	//commented by MAX for redmine 3705			
			}
		});
		
		$(".mtFlag").change();
    });
</script>