<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="layout" content="main_ets" />
<title>Trade Finance System - ${title} </title>

	    <g:javascript src="popups/alert_utility.js" />
	    <g:javascript src="js-temp/amount_utility.js" />
<%--		<g:javascript src="js-temp/validation_Charges_Tab.js"/>--%>
		<g:if test="${windowed}">
	    <g:javascript src="utilities/ets/commons/window_utility.js" />
		</g:if>
		<g:javascript src="utilities/ets/opening/initialize_forms.js" />
		<g:javascript src="utilities/commons/initialize_charges_tab.js" />
		<g:javascript src="popups/ets_opening_header_utility.js" />
		<g:if test="${!serviceType?.equalsIgnoreCase('CANCELLATION')}">
		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
		</g:if>
        <g:javascript src="utilities/commons/ets_index_utility.js" />
        <g:javascript src="utilities/commons/textarea_utility.js" />
		

        <g:if test="${serviceType?.equalsIgnoreCase("NEGOTIATION")}">
            <%--implements front end business rules if service type is negotiation--%>
            <g:javascript src="utilities/ets/negotiation/ic-utility.js" />
            <g:javascript src="utilities/businessrules/lc/ets/negotiation/negotiation_ets_businessrules.js" />
        </g:if>
        
        <g:if test="${serviceType?.equalsIgnoreCase("AMENDMENT")}">
            <%--implements front end business rules if service type is amendment--%>           
            <g:javascript src="utilities/businessrules/lc/ets/Amendment/amendment_ets_businessrules.js" />
        </g:if>
        
		<script type="text/javascript">


			var serviceType = '${serviceType}';

            var referenceType = '${referenceType}';
			// for wiring purpose	
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var documentSubType1 = '${documentSubType1}';
			var documentSubType2 = '${documentSubType2}';
            var etsNumberHolder = '${serviceInstructionId}';
            var tradeServiceIdHolder = '${tradeServiceId}';
			var loggedInUser='${session['group']}';
			var userRole='${session.userrole.id}';
			var docStatus='${status}';
			var reverseEts='${reverseEts}';
			var title = '${title}';
			var _viewMode='${viewMode}';		
			var formId = "#basicDetailsTabForm";
			var gotoUrl;
			var saveUrl;
			var uploadDocumentUrl;
			var updateUrl;
			var deleteDocumentUrl;
			var updateStatusUrl;

			var unactedTransactionsUrl = '${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            var icDetailsUrl = '${g.createLink(controller: 'documentClass', action: 'findIcDetailsByIc')}';
				
            var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
            var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
            var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
            var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
            var attachedDocumentsUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
            var downloadDocumentUrl = '${g.createLink(controller:'lcEtsOpening', action:'downloadFile')}';

			var requestFacilityBalanceUrl = '${g.createLink(controller:'facility', action:'requestFacilityBalance')}'

            var addConditions1Url = "";

            var computeTotalUrl = '${g.createLink(controller: "recompute", action: "computeTotal")}';
            var computeBalanceUrl = '${g.createLink(controller: "recompute", action: "computeBalance")}';
            var recomputeUrl = '${g.createLink(controller: "recompute", action: "recomputeCharge")}';
            var recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency')}';

            var recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_OPENING_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_OPENING_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_NEGOTIATION_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_NEGOTIATION_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_UA_LOAN_SETTLEMENT_EDIT_COMPUTATION')}';

            var recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_DOMESTIC_AMENDMENT_EDIT_COMPUTATION')}';
            var recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_LC_FOREIGN_AMENDMENT_EDIT_COMPUTATION')}';

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

            // initialize urls
			if(serviceType == "Opening" || serviceType == "OPENING_REVERSAL") {
				gotoUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewOpeningEts')}';
				saveUrl = '${g.createLink(controller:'lcEtsOpening', action:'saveOpeningEts')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsOpening', action:'uploadDocument')}';
				updateUrl = '${g.createLink(controller:'lcEtsOpening', action:'updateOpeningEts')}';
				deleteDocumentUrl = '${g.createLink(controller:'lcEtsOpening', action:'deleteDocument')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsOpening', action:'updateEtsStatus')}';

            }else if(serviceType == "Adjustment") {
				gotoUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'viewAdjustmentEts')}';
				saveUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'saveAdjustmentEts')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'uploadDocument')}';
				updateUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'updateAdjustmentEts')}';
				deleteDocumentUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'deleteDocument')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsAdjustment', action:'updateEtsStatus')}';

			}else if(serviceType == "Amendment") {
				gotoUrl = '${g.createLink(controller:'lcEtsAmendment', action:'viewAmendmentEts')}';
				saveUrl  = '${g.createLink(controller:'lcEtsAmendment', action:'saveAmendmentEts')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsAmendment', action:'uploadDocument')}';
				updateUrl = '${g.createLink(controller:'lcEtsAmendment', action:'updateAmendmentEts')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsAmendment', action:'deleteDocument')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsAmendment', action:'updateEtsStatus')}';
                recomputeCurrencyUrl = '${g.createLink(controller: 'recompute',action: 'recomputeCurrencyAmendment')}';

			}else if(serviceType == "Cancellation"){
				gotoUrl = '${g.createLink(controller:'lcEtsCancellation', action:'viewCancellationEts')}';
				saveUrl = '${g.createLink(controller:'lcEtsCancellation', action:'saveCancellationEts')}';
				updateUrl = '${g.createLink(controller:'lcEtsCancellation', action:'updateCancellationEts')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsCancellation', action:'updateEtsStatus')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsCancellation', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsCancellation', action:'deleteDocument')}';

			}else if(serviceType.toLowerCase() == "issuance" && documentClass.toLowerCase() == "indemnity"){

				gotoUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'viewIndemnityIssuanceEts')}';
				saveUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'saveIndemnityIssuanceEts')}';
				updateUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'updateIndemnityIssuanceEts')}';
				deleteDocumentUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'deleteDocument')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'updateEtsStatus')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsIndemnityIssuance', action:'deleteDocument')}';

			}else if(serviceType.toUpperCase() == "NEGOTIATION"){
				gotoUrl = '${g.createLink(controller:'lcEtsNegotiation', action:'viewNegotiationEts')}';
				saveUrl = '${g.createLink(controller:'lcEtsNegotiation', action:'saveNegotiationEts')}';
				updateUrl = '${g.createLink(controller:'lcEtsNegotiation', action:'updateNegotiationEts')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsNegotiation', action:'updateEtsStatus')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsNegotiation', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsNegotiation', action:'deleteDocument')}';
			}else if((serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT")) {
				gotoUrl = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'viewUaLoanSettlementEts')}';
				saveUrl  = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'saveUaLoanSettlementEts')}';
				updateUrl = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'updateUaLoanSettlementEts')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'updateEtsStatus')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsUaLoanSettlement', action:'deleteDocument')}';

			}else if((serviceType == "UA Loan Maturity Adjustment" || serviceType == "UA_LOAN_MATURITY_ADJUSTMENT")) {

				gotoUrl = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'viewMaturityAdjustmentEts')}';
				saveUrl  = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'saveMaturityAdjustmentEts')}';
				updateUrl = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'updateMaturityAdjustmentEts')}';
				updateStatusUrl = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'updateEtsStatus')}';
				uploadDocumentUrl = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'uploadDocument')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcEtsUaLoanMaturityAdjustment', action:'deleteDocument')}';
			}

            $(document).ready(function() {
                $(formId).change(function() {
                    formChanged = formId;
                    formIsChanged = true;
                });
            });
		</script>
		
  	</head>
  	<body style="visibility: hidden;" onload="js_Load()">
  		    <g:hiddenField name="hiddentitle" id='hiddentitle' value='${documentSubType1}'/>
  			<div id="outer_wrap" <g:if test="${windowed}">class="window"</g:if> >
	  		<g:render template="../layouts/header"/>
			
	  		<div id="inner_wrap">
                <g:if test="${!windowed}">
	  			    <g:render template="../layouts/accordion"/>
	  			</g:if>
					
	  			<div id="body_forms" <g:if test="${windowed}">class="window"</g:if>>
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
			  					<td> <span class="field_label">CIF Number <g:if test="${serviceType?.equalsIgnoreCase('OPENING')}"><span class="asterisk">*</span></g:if> </span> </td>
			  					<td>
			      					<g:textField class="input_field numericString ${session['userrole']['id']?.equals("BRM") && serviceType?.equalsIgnoreCase("OPENING") ? 'required' : ''}" name="cifNumber" readonly="readonly" value="${cifNumber}"/>
                                    <g:if test="${session['userrole']['id']?.equals("BRM") && serviceType?.equalsIgnoreCase("OPENING")}">
			          					<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
			 						</g:if>
			 						
			  					</td>
		    				</tr>
							<tr>
			  					<td> <span class="field_label"> CIF Name </span> </td>
			  					<td colspan="2">
                                      <g:textField class="input_field" readonly="readonly" name="cifName" value="${cifName}"/>
                                  </td>
		    				</tr>
							<tr>
			  					<td> <span class="field_label"> Account Officer </span> </td>
			  					<td colspan="2"> <g:textField class="input_field" readonly="readonly" name="accountOfficer" value="${accountOfficer}"/> </td>
		  	  				</tr>
							<tr>
			  					<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
			  					<td colspan="2"> <g:textField class="input_field" readonly="readonly" name="ccbdBranchUnitCode" value="${ccbdBranchUnitCode}"/> 
			  					<g:hiddenField name="allocationUnitCode" value="${allocationUnitCode}"/></td>
		    				</tr>
		  				</table>
                        <div class="note">
                        	<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
                           <g:if test="${(reinstateFlag.equals('Y'))}">
                               <span class="note_inside"> NOTE: LC expired on ${expiryDate}. </span> 
                           </g:if>
                           <g:elseif test="${serviceType != 'Opening' && remainingDays && remainingDays <= 7 && remainingDays > 0}">
                               <span class="note_inside"> NOTE: LC will expire in ${remainingDays} ${remainingDays == 1 ? 'day' : 'days'}. </span>
                           </g:elseif>
                          	<div class="note_inside overAvailment"> ${overAvailment}</div>
                  			<g:hiddenField name="overAvailment" value="${overAvailment}" />
                        </div>
		  				<br />
					</div>
                    
                    <g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
                    <g:hiddenField name="remainingDays" value="${remainingDays}" />
					<div id="tab_container">
		  				<ul id="tabs">
							<%--	BASIC DETAILS	--%>
		    				<li> <a href="#basic_details_tab" id="basicDetailsTab"> <span class="tab_titles"> Basic Details <br/> &#160; </span> </a></li>

		    				<%--	ATTACHED DOCUMENTS	--%>
		    					<li class="display_attached_documents"> <a href="#attached_documents_tab" id="attachedDocumentsTab"> <span class="tab_titles"> Attached<br/>Documents </span> </a></li>
		    				
							<%--	SPECIAL TAB FOR Amendment ONLY	--%>
							<g:if test="${ (serviceType?.equalsIgnoreCase('Amendment')) }">
			   					<li><a href="#nature_of_amendment_tab" id="natureOfAmendmentTab"><span class="tab_titles"> Nature of<br/>Amendment </span></a></li>
		   					</g:if>
		   							   					
		   					<%--	CASH LC PAYMENT TAB	--%>
		   					<g:if test="${(serviceType?.equalsIgnoreCase('Amendment') && documentSubType1?.equalsIgnoreCase('CASH')) || (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR') && partialCashSettlementFlag?.equalsIgnoreCase("partialCashSettlementEnabled"))  || (serviceType?.equalsIgnoreCase('Opening') && documentSubType1?.equalsIgnoreCase('CASH')) }">
			   					<%-- remove tab when viewed thru view approved ets link --%>
			   					<g:if test="${!windowed?.equalsIgnoreCase('true')}">
				   					<li class="cash_lc_payment_tab display_cash_payment">
				   						<a href="#cash_lc_payment_tab" id="cashLcPaymentTab">
				   							<span class="tab_titles">
				   								<g:if test="${ !(serviceType?.equalsIgnoreCase('Amendment'))}">
				   									Cash LC Payment <br/> &#160;
				   								</g:if>
				   								<g:else>
				   									Additional LC<br/>Cash Payment
				   								</g:else>
				   							</span>
				   						</a>
				   					</li>
			   					</g:if>
		   					</g:if>

							<%--	CASH LC TAB FOR Negotiation AND UA Loan Settlement	--%>
		    				<%-- <g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation') || serviceType?.equalsIgnoreCase('UA Loan Settlement')) }"> --%>
		    				<g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation') || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))) }">
			    				<%-- remove tab when viewed thru view approved ets link --%>
			   					<g:if test="${!windowed?.equalsIgnoreCase('true')}">
				    				<li class="display_negotiation_ua_loan">
			    						<a href="#cash_lc_payment_tab" id="cashLcPaymentTab">
			    							<span class="tab_titles">
			    								<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation'))}">
			    									Negotiation<br/>Payment
			    								</g:if>
			    								<%-- <g:if test="${ (serviceType?.equalsIgnoreCase('UA Loan Settlement')) }"> --%>
			    								<g:if test="${ (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")) }">
	
			    									<g:if test="${ documentType?.equalsIgnoreCase('FOREIGN') }">
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
		    				</g:if>
		    				
		    				<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">
								<%-- <li class="loanDetailsTab_data_entry"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li> --%>
								<li class="showLoanDetailsTab"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li>
							</g:if>
		    				

							<g:if test="${(((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT'))) && documentType?.equalsIgnoreCase('DOMESTIC'))}">
								<%--<li><a href="#proceeds_tab" id="proceedsDetailsTab"><span class="tab_titles"> Proceeds Details for<br/>Beneficiary</span></a></li>--%>
								<li><a href="#proceeds_tab" id="proceedsDetailsTab"><span class="tab_titles"> Settlement to<br/>Beneficiary</span></a></li>
							</g:if>

		   					<%--	CHARGES TAB --%>

		   					<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                       !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                       !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                       !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
		   						<%-- remove tab when viewed thru view approved ets link --%>
			   					<g:if test="${!windowed?.equalsIgnoreCase('true')}">
		   							<li class="charges_tab"> <a href="#charges_tab" id="chargesTab"> <span class="tab_titles"> Charges  <br/> &#160;</span> </a></li>
		   						</g:if>
		   					</g:if>

		   					<%--	CHARGES PAYMENT TAB --%>
		   					<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                       !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                       !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                       !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
								<%-- remove tab when viewed thru view approved ets link --%>
			   					<g:if test="${!windowed?.equalsIgnoreCase('true')}">
		   							<li class="charges_payment_tab"> <a href="#charges_payment_tab" id="chargesPaymentTab"> <span class="tab_titles"> Charges<br/>Payment </span> </a></li>
		   						</g:if>
		   					</g:if>


                          <%--	SETTLEMENT TO BENEFICIARY // PROCEEDS TO BENEFICIARY // Negotiation (DOMESTIC) & UA Loan Settlement (DOMESTIC) ONLY --%>
							
							%{--<g:if test="${ (((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT')) && documentType?.equalsIgnoreCase('DOMESTIC'))) }">--}%
		   						%{--<li><a href="#proceeds_tab" id="proceedsDetailsTab"><span class="tab_titles"> Proceeds Details for<br/>Beneficiary </span></a></li>--}%
		   					%{--</g:if>--}%

		   					<%-- <g:if test="${ ((serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('DOMESTIC')) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC'))) }"> --%>
		   					<%-- <g:if test="${ ((serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC'))) }"> --%>


		   					<%--	INSTRUCTIONS AND ROUTING	 --%>
							<li> <a href="#instructions_routing_tab" id="instructionsRoutingTab"> <span class="tab_titles"> Instructions and<br/>Routing</span> </a></li>

		  				</ul>

		  				<div id="basic_details_tab">
  							<form id="basicDetailsTabForm">
		  						<g:if test="${serviceType?.equalsIgnoreCase('OPENING') || serviceType?.equalsIgnoreCase('OPENING_REVERSAL')}">
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('REGULAR')}">
			  							<g:render template="../lc/ets/opening/regular/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
			  							<g:render template="../lc/ets/opening/standby/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('CASH')}">
			  							<g:render template="../lc/ets/opening/cash/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('REGULAR')}">
			  							<g:render template="../lc/ets/opening/regular/domestic/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
			  							<g:render template="../lc/ets/opening/standby/domestic/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('CASH')}">
			  							<g:render template="../lc/ets/opening/cash/domestic/basic_details_tab" />
									</g:if>
								</g:if>
								
								<%-- if Adjustment --%>
								<g:if test="${serviceType?.equalsIgnoreCase('Adjustment')}">
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') }">
										<g:render template="../lc/ets/adjustment/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') }">
										<g:render template="../lc/ets/adjustment/domestic/basic_details_tab" />
									</g:if>
								</g:if>




								<%-- if Amendment --%>
								<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('REGULAR')}">
								  		<g:render template="../lc/ets/amendment/regular/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
								  		<g:render template="../lc/ets/amendment/standby/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('CASH')}">
								  		<g:render template="../lc/ets/amendment/cash/foreign/basic_details_tab" />
									</g:if>

									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('REGULAR')}">
								  		<g:render template="../lc/ets/amendment/regular/domestic/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
								  		<g:render template="../lc/ets/amendment/standby/domestic/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('CASH')}">
								  		<g:render template="../lc/ets/amendment/cash/domestic/basic_details_tab" />
									</g:if>
								</g:if>

								<%-- if Cancellation --%>
								<g:if test="${serviceType?.equalsIgnoreCase('Cancellation') }">
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') }">
										<g:render template="../lc/ets/cancellation/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') }">
										<g:render template="../lc/ets/cancellation/domestic/basic_details_tab" />
									</g:if>
								</g:if>

								<%-- if Indemnity Issuance --%>
								<g:if test="${serviceType?.equalsIgnoreCase('ISSUANCE') && documentClass?.equalsIgnoreCase('INDEMNITY') }">
									<g:render template="../lc/ets/indemnity_issuance/foreign/basic_details_tab" />
								</g:if>

								<%-- if Negotiation --%>
								<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') }">
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
										<g:render template="../lc/ets/negotiation/foreign/basic_details_tab" />
									</g:if>
									<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN')}">
                                        <g:render template="../lc/ets/negotiation/foreign/nonStandby/basic_details_tab" />
                                    </g:elseif>
									<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
										<g:render template="../lc/ets/negotiation/domestic/basic_details_tab" />
									</g:elseif>
									<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
                                        <g:render template="../lc/ets/negotiation/domestic/nonStandby/basic_details_tab" />
                                    </g:elseif>
								</g:if>

								<%-- FOR UA Loan Settlement --%>
								<%-- <g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement')}"> --%>
								<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT")}">

									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
										<g:render template="../lc/ets/ua_loan_settlement/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
										<g:render template="../lc/ets/ua_loan_settlement/domestic/basic_details_tab" />
									</g:if>
								</g:if>

								<%-- FOR UA Loan Maturity Adjustment --%>
								<%-- <g:if test="${serviceType?.equalsIgnoreCase('UA Loan Maturity Adjustment')}"> --%>
								<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Maturity Adjustment') || serviceType?.equalsIgnoreCase("UA_LOAN_MATURITY_ADJUSTMENT")}">

									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
										<g:render template="../lc/ets/ua_loan_maturity_adjustment/foreign/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
										<g:render template="../lc/ets/ua_loan_maturity_adjustment/domestic/basic_details_tab" />
									</g:if>
								</g:if>
							</form>
						</div>


						<%-- ATTACHED DOCUMENTS TAB --%>
	 						<div id="attached_documents_tab">
	 							<%-- <form id="attachedDocumentsTabForm" > --%>
		  							<g:render template="../commons/tabs/attached_documents_tab" />
		  						<%-- </form> --%>
		  					</div>

						<%-- NATURE OF Amendment TAB (Amendment ONLY)--%>
						<g:if test="${ serviceType?.equalsIgnoreCase('Amendment') }">
			  				<div id="nature_of_amendment_tab">
			  					<form id="natureOfAmendmentTabForm">
			  						<g:render template="../commons/tabs/nature_amendments_tab" />
								</form>
			   				</div>
		   				</g:if>
		   				
		   				<%-- PROCEEDS FOR BENEFICIARY TAB (DOMESTIC UA Loan Settlement AND Negotiation ONLY--%>
						<%-- <g:if test="${ (serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('DOMESTIC')) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC')) }"> --%>
						<%-- <g:if test="${ (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC')) }"> --%>
						%{--<g:if test="${ (((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT')) && documentType?.equalsIgnoreCase('DOMESTIC'))) }">--}%

						%{--start - this is a bug fix. please do not comment this--}%
						<g:if test="${(((serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) || (serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT'))) && documentType?.equalsIgnoreCase('DOMESTIC'))}">
						%{--end - this is a bug fix. please do not comment this--}%

							<div id="proceeds_tab">
								<form id="proceedsDetailsTabForm">
									<g:render template="../commons/tabs/proceeds_details_tab" />
								</form>
							</div> 
						</g:if>

		   				<%-- CHARGES TAB --%>
						<%-- Kinomment para makatuloy sa Saving -- May Textfield Error pa dito --%>
<%--		   			  	<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) || ((documentType?.equalsIgnoreCase('FOREIGN') && serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR') || serviceType?.equalsIgnoreCase('NEGOTIATION')) || (documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT')))}">--%>
		   			  	<g:if test="${ (!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                     !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                     !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                     !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
							<%-- remove tab when viewed thru view approved ets link --%>
			   				<g:if test="${!windowed?.equalsIgnoreCase('true')}">
		 						<div id="charges_tab" class="charges_tab">
		 							<form id="chargesTabForm">
			  							<g:render template="../commons/tabs/charges_tab" />
									</form>
								</div>
							</g:if>
						</g:if>						
						

						<%-- CHARGES PAYMENT TAB --%>
<%--						<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) || ((documentType?.equalsIgnoreCase('FOREIGN') && serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR') || serviceType?.equalsIgnoreCase('NEGOTIATION')) || (documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('NEGOTIATION') && documentSubType2?.equalsIgnoreCase('SIGHT'))) }">--%>
						<g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
                                !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
                                !(documentType?.equalsIgnoreCase('DOMESTIC') && serviceType?.equalsIgnoreCase('Adjustment')) &&
                                !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
							<%-- remove tab when viewed thru view approved ets link --%>
			   				<g:if test="${!windowed?.equalsIgnoreCase('true')}">
								<div id="charges_payment_tab" class="charges_payment_tab">
					  				<form id="chargesPaymentTabForm">
							  			<g:render template="../commons/tabs/charges_payment_tab" />
							  		</form>
							  	</div>
							</g:if>
					  	</g:if>

	    				<%-- CASH LC PAYMENT --%>
    					<%-- <g:if test="${ ( documentSubType1?.equalsIgnoreCase('CASH') && ( serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment') )) || (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR')) || serviceType?.equalsIgnoreCase('Negotiation') || serviceType?.equalsIgnoreCase('UA Loan Settlement')}"> --%>
    					<g:if test="${ ( documentSubType1?.equalsIgnoreCase('CASH') && ( serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment') )) || (serviceType?.equalsIgnoreCase('Adjustment') && documentSubType1?.equalsIgnoreCase('REGULAR') && partialCashSettlementFlag?.equalsIgnoreCase("partialCashSettlementEnabled")) || serviceType?.equalsIgnoreCase('Negotiation') || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase("UA_LOAN_SETTLEMENT"))}">
    						<%-- remove tab when viewed thru view approved ets link --%>
			   				<g:if test="${!windowed?.equalsIgnoreCase('true')}">
	    						<div id="cash_lc_payment_tab">
									<form id="cashLcPaymentTabForm">
				  						<g:render template="../commons/tabs/cash_lc_payment_tab" />
			    					</form>
								</div>
							</g:if>
    					</g:if>
    					
    					<%-- For ua loan Settlement and Negotiation --%>
						<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT'))}">
	                        <div id="loan_details_tab" >
	                            <form id="loanDetailsTabForm"  >
	                                    <g:render template="../commons/tabs/loan_details_tab"/>
	                            </form>
	                        </div>
						</g:if>
						
		   				<%-- INSTRUCIONS AND ROUTING TAB --%>
	  					<div id="instructions_routing_tab">
	  						<form id="instructionsAndRoutingTabForm">
	  							<g:render template="../commons/tabs/instructions_and_routing_tab" />
	  						</form>
	  					</div>
	  					
					</div>
	  			</div>
	 	 	</div>
		</div>


      <g:render template="../layouts/confirm_alert"/>
      <g:render template="../layouts/confirm_alert_cancel"/>
      <g:render template="../layouts/alert_confirmation" model="${[popupId:'popup_cancel_basic_details',popupTitle:'Save Basic Details',
		  popupMessage:'Do you want to save your changes?<br/>'+ 
    	'If Yes, save data then redirect to Unacted<br/>'+
    	'If No, resets data then redirect to Unacted<br/>'+
    	'If Close, disregard this popup' ,includeCancel:true,yesBtnId:'yesBtnBD',noBtnId:'noBtnBD',cancelBtnId:'cancelBtnBD'] }"/>
      <g:render template="../layouts/alert"/>
      <g:render template="../commons/popups/cif_search_popup"/>

      <g:render template="../commons/popups/create_transaction_popup"/>
      <g:render template="../commons/popups/create_ua_popup"/>
      <g:render template="../commons/popups/create_ets_popup"/>
      <g:render template="../commons/popups/create_non_lc_popup"/>
      <g:if test="${!serviceType?.equalsIgnoreCase('CANCELLATION')}">
      <g:render template="../commons/popups/mode_of_payment_charges_popup"/>
      </g:if>
      <g:render template="/commons/popups/loan_details_popup"/>
      <g:render template="/commons/popups/facility_id_popup"/>

      <g:render template="../product/commons/popups/create_export_bills_transaction" />
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

      <g:if test="${!session['userrole']['id'].equals("BRM")}"></g:if>

      <g:if test="${(!serviceType?.equalsIgnoreCase('Cancellation')) &&
              !('DOMESTIC'.equalsIgnoreCase(documentType) && 'REGULAR'.equalsIgnoreCase(documentSubType1) && 'USANCE'.equalsIgnoreCase(documentSubType2) && 'NEGOTIATION'.equalsIgnoreCase(serviceType)) &&
              !((documentType?.equalsIgnoreCase('DOMESTIC') || !(documentType?.equalsIgnoreCase('FORIEGN') && !(documentSubType1?.equalsIgnoreCase('REGULAR') && documentSubType2?.equalsIgnoreCase('SIGHT')))) && serviceType?.equalsIgnoreCase('Adjustment')) &&
              !("NO_PAYMENT_REQUIRED".equalsIgnoreCase(paymentStatus) && "DOMESTIC".equalsIgnoreCase(documentType) && "LC".equalsIgnoreCase(documentClass) && "CASH".equalsIgnoreCase(documentSubType1) && "NEGOTIATION".equalsIgnoreCase(serviceType))}">
          <%-- 
          remove script when viewed thru view approved ets link, 
          because the function it calls is in charges tab which is also
          hidden when viewed thru view approved ets link.
          --%>
		  <g:if test="${!windowed?.equalsIgnoreCase('true')}">
	          <script type="text/javascript">
	              $(document).ready(function () {
	                  checkForOtherCurrency();
	                  var timeoutID = window.setTimeout(updateTotals, 1000);
	              });
	          </script>
          </g:if>
      </g:if>
	</body>
</html>