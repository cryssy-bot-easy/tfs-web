<%-- 
(revision)
SCR/ER Number: 
SCR/ER Description: Loans Interest Rate
[Revised by:] John Patrick C. Bautista
[Date revised:] 08/24/2016
Program [Revision] Details: Added classes for Interest Rate field to do formatting.
Member Type: Groovy Server Pages (GSP)
Project: tfs-web
Project Name: _mode_of_payment.gsp
--%>

<g:javascript src="grids/apply_ap_jqgrid.js"/>
%{--<g:javascript src="utilities/commons/initialize_mode_of_payment.js" />--}%
%{--<g:javascript src="utilities/commons/accounts_payable_mode_of_payment.js" />--}%
%{--<g:javascript src="utilities/commons/accounts_receivable_mode_of_payment.js" />--}%
<g:javascript src="popups/facility_id_popup.js"/>
<g:javascript src="utilities/commons/casa_accounts.js" />
<g:javascript src="utilities/dataentry/commons/loan_details_utility.js" />
<%--<g:javascript src="js-temp/mode_of_payment_charges_pop_up_validation.js"/>--%>
<script type="text/javascript">
    var getPaymentReferenceByMCUrl = '${g.createLink(controller: "cdt", action: "getPaymentReferenceByMC")}';
    var clearPaymentReferenceByMC = '${g.createLink(controller: "cdt", action: "clearPaymentReferenceByMC")}';

    var addDeleteSettlementUrl = '${g.createLink(controller: "chargesPayment", action: "addDeleteSettlement")}';
    var findAllApByDocNumUrl = '${g.createLink(controller: "chargesPayment", action: "findAccountsPayableByDocumentNumber")}';
    var findAllArByDocNumUrl = '${g.createLink(controller: "chargesPayment", action: "findAccountsReceivableByDocumentNumber")}';

    var accountsPayable = '${accountsPayable}';
    var accountsReceivable = '${accountsReceivable}';

    var getLoanMaturityDateUrl = '${g.createLink(controller: "chargesPayment", action: "computeLoanMaturityDate")}';
    var getIbTrLoanMaturityDateUrl = '${g.createLink(controller: "payment", action: "calculateLoanMaturityDate")}';


    var searchCasaAccountsUrl = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    if ($("#cifNumber").length > 0) {
        searchCasaAccountsUrl += "?cifNumber="+$("#cifNumber").val();
    }

    var ibLineFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getIBFacilities")}';
    var uaLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getUAFacilities")}';
    var trLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getTrFacilities")}';
    var dbpLoanFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getDbpFacilities")}';
    var ebpLoanFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getEbpFacilities")}';


    var checkIfHolidayUrl = "${g.createLink(controller: 'modeOfPayment', action: 'checkDateIfHolidayOrNotBusinessDay')}";
    var getMdBalanceUrl = '${g.createLink(controller: "modeOfPayment", action: "getTotalMd")}';

    var findAllApByCifNumberAndCurrencyUrl = '${g.createLink(controller: "modeOfPayment", action: "findAllApByCifNumberAndCurrency")}';
    var findAllApBySettlementAcctNo = '${g.createLink(controller: "modeOfPayment", action: "findAllApBySettlementAcctNo")}';
    var findAllApByIdUrl = '${g.createLink(controller: "modeOfPayment", action: "findAllApById")}';
    var findAllMultipleApUrl = '${g.createLink(controller: "modeOfPayment", action: "constructMultipleAp")}';

    var casaUserSearchUrl = "${g.createLink(controller: 'modeOfPayment', action: 'searchCasaAccountsByUser')}";

    var cifNumber = '${cifNumber}';

</script>

<div id="popup_modeOfPaymentCharges" class="popup_div_override">
<div class="popup_container">
<%--Same Class --%>
<table>
    <tr>
        <td width="210">
            <span class="field_label" id="modeOfPaymentTitle"> Mode of Payment </span>
        </td>
        <td>
            <g:select name="modeOfPaymentCharges" id="modeOfPaymentCharges" from="" noSelection="['':'SELECT ONE...']" class="select_dropdown" />

        </td>
    </tr>
</table>

<table class="display-casa-charges">
    <tr>
        <td/>
        <td><g:select name="accountNumberCheck" class="select_dropdown" from="['CIF','Others']" keys="['C','O']" /></td>
    </tr>
    <tr>
        <td width="210" class="label_credit_casa"><span class="field_label">If Credit CASA, specify Account Number</span></td>
        <td width="210" class="label_debit_casa"><span class="field_label">If Debit CASA, specify Account Number</span></td>
        <td>
            <input class="tags_accountNumber select2_dropdown bigdrop" name="accountNumber" id="accountNumber" />
        </td>
        <td>
            <input type="button" class="check_button" id="accountNameCheck" />
        </td>
    </tr>
    <tr>
        <td class="single_indent"><span class="field_label">Account Name</span></td>
        <td>
            <g:textField name="accountName" class="input_field textFormat-20" readonly="readonly" value=""  disabled="disabled"/>
            <script>
                $(document).ready(function() {
                     $("#accountNumber").on("keydown", function(e) {
                        return e.which !== 32;
                    });
                });
            </script>
        </td>
    </tr>
</table>


<table class="display-check-charges">
    <tr>
        <td width="210"><span class="field_label">Trade Suspense Account</span></td>
        <td><g:textField name="checkTradeSuspenseAccount" class="input_field " disabled="disabled"/></td>
    </tr>
</table>
<table class="display-cash-charges">
    <tr>
        <td width="210"><span class="field_label">Trade Suspense Account</span></td>
        <td><g:textField name="cashTradeSuspenseAccount" class="input_field " disabled="disabled"/></td>
    </tr>
</table>
<table class="display-remittance-cash">
    <tr>
        <td width="210"><span class="field_label">AP Remittance Account</span></td>
        <td><g:textField name="apRemittanceAccount" class="input_field" disabled="disabled"/></td>
    </tr>
</table>
<table class="display-apply-ap-charges">
    <tr>
        <td width="210"><span class="field_label">Document Number/Reference Number</span></td>
        <td>
            <g:select name="documentReferenceNumberAp" from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE...']"  disabled="disabled"/>
            <g:hiddenField name="apReferenceId" value="" />
        </td>
    </tr>
</table>
<table class="display-ap-balance2_charges">
    <tr>
        <td width="210"><span class="field_label">O/S AP Balance</span></td>
        <td><g:textField name="apOutstandingBalance" class="input_field right numericCurrency" value="" readonly="readonly"  disabled="disabled"/></td>
    </tr>
</table>

<table class="display-ib-tr-loan">
    <tr>
		<td width="150"><span class="field_label">Payment Code <span class="asterisk">*</span></span></td>
		<td><g:select from="${['0','1','2','3','4','5','6'] }" value="2" name="loanPaymentCode" class="select_dropdown_medium loanField popup_required"/></td>
	</tr>
	<tr>
		<td width="150"><span class="field_label">Interest Rate (in %) <span class="asterisk">*</span></span></td>
<%--		<td><g:textField name="interestRate" class="input_field_medium loanField popup_required intRate appendZero appendDecimal" maxlength="8"/></td>--%>
		<td><g:hiddenField name="interestRate" class="input_field_medium numericCurrency"/>
					<g:textField name="interestRate2" class="input_field_medium loanField intRate appendZero appendDecimal"/></td>
	</tr>
	<tr>
		<td width="150"><span class="field_label">Interest Term / Code <span class="asterisk">*</span></span></td>
			<td><g:textField name="interestTermNegotiation" class="input_field_medium numberFormat-5 loanField popup_required" value="30"/>
			<g:radioGroup name="interestCodeFlagNegotiation" labels="['Months','Days']" values="['M','D']" value="" class="loanField">
        				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160; 
    				</g:radioGroup>
			<td>
	</tr>
	<tr>
		<td width="150"><span class="field_label">Loan Term <span class="asterisk">*</span></span></td>
		<td>
                     <g:textField name="loanTermNegotiation" class="input_field_medium numberFormat-5 loanField popup_required" value="30"/>
                     <g:radioGroup name="loanCodeFlagNegotiation" labels="['Months','Days']" values="['M','D']" value="" id="loanCodeFlagNegotiation" class="loanField">
       			${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160; 
   				</g:radioGroup>
   		</td>
	</tr>
	<g:if test="${documentClass == 'BP'}">
    <tr>
    	<td width="150"><span class="field_label">Number of Free Float Days? <span class="asterisk">*</span></span></td>
    	<td><g:textField class="input_field_medium loanField numericWholeQuantity popup_required" name="numberOfFreeFloatDaysNegotiation" value="0" /></td>
	</tr>
	</g:if>
    <tr>
        <td width="150"><span class="field_label">Loan Maturity Date <span class="asterisk">*</span></span></td>
        <td><g:textField class="input_field_medium datepicker_field loanField popup_required" name="loanMaturityDate" id="loanMaturityDate" readonly="readonly" /></td>
    </tr>
    <tr>
        <td width="150"><span class="field_label">With Excess Availment Approval From CFP? <span class="asterisk">*</span></span></td>
        <td>
            <g:radioGroup name="cramApprovalFlag" labels="['Yes','No']" values="['true','false']" value="" class="loanField">
                ${it.radio}&#160;<g:message code="${it.label}" />
            </g:radioGroup>
            <g:hiddenField class="loanField" name="cramApprovalCheck" />
        </td>
	</tr>
</table>
<%--
<table class="display_ibt_branch">
	<tr>
	    <td width="210" class="label_debit_casa"><span class="field_label">If IBT-Branch, specify Unit Code of Branch</span></td>
	    <td><g:select name="ibtAccountNumber" from="${['4578-08','4583-23']}" noSelection="['':'SELECT ONE...']" class="select_dropdown"  disabled="disabled"/></td>
	</tr>
</table>
--%>
<br/>
<table class="popup_buttons">
    <tr><td> <input type="button" class="input_button" id="save_modeOfPaymentCharges" value="Save" /> </td></tr>
    <tr><td> <input type="button" class="input_button_negative" id="close_modeOfPaymentCharges2" value="Close" /> </td></tr>
</table>

</div>
</div>
<div id="mode_of_payment_charges_bg" class="popup_bg_override"> </div>


<script>
    $(document).ready(function() {
        $("#accountNumber").setAccountNumberDropdown();
    });
</script>