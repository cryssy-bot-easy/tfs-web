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
			var	attachedDocumentsUrl;
			var getRemarks;

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
<%--        <g:javascript src="utilities/ets/commons/charges_tab_utility.js" />--%>
		
<%--		javascript for cif/main cif header popup button--%>
		<g:javascript src="popups/ets_opening_header_utility.js" />
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<g:render template="../layouts/header"/>

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
		  					<g:if test="${ subType1 == 'Second' }">
		  						<td><a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a></td>
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
						<g:if test="${ !serviceType?.equalsIgnoreCase('processing of other export charges') }">
	   						<li><a href="#basic_details_tab" id="basicDetailsTab"><span class="tab_titles"> Basic Details </span></a></li>
	   					</g:if>
	   					<g:if test="${ documentClass?.equalsIgnoreCase('advise')}">
	   						<li><a href="#attached_documents_tab" id="attachedDocumentsTab"><span class="tab_titles"> Attached Documents </span></a></li>
	   					</g:if>
	   					<g:if test="${ serviceType?.equalsIgnoreCase('refund of other export charges') }">
	   						<li><a href="#refund_details_charges_tab" id="refundDetailsChargesTab"><span class="tab_titles">Refund Details for Charges</span></a></li>
						</g:if>
						
						<g:if test="${ serviceType?.equalsIgnoreCase('processing of other export charges') }">
							<li><a href="#payment_details_for_charges_tab" id="paymentdetailsForChargesTab"><span class="tab_tiles">Payment Details for Charges</span></a></li>
						</g:if>
						<g:if test='${ !serviceType?.equalsIgnoreCase('Opening') && !serviceType?.equalsIgnoreCase('Amendment') && !serviceType?.equalsIgnoreCase('Cancellation') }'>
							<g:if test="${ !serviceType?.equalsIgnoreCase('processing of other export charges') }">
		   						<li><a href="#export_advance_details_tab" id="exportAdvanceDetailsTab"><span class="tab_titles"> <g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}"> Settlement to Export Proceeds to Beneficiary </g:if>  <g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}"> Export Advance Refund Details </g:if> <g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges') }"> Mode of Refund</g:if> </span> </a> </li>
		   					</g:if>
	   					</g:if>
	   					<g:if test='${ !serviceType?.equalsIgnoreCase('Opening') && !serviceType?.equalsIgnoreCase('Amendment') && !serviceType?.equalsIgnoreCase('Cancellation') }'>
							<g:if test="${ !serviceType?.equalsIgnoreCase('refund of other export charges') && !serviceType?.equalsIgnoreCase('processing of other export charges') }">
								<li><a href="#charges_tab" id="chargesTab"><span class="tab_titles"> Charges  </span></a></li>
		   						<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment </span></a></li>
		   					</g:if>
							<g:if test="${ !serviceType?.equalsIgnoreCase('refund of other export charges') && !serviceType?.equalsIgnoreCase('processing of other export charges') || serviceType?.equalsIgnoreCase('export advance payment') }">
								<li><a href="#mt_103_tab" id="mt103Tab"><span class="tab_titles"> MT 103 </span></a></li>
							</g:if>
						</g:if>
						<g:if test="${serviceType?.equalsIgnoreCase('export advance payment') }">
							<li><a href="#pddts_tab" id="pddtsTab"><span class="tab_titles"> PDDTS </span></a></li>
						</g:if>
	  					<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
	  				</ul>
     				
     				<g:if test="${ !serviceType?.equalsIgnoreCase('processing or other export charges') }">
		     			<div id="basic_details_tab">
		     				<form id="basicDetailsTabForm">
								<g:if test="${serviceType?.equalsIgnoreCase('export advance payment')}">
									<g:render template="../others/exports/dataentry/export_advance/payment/basic_details_tab" />   
				    			</g:if>
				     			<g:if test="${serviceType?.equalsIgnoreCase('export advance refund')}">
				     				<g:render template="../others/exports/dataentry/export_advance/refund/basic_details_tab" />
				     			</g:if>
				     			<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
									<g:render template="../others/exports/dataentry/other_export_charges/refund/basic_details_tab" />   
				    			</g:if>
				    			<g:if test="${ serviceType. equalsIgnoreCase('opening')}">
				    				<g:render template="../others/exports/dataentry/advise/opening/basic_details_tab" />
				    			</g:if>
				    			<g:if test="${ serviceType. equalsIgnoreCase('amendment')}">
				    				<g:render template="../others/exports/dataentry/advise/amendment/basic_details_tab" />
				    			</g:if>
				    			<g:if test="${ serviceType. equalsIgnoreCase('cancellation')}">
				    				<g:render template="../others/exports/dataentry/advise/cancellation/basic_details_tab" />
				    			</g:if>
				     		</form>
				     	</div>  
	      			</g:if>
	      			
	      			<g:if test="${ documentClass?.equalsIgnoreCase('advise')}">
	      				<div id="attached_documents_tab">
	      					<form id="attachedDocumentsTabForm">
	      						<g:render template="../commons/tabs/attached_documents_tab" />
	      					</form>
	      				</div>
	      			</g:if>
	      			
	      			<g:if test="${serviceType?.equalsIgnoreCase('processing of other export charges') }">
		      			<div id="payment_details_for_charges_tab">
		      				<form id="paymentDetailsForChargesTabForm">
		      					<g:render template="../others/exports/dataentry/other_export_charges/processing/payment_details_tab" />
		      				</form>
		      			</div>
	      			</g:if>
	      			<g:if test='${ !serviceType?.equalsIgnoreCase('Opening') && !serviceType?.equalsIgnoreCase('Amendment') && !serviceType?.equalsIgnoreCase('Cancellation') }'>
		      			<g:if test="${!serviceType?.equalsIgnoreCase('processing of other export charges') }">
				      		<div id="export_advance_details_tab">
				      			<form id="exportAdvanceDetailsTabForm">
				      				<g:render template="../others/commons/tabs/export_advance_details_tab" />
				      			</form>
				      		</div>
		      			</g:if>
	      			</g:if>
	      			<g:if test='${ !serviceType?.equalsIgnoreCase('Opening') && !serviceType?.equalsIgnoreCase('Amendment') && !serviceType?.equalsIgnoreCase('Cancellation') }'>
		      			<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges') && !serviceType?.equalsIgnoreCase('processing of other export charges')}">
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
					</g:if>
					<g:if test="${serviceType?.equalsIgnoreCase('refund of other export charges')}">
						<div id="refund_details_charges_tab">
							<form id="refundDetailsChargesTabForm">
								<g:render template="../others/exports/dataentry/other_export_charges/processing/payment_details_tab" />
							</form>
						</div>
					</g:if>
					<g:if test='${ !serviceType?.equalsIgnoreCase('Opening') && !serviceType?.equalsIgnoreCase('Amendment') && !serviceType?.equalsIgnoreCase('Cancellation') }'>
						<g:if test="${!serviceType?.equalsIgnoreCase('refund of other export charges') && !serviceType?.equalsIgnoreCase('processing of other export charges') }">
							<div id="mt_103_tab">
								<form id="mt103TabForm">
									<g:render template="../commons/tabs/mt_103_tab" />
								</form>
							</div>
						</g:if>
					</g:if>
					<g:if test="${serviceType?.equalsIgnoreCase('export advance payment') && !serviceType?.equalsIgnoreCase('processing of other export charges') }">
						<div id="pddts_tab">
							<form id="pddtsTabForm">
								<g:render template="../commons/tabs/pddts_tab" />
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
	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/alert" />
	<g:render template="../commons/popups/mode_of_payment_charges_popup" />	
	<g:render template="../commons/popups/cif_search_popup" />
	</body>
</html>