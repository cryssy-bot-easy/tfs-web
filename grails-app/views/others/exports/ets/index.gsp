<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System </title>
		<meta name="layout" content="main" />
		<script type="text/javascript">
				var productChargeUrl;
				
				var referenceType = '${referenceType}'; 
				var serviceType = '${serviceType}'; 
				var documentType = '${documentType}';
				var documentClass = '${documentClass}';
				var subType1 = '${subType1}';
				var subType2 = '${subType2}';
				
				var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
				var attachedDocumentsUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewAttachments')}';
				var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
				var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
				var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';

				//Auto Complete
			    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
			    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
			    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
			    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
			    
	
		</script>	
		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
		<g:javascript src="popups/alert_utility.js" />
		%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
        <g:javascript src="utilities/other_exports/commons/initialize_forms.js" />
        <g:javascript src="grids/payment_jqgrid.js" />
        <g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges')}">
        <g:javascript src="utilities/ets/commons/charges/charges_tab_utility.js" />
		</g:if>
		
<%--		javascript for cif/main cif header popup button--%>
		<g:javascript src="popups/ets_opening_header_utility.js" />
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			<g:render template="../layouts/header"/>
			
			<%-- ACCORDION --%>
			<g:render template="../layouts/accordion" />

			<div id="body_forms">
				<div id="body_forms_header">
					<div id="header_details">
						<h3 class="header_details_title">  </h3>
						<h3 class="header_details_title">  </h3>
						<h3 class="header_details_title">  </h3>
						
						<br /><br /><br />
					</div>
					<table id="header_details2">
						<tr>
		  					<td><span class="field_label"> CIF Number </span> </td>
		  					<td><g:textField name="cifNumber" class="input_field textFormat-7" readonly="readonly" /> </td>
		  					<g:if test="${serviceType?.equalsIgnoreCase('export advance payment') || serviceType?.equalsIgnoreCase('refund of other export charges')}">
		  						<td> <a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a></td>
		  					</g:if>
						</tr>
						<tr> 
		  					<td> <span class="field_label"> CIF Name </span> </td>
		  					<td> <g:textField name="cifName" class="input_field textFormat-20" readonly="readonly" /> </td>
						</tr>
						<tr> 
		  					<td> <span class="field_label"> Account Officer </span> </td>
		  					<td> <g:textField name="accountOfficer" class="input_field" readonly="readonly" /> </td>
						</tr>
						<tr> 
		  					<td> <span class="field_label"> CCBD/Branch Unit Code </span> </td>
		  					<td> <g:textField name="ccbdBranchUnitCode" class="input_field textFormat-3" readonly="readonly" /> </td>
						</tr>
					</table>
				</div>
				<div id="tab_container">
					<ul>
	   					<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details </span></a></li>
	   					<g:if test="${ serviceType?.equalsIgnoreCase('refund of other export charges') }">
	   						<li><a href="#refund_details_charges" id="refundDetailsChargesTab"><span class="tab_titles">Refund Details for Charges</span></a></li>
						</g:if>
	   					<li><a href="#export_advance_details_tab" id="exportAdvanceDetailsTab"><span class="tab_titles"> <g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}"> Settlement to Export Proceeds to Beneficiary </g:if>  <g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}"> Export Advance Refund Details </g:if> <g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') }"> Mode of Refund</g:if> </span> </a> </li>
						<g:if test="${ !serviceType?.equalsIgnoreCase('refund of other export charges') }">
							<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges  </span></a></li>
	   						<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment </span></a></li>
	   					</g:if>

	  					<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
	  				</ul>
     			
	     			<div id="basic_details_tab">
	     				<form id="basicDetailsTabForm">
							<g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}">
								<g:render template="../others/exports/ets/export_advance/payment/basic_details_tab" />   
			    			</g:if>
			     			<g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}">
			     				<g:render template="../others/exports/ets/export_advance/refund/basic_details_tab" />
			     			</g:if>
			     			<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
								<g:render template="../others/exports/ets/other_export_charges/refund/basic_details_tab" />   
			    			</g:if>
			     		</form>
			     	</div>  
	      	
		      		<div id="export_advance_details_tab">
		      			<form id="exportAdvanceDetailsTabForm">
				      		<g:render template="../others/commons/tabs/export_advance_details_tab" />
		      			</form>
		      		</div>
	      			
	      			<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges')}">
		      			<div id="charges_tab">
		      				<form id="chargesTabForm">
		      					<g:render template="../commons/tabs/charges_tab" />
		      				</form>
		      			</div>
		      	
		      			<div id="charges_payment_tab">
		      				<form id="chargesPaymentTabForm">
								<g:render template="../commons/tabs/charges_payment_tab" />
							</form>   
						</div>
					</g:if>
			
					<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
						<div id="refund_details_charges">
							<form id="refundDetailsChargesTabForm">
								<g:render template="../others/exports/dataentry/other_export_charges/processing/payment_details_tab" />
							</form>
						</div>
					</g:if>
			
					<div id="instructions_routing_tab">
						<form id="instructionsAndRoutingTabForm">
							<g:render template="../commons/tabs/instructions_and_routing_tab" />
						</form>
					</div>
				</div> 
			</div>				
		</div>
	<%--<g:render template="../popups/special/accounting_entries_popup" />
	<g:javascript src="popups/dialog_accounting_entries.js"/>--%>
	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/alert" />
	<g:render template="../commons/popups/mode_of_payment_charges_popup" />	
	<g:render template="../commons/popups/cif_search_popup" />
	</body>
</html>