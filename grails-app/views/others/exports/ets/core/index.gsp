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
            //Charges Recompute URLS
            var recomputeCurrency_BC_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_DOMESTIC_SETTLEMENT')}';
            var recomputeCurrency_BC_FOREIGN_CANCELLATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_FOREIGN_CANCELLATION')}';
            var recomputeCurrency_BC_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BC_FOREIGN_SETTLEMENT')}';

            var recomputeCurrency_BP_DOMESTIC_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_NEGOTIATION')}';
            var recomputeCurrency_BP_DOMESTIC_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_DOMESTIC_SETTLEMENT')}';
            var recomputeCurrency_BP_FOREIGN_NEGOTIATION_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_NEGOTIATION')}';
            var recomputeCurrency_BP_FOREIGN_SETTLEMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_BP_FOREIGN_SETTLEMENT')}';

</script>
<g:javascript src="popups/alert_utility.js" />
<g:javascript src="utilities/exports/initialize_forms.js" />
<g:javascript src="grids/payment_jqgrid.js" />
%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
<g:javascript src="grids/other_exports_foreign_exchange_jqgrid.js" />
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
							<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE'))}">
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
					
					<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')}">
						<li> <a href="#loan_setup_tab" id="loanSetupTab"> <span class="tab_titles"> Loan <br /> Set-Up </span> </a> </li>
					</g:if>
					
					<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || (serviceType?.equalsIgnoreCase('SETTLEMENT') && documentClass?.equalsIgnoreCase('COLLECTION'))}">
						<li> <a href="#settlement_proceeds_seller_tab" id="settlementProceedsSellerTab"> <span class="tab_titles"> Settlement of <br /> Proceeds to Seller </span> </a> </li>
					</g:if>
					
					<g:if test="${(serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')) || serviceType?.equalsIgnoreCase('SETTLEMENT')}">
						<li> <a href="#charges_tab" id="chargesTab"> <span class="tab_titles"> Charges <br /> &#160; </span> </a> </li>
						<li> <a href="#charges_payment_tab" id="chargesPaymentTab"> <span class="tab_titles"> Charges <br /> Payment </span> </a> </li>
					</g:if>
					
					<li> <a href="#instructions_and_routing_tab" id="instructionsAndRoutingTab"> <span class="tab_titles"> Instructions <br /> and Routing </span> </a> </li>
				</ul>
				
				<form id="basicDetailsTabForm">
					<div id="basic_details_tab">
						<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')}">
							<g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
								<g:render template="../others/exports/ets/core/purchase/negotiation/foreign/basic_details_tab" />
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
								<g:render template="../others/exports/ets/core/purchase/negotiation/domestic/basic_details_tab" />
							</g:elseif>
						</g:if>
						<g:elseif test="${serviceType?.equalsIgnoreCase('SETTLEMENT') && documentClass?.equalsIgnoreCase('COLLECTION')}">
							<g:if test="${documentType?.equalsIgnoreCase('EXPORT')}">
								<g:render template="../others/exports/ets/core/collection/settlement/foreign/basic_details_tab" />
							</g:if>
							<g:elseif test="${documentType?.equalsIgnoreCase('DOMESTIC')}">
								<g:render template="../others/exports/ets/core/collection/settlement/domestic/basic_details_tab" />
							</g:elseif>
						</g:elseif>
					</div>
				</form>
				
				<g:if test="${serviceType?.equalsIgnoreCase('NEGOTIATION') && documentClass?.equalsIgnoreCase('PURCHASE')}">
					<form id="loanSetupTabForm">
						<div id="loan_setup_tab">
							<g:render template="../others/commons/tabs/loan_setup_ets_tab" />
						</div>
					</form>
				</g:if>
				
				<form id="settlementProceedsSellerTabForm">
					<div id="settlement_proceeds_seller_tab">
						<g:render template="../others/commons/tabs/settlement_proceeds_seller_tab" />
					</div>
				</form>

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
				
				<form id="instructionsAndRoutingTabForm">
					<div id="instructions_and_routing_tab">
						<g:render template="../commons/tabs/instructions_and_routing_tab" />
					</div>
				</form>

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