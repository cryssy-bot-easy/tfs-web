<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Trade Finance System</title>
<meta name="layout" content="main" />
<script type="text/javascript">
	
			var referenceType = '${referenceType}';
			var serviceType = '${serviceType}';
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var serviceType = '${serviceType}';

			var formId = "#basicDetailsTabForm";
			
			var gotoUrl;
			var saveUrl;
			var uploadDocumentUrl;
			var updateUrl;
			var deleteDocumentUrl;
			var updateStatusUrl;
			var addRemarksUrl;

			var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
            var attachedDocumentsUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewAttachments')}';
            var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
            var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
            var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
</script>
<g:javascript src="popups/alert_utility.js" />
<g:javascript src="utilities/exports/initialize_forms.js" />
<g:javascript src="grids/payment_jqgrid.js" />
%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
<g:javascript src="grids/other_imports_foreign_exchange_jqgrid.js" />
<g:javascript src="popups/mode_of_payment_charges_popup.js" />
</head>
<body>
	<div id="outer_wrap">
		<%-- HEADER --%>
		<g:render template="../layouts/header" />

		<%-- ACCORDION --%>
		<g:render template="../layouts/accordion" />

		<div id="body_forms">

			<div id="body_forms_header">
				<div id="header_details">
					<h3 class="header_details_title"> </h3>
					<h3 class="header_details_title"> </h3>
					<h3 class="header_details_title"> </h3>
					<br /> <br /> <br />
				</div>
				<table id="header_details2">
					<tr>
						<td> <span class="field_label"> CIF Number </span> </td>
						<td>
							<g:textField name="cifNumber" class="input_field" readonly="readonly" value="123456" />
							<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('COLLECTION')}">
								<a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a>
							</g:if>
						</td>
					</tr>
					<tr>
						<td> <span class="field_label"> CIF Name </span> </td>
						<td> <g:textField name="cifName" class="input_field" readonly="readonly" value="San Fernando Transpo" /> </td>
					</tr>
					<tr>
						<td> <span class="field_label"> Account Officer </span> </td>
						<td> <g:textField name="accountOfficer" class="input_field" readonly="readonly" value="Juliet Periabras" /> </td>
					</tr>
					<tr>
						<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
						<td> <g:textField name="ccbdBranchUnitCode" class="input_field" readonly="readonly" value="930" /> </td>
					</tr>
				</table>
			</div>
			<div id="tab_container">
				<ul>
					<li> <a href="#basic_details_tab" id="basicDetailsTab"> <span class="tab_titles"> Basic <br /> Details </span> </a> </li>
					
					<g:if test="${serviceType?.equalsIgnoreCase('CANCELLATION')}">
						<li> <a href="#lc_details_tab" id="lcDetailsTab"> <span class="tab_titles"> LC <br /> Details </span> </a> </li>
					</g:if>
					
					<g:if test="${serviceType?.equalsIgnoreCase('CANCELLATION') || (serviceType?.equalsIgnoreCase('SETTLEMENT') && documentClass?.equalsIgnoreCase('COLLECTION') && documentType?.equalsIgnoreCase('EXPORT'))}">
						<li> <a href="#attached_documents_tab" id="attachedDocumentsTab"> <span class="tab_titles"> Attached <br /> Documents </span> </a> </li>
					</g:if>
					
					<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')}">
						<li> <a href="#loan_setup_tab" id="loanSetupTab"> <span class="tab_titles"> Loan <br /> Set-Up </span> </a> </li>
					</g:if>
					
					<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
						<li> <a href="#setup_lc_details_tab" id="setupLcDetailsTab"> <span class="tab_titles"> Set-Up <br /> LC Details </span> </a> </li>
					</g:if>
					
					<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentType?.equalsIgnoreCase('EXPORT')}">
						<li> <a href="#setup_non_lc_details_tab" id="setupNonLcDetailsTab"> <span class="tab_titles"> Set-Up <br /> Non-LC Details </span> </a> </li>
					</g:if>
					
					<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
						<li> <a href="#documents_enclosed_instructions_tab" id="documentsEnclosedInstructionsTab"> <span class="tab_titles"> Documents Enclosed <br /> and Instructions </span> </a> </li>
					</g:if>
					
					<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || (serviceType?.equalsIgnoreCase('SETTLEMENT') && documentClass?.equalsIgnoreCase('COLLECTION'))}">
						<li> <a href="#settlement_proceeds_seller_tab" id="settlementProceedsSellerTab"> <span class="tab_titles"> Settlement of <br /> Proceeds to Seller </span> </a> </li>
						<li> <a href="#mt_103_tab" id="mt103Tab"> <span class="tab_titles"> MT 103 <br /> &#160; </span> </a> </li>
						<li> <a href="#pddts_tab" id="pddtsTab"> <span class="tab_titles"> PDDTS <br /> &#160; </span> </a> </li>
					</g:if>
					
					<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || serviceType?.equalsIgnoreCase('SETTLEMENT')}">
						<li> <a href="#charges_tab" id="chargesTab"> <span class="tab_titles"> Charges <br /> &#160; </span> </a> </li>
						<li> <a href="#charges_payment_tab" id="chargesPaymentTab"> <span class="tab_titles"> Charges <br /> Payment </span> </a> </li>
					</g:if>
					
					<li> <a href="#instructions_and_routing_tab" id="instructionsRoutingTab"> <span class="tab_titles"> Instructions <br /> and Routing </span> </a> </li>
<%--					<li> <a href="#test">test<br /> &#160; </a>--%>
				</ul>
				
				<form id="basicDetailsTabForm">
					<div id="basic_details_tab">
						<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
							<g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
								<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE')}">
									<g:render template="../others/exports/dataentry/core/purchase/negotiation/foreign/basic_details_tab" />
								</g:if>
								<g:elseif test="${documentClass?.equalsIgnoreCase('COLLECTION')}">
									<g:render template="../others/exports/dataentry/core/collection/negotiation/foreign/basic_details_tab" />
								</g:elseif>
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
								<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE')}">
									<g:render template="../others/exports/dataentry/core/purchase/negotiation/domestic/basic_details_tab" />
								</g:if>
								<g:elseif test="${documentClass?.equalsIgnoreCase('COLLECTION')}">
									<g:render template="../others/exports/dataentry/core/collection/negotiation/domestic/basic_details_tab" />
								</g:elseif>
							</g:elseif>
						</g:if>
						<g:elseif test="${serviceType?.equalsIgnoreCase('SETTLEMENT')}">
							<g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
								<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE')}">
									<g:render template="../others/exports/dataentry/core/purchase/settlement/foreign/basic_details_tab" />
								</g:if>
								<g:elseif test="${documentClass?.equalsIgnoreCase('COLLECTION')}">
									<g:render template="../others/exports/dataentry/core/collection/settlement/foreign/basic_details_tab" />
								</g:elseif>
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
								<g:if test="${documentClass?.equalsIgnoreCase('PURCHASE')}">
									<g:render template="../others/exports/dataentry/core/purchase/settlement/domestic/basic_details_tab" />
								</g:if>
								<g:elseif test="${documentClass?.equalsIgnoreCase('COLLECTION')}">
									<g:render template="../others/exports/dataentry/core/collection/settlement/domestic/basic_details_tab" />
								</g:elseif>
							</g:elseif>
						</g:elseif>
						<g:elseif test="${serviceType?.equalsIgnoreCase('CANCELLATION')}">
							<g:render template="../others/exports/dataentry/core/collection/cancellation/foreign/basic_details_tab" />
						</g:elseif>
					</div>
				</form>
				
				<g:if test="${serviceType?.equalsIgnoreCase('CANCELLATION')}">
					<form id="lcDetailsTabForm">
						<div id="lc_details_tab">
							<g:javascript src="utilities/exports/lc_details_utility.js" />
							<g:render template="../others/commons/tabs/setup_lc_details_foreign_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${serviceType?.equalsIgnoreCase('CANCELLATION') || (serviceType?.equalsIgnoreCase('Settlement') && documentClass?.equalsIgnoreCase('COLLECTION') && documentType?.equalsIgnoreCase('EXPORT'))}">
					<form id="attachedDocumentsTabForm">
						<div id="attached_documents_tab">
							<g:render template="../commons/tabs/attached_documents_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')}">
					<form id="loanSetupTabForm">
						<div id="loan_setup_tab">
							<g:render template="../others/commons/tabs/loan_setup_dataentry_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
					<form id="setupLcDetailsTabForm">
						<div id="setup_lc_details_tab">
							<g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
								<g:render template="../others/commons/tabs/setup_lc_details_foreign_tab" />
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
								<g:render template="../others/commons/tabs/setup_lc_details_domestic_tab" />
							</g:elseif>
						</div>
					</form>
				</g:if>
				
				<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentType?.equalsIgnoreCase('EXPORT')}">
					<form id="setupNonLcDetailsTabForm">
						<div id="setup_non_lc_details_tab">
							<g:render template="../others/commons/tabs/setup_nonlc_details_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION')}">
					<form id="documentsEnclosedAndInstructionsTabForm">
						<div id="documents_enclosed_instructions_tab">
							<g:render template="../others/commons/tabs/documents_enclosed_instructions_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || (serviceType?.equalsIgnoreCase('SETTLEMENT') && documentClass?.equalsIgnoreCase('COLLECTION'))}">
					<form id="settlementProceedsSellerTabForm">
						<div id="settlement_proceeds_seller_tab">
							<g:render template="../others/commons/tabs/settlement_proceeds_seller_tab" />
						</div>
					</form>
				
					<form id="mt103TabForm">
						<div id="mt_103_tab">
							<g:render template="../commons/tabs/mt_103_tab" />
						</div>
					</form>
					
					<form id="pddtsTabForm">
						<div id="pddts_tab">
							<g:render template="../commons/tabs/pddts_tab" />
						</div>
					</form>
				</g:if>
				
				<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || serviceType?.equalsIgnoreCase('SETTLEMENT')}">
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
				
				<form id="instructionsAndRoutingTabForm">
					<div id="instructions_and_routing_tab">
						<g:render template="../commons/tabs/instructions_and_routing_tab" />
					</div>
				</form>
				
<%--				<div id="test">--%>
<%--					<g:render template="../others/commons/tabs/other_export_charges_payment_details_tab" />--%>
<%--				</div>--%>

			</div> <%-- End of Tab Container --%>
		</div>
	</div>


		<g:render template="../layouts/confirm_alert" />
		<g:render template="../layouts/alert" />
		<g:render template="../commons/popups/cif_search_popup" />
		<g:javascript src="popups/cif_search_popup.js"/>
		<g:render template="../commons/popups/mode_of_payment_charges_popup" />
<%--		<g:render template="../commons/popups/ec_login" />--%>
<%--		<g:render template="../commons/popups/sender_receiver_popup" />--%>
		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
</body>
</html>