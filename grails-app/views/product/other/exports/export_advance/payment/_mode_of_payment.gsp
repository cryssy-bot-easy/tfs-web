<g:javascript src="grids/apply_ap_jqgrid.js"/>
<g:javascript src="utilities/commons/accounts_payable_mode_of_payment.js" />
<g:javascript src="utilities/commons/accounts_receivable_mode_of_payment.js" />
<g:javascript src="popups/facility_id_popup.js"/>
<g:javascript src="utilities/commons/casa_accounts.js" />

<script type="text/javascript">
    var addDeleteSettlementUrl = '${g.createLink(controller: "chargesPayment", action: "addDeleteSettlement")}';
    var findAllApByDocNumUrl = '${g.createLink(controller: "chargesPayment", action: "findAccountsPayableByDocumentNumber")}';
    var findAllArByDocNumUrl = '${g.createLink(controller: "chargesPayment", action: "findAccountsReceivableByDocumentNumber")}';

    var accountsPayable = '${accountsPayable}';
    var accountsReceivable = '${accountsReceivable}';

    var getLoanMaturityDateUrl = '${g.createLink(controller: "chargesPayment", action: "computeLoanMaturityDate")}';
    var getIbTrLoanMaturityDateUrl = '${g.createLink(controller: "payment", action: "calculateLoanMaturityDate")}';

    var searchCasaAccountsUrl = '${g.createLink(controller: "cif", action: "searchCasaAccountsByCif")}';
    searchCasaAccountsUrl += "?cifNumber="+$("#cifNumber").val();
    var ibLineFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getIBFacilities")}';
    var uaLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getUAFacilities")}';
    var trLineFacilitySearchUrl = '${g.createLink(controller: "facility", action: "getTrFacilities")}';
    var dbpLoanFacilitySearchUrl =  '${g.createLink(controller: "facility", action: "getDbpFacilities")}';

</script>

<div id="modeOfPaymentDiv" class="popup_div_override">
    <h2 id="popup_header_modeOfPayment"> Mode Of Payment</h2>
    <br />
    <div class="popup_container">

        <div class="popup_container">
            <table>
                <tr>
                    <td width="210">
                        <span class="field_label" id="modeOfPaymentTitle">
                            Mode of Payment
                        </span>
                    </td>
                    <td>
                        <g:select name="modeOfPaymentCharges" from="" noSelection="['':'SELECT ONE...']" class="select_dropdown"/>

                    </td>
                </tr>
            </table>
            <table class="display-casa-charges">
                <tr>
                    <td width="210" class="label_credit_casa"><span class="field_label">If Credit CASA, specify Account Number</span></td>
                    <td width="210" class="label_debit_casa"><span class="field_label">If Debit CASA, specify Account Number</span></td>
                    <td>
                        <input class="tags_accountNumber select2_dropdown bigdrop" name="accountNumber" id="accountNumber" />
                    </td>
                </tr>
                <tr>
                    <td class="single_indent"><span class="field_label">Account Name</span></td>
                    <td>
                        <g:textField name="accountName" class="input_field textFormat-20" readonly="readonly" value="SAN FERNANDO"  disabled="disabled"/>
                        <script>
                            $(document).ready(function() {
                                $("#accountName").on("keydown", function(e) {
                                    return e.which !== 32;
                                });
                            });
                        </script>
                    </td>
                </tr>
                <tr class="md_casa">
                    <td class="single_indent"><span class="field_label">Available Account Balance</span></td>
                    <td><g:textField name="availableBalance" class="input_field textFormat-20" readonly="readonly" value="0.00"  disabled="disabled"/></td>
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
                        <g:select name="documentReferenceNumberAp" from="${[] }" class="select_dropdown" noSelection="['':'SELECT ONE...']"  disabled="disabled"/>
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
            <table class="display-ap-balance1_charges  full_width">
                <tr>
                    <td valign="top"><span class="float_left">O/S AP Balance</span>&#160;&#160;&#160;</td>
                    <td>
                        <div class="grid_wrapper_apply_ap float_right">
                            <table id="grid_list_ap_balance_charges"> </table>
                        </div>
                    </td>
                </tr>
            </table>

            <table class="display-ib-tr-loan">
                <tr>
                    <td width="150"><span class="field_label">Booking Currency</span></td>
                    <td>
                        <g:radio name="bookingCurrencyIbTr" value="USD" checked="${currency.equals("USD") ? true : false}"/> USD <g:radio name="bookingCurrencyIbTr" value="PHP" checked="${currency.equals("PHP") ? true : false}"/> PHP
                    </td>
                </tr>
                <tr>
                    <td><span class="field_label">Interest Rate (in %)</span></td>
                    <td><g:textField name="interestRate" class="input_field_medium"/></td>
                </tr>
                <tr>
                    <td><span class="field_label">Interest Term / Code</span></td>
                    <td><g:textField name="interestTermNegotiation" class="input_field_medium numberFormat-5" value="30"/>&#160;Days
                    <td>
                </tr>
                <tr>
                    <td><span class="field_label">Repricing Term / Code</span></td>
                    <td><g:textField name="repricingTermNegotiation" class="input_field_medium numberFormat-5" value="30"/> &#160;Days
                    </td>
                </tr>
                <tr>
                    <td><span class="field_label">Loan Term</span></td>
                    <td>
                        <g:textField name="loanTermNegotiation" class="input_field_medium numberFormat-5" value="30"/>&#160;Days
                    </td>
                </tr>
                <tr>
                    <td><span class="field_label">Loan Maturity Date</span></td>
                    <td><g:textField class="input_field_medium" name="loanMaturityDate" readonly="readonly"/></td>
                </tr>
                <g:if test="${ serviceType == 'UA Loan Settlement' || serviceType == 'UA_LOAN_SETTLEMENT'}">
                    <tr>
                        <td><span class="field_label">Doc Stamp Tagging</span></td>
                        <td><g:select name="docStampTagging" class="select_dropdown" from="${['TAG 1','TAG 2','TAG 3']}" noSelection="['':'SELECT ONE...']" /></td>
                    </tr>
                </g:if>
            </table>

            <table class="display_ibt_branch">
                <td width="210" class="label_debit_casa"><span class="field_label">If IBT-Branch, specify Unit Code of Branch</span></td>
                <td><g:select name="ibtAccountNumber" from="${['4578-08','4583-23']}" noSelection="['':'SELECT ONE...']" class="select_dropdown"  disabled="disabled"/></td>
            </tr>
            </table>
        </div>
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