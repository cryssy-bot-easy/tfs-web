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
			var username = '${username}';

			//Auto Complete
		    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
		    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
		    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
		    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
		    
<%--			var serviceType = '${serviceType}';--%>
<%----%>
<%--			var formId = "#basicDetailsTabForm";--%>
<%--			--%>
<%--			var gotoUrl;--%>
<%--			var saveUrl;--%>
<%--			var uploadDocumentUrl;--%>
<%--			var updateUrl;--%>
<%--			var deleteDocumentUrl;--%>
<%--			var updateStatusUrl;--%>
<%--			var addRemarksUrl;--%>


		</script>	
		<g:javascript src="popups/alert_utility.js" />
        <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />
        <g:javascript src="grids/payment_jqgrid.js"/>
        %{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
        <g:javascript src="grids/foreign_exchange_jqgrid.js" />
        <g:javascript src="grids/other_imports_foreign_exchange_jqgrid.js"/>
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			<g:render template="../layouts/header"/>
		
			<%-- ACCORDION --%>
			<g:render template="../layouts/accordion" />
				
			<%-- CDT Remittance --%>
			<g:if test="${title.contains('Remittance')}">
				<g:render template="../others/imports/cdt/remittance/content"/>
			</g:if>
			<g:if test="${title.contains('Refund')}">
				<g:render template="../others/imports/cdt/collection_refund/content"/>
			</g:if>
			
			
		</div>	
			
	
	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/alert" />
	<g:render template="../commons/popups/ec_login" />
	<g:render template="../commons/popups/reverse_button_confirmation" />
	<g:render template="../commons/popups/sender_receiver_popup"/>
	<g:javascript src="popups/sender_receiver_popup.js" />
	</body>
</html>