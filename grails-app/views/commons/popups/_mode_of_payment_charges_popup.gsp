<%-- 
(revision)
SCR/ER Number: 
SCR/ER Description: Loans Interest Rate
[Revised by:] John Patrick C. Bautista
[Date revised:] 08/24/2016
Program [Revision] Details: Added classes for Interest Rate field to do formatting.
Member Type: Groovy Server Pages (GSP)
Project: tfs-web
Project Name: _mode_of_payment_charges_popup.gsp
--%>

<g:javascript src="grids/apply_ap_jqgrid.js"/>
<%-- <g:javascript src="utilities/commons/initialize_mode_of_payment.js" /> --%>
<%-- <g:javascript src="utilities/commons/accounts_payable_mode_of_payment.js" /> --%>
<%-- <g:javascript src="utilities/commons/accounts_receivable_mode_of_payment.js" /> --%>
<g:javascript src="popups/facility_id_popup.js"/>
<g:javascript src="utilities/commons/casa_accounts.js" />
<%--<g:javascript src="js-temp/mode_of_payment_charges_pop_up_validation.js"/>--%>
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
<%--	<g:if test="${(serviceType != 'UA Loan Settlement' && documentType != 'DOMESTIC') && (serviceType != 'UA Loan Settlement' && documentType != 'FOREIGN') }">--%>
<%--		<h2 id="popup_header_modeOfPaymentCharges"> Mode Of Payment - Charges Payment </h2>--%>
<%--	</g:if>--%>
    <%--<g:if test="${serviceType?.equalsIgnoreCase('COLLECTION') && documentClass?.equalsIgnoreCase('MD')}">--%>
        <%--<h2 id="popup_header_modeOfPaymentCharges"> Mode of Payment - MD Collection </h2>--%>
    <%--</g:if>--%>
<%--	<br />--%>
	<div class="popup_container">
		<%--Same Class --%>
		<div class="popup_container">
			<%--<table>
				<tr>
                    <g:if test="${serviceType?.equalsIgnoreCase('Collection') && documentClass?.equalsIgnoreCase('MD')}">
					    <td width="210"><span class="field_label">Mode of Payment - Marginal Deposit </span></td>
                    </g:if>
                    <g:else>
                        <td width="210"><span class="field_label">Mode of Payment</span></td>
                    </g:else>
					<td>
                        <g:select name="modeOfPaymentCharges" from="" noSelection="['':'SELECT ONE...']" class="select_dropdown"/>
                    </td>
				</tr>
			</table> 
			
			--%>
			<table id="modeOfPaymentTitleTable">
				<tr>
					<td width="210">
						<span class="field_label" id="modeOfPaymentTitle">
<%--							<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') || serviceType?.equalsIgnoreCase('export advance refund')}">Mode of Refund</g:if>--%>
<%--							<g:else>Mode of Payment</g:else>--%>
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
					<td/>
					<td><g:select name="accountNumberCheck" class="select_dropdown" from="['CIF','Others']" keys="['C','O']" /></td>
				</tr>
				<tr>
					<td width="210" class="label_credit_casa"><span class="field_label">If Credit CASA, specify Account Number</span></td>
					<td width="210" class="label_debit_casa"><span class="field_label">If Debit CASA, specify Account Number</span></td>
					<td>
                        %{--<g:select name="accountNumber" from="${[]}" noSelection="['':'SELECT ONE...']" class="select_dropdown"  disabled="disabled"/>--}%
                        <input class="tags_accountNumber select2_dropdown bigdrop" name="accountNumber" id="accountNumber" maxlength="12"/> </td>
                    <td>
                    	<input type="button" class="check_button" id="accountNameCheck" />
                    </td>
				</tr>
				<tr>
					<td class="single_indent"><span class="field_label">Account Name</span></td>
					<td>
                        <g:textField id="accountName" name="accountName" class="input_field textFormat-20" readonly="readonly" value=""  disabled="disabled"/>
                        <script>
                            $(document).ready(function() {
                                $("#accountNumber").keydown(function (e) {
                                    if (e.keyCode == 32) {
                                        return false;
                                    }
                                });
                            });
                        </script>
                    </td>
				</tr>
<%--                <tr class="md_casa">--%>
<%--                    <td class="single_indent"><span class="field_label">Available Account Balance</span></td>--%>
<%--                    <td><g:textField name="availableBalance" class="input_field textFormat-20" readonly="readonly" value="0.00"  disabled="disabled"/></td>--%>
<%--                </tr>--%>
			</table>

            <table id="md_balance">
                <tr>
                    <td width="210"><span class="field_label">Available Account Balance</span></td>
                    <td>
                        <g:textField name="mdBalance" value="" class="input_field" readonly="readonly"/>
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
                        %{--<g:select name="documentReferenceNumber" from="${["DOCUMENT NUMBER 1","DOCUMENT NUMBER 2"] }" class="select_dropdown" noSelection="['':'SELECT ONE...']"  disabled="disabled"/>--}%
                        <g:select name="documentReferenceNumberAp" from="${[]}" class="select_dropdown" noSelection="['':'SELECT ONE...']"  disabled="disabled"/>
                        <g:hiddenField name="apReferenceId" value="" />
                        %{--<g:select name="documentReferenceNumberAr" from="${[] }" class="select_dropdown" noSelection="['':'SELECT ONE...']"  disabled="disabled"/>--}%
                        %{--<g:hiddenField name="arReferenceId" value="" />--}%
                    </td>
				</tr>
			</table>
			<table class="display-ap-balance2_charges">
				<tr>
					<td width="210"><span class="field_label">O/S AP Balance</span></td>
					<td><g:textField name="apOutstandingBalance" class="input_field right numericCurrency" value="" readonly="readonly"  disabled="disabled"/></td>
				</tr>
			</table>
			%{--<table class="display-ap-balance1_charges  full_width">--}%
				%{--<tr>--}%
					%{--<td valign="top"><span class="float_left">O/S AP Balance</span>&#160;&#160;&#160;</td>--}%
					%{--<td>--}%
						%{--<div class="grid_wrapper_apply_ap float_right">--}%
                            %{--<table id="grid_list_ap_balance_charges"></table>--}%
						%{--</div>--}%
					%{--</td>--}%
				%{--</tr>--}%
			%{--</table>--}%

			<table class="display-ib-tr-loan" id="ib_tr_table">
<%--				<g:if test="${!(documentClass in ['DA', 'DP', 'OA', 'DR'])}">--%>
<%--				<tr>--%>
<%--					<td width="150"><span class="field_label">Booking Currency</span></td>--%>
<%--					<td>--%>
<%--                      <span class="bookingCurrencyUSD"><g:radio name="bookingCurrencyIbTr" value="USD" checked="${currency.equals("USD") ? true : false}"/> USD</span>--%>
<%--                      <span class="bookingCurrencyPHP"><g:radio name="bookingCurrencyIbTr" value="PHP" checked="${currency.equals("PHP") ? true : false}"/> PHP</span>--%>
<%--                        %{--<g:radioGroup name="bookingCurrency" labels="['USD', 'PHP']" values="['USD', 'PHP']" >--}%--%>
<%--                            %{--<label>${it.radio} ${it.label} &#160;&#160;</label>--}%--%>
<%--                        %{--</g:radioGroup>--}%--%>
<%--                    </td>--%>
<%--				</tr>--%>
<%--				</g:if>--%>
				<tr>
					<td width="150"><span class="field_label">Payment Code <span class="asterisk">*</span></span></td>
					<td><g:select from="${['0','1','2','3','4','5','6'] }" value="2" name="loanPaymentCode" class="select_dropdown_medium loanField"/></td>
				</tr>
				<tr>
					<td width="150"><span class="field_label">Interest Rate (in %) <span class="asterisk">*</span></span></td>
					<td><g:hiddenField name="interestRate" class="input_field_medium numericCurrency"/>
					<g:textField name="interestRate2" class="input_field_medium loanField intRate appendZero appendDecimal"/></td>
				</tr>
				<tr>
					<td width="150"><span class="field_label">Interest Term / Code <span class="asterisk">*</span></span></td>
 					<td><g:textField name="interestTermNegotiation" class="input_field_medium numberFormat-5 loanField" value="30" disabled="true"/>
<%-- 						 &#160;Days --%>
  						<g:radioGroup id="interestCodeFlagNegotiation" name="interestCodeFlagNegotiation" labels="['Months','Days']" values="['M','D']" value="" class="loanField">
  	        				${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160; 
  	    				</g:radioGroup>
 					<td>
 				</tr>
<%--				<tr>--%>
<%--					<td><span class="field_label">Repricing Term / Code</span></td>--%>
<%-- 					<td><g:textField name="repricingTermNegotiation" class="input_field_medium numberFormat-5" value="30"/> --%>
<%-- 						 &#160;Days --%>
<%--  						<g:radioGroup name="repricingCodeFlagNegotiation" labels="['Months','Days']" values="['M','D']" value=""> --%>
<%--  		        			${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160; --%>
<%--   	    				</g:radioGroup>--%>
<%--  		    		</td>--%>
<%--				</tr>--%>
				<tr>
					<td width="150"><span class="field_label">Loan Term <span class="asterisk">*</span></span></td>
 					<td>
                         <g:textField name="loanTermNegotiation" class="input_field_medium numberFormat-5 loanField" value="30" disabled="true"/>
<%--						  &#160;Days --%>
  						<g:radioGroup name="loanCodeFlagNegotiation" labels="['Months','Days']" values="['M','D']" value="" id="loanCodeFlagNegotiation" class="loanField">
 		        			${it.radio}&#160;<g:message code="${it.label}" />&#160;&#160; 
  	    				</g:radioGroup>
 		    		</td>
				</tr>
                <tr>
                    <td width="150"><span class="field_label">Loan Maturity Date <span class="asterisk">*</span></span></td>
                    <td><g:textField class="input_field_medium datepicker_field loanField" name="loanMaturityDate" readonly="readonly" /></td>
                </tr>
<%--                <g:if test="${ serviceType == 'UA Loan Settlement' }">--%>
<%--					<tr>--%>
<%--						<td><span class="field_label">Doc Stamp Tagging</span></td>--%>
<%--						<td><g:select name="docStampTagging" class="select_dropdown" from="${['TAG 1','TAG 2','TAG 3']}" noSelection="['':'SELECT ONE...']" /></td>--%>
<%--					</tr>--%>
<%--				</g:if>--%>
				<tr>
			        <td width="150"><span class="field_label">With Excess Availment Approval From CFP? <span class="asterisk">*</span></span></td>
			        <td>
			            <g:radioGroup name="cramApprovalFlagNegotiation" labels="['Yes','No']" values="['true','false']" value="" class="loanField">
			                ${it.radio}&#160;<g:message code="${it.label}" />
			            </g:radioGroup>
			            <g:hiddenField class="loanField" name="cramApprovalCheck" />
			        </td>
			    </tr>
			</table>
			<table class="display-ua-loan" id="ua_table">
				<tr>
                    <td width="210"><span class="field_label">Loan Maturity Date <span class="asterisk">*</span></span></td>
                    <td>
                        %{--fix for issue#851--}%
                        <g:if test="${"LC".equals(documentClass) && "NEGOTIATION".equalsIgnoreCase(serviceType) && "DOMESTIC".equals(documentType)}">
                            <g:textField class="input_field_medium datepicker_field loanField" name="loanMaturityDate" />
                        </g:if>
                        <g:else>
                            <g:textField class="datepicker_field loanField" name="loanMaturityDate" readonly="readonly"/>
                        </g:else>
                    </td>
                </tr>
			</table>


			%{--<table class="display-ua-loan">--}%
				%{--<tr>--}%
					%{--<td width="210px"><span class="field_label">Booking Currency</span></td>--}%
					%{--<td >--}%
                        %{--<g:radio name="bookingCurrencyUsance" value="USD"/> USD--}%
                        %{--<input type="radio" name="bookingCurrencyUsance" value="USD" /> USD--}%
                        %{--<g:radio name="bookingCurrencyUsance" value="PHP"/> PHP--}%
                        %{--<input type="radio" name="bookingCurrencyUsance" value="PHP" /> PHP--}%
                    %{--</td>--}%
				%{--</tr>--}%
                %{--<tr>--}%
                    %{--<td><span class="field_label">Interest Rate (in %)</span></td>--}%
                    %{--<td><g:textField name="interestRate" class="input_field_medium"/></td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                    %{--<td><span class="field_label">Interest Term / Code</span></td>--}%
                    %{--<td><g:textField name="interestTermNegotiation" class="input_field_medium numberFormat-5" value="30"/>&#160;Days--}%
                %{--</tr>--}%
                %{--<tr>--}%
                    %{--<td><span class="field_label">Repricing Term / Code</span></td>--}%
                    %{--<td><g:textField name="repricingTermNegotiation" class="input_field_medium numberFormat-5" value="30"/> &#160;Days--}%
                    %{--</td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                    %{--<td><span class="field_label">Loan Term</span></td>--}%
                    %{--<td>--}%
                        %{--<g:textField name="loanTermNegotiation" class="input_field_medium numberFormat-5" value="30"/>&#160;Days--}%
                    %{--</td>--}%
                %{--</tr>--}%
                %{--<tr>--}%
                    %{--<td><span class="field_label">Payment Term</span></td>--}%
                    %{--<td>--}%
                        %{--<g:textField name="paymentTerm" class="input_field_medium numberFormat-5" value="30"/>&#160;Days--}%
                    %{--</td>--}%
                %{--</tr>--}%
				%{--<tr>--}%
					%{--<td><span class="field_label">Loan Maturity Date</span></td>--}%
					%{--<td><g:textField class="input_field" name="loanMaturityDateUsance" readonly="readonly"/></td>--}%
				%{--</tr>--}%
                %{--<tr>--}%
                    %{--<td class="label_width"> <span class="field_label"> Facility ID </span> </td>--}%
                    %{--<td class="input_width"> <g:textField class="input_field input_eleven" name="usanceFacilityId" readonly="readonly" value="${facilityId}"/>--}%
                        %{--<a href="javascript:void(0)" class="search_btn"  id="uaFacilitySearchButton"> Search/Look-up Button </a>--}%
                    %{--</td>--}%
                %{--</tr>--}%
            %{--</table>--}%
        %{--<g:hiddenField name="facilityId" value="${facilityId}"/>--}%

        %{--<g:hiddenField name="facilityType" value="" />--}%
        %{--<g:hiddenField name="facilityReferenceNumber" value="" />--}%
			<g:if test="${documentClass != 'MD' && serviceType != 'Collection'}">
	        	<table class="display_ibt_branch">
	                    <td width="210" class="label_debit_casa"><span class="field_label">If IBT-Branch, specify Unit Code of Branch</span></td>
	                    <td><g:select name="ibtAccountNumber" from="${['4578-08','4583-23']}" noSelection="['':'SELECT ONE...']" class="select_dropdown"  disabled="disabled"/></td>
	                </tr>
	            </table>
            </g:if>
		</div>
		<br/>
		<table class="popup_buttons">
			<tr><td> <input type="button" class="input_button" id="save_modeOfPaymentCharges" value="Save" /> </td></tr>
			<tr><td> <input type="button" class="input_button_negative" id="close_modeOfPaymentCharges2" value="Close" /> </td></tr>
		</table>
		
	</div>
</div>
<div id="mode_of_payment_charges_bg" class="popup_bg_override"> </div>

%{--<g:render template="../commons/popups/facility_id_popup" />--}%

%{--<script>--}%
    %{--$(document).ready(function() {--}%
        %{--$("#accountNumber").setAccountNumberDropdown();--}%
    %{--});--}%
%{--</script>--}%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       