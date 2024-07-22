<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System </title>
		<meta name="layout" content="main_loading" />
		
		<g:javascript src="popups/alert_utility.js" />
        <g:javascript src="utilities/payment/initialize_forms.js" />
        <g:javascript src="utilities/commons/initialize_charges_tab.js" />
<%--        <g:javascript src="js-temp/validation_Charges_Tab.js"/>--%>
        <g:if test="${serviceType?.equalsIgnoreCase("NEGOTIATION")}">
        %{--implements front end business rules if service type is negotiation--}%
            <g:javascript src="utilities/businessrules/lc/payment/negotiation_payment_businessrules.js" />
        </g:if>
        <g:javascript src="popups/mode_of_payment_charges_popup.js" />
        %{--<g:javascript src="utilities/commons/autocomplete_currency_utility.js"/>--}%
        <g:javascript src="utilities/commons/textarea_utility.js" />
        
<%--        <g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">--%>
            <%--implements front end business rules if service type is negotiation--%>
<%--            <g:javascript src="utilities/ets/negotiation/ic-utility.js" />--%>
<%--            <g:javascript src="utilities/businessrules/lc/ets/negotiation/negotiation_ets_businessrules.js" />--%>
<%--        </g:if>--%>
        
		<script type="text/javascript">
			var serviceType = '${serviceType}';

    		// for wiring purpose
			var documentTypeParam = '${documentType}';
            documentType = '${documentType}';
			documentClass = '${documentClass}';
			documentSubType1 = '${documentSubType1}';
			documentSubType2 = '${documentSubType2}';
            var referenceType = '${referenceType}';
            var _viewMode = ("TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && 'true' != '${title.contains('Data Entry') ? 'true' : 'false'}') ? "viewMode" : '${viewMode}';

            var icDetailsUrl = '${g.createLink(controller: 'documentClass', action: 'findIcDetailsByIc')}';
            
            formId = "#basicDetailsTabForm"
           	var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
            var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
            var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
            var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';

            var recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION')}';

            var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
            var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';
            var recomputeUrl = '${g.createLink(controller: "recompute", action: "recomputeCharge")}';
            var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';

            var recomputeCurrency_LC_DOMESTIC_OPENING_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_OPENING')}';
            var recomputeCurrency_LC_DOMESTIC_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_NEGOTIATION')}';
            var recomputeCurrency_LC_DOMESTIC_AMENDMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_AMENDMENT')}';
            var recomputeCurrency_LC_DOMESTIC_UA_LOAN_MATURITY_ADJUSTMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_UA_LOAN_MATURITY_ADJUSTMENT')}';
            var recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT')}';
            
            var recomputeCurrency_LC_FOREIGN_OPENING_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_OPENING')}';
            var recomputeCurrency_LC_FOREIGN_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_NEGOTIATION')}';
            var recomputeCurrency_LC_FOREIGN_AMENDMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_AMENDMENT')}';
            var recomputeCurrency_LC_FOREIGN_ADJUSTMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_ADJUSTMENT')}';
            var recomputeCurrency_LC_FOREIGN_UA_LOAN_MATURITY_ADJUSTMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_UA_LOAN_MATURITY_ADJUSTMENT')}';
            var recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT')}';
            var recomputeCurrency_LC_FOREIGN_INDEMNITY_ISSUANCE_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_INDEMNITY_ISSUANCE')}';
            var recomputeCurrency_LC_FOREIGN_INDEMNITY_CANCELLATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_INDEMNITY_CANCELLATION')}';

          	//Auto Complete
            var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
            var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
            var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
            var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';

            var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment")}';

            var createLoanUrl = '${g.createLink(controller:'payment', action:'createLoan')}';
            var getLoanErrorsUrl = '${g.createLink(controller:'payment', action:'getLoanApplicationErrors')}';
            var updateLoanUrl = '${g.createLink(controller:'payment', action:'updateLoan')}';
            var inquireLoanUrl = '${g.createLink(controller:'payment', action:'inquireLoanStatus')}';
            var errorCorrectUrl = '${g.createLink(controller:'payment', action:'errorCorrectPayment')}';
                reversePaymentUrl = '${g.createLink(controller:'payment', action:'reversePayment')}';
            var errorCorrectTfsUrl = '${g.createLink(controller:'payment', action:'errorCorrectTfsPayment')}';
            var inquireLoanStatusUrl = '${g.createLink(controller:'payment', action:'getLoanStatus')}';
            var reverseLoanUrl = '${g.createLink(controller:'payment', action:'reverseLoan')}';
            var checkCasaBalanceUrl = '${g.createLink(controller:'payment', action:'validateCasaTransactionAmount')}';
            var verifyOfficerPasswordUrl = '${g.createLink(controller:'payment', action:'loginOfficer')}';

            var validateSavedChargesUrl  = '${g.createLink(controller: 'chargesPayment', action: 'validateSavedCharges')}';

            // initialize urls
            //if(serviceType == "Opening") {
            
            
            var payUrl;
            var gotoUrl;
            var saveUrl;
            var updateUrl;
            var updateStatusUrl;
            var deleteDocumentUrl;
            
			if(serviceType.toUpperCase() == "OPENING") {
                saveUrl = '';
				gotoUrl = '${g.createLink(controller:'lcChargesOpening', action:'viewOpeningCharges')}';
				updateUrl = '${g.createLink(controller:'lcChargesOpening', action:'updateOpeningCharges')}';

				computeTotalUrl = '${g.createLink(controller:'lcChargesOpening', action:'computeTotal')}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';

				// for popups
				%{--recomputeCurrencyUrl = '${g.createLink(controller:'lcChargesOpening', action:'recompute')}';			--}%
			//} else if(serviceType == "Adjustment") { 
			} else if(serviceType.toUpperCase() == "ADJUSTMENT") {

                saveUrl = '';
                gotoUrl = '${g.createLink(controller:'lcChargesAdjustment', action:'viewAdjustmentCharges')}';
                updateUrl = '${g.createLink(controller:'lcChargesAdjustment', action:'updateAdjustmentCharges')}';

                computeTotalUrl = '${g.createLink(controller:'lcChargesAdjustment', action:'computeTotal')}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesAdjustment', action:'errorCorrectPayment')}';--}%

			}else if(serviceType.toUpperCase() == "UA LOAN MATURITY ADJUSTMENT" || serviceType.toUpperCase() == "UA_LOAN_MATURITY_ADJUSTMENT") {

				gotoUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'viewMaturityAdjustmentCharges')}';
				saveUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'saveMaturityAdjustmentCharges')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'uploadDocument')}';
				updateUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'updateMaturityAdjustmentCharges')}';
				deleteDocumentUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'deleteDocument')}';

                computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesUaLoanMaturityAdjustment', action:'errorCorrectPayment')}';--}%

			}else if(serviceType.toUpperCase() == "UA LOAN SETTLEMENT" || serviceType.toUpperCase() == "UA_LOAN_SETTLEMENT") {

				gotoUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'viewSettlementCharges')}';
				saveUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'saveSettlementCharges')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'uploadDocument')}';
				updateUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'updateSettlementCharges')}';
				deleteDocumentUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'deleteDocument')}';
				updateStatusUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'updateEtsStatus')}';
                computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
				computeBalanceUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'computeBalance')}';
	
				// for popups
				recomputeUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'recompute')}';			
			payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesUaLoanSettlement', action:'errorCorrectPayment')}';--}%
			}else if(serviceType.toUpperCase() == "AMENDMENT") {

                saveUrl = '';
                gotoUrl = '${g.createLink(controller:'lcChargesAmendment', action:'viewAmendmentCharges')}';
                updateUrl = '${g.createLink(controller:'lcChargesAmendment', action:'updateAmendmentCharges')}';

                computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesAmendment', action:'errorCorrectPayment')}';--}%
			//} else if(serviceType == "Negotiation") {
			} else if(serviceType.toUpperCase() == "NEGOTIATION") {

                saveUrl = '';
                gotoUrl = '${g.createLink(controller:'lcChargesNegotiation', action:'viewNegotiationCharges')}';
                updateUrl = '${g.createLink(controller:'lcChargesNegotiation', action:'updateNegotiationCharges')}';

                computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesNegotiation', action:'errorCorrectPayment')}';--}%
            } else if(serviceType.toUpperCase() == "ISSUANCE") {
                saveUrl = '';
                gotoUrl = '${g.createLink(controller:'lcChargesIndemnityIssuance', action:'viewIndemnityIssuanceCharges')}';
                updateUrl = '${g.createLink(controller:'lcChargesIndemnityIssuance', action:'updateIndemnityIssuanceCharges')}';

                computeTotalUrl = '${g.createLink(controller:'lcChargesIndemnityIssuance', action:'computeTotal')}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesIndemnityIssuance', action:'errorCorrectPayment')}';--}%
            }else if(serviceType.toUpperCase() == "CANCELLATION" && documentClass.toUpperCase() == "INDEMNITY") {
                saveUrl = '';
                gotoUrl = '${g.createLink(controller:'lcChargesIndemnityCancellation', action:'viewIndemnityCancellationCharges')}';
                updateUrl = '${g.createLink(controller:'lcChargesIndemnityCancellation', action:'updateIndemnityCancellationCharges')}';

                computeTotalUrl = '${g.createLink(controller:'lcChargesIndemnityCancellation', action:'computeTotal')}';
                computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';

                payUrl = '${g.createLink(controller:'payment', action:'payItem')}';
                %{--errorCorrectUrl = '${g.createLink(controller:'lcChargesIndemnityIssuance', action:'errorCorrectPayment')}';--}%
            }
		</script>
	</head>
	<body style="visibility: hidden;" onload="js_Load()">

    %{--loading screen--}%
    %{--Note: this is placed here since it requires to be on top of everything--}%
    <g:render template="/layouts/loading" />

		<div id="outer_wrap">
			
			<g:render template="../layouts/header"/>
				
		
			<g:render template="../layouts/accordion" />
				
			<div id="body_forms">
			
				<div id="body_forms_header">
					<div id="header_details">
                        <h3 class="header_details_title" id="longNameDisplay"> ${longName} </h3> <g:hiddenField name="longName" value="${longName}" />
                        <h3 class="header_details_title" id="address1Display"> ${address1} </h3> <g:hiddenField name="address1" value="${address1}" />
                        <h3 class="header_details_title" id="address2Display"> ${address2} </h3> <g:hiddenField name="address2" value="${address2}" />
                        <g:hiddenField name="firstName" value="${firstName}"/>
						<g:hiddenField name="middleName" value="${middleName}"/>
						<g:hiddenField name="lastName" value="${lastName}"/>
						<g:hiddenField name="tinNumber" value="${tinNumber}"/>
						<g:hiddenField name="officerCode" value="${officerCode}"/>
           				<g:hiddenField name="exceptionCode" value="${exceptionCode}"/>
						<br /><br /><br />
					</div>
					<table id="header_details2">
						<tr>
						  <td> <span class="field_label"> CIF Number</span> </td>
						  <td> <g:textField name="cifNumber" value="${cifNumber}" class="input_field textFormat-7 numericString" readonly="readonly" /> </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> CIF Name </span> </td>
						  <td> <g:textField name="cifName" class="input_field textFormat-20" readonly="readonly" value="${cifName}" /> </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> Account Officer </span> </td>
						  <td> <g:textField name="accountOfficer" class="input_field textFormat-30" readonly="readonly" value="${accountOfficer}" /> </td>
						</tr>
						<tr> 
						  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
						  <td> <g:textField name="ccbdBranchUnitCode" class="input_field textFormat-3" readonly="readonly" value="${ccbdBranchUnitCode}" /> </td>
						  <g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
						</tr>
					</table>
					<br />
					<div class="note">
                        <g:if test="${serviceType != 'Opening' && remainingDays && remainingDays <= 7 && remainingDays > 0}">
                            <span class="note_inside"> NOTE: LC will expire in ${remainingDays} ${remainingDays == 1 ? 'day' : 'days'}. </span>
                        </g:if>
                        <g:if test="${'true'.equals(isOverAvailed) && !viewMode}">
                             <div class="note_inside"> NOTE: ${overAvailment}</div>
                        </g:if>
                    </div>
                    <g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
                    <g:hiddenField name="remainingDays" value="${remainingDays}" />
				</div>
				<div id="tab_container"> 				
				
					<ul id="tabs">				
						<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details <br/> &#160; </span></a></li>
<%--						<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && (!documentSubType1?.equalsIgnoreCase('CASH') && (documentType?.equalsIgnoreCase('DOMESTIC') || documentType?.equalsIgnoreCase('FOREIGN')))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC'))}">--%>
<%--						<g:each in="${paymentsMade}"><g:if test="${it.PAYMENTINSTRUMENTTYPE in ['TR_LOAN', 'IB_LOAN', 'UA_LOAN']}">--%>
<%--			    			<li class="loanDetailsTab_data_entry"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li>--%>
<%--		    			</g:if></g:each>--%>
<%--			    		</g:if>--%>
						
<%--						 <g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation')) || (serviceType?.equalsIgnoreCase('UA Loan Settlement')) }">--%>

						 <g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation') || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))) }">
                             <li class="display_negotiation_ua_loan">
		    					<a href="#cash_lc_payment_tab" id="cashLcPaymentTab">
		    						<span class="tab_titles">
		    							<g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation')) }">
		    								Negotiation Payment <br/> &#160;
		    							</g:if>
		    							<g:if test="${ (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">
		    								<g:if test="${ documentType?.equalsIgnoreCase('FOREIGN')}">
		    								UA Loan Payment <br/> &#160;
		    								</g:if>
		    								<g:if test="${ documentType?.equalsIgnoreCase('DOMESTIC') }">
		    								DUA Loan Payment <br/> &#160;
		    								</g:if>
			    						</g:if>
			    					</span>
			    				</a>
		    				</li>
		    			</g:if>
						
						<%-- remove showLoanDetailstab &&, it will only be 'true' if it comes from data entry --%>
						<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">
							<%-- <li class="loanDetailsTab_data_entry"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li> --%>
							<li class="showLoanDetailsTab"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li>
						</g:if>
		    			
						<g:if test="${ (serviceType?.equalsIgnoreCase('Amendment') && lcAmountFlag?.equalsIgnoreCase('INC') && documentSubType1?.equalsIgnoreCase('CASH')) ||
						               (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR')) ||
						               (serviceType?.equalsIgnoreCase('Opening') && documentSubType1?.equalsIgnoreCase('CASH'))}">
			   				<li class="cash_lc_payment_tab display_cash_payment">
			   					<a href="#cash_lc_payment_tab" id="cashLcPaymentTab">
			   						<span class="tab_titles">
			   							<g:if test="${ !(serviceType?.equalsIgnoreCase('Amendment')) && !serviceType?.equalsIgnoreCase("Negotiation")}">

			   								Cash LC Payment <br/> &#160;
			   							</g:if>
			   							<g:else>
                                                Additional LC<br/>Cash Payment
			   							</g:else>
			   						</span>
			   					</a>
			   				</li>
		   				</g:if>
						
                        <%-- marv.04Mar2013.start - this is a bug fix. please do not comment this --%>
                      	<%-- <g:if test="${ (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT') && documentType?.equalsIgnoreCase('DOMESTIC')) }"> --%>
                      	<g:if test="${ (((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2.equalsIgnoreCase('SIGHT')) && documentType?.equalsIgnoreCase('DOMESTIC'))) }">
                        <%-- marv.04Mar2013.end - this is a bug fix. please do not comment this --%>
                        
							<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">    
                           		<li><a href="#proceeds_tab" id="proceedsDetailsTab"><span class="tab_titles"> Settlement to Beneficiary <br/> &#160; </span></a></li>
                           		<li id="pddtsTabLi"><a href="#pddts_tab" id="pddtsTab"><span class="tab_titles"> PDDTS<br>&#160;</span></a></li>
                           		<li id="mt103TabLi"><a href="#mt103_tab" id="mt103Tab"><span class="tab_titles"> MT103<br>&#160;</span></a></li>
                           	</g:if>
                       	</g:if>
                    	<%-- <g:if test="${!(serviceType?.equalsIgnoreCase('Adjustment')) &&--%>
                      	<%-- !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType))}">--%>
                        <g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
                                %{--documentSubType1?.equalsIgnoreCase('REGULAR') && documentType?.equalsIgnoreCase('Domestic'))}">--}%
						<li id="chargesLi" class="charges_tab"><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges  <br/> &#160;</span></a></li>
						<li id="chargesPaymentLi" class="charges_payment_tab"><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment  <br/> &#160;</span></a></li>
						</g:if>
						<g:if test="${documentClass?.equalsIgnoreCase('Indemnity') && serviceType?.equalsIgnoreCase('Cancellation')}">
							<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges  <br/> &#160;</span></a></li>
							<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment  <br/> &#160;</span></a></li>	
						</g:if>
					
					
						
					</ul>
											
					<form id="basicDetailsTabForm">
			        	<div id="basic_details_tab">
	
		        		<g:if test="${serviceType?.equalsIgnoreCase('Opening')}">
			        		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('CASH')}">
				         		<g:render template="/lc/payment/opening/foreign/cash/basic_details_tab" />   
			         		</g:if>
			         		<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN') && !documentSubType1?.equalsIgnoreCase('CASH')}">
			         			<g:render template="/lc/payment/opening/foreign/basic_details_tab" />
			         		</g:elseif>
			         		<g:else>
				         		<g:render template="/lc/payment/opening/domestic/basic_details_tab" />  
			        		</g:else>
		        		</g:if>
		         		 <g:elseif test="${serviceType?.equalsIgnoreCase('Adjustment')}">
							<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('CASH') }">
								<g:render template="/lc/payment/adjustment/foreign/basic_details_tab" />
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN') && !documentSubType1?.equalsIgnoreCase('CASH') }">
								<g:render template="/lc/payment/adjustment/foreign/basic_details_tab" />
							</g:elseif>		
							<g:else>
								<g:render template="/lc/payment/adjustment/domestic/basic_details_tab" /> 
							</g:else>	         		 
		         		 </g:elseif>
		         		 <g:elseif test="${serviceType?.equalsIgnoreCase('UA Loan Maturity Adjustment') || serviceType?.equalsIgnoreCase('UA_LOAN_MATURITY_ADJUSTMENT')}">
		         		 	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		         		 		<g:render template="/lc/payment/ua_loan_maturity_adjustment/foreign/basic_details_tab" />
		         		 	</g:if>
		         		 	<g:else>
		         		 		<g:render template="/lc/payment/ua_loan_maturity_adjustment/domestic/basic_details_tab" />
		         		 	</g:else>
		         		 </g:elseif>
		         		 <g:elseif test="${serviceType?.equalsIgnoreCase('Amendment')}">
		         		 	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		         		 		<g:if test="${documentSubType1?.equalsIgnoreCase('STANDBY')}">
		         		 			<g:render template="/lc/payment/amendment/foreign/standby/basic_details_tab" />
		         		 		</g:if>
		         		 		<g:else>
		         		 			<g:render template="/lc/payment/amendment/foreign/basic_details_tab" />
		         		 		</g:else>
		         		 	</g:if>
		         		 	<g:else>
		         		 		<g:render template="/lc/payment/amendment/domestic/basic_details_tab" />
		         		 	</g:else>
		         		</g:elseif>
		         		<g:elseif test="${(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
		         		 		<g:render template="/lc/payment/indemnity_cancellation/foreign/basic_details_tab" />
		         		</g:elseif>
		         		<g:elseif test="${(serviceType?.equalsIgnoreCase('Issuance') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
		         		 		<g:render template="/lc/payment/indemnity_issuance/foreign/basic_details_tab" />
		         		</g:elseif>
		         		<g:elseif test="${serviceType?.equalsIgnoreCase('Negotiation')}">
		         		 	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		         		 		<g:render template="/lc/payment/negotiation/foreign/basic_details_tab" />
		         		 	</g:if>
		         		 	<g:else>
		         		 		<g:render template="/lc/payment/negotiation/domestic/basic_details_tab" />
		         		 	</g:else>
		         		</g:elseif>
		         		<g:elseif test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')}">
		         		 	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
		         		 		<g:render template="/lc/payment/ua_loan_settlement/foreign/basic_details_tab" />
		         		 	</g:if>
		         		 	<g:else>
		         		 		<g:render template="/lc/payment/ua_loan_settlement/domestic/basic_details_tab" />
		         		 	</g:else>
		         		</g:elseif>
			        	</div>
			        </form>

					<g:if test="${ (serviceType?.equalsIgnoreCase('Amendment') && lcAmountFlag?.equalsIgnoreCase('INC') && documentSubType1?.equalsIgnoreCase('CASH')) ||
						               (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR')) ||
						               (serviceType?.equalsIgnoreCase('Opening') && documentSubType1?.equalsIgnoreCase('CASH')) ||
						               (serviceType?.equalsIgnoreCase('Negotiation') || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")))}">
                        <form id="cashLcPaymentTabForm">
                            <div id="cash_lc_payment_tab">
                                <g:render template="../commons/tabs/cash_lc_payment_tab" />
                            </div>
                        </form>
                    </g:if>
					
                    <%-- For ua loan Settlement and Negotiation --%>
                    <%-- remove showLoanDetailstab &&, it will only be 'true' if it comes from data entry --%>
					<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">
                        <div id="loan_details_tab" >
                            <form id="loanDetailsTabForm"  >
                                    <g:render template="../commons/tabs/loan_details_tab"/>
                            </form>
                        </div>
					</g:if>

                   	<g:if test="${ (((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2.equalsIgnoreCase('SIGHT')) && documentType?.equalsIgnoreCase('DOMESTIC'))) }">
                    	          
                   		<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">          	
                        	<form id="proceedsDetailsTabForm">
                            	<div id="proceeds_tab">
                                		<g:render template="../commons/tabs/proceeds_details_tab" />
                            	</div>
                        	</form>						
						
                            <form id="pddtsTabForm"  >
                                <div id="pddts_tab" >
                                    <g:render template="../commons/tabs/pddts_tab"/>
                                </div>
                            </form>

                            <form id="mt103TabForm"  >
                                <div id="mt103_tab" >
                                    <g:render template="../commons/tabs/mt_103_tab"/>
                                </div>
                            </form>
						</g:if>
                            
                    </g:if>

<%--					<g:if test="${!(serviceType?.equalsIgnoreCase('Adjustment')) &&--%>
<%--                            !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType))}">--%>
					<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
                            %{--documentSubType1?.equalsIgnoreCase('REGULAR') && documentType?.equalsIgnoreCase('Domestic'))}">--}%
                        <form id="chargesTabForm">
                            <div id="charges_tab">
                                <g:render template="../commons/tabs/charges_tab" />
                            </div>
                        </form>


                        <form id="chargesPaymentTabForm">
                            <div id="charges_payment_tab">
                                <g:render template="../commons/tabs/charges_payment_tab" />
                            </div>
                        </form>
	    			</g:if>

					<g:if test="${documentClass?.equalsIgnoreCase('Indemnity') && serviceType?.equalsIgnoreCase('Cancellation')}">	    			
						<form id="chargesTabForm">
                            <div id="charges_tab">
                                <g:render template="../commons/tabs/charges_tab" />
                            </div>
                        </form>
                        <form id="chargesPaymentTabForm">
                            <div id="charges_payment_tab">
                                <g:render template="../commons/tabs/charges_payment_tab" />
                            </div>
                        </form>
					</g:if>

				</div>
			</div>
		</div>	
			
	<%--<g:render template="../popups/special/accounting_entries_popup" />
	<g:javascript src="popups/dialog_accounting_entries.js"/>--%>

    <g:render template="/layouts/loading" />

	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/confirm_alert_cancel" />
	<g:render template="../layouts/alert_confirmation" model="${[popupId:'popup_cancel_basic_details',popupTitle:'Save Basic Details',
		  popupMessage:'Do you want to save your changes?<br/>'+ 
    	'If Yes, save data then redirect to Unacted<br/>'+
    	'If No, resets data then redirect to Unacted<br/>'+
    	'If Close, disregard this popup' ,includeCancel:true,yesBtnId:'yesBtnBD',noBtnId:'noBtnBD',cancelBtnId:'cancelBtnBD'] }"/>
	<g:render template="../layouts/alert" />

	<g:render template="../commons/popups/mode_of_payment_charges_popup" />
    %{--<g:render template="/commons/popups/override_confirmation"/>--}%

    <g:javascript src="new/override_authorization_utils.js" />
    <g:render template="/commons/popups/override_authorization"
              model="[overrideAuthDivId: 'payAuthorizeDiv',
                      overrideAuthDivBg: 'payAuthorizeBg',
                      overrideAuthUsernameId: 'payAuthorizeUsername',
                      overrideAuthPasswordId: 'payAuthorizePassword',
                      overrideAuthConfirmId: 'payAuthorizeConfirm',
                      overrideAuthCancelId: 'payAuthorizeCancel',
                      overrideAuthCasaPaymentId: 'payAuthorizeCasaId'
              ]"/>

    <g:render template="/commons/popups/override_authorization"
              model="[overrideAuthDivId: 'unpayAuthorizeDiv',
                      overrideAuthDivBg: 'unpayAuthorizeBg',
                      overrideAuthUsernameId: 'unpayAuthorizeUsername',
                      overrideAuthPasswordId: 'unpayAuthorizePassword',
                      overrideAuthConfirmId: 'unpayAuthorizeConfirm',
                      overrideAuthCancelId: 'unpayAuthorizeCancel',
                      overrideAuthCasaPaymentId: 'unpayAuthorizeCasaId'
              ]"/>

    <g:render template="../commons/popups/create_transaction_popup" />
    <g:render template="../commons/popups/create_ua_popup" />
    <g:render template="../commons/popups/create_ets_popup" />
    <g:render template="../commons/popups/create_non_lc_popup" />
    <g:render template="../commons/popups/ec_login" />
    <g:render template="../commons/popups/reverse_button_confirmation" />
    <g:render template="../commons/popups/loan_details_popup"/>
    <g:render template="../commons/popups/facility_id_popup" />


	<g:if test="${!(serviceType?.equalsIgnoreCase('Adjustment')) &&
            !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType))}">
            %{--documentSubType1?.equalsIgnoreCase('REGULAR') && documentType?.equalsIgnoreCase('Domestic'))}">--}%
    <g:if test="${!session['userrole']['id'].equals("BRM")}">
        <script type="text/javascript">
            $(document).ready(function () {
            	if('function' === typeof updateTotals){
                	var timeoutID = window.setTimeout(updateTotals, 1000);
                }
            });
        </script>
    </g:if>

    <g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) && (documentType?.equalsIgnoreCase('FOREIGN') && serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR')) }">
        <script type="text/javascript">
            $(document).ready(function () {
                checkForOtherCurrency();
                var timeoutID = window.setTimeout(updateTotals, 1000);
            });
        </script>
    </g:if>
    </g:if>
    <script type="text/javascript">
        var pddtsFlag = '${pddtsFlag}';
        var mt103Flag = '${mt103Flag}';


        $(document).ready(function() {
            $("#pddtsTabLi").hide();
            $("#mt103TabLi").hide();

            if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                $("#chargesLi").show();
                $("#chargesPaymentLi").show();
            }

            if (pddtsFlag == "Y") {
                $("#pddtsTabLi").show();

                if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                    $("#chargesLi").show();
                    $("#chargesPaymentLi").show();
                }
            }

            if (mt103Flag == "Y") {
                $("#mt103TabLi").show();

                if (documentClass == "LC" && documentType == "DOMESTIC" && documentSubType1 == "CASH" && serviceType.toUpperCase() == "NEGOTIATION") {
                    $("#chargesLi").show();
                    $("#chargesPaymentLi").show();
                }
            }

        });
    </script>
	</body>
</html>