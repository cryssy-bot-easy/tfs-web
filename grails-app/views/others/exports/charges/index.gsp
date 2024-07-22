<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title> Trade Finance System </title>
		<meta name="layout" content="main" />
		<script type="text/javascript">
			var referenceType = '${referenceType}'; 
			var serviceType = '${serviceType}'; 
			var documentType = '${documentType}';
			var documentClass = '${documentClass}';
			var subType1 = '${subType1}';
			var subType2 = '${subType2}';

			//Auto Complete
		    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
		    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
		    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
		    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
		    
		</script>	
		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
		<g:javascript src="popups/alert_utility.js" />
		%{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
<%--        <g:javascript src="utilities/other_exports/commons/initialize_forms.js" />--%>
        <g:javascript src="grids/payment_jqgrid.js" />
<%--        <g:javascript src="utilities/ets/commons/charges_tab_utility.js" />--%>
		
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
<%--		  						<td> <a href="javascript:void(0)" class="search_btn" id="popup_btn_cif"> Search/Look-up Button </a></td>--%>
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
		  					<g:hiddenField name="allocationUnitCode" value="${allocationUnitCode }"/>
						</tr>
					</table>
				</div>
				<div id="tab_container">
					<ul>
	   					<li><a href="#charges_payment_tab" id="chargesPaymentTab"><span class="tab_titles"> Charges Payment </span></a></li>
	  					<li><a href="#instructions_routing_tab" id="instructionsRoutingTab"><span class="tab_titles"> Instructions and Routing </span></a></li>
	  				</ul>

	      			<div id="charges_payment_tab">
	      				<form id="chargesPaymentTabForm">
							<g:render template="../others/exports/charges/advise/charges_payment_tab" />
						</form>   
					</div>
			
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