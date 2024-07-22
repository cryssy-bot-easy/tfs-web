<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Created by: Rafael Ski Poblete
	 Date: 08/28/18 
	 Description: Added new JS and GSP to be use in the module.-->

<%-- 
(revision)
[Revised by:] Cedrick C. Nungay
[Date deployed:] 08/09/2018
Program [Revision] Details: Added input instructions js and modified tabs for MT707.
Member Type: Groovy Server Pages (GSP)
Project: WEB
Project Name: _narrative_tab.gsp
--%>

<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System - ${title} </title>
		<meta name="layout" content="main" />
        <g:javascript src="utilities/commons/ets_index_utility.js" />
		<g:javascript src="utilities/dataentry/initialize_forms.js" />
		<g:javascript src="popups/alert_utility.js" />
		<g:javascript src="popups/add_condition1_popup.js" />
		<g:javascript src="popups/required_documents1.js" />
	<%--<g:javascript src="popups/mode_of_payment_charges_popup.js" />--%>
		<g:javascript src="popups/period_for_presentation_popup2.js" />
		
		<g:javascript src="popups/bank_address_popup.js" />
        <g:if test="${serviceType?.equalsIgnoreCase("NEGOTIATION")}">
            <g:javascript src="utilities/businessrules/lc/dataentry/negotiation/negotiation_dataentry_businessrules.js" />
        </g:if>
        <g:javascript src="popups/cif_normal_search_popup.js"/>
        <g:javascript src="utilities/commons/textarea_utility.js" />
        %{--this is for the required documents--}%
        <g:javascript src="popups/required_docs_popup.js" />
        %{--this is for the additional conditions--}%
        <g:javascript src="popups/additional_condition_popup.js" />
        <g:javascript src="popups/input_instructions_popup.js" />
		<script type="text/javascript">
		  // for negotiation
            var loanCount = '${loanCount}';
			var serviceType = '${serviceType}';

			// for wiring purpose
            var referenceType = '${referenceType}';
			documentType = '${documentType}';
            documentClass = '${documentClass}';
			documentSubType1 = '${documentSubType1}';
			documentSubType2 = '${documentSubType2}';
			var tradeServiceIdHolder = '${tradeServiceId}';
            var loggedInUser='${session['group']}'; //TSD,BRANCHM
            var userRole='${session.userrole.id}'; //TSDM,BRM
            var docStatus='${status}';
            var _viewMode = '${viewMode}';
            var hasRoute='${hasRoute}';
            if("TSDM" != '${session['userrole']['id']}' && "BRANCH" != '${session['group']}' && _viewMode != 'viewMode'){
                	hasRoute='true';
            }
			var tsdInitiated = '${tsdInitiated}';
			
			var formId = "#basicDetailsTabForm";

			var gotoUrl;
			var saveUrl;
			var uploadDocumentUrl;
			var updateUrl;
			var deleteDocumentUrl;
			var updateStatusUrl;
			var addRemarksUrl;

			var computeTotalUrl;
			var computeBalanceUrl;

			//Auto Complete
            var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
            var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
            var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
            var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
			
			// for popups
			var recomputeUrl;

			var unactedTransactionsUrl = '${g.createLink(controller:'unactedTransactions', action:'viewUnacted')}';
            var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
            var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
            var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
            var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
            var attachedDocumentsUrl = '${g.createLink(controller:'lcDataEntryOpening', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
            var downloadDocumentUrl = '${g.createLink(controller:'lcDataEntryOpening', action:'downloadFile')}';


			// initialize urls
			if(serviceType.toLowerCase() == "opening") {
				gotoUrl = '${g.createLink(controller:'lcDataEntryOpening', action:'viewOpeningDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryOpening', action:'updateOpeningDataEntry')}';
				updateStatusUrl = '${g.createLink(controller:'lcDataEntryOpening', action:'updateDataEntryStatus')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryOpening', action:'deleteDocument')}';
			} else if(serviceType.toLowerCase() == "adjustment") {
				gotoUrl = '${g.createLink(controller:'lcDataEntryAdjustment', action:'viewAdjustmentDataEntry')}';
                saveUrl = '${g.createLink(controller:'lcDataEntryAdjustment', action:'saveAdjustmentDataEntry')}';
                updateUrl = '${g.createLink(controller:'lcDataEntryAdjustment', action:'updateAdjustmentDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryAdjustment', action:'updateDataEntryStatus')}';
                deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryAdjustment', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == "ua loan maturity adjustment" || serviceType.toLowerCase() == "ua_loan_maturity_adjustment") {
				gotoUrl = '${g.createLink(controller:'lcDataEntryUaLoanMaturityAdjustment', action:'viewMaturityAdjustmentDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryUaLoanMaturityAdjustment', action:'updateDataEntryStatus')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryUaLoanMaturityAdjustment', action:'updateMaturityAdjustmentDataEntry')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryUaLoanMaturityAdjustment', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == "ua loan settlement" || serviceType.toLowerCase() == "ua_loan_settlement") {
				gotoUrl = '${g.createLink(controller:'lcDataEntryUaLoanSettlement', action:'viewSettlementDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryUaLoanSettlement', action:'updateDataEntryStatus')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryUaLoanSettlement', action:'updateSettlementDataEntry')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryUaLoanSettlement', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == "amendment") {
				gotoUrl = '${g.createLink(controller:'lcDataEntryAmendment', action:'viewAmendmentDataEntry')}';
                saveUrl = '${g.createLink(controller:'lcDataEntryAmendment', action:'saveAmendmentDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryAmendment', action:'updateAmendmentDataEntry')}';
				updateStatusUrl = '${g.createLink(controller:'lcDataEntryAmendment', action:'updateDataEntryStatus')}';
				deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryAmendment', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == 'cancellation'){
			        if(documentClass.toLowerCase() == "lc"){
				        gotoUrl = '${g.createLink(controller:'lcDataEntryCancellation', action:'viewCancellationDataEntry')}';
				        updateUrl = '${g.createLink(controller:'lcDataEntryCancellation', action:'updateCancellationDataEntry')}';
				        updateStatusUrl = '${g.createLink(controller:'lcDataEntryCancellation', action:'updateDataEntryStatus')}';
				        uploadDocumentUrl = '${g.createLink(controller:'lcDataEntryCancellation', action:'uploadDocument')}';
						deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryCancellation', action:'deleteDocument')}';						
                    } else if(documentClass.toLowerCase() == "indemnity") {
                        gotoUrl = '${g.createLink(controller: "lcDataEntryIndemnityCancellation", action: "viewIndemnityCancellationDataEntry")}';
                        saveUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'saveIndemnityCancellationDataEntry')}';
                        updateUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'updateIndemnityCancellationDataEntry')}';
                        updateStatusUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'updateDataEntryStatus')}';
                    }			
			}else if(serviceType.toLowerCase() == "issuance" && documentClass.toLowerCase() == "indemnity"){
				gotoUrl = '${g.createLink(controller:'lcDataEntryIndemnityIssuance', action:'viewIndemnityIssuanceDataEntry')}';
				saveUrl = '${g.createLink(controller:'lcDataEntryIndemnityIssuance', action:'saveIndemnityIssuanceDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryIndemnityIssuance', action:'updateIndemnityIssuanceDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryIndemnityIssuance', action:'updateDataEntryStatus')}';
                deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryIndemnityIssuance', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == 'negotiation'){
				gotoUrl = '${g.createLink(controller:'lcDataEntryNegotiation', action:'viewNegotiationDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryNegotiation', action:'updateNegotiationDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryNegotiation', action:'updateDataEntryStatus')}';
                deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryNegotiation', action:'deleteDocument')}';
			}else if(serviceType.toLowerCase() == 'indemnity cancellation'){
				gotoUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'viewIndemnityCancellationDataEntry')}';
				saveUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'saveIndemnityCancellationDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'updateIndemnityCancellationDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'updateDataEntryStatus')}';
                deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryIndemnityCancellation', action:'deleteDocument')}';
			}else if((serviceType.toLowerCase() == 'negotiation discrepancy') || (serviceType.toLowerCase() == 'negotiation_discrepancy')){
				gotoUrl = '${g.createLink(controller:'lcDataEntryNegotiationDiscrepancy', action:'viewNegotiationDiscrepancyDataEntry')}';
				saveUrl = '${g.createLink(controller:'lcDataEntryNegotiationDiscrepancy', action:'saveNegotiationDiscrepancyDataEntry')}';
				updateUrl = '${g.createLink(controller:'lcDataEntryNegotiationDiscrepancy', action:'updateNegotiationDiscrepancyDataEntry')}';
                updateStatusUrl = '${g.createLink(controller:'lcDataEntryNegotiationDiscrepancy', action:'updateDataEntryStatus')}';
                deleteDocumentUrl  = '${g.createLink(controller:'lcDataEntryNegotiationDiscrepancy', action:'deleteDocument')}';
			}

		</script>

		%{--<g:if test="${serviceType?.equalsIgnoreCase('Opening') || (serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) }">--}%
			%{--<g:javascript src="utilities/temp_validation_js/validation_js.js"/>--}%
		%{--</g:if>--}%

        <g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && (documentClass?.equalsIgnoreCase('LC') && documentSubType1?.equalsIgnoreCase('CASH') &&  documentType?.equalsIgnoreCase('DOMESTIC')) }">
            <g:javascript src="utilities/temp_validation_js/validation_cash_nego_enough_.js"/>
        </g:if>

		
	</head>

	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">

				<g:render template="../layouts/header"/>

				<g:render template="../layouts/accordion"/>

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
						  <td> <span class="field_label"> CIF Number </span> </td>
						  <td> <g:textField name="cifNumber" class="input_field numericString" readonly="readonly" value="${cifNumber}" /> </td>
						</tr>
						<tr>
						  <td> <span class="field_label"> CIF Name </span> </td>
						  <td> <g:textField name="cifName" class="input_field" readonly="readonly" value="${cifName}" /> </td>
						</tr>
						<tr>
						  <td> <span class="field_label"> Account Officer </span> </td>
						  <td> <g:textField name="accountOfficer" class="input_field" readonly="readonly" value="${accountOfficer}" /> </td>
						</tr>
						<tr>
						  <td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
						  <td> <g:textField name="ccbdBranchUnitCode" class="input_field" readonly="readonly" value="${ccbdBranchUnitCode}" /> </td>
						  <g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
						</tr>
					</table>
					<br />
                    <div class="note">
                    	<g:hiddenField name="reinstateFlag" value="${reinstateFlag}" />
                        <g:if test="${(reinstateFlag.equals('Y'))}">
                             <span class="note_inside"> NOTE: LC expired on ${expiryDate}. </span> 
                        </g:if>
                        <g:elseif test="${serviceType != 'Opening' && remainingDays && remainingDays <= 7 && remainingDays > 0}">
                            <span class="note_inside"> NOTE: LC will expire in ${remainingDays} ${remainingDays == 1 ? 'day' : 'days'}. </span>
                        </g:elseif>
                        <g:if test="${isOverAvailed && ('true'.equals(isOverAvailed) || !'false'.equals(isOverAvailed)) && !viewMode}">
                            <div class="note_inside"> NOTE: ${overAvailment}</div>
                        </g:if>
                    </div>
                    <g:hiddenField name="tradeServiceId" value="${tradeServiceId}" />
                    <g:hiddenField name="remainingDays" value="${remainingDays}" />
				</div>
				<div id="tab_container">
				    <ul id="tabs">
			    		<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic <br /> Details </span></a></li>

						<g:if test="${(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) && documentType?.equalsIgnoreCase('FOREIGN') && 'MT202' == generateMt}">
							<li class="mt202Tab_data_entry"><a href="#details_for_mt202_tab" id="detailsForMT202Tab"><span class="tab_titles">Details<br/>for MT202</span></a></li>
			    		</g:if>

			    		<g:if test="${serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('Negotiation_Discrepancy')}">
			    			<li class="discrepancyTab_data_entry"><a href="#discrepancy_tab" id="discrepancyTab"><span class="tab_titles"> Discrepancy <br/> &#160; </span></a></li>
			    		</g:if>

						<g:if test="${!(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
			    			<li class="attachedDocumentsTab_data_entry"><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached<br />Documents </span></a></li>
						</g:if>

			    		<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('FOREIGN') && 'MT202' == generateMt}">
			    			<li class="mt752202Tab_data_entry"><a href="#mt_202_tab" id="mt202Tab" ><span class="tab_titles">MT 202<br/> &#160;</span></a></li>
						</g:if>

			    		<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('FOREIGN') && 'MT752' == generateMt}">
			    			<li class="mt752202Tab_data_entry"><a href="#mt_752_tab" id="mt752Tab" ><span class="tab_titles">MT 752<br/> &#160;</span></a></li>
						</g:if>

	
<%--							<g:if test="${showLoanDetailstab && (serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC'))}">--%>
<%--								<li class="loanDetailsTab_data_entry"><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li>--%>
<%--				    			<li><a href="#loan_details_tab" id="loanDetailsTab"><span class="tab_titles">Loan Details<br>&#160;</span></a></li>--%>
<%--				    		</g:if>--%>

						%{--<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">--}%
							%{--<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Cash')) || (serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Standby'))  || (serviceType?.equalsIgnoreCase('Negotiation')  && documentSubType2 == 'Sight') || serviceType?.equalsIgnoreCase('UA Loan Settlement')}">--}%
								%{--<%-- <li class="settlementToBenificiaryTab_data_entry"><a href="#settle_to_beneficiary_tab" id="proceedsDetailsTab"><span class="tab_titles"> Settlement<br/>to Beneficiary</span></a></li> --%>--}%
								%{--<li class="settlementToBenificiaryTab_data_entry"><a href="#settle_to_beneficiary_tab" id="settlementToBenificiaryTab"><span class="tab_titles"> Settlement<br/>to Beneficiary</span></a></li>--}%
								%{--<li class="mt103Tab_data_entry"><a href="#mt103_tab" id="mt103Tab"><span class="tab_titles"> MT103<br>&#160;</span></a></li>--}%
								%{--<g:if test="${!((serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Cash')) || (serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Standby')))}">--}%
									%{--<li class="pddtsTab_data_entry"><a href="#pddts_tab" id="pddtsTab"><span class="tab_titles"> PDDTS<br>&#160;</span></a></li>--}%
								%{--</g:if>--}%
							%{--</g:if>--}%
						%{--</g:if>--}%
						
						<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">
		    				<li class="narrativeTab_data_entry">
		    					<a href="#narrative_tab" id="narrativeTab">
		    						<span class="tab_titles">
			    						<g:if test="${documentSubType1?.equalsIgnoreCase('Standby')}">
			    							Amendment<br/>Details
										</g:if>
										<g:else>
											Narrative<br/>&#160; 
										</g:else>
									</span>
								</a>
							</li>
		    			</g:if>
						
						<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
							<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">
								<li class="additionalDetailsTab_data_entry"><a href="#additional_details_tab" id="additionalDetailsTab"><span class="tab_titles"> Additional <br /> Details </span></a></li>
			    			</g:if>
			    		</g:if>

			    		<g:if test="${serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')}">
			    			<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			    				<%-- <li class="importerExporterDetailsTab_data_entry"><a href="#ie_details_tab" id="importerExporterDetailsTab"><span class="tab_titles"> Importer/Exporter <br /> Details </span></a></li> --%>
			    			</g:if>
			    		</g:if>

						<g:if test="${(serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')) && !documentSubType1?.equalsIgnoreCase('STANDBY')}">
							<li class="shipmentOfGoodsTab_data_entry"><a href="#shipment_goods_tab" id="shipmentOfGoodsTab"><span class="tab_titles"> Shipments <br /> Details</span></a></li>
						</g:if>

			    		<g:if test="${serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')}">
			    			<g:if test="${((documentType?.equalsIgnoreCase('FOREIGN') && serviceType?.equalsIgnoreCase('Amendment')) || serviceType?.equalsIgnoreCase('Opening')) && documentSubType1?.equalsIgnoreCase('STANDBY')}">
			    				<li class="detailsOfGuaranteeTab_data_entry"><a href="#details_of_gurantee_tab" id="detailsOfGuaranteeTab"><span class="tab_titles"> Details <br /> of Guarantee </span></a></li>
			    			</g:if>
			    		</g:if>

						<g:if test="${serviceType?.equalsIgnoreCase('Opening') || (serviceType?.equalsIgnoreCase('Amendment') && !documentType?.equalsIgnoreCase('FOREIGN'))}">
			    			<g:if test="${!(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
				    			<li class="documentsRequiredTab_data_entry">
				    				<a href="#documents_required_tab" id="documentsRequiredTab">
				    					<span class="tab_titles">
				    						<g:if test="${serviceType?.equalsIgnoreCase('Opening')}">
				    							Required Documents / <br /> Special Instructions
				    						</g:if>
				    						<g:else>
				    							Required <br /> Documents
				    						</g:else>
				    					</span>
				    				</a>
				    			</li>
			    			</g:if>
			    		</g:if>

						<g:if test="${serviceType?.equalsIgnoreCase('Amendment') && documentType?.equalsIgnoreCase('FOREIGN') && !(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
			    			<li class="documentsRequiredTab_data_entry">
			    				<a href="#documents_required_tab" id="documentsRequiredTab">
			    					<span class="tab_titles">
			    						<g:if test="${serviceType?.equalsIgnoreCase('Opening')}">
			    							Required Documents / <br /> Special Instructions
			    						</g:if>
			    						<g:else>
			    							Required <br /> Documents
			    						</g:else>
			    					</span>
			    				</a>
			    			</li>
			    		</g:if>
			    		
						<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			    			<g:if test="${!(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
			    				<g:if test="${serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')}">
						    		<li class="additionalCondition1Tab_data_entry"><a href="#additional_conditions_1_tab" id="additionalCondition1Tab"><span class="tab_titles"> Additional <br /> Conditions </span></a></li>
							    	<li class="additionalCondition2Tab_data_entry"><a href="#additional_conditions_2_tab" id="additionalCondition2Tab"><span class="tab_titles"> Reimbursement <br /> Details </span></a></li>
			    				</g:if>
			    			</g:if>
			    		</g:if> 

						<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && !(documentType?.equalsIgnoreCase('Domestic') && documentSubType1?.equalsIgnoreCase('Cash'))}">
			    			<li class="detailsTransmittalLetterTab_data_entry"><a href="#details_transmittal_letter_tab" id="detailsTransmittalLetterTab"><span class="tab_titles">Details for <br> Transmittal Letter</span></a></li>
			    		</g:if>
						
			    		<li><a href="#instructions_and_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions<br />and Routing </span></a></li>
						
				    </ul>

                <div id="basic_details_tab">
				    <form id="basicDetailsTabForm">
							<g:if test="${serviceType?.equalsIgnoreCase('Opening')}">
								<%-- FOREIGN --%>
								<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && !(documentSubType1?.equalsIgnoreCase('STANDBY')) }">
									<g:render template="../lc/dataentry/opening/foreign/basic_details_tab"/>
								</g:if>

				         		<%-- if fxlc standby --%>
				         		<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY') }">
				         			<g:render template="../lc/dataentry/opening/foreign/standby/basic_details_tab" />
								</g:if>

			  					<%-- DOMESTIC --%>
			  					<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && !(documentSubType1?.equalsIgnoreCase('STANDBY')) }">
				         			<g:render template="../lc/dataentry/opening/domestic/basic_details_tab" />
				         		 </g:if>


				         		<%-- if dmlc standby --%>
				         		<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('STANDBY') }">
				         			<g:render template="../lc/dataentry/opening/domestic/standby/basic_details_tab" />
				         		</g:if>
				         	</g:if>

							<%--FOR ADJUSTMENT--%>

							<g:if test="${serviceType?.equalsIgnoreCase('Adjustment')}">
								<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
				  					<g:render template="../lc/dataentry/adjustment/foreign/basic_details_tab"/>
				         		</g:if>
				         		<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
				  					<g:render template="../lc/dataentry/adjustment/domestic/basic_details_tab"/>
				         		</g:if>
				         	</g:if>

					         <%--for UA LOAN MATURITY ADJUSTMENT --%>
					         <g:if test="${serviceType?.equalsIgnoreCase('UA Loan Maturity Adjustment') || serviceType?.equalsIgnoreCase('UA_LOAN_MATURITY_ADJUSTMENT')}">
					         	<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
							  		<g:render template="../lc/dataentry/ua_loan_maturity_adjustment/foreign/basic_details_tab" />
								</g:if>
								<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
									<g:render template="../lc/dataentry/ua_loan_maturity_adjustment/domestic/basic_details_tab" />
								</g:if>
							</g:if>

								<%--for UA LOAN SETTLEMENT --%>
							<g:if test="${serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')}">
								<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
							  		<g:render template="../lc/dataentry/ua_loan_settlement/foreign/basic_details_tab" />
								</g:if>
								<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
									<g:render template="../lc/dataentry/ua_loan_settlement/domestic/basic_details_tab" />
								</g:if>
							</g:if>

							<%--for foreign AMENDMENT --%>
							<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">

						  			<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('CASH')}">
						  				<g:render template="../lc/dataentry/amendment/foreign/cash/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('REGULAR')}">
							  			<g:render template="../lc/dataentry/amendment/foreign/regular/basic_details_tab" />
									</g:if>
									<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
							  			<g:render template="../lc/dataentry/amendment/foreign/standby/basic_details_tab" />
									</g:if>

							<%--for stic Amendment --%>
								<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
									<g:render template="../lc/dataentry/amendment/domestic/basic_details_tab" />
								</g:if>
							</g:if>

							<%--Cancellation --%>
							<g:if test="${serviceType?.equalsIgnoreCase('Cancellation')}">
							  <g:if test="${documentClass?.equalsIgnoreCase("LC")}">
			         			      <g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			         				  <g:render template="../lc/dataentry/cancellation/foreign/basic_details_tab"/>
			         			      </g:if>
			         		  	      <g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
			         			          <g:render template="../lc/dataentry/cancellation/domestic/basic_details_tab"/>
			         			      </g:if>
			         		          </g:if>
			         		          
			         		          <g:if test="${documentClass?.equalsIgnoreCase("INDEMNITY")}">
                                                            <g:render template="../lc/dataentry/indemnity_cancellation/basic_details_tab"/>
                                                          </g:if>
			         		        </g:if>

			         		<%--INDEMNITY Issuance --%>
			         		<g:if test="${(serviceType?.equalsIgnoreCase('Issuance') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
			         			<g:render template="../lc/dataentry/indemnity_issuance/basic_details_tab"/>
			         		</g:if>

			         		<%--Negotiation --%>
			         		<g:if test="${serviceType?.equalsIgnoreCase('Negotiation')}">
			         			<g:if test="${documentType?.equalsIgnoreCase('FOREIGN') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
			         				<g:render template="../lc/dataentry/negotiation/foreign/basic_details_tab"/>
			         			</g:if>
			         			<g:elseif test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			         			    <g:render template="../lc/dataentry/negotiation/foreign/nonStandby/basic_details_tab"/> 
                                </g:elseif>
			         			<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC') && documentSubType1?.equalsIgnoreCase('STANDBY')}">
			         				<g:render template="../lc/dataentry/negotiation/domestic/basic_details_tab"/>
			         			</g:elseif>
			         			<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
                                    <g:render template="../lc/dataentry/negotiation/domestic/nonStandby/basic_details_tab"/> 
                                </g:elseif>
			         		</g:if>

			         		<%--Negotiation Discrepancy --%>
			         		<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('NEGOTIATION_DISCREPANCY'))}">
			         			<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">
			         				<g:render template="../lc/dataentry/negotiation_discrepancy/foreign/basic_details_tab"/>
			         			</g:if>
			         			<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
			         				<g:render template="../lc/dataentry/negotiation_discrepancy/domestic/basic_details_tab"/>
			         			</g:if>
			         		</g:if>

					</form>
                </div>

					<%-- Applied to all except fxlc amendment standby --%>
					<g:if test="${!(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase('INDEMNITY'))}">
                		<div id="attached_documents_tab" >
							<g:render template="/commons/tabs/attached_documents_tab"/>
                		</div>
					</g:if>

					<g:if test="${(serviceType?.equalsIgnoreCase('UA Loan Settlement') || serviceType?.equalsIgnoreCase('UA_LOAN_SETTLEMENT')) && documentType?.equalsIgnoreCase('FOREIGN') && 'MT202' == generateMt}">
                        <div id="details_for_mt202_tab" >
                            <form id="detailsForMT202TabForm"  >
                                    <g:render template="../commons/tabs/mt_202_tab"/>
                            </form>
                        </div>
					</g:if>

					<g:if test="${serviceType?.equalsIgnoreCase('Negotiation Discrepancy') || serviceType?.equalsIgnoreCase('Negotiation_Discrepancy')}">
                        <div id="discrepancy_tab" >
                            <form id="discrepancyTabForm"  >
                                    <g:render template="../commons/tabs/discrepancy_tab" />
                            </form>
                        </div>
					</g:if>

<%--					For ua loan Settlement and Negotiation --%>
<%--					<g:if test="${showLoanDetailstab && (serviceType?.equalsIgnoreCase('Negotiation') && ((!documentSubType1?.equalsIgnoreCase('CASH') && documentType?.equalsIgnoreCase('DOMESTIC')) || documentType?.equalsIgnoreCase('FOREIGN'))) || (serviceType?.equalsIgnoreCase('UA Loan Settlement') && documentType?.equalsIgnoreCase('DOMESTIC'))}">--%>
<%--                        <div id="loan_details_tab" >--%>
<%--                            <form id="loanDetailsTabForm"  >--%>
<%--                                    <g:render template="../commons/tabs/loan_details_tab"/>--%>
<%--                            </form>--%>
<%--                        </div>--%>
<%--					</g:if>--%>

					<%--For Negotiation --%>
						<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('FOREIGN') && 'MT202' == generateMt}">
                            <div id="mt_202_tab" >
                                <form id="mt202TabForm">
                                        <g:render template="../commons/tabs/mt_202_tab" />
                                </form>
                            </div>
						</g:if>

						<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && documentType?.equalsIgnoreCase('FOREIGN') && 'MT752' == generateMt}">
                            <div id="mt_752_tab" >
                                <form id="mt752TabForm"  >
                                        <g:render template="../commons/tabs/mt_752_tab" />
                                </form>
                            </div>
						</g:if>

						<%-- for ua loan settlement and negotiation--%>
						%{--<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">--}%
							%{--<g:if test="${(serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Cash')) || (serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Standby'))  || (serviceType?.equalsIgnoreCase('Negotiation')  && documentSubType2 == 'Sight') || serviceType?.equalsIgnoreCase('UA Loan Settlement')}">--}%
                                %{--<div id="settle_to_beneficiary_tab" >                                    --}%
                                    %{--<%-- <form id="proceedsDetailsTabForm"  > --%>--}%
                                    %{--<form id="settlementToBeneficiaryTabForm"  >--}%
                                            %{--<g:render template="../commons/tabs/proceeds_details_tab" />--}%
                                    %{--</form>--}%
                                %{--</div>--}%

                                %{--<div id="mt103_tab" >--}%
                                    %{--<form id="mt103TabForm"  >--}%
                                            %{--<g:render template="../commons/tabs/mt_103_tab"/>--}%
                                    %{--</form>--}%
                                %{--</div>--}%

                             %{--<g:if test="${!((serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Cash')) || (serviceType?.equalsIgnoreCase('Negotiation') && documentSubType1?.equalsIgnoreCase('Standby')))}">--}%
                                	%{--<div id="pddts_tab" >--}%
                                    	%{--<form id="pddtsTabForm"  >--}%
                                            %{--<g:render template="../commons/tabs/pddts_tab"/>--}%
                                    	%{--</form>--}%
                                	%{--</div>--}%
                                %{--</g:if>--}%
							%{--</g:if>--}%
						%{--</g:if>--}%


						<g:if test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
							<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">
                                <div id="additional_details_tab" >
                                    <form id="additionalDetailsTabForm"  >
                                    <%-- ADDITIONAL DETAILS --%>
                                            <g:render template="../commons/tabs/additional_details_tab"/>
                                    </form>
                                </div>
							</g:if>
						</g:if>

						<%-- For Foreign Opening and Amendment --%>
						<%--
						<g:if test="${(serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')) && (documentType?.equalsIgnoreCase('FOREIGN'))}">
                            <div id="ie_details_tab" >
								<form id="importerExporterDetailsTabForm"  >
										<g:render template="../commons/tabs/ie_details_tab" />
								</form>
                            </div>
						</g:if>
						--%>
						<g:if test="${serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')}">
			    			<g:if test="${((documentType?.equalsIgnoreCase('FOREIGN') && serviceType?.equalsIgnoreCase('Amendment')) || serviceType?.equalsIgnoreCase('Opening')) && documentSubType1?.equalsIgnoreCase('STANDBY')}">
                                <div id="details_of_gurantee_tab" >
                                    <form id="detailsOfGuaranteeTabForm"  >
                                            <g:render template="../commons/tabs/details_guarantee_tab" />
                                    </form>
                                </div>
							</g:if>
						</g:if>

						<g:if test="${(serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')) && !documentSubType1?.equalsIgnoreCase('STANDBY')}">
                            <div id="shipment_goods_tab" >
                                <form id="shipmentOfGoodsTabForm"  >
                                        <g:render template="../commons/tabs/shipments_goods_tab"/>
                                </form>
                            </div>
                        </g:if>


						<g:if test="${serviceType?.equalsIgnoreCase('Opening') || (serviceType?.equalsIgnoreCase('Amendment') && !documentType?.equalsIgnoreCase('FOREIGN'))}">
							<g:if test="${!(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
                                <div id="documents_required_tab" >
                                    <form id="documentsRequiredTabForm"  >
                                            <g:render template="../commons/tabs/doc_required_tab"/>
                                    </form>
                                </div>
							</g:if>
						</g:if>

						<g:if test="${serviceType?.equalsIgnoreCase('Amendment') && documentType?.equalsIgnoreCase('FOREIGN') && !(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
                            <div id="documents_required_tab" >
                                <form id="documentsRequiredTabForm"  >
                                    <g:render template="../angular/mt707/doc_required_tab"/>
                                </form>
                            </div>
						</g:if>
						<g:if test="${(documentType?.equalsIgnoreCase('FOREIGN')) && !(documentSubType1?.equalsIgnoreCase('STANDBY'))}">
			    				<g:if test="${serviceType?.equalsIgnoreCase('Opening')}">
                                    <div id="additional_conditions_1_tab" >
                                        <form id="additionalCondition1TabForm"  >
                                                <g:render template="../commons/tabs/additional_conditions1_tab"/>
                                        </form>
                                    </div>
								</g:if>
			    				<g:elseif test="${serviceType?.equalsIgnoreCase('Amendment')}">
                                    <div id="additional_conditions_1_tab" >
                                        <form id="additionalCondition1TabForm"  >
                                                <g:render template="../angular/mt707/additional_conditions1_tab"/>
                                        </form>
                                    </div>
								</g:elseif>
			    				<g:if test="${serviceType?.equalsIgnoreCase('Opening') || serviceType?.equalsIgnoreCase('Amendment')}">

                                    <div id="additional_conditions_2_tab" >
                                        <form id="additionalCondition2TabForm"  >
                                                <g:render template="../commons/tabs/additional_conditions2_tab"/>
                                        </form>
                                    </div>
								</g:if>
						</g:if>


					<%--for Amendment only--%>
		    		<g:if test="${serviceType?.equalsIgnoreCase('Amendment')}">
						<div id="narrative_tab" >
							<form id="narrativeTabForm"  >
								<g:render template="../commons/tabs/narrative_tab"/>
							</form>
						</div>
					</g:if>



				<%--For UA LOAN MATURITY ADJUSTMENT and cancellation --%>
<%--					<g:if test="${documentType?.equalsIgnoreCase('FOREIGN')}">--%>
<%--							<g:if test="${(serviceType?.equalsIgnoreCase('Cancellation') && documentClass?.equalsIgnoreCase("LC")) || serviceType?.equalsIgnoreCase('UA Loan Maturity Adjustment')}">--%>
<%----%>
<%--                                <div id="details_for_mt799_tab"  >--%>
<%--                                    <form id="detailsForMt799TabForm"   >--%>
<%--                                            <g:render template="../commons/tabs/details_for_mt_799_tab" />--%>
<%--                                    </form>--%>
<%--                                </div>--%>
<%--							</g:if>--%>
<%--					</g:if>--%>

					<g:if test="${serviceType?.equalsIgnoreCase('Negotiation') && !(documentType?.equalsIgnoreCase('Domestic') && documentSubType1?.equalsIgnoreCase('Cash'))}">
                        <div id="details_transmittal_letter_tab" >
                            <form id="detailsTransmittalLetterTabForm"  >
                                    <g:render template="../commons/tabs/details_transmittal_letter_tab" />
                            </form>
                        </div>
					</g:if>


                    <form id="instructionsAndRoutingTabForm"  >
						<div id="instructions_and_routing_tab">
							<g:render template="../commons/tabs/instructions_and_routing_tab"/>
						</div>
					</form>
				</div>
			</div>
		</div>

<%--		<g:render template="../commons/popups/mode_of_payment_charges_popup" />--%>
        <g:render template="/commons/popups/facility_id_popup"/>
        <g:render template="/commons/popups/loan_details_popup"/>

        <g:render template="../layouts/confirm_alert" />
		<g:render template="../layouts/confirm_alert_cancel" />
		<g:render template="../layouts/alert_confirmation" model="${[popupId:'popup_cancel_basic_details',popupTitle:'Save Basic Details',
		  popupMessage:'Do you want to save your changes?<br/>'+ 
    	'If Yes, save data then redirect to Unacted<br/>'+
    	'If No, resets data then redirect to Unacted<br/>'+
    	'If Close, disregard this popup' ,includeCancel:true,yesBtnId:'yesBtnBD',noBtnId:'noBtnBD',cancelBtnId:'cancelBtnBD'] }"/>
         <g:render template="../layouts/alert" />

		<g:render template="../commons/popups/add_instruction_popup" />
		<g:render template="../commons/popups/add_condition1_popup"/>
		<g:render template="../commons/popups/required_documents1_popup"/>
		<g:render template="../commons/popups/period_for_presentation_popup2" />
		<g:render template="../commons/popups/sender_receiver_popup"/>
		<g:render template="../commons/popups/new_sender_receiver_popup"/>
		<g:javascript src="popups/sender_receiver_popup.js" />
		
		<g:render template="../commons/popups/bank_address_popup" />
        <g:render template="../commons/popups/create_transaction_popup" />
        <g:render template="../commons/popups/create_ua_popup" />
        <g:render template="../commons/popups/create_ets_popup" />
        <g:render template="../commons/popups/create_non_lc_popup" />

        <g:render template="../commons/popups/cif_search_normal"/>
        <g:render template="../commons/popups/cif_search_popup"/>
        
        <g:render template="../commons/popups/input_instructions_popup"/>
		<g:render template="../commons/popups/other_place_of_expiry_popup"/>
		<g:javascript src="popups/other_place_of_expiry_popup.js" />
		
		<g:render template="../commons/popups/new_mixed_payment_details_popup"/>
		<g:javascript src="popups/new_mixed_payment_details_popup.js" />
		
		<g:render template="../commons/popups/new_deferred_payment_details_popup"/>
		<g:javascript src="popups/new_deferred_payment_details_popup.js" />
		
		<g:render template="../commons/popups/special_payment_conditions_for_beneficiary_popup"/>
		<g:javascript src="popups/special_payment_conditions_for_beneficiary_popup.js" />
		
		<g:render template="../commons/popups/special_payment_conditions_for_receiving_bank_popup"/>
		<g:javascript src="popups/special_payment_conditions_for_receiving_bank_popup.js" />
	</body>
</html>