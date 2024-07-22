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
		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
		<g:javascript src="popups/alert_utility.js" />
        <g:javascript src="utilities/other_imports/commons/initialize_forms.js" />
        %{--<g:javascript src="utilities/commons/textarea_utility.js" />--}%
        <g:javascript src="grids/foreign_exchange_jqgrid.js" />
        <g:javascript src="grids/other_imports_foreign_exchange_jqgrid.js"/>
        <script type="text/javascript">
		<%--Used by cash_lc_payment_jqgrid.js--%>
		    var productChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findProductChargesPayments')}';
		    productChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
		    productChargeUrl += "&referenceType=" + $("#referenceType").val();
		</script>
		<script type="text/javascript">
		<%--Used by attched documents jqgrid--%>
			var attachedDocumentsUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewAttachments')}';
		</script>
        <g:javascript src="grids/cash_lc_payment_jqgrid.js"/>
        
        <g:javascript src="grids/ap_refund_jqgrid.js"/>
		<g:javascript src="grids/refund_of_cash_lc_and_charges_grid.js"/>
		<g:javascript src="grids/charges_payment_summary_jqgrid.js"/>
		<script type="text/javascript">
		<%--Used by charges_payment_summary_jqgrid.js--%>
		    var serviceChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findServiceChargesPayments')}';
		    serviceChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
		    serviceChargeUrl += "&referenceType=" + $("#referenceType").val();
		    serviceChargeUrl += "&documentClass=" + $("#documentClass").val();
		</script>
		<script type="text/javascript">
		<%--Used by md_balance_jqgrid.js--%>
		    var outstandingBalanceGridUrl = '${g.createLink(controller: "mdEtsCollection", action: "displayOutstandingBalance")}';
		    outstandingBalanceGridUrl += "?documentNumber="+'${documentNumber}';
		</script>
		<g:javascript src="grids/md_balance_jqgrid.js"/>
		<g:javascript src="grids/payment_jqgrid.js"/>
		<g:javascript src="grids/import_advance_payment_jqgrid.js" />
		<g:javascript src="grids/import_advance_refund_jqgrid.js" />		
		<g:javascript src="grids/mode_of_application_jqgrid.js"/>
		<g:javascript src="grids/md_collection_jqgrid.js"/>
		<g:javascript src="grids/payment_details_for_charges_jqgrid.js"/>
		

		<g:javascript src="popups/other_import_charges_payment_popup.js"/>
		
		<g:javascript src="temp/utilities/display_casa.js"/>
		<g:javascript src="temp/utilities/refund_of_cash_lc_and_charges_formats.js"/>
		<g:javascript src="temp/utilities/currency_changer.js" />
		<g:javascript src="temp/utilities/refund_details_lc_amount_utility.js"/>
        <g:javascript src="temp/utilities/md_application_dropdown_formats.js"/>
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			%{--<g:render template="../layouts/header"/>--}%
			<g:render template="/grails-app/views/layouts/header"/>

			<%-- ACCORDION --%>
			%{--<g:render template="../layouts/accordion" />--}%
			<g:render template="/grails-app/views/layouts/accordion" />

			<%-- AP Monitoring Page --%>
			<g:if test="${title.contains('AP Monitoring')}">
				<g:render template="/grails-app/views/others/imports/dataentry/ap_monitoring/content"/>
			</g:if>
			
			<%-- AR Monitoring Page --%>
			<g:if test="${title.contains('AR Monitoring')}">
				%{--<g:render template="../others/imports/dataentry/ar_monitoring/content"/>--}%
				<g:render template="/grails-app/views/others/imports/dataentry/ar_monitoring/content"/>
			</g:if>
			
			<%-- Import Advance Page --%>
			<g:if test="${title.contains('Import Advance')}">
				%{--<g:render template="../others/imports/dataentry/import_advance/content"/>--}%
				<g:render template="/grails-app/views/others/imports/dataentry/import_advance/content"/>
			</g:if>
			
			<%-- MD Pages --%>
			<g:if test="${title.contains('MD')}">
				%{--<g:render template="../others/imports/dataentry/md/content"/>--}%
				<g:render template="/grails-app/views/others/imports/dataentry/md/content"/>
			</g:if>
			
			<%-- Processing of Rebates Pages --%>
			<g:if test="${title.contains('Processing of Rebates')}">
				%{--<g:render template="../others/imports/dataentry/processing_rebates/content"/>--}%
				<g:render template="/grails-app/views/others/imports/dataentry/processing_rebates/content"/>
			</g:if>
			
			<%-- Settlement of Actual Corres Charges Pages --%>
			<g:if test="${title.contains('Settlement')}">
				%{--<g:render template="../others/imports/dataentry/settlement_actual_corres_charges/content"/>--}%
				<g:render template="/grails-app/views/others/imports/dataentry/settlement_actual_corres_charges/content"/>
			</g:if>
			
			<%-- Payment of Other Import Charges Pages --%>
			<g:if test="${title.contains('Payment of Other Import Charges')}">
				<g:render template="../others/imports/dataentry/payment_other_import_charges/content"/>
			</g:if>
			
			<%-- Refund of Cash LC & Charges Reversal Pages --%>
			<g:if test="${title.contains('Refund of Cash LC')}">
				<g:render template="../others/imports/dataentry/refund_of_cash_lc/content"/>
			</g:if>
			
			<%-- Processing of Other Outgoing MT Pages --%>
			<g:if test="${title.contains('Other Outgoing MT')}">
				<g:render template="../others/imports/dataentry/outgoing_mt/content"/>
			</g:if>
			
			<g:if test="${title.contains('Incoming MT Monitoring')}">
				<g:render template="../others/imports/dataentry/incoming_mt/content"/>
<%--				<g:render template="../others/imports/dataentry/incoming_mt/maker/maker_incoming_mt"/>--%>
			</g:if>
			
		</div>	
			
	%{--<g:render template="../commons/popups/mode_of_payment_charges_popup" />	--}%
	<g:render template="/grails-app/views/commons/popups/mode_of_payment_charges_popup" />
	%{--<g:render template="../layouts/confirm_alert" />--}%
	<g:render template="/grails-app/views/layouts/confirm_alert" />
	%{--<g:render template="../layouts/alert" />--}%
	<g:render template="/grails-app/views/layouts/alert" />
	%{--<g:render template="../commons/popups/ec_login" />--}%
	<g:render template="/grails-app/views/commons/popups/ec_login" />
	%{--<g:render template="../commons/popups/reverse_button_confirmation" />--}%
	<g:render template="/grails-app/views/commons/popups/reverse_button_confirmation" />
	%{--<g:render template="../commons/popups/sender_receiver_popup"/>--}%
	<g:render template="/grails-app/views/commons/popups/sender_receiver_popup"/>
	<g:javascript src="popups/sender_receiver_popup.js" />
	
	%{--<g:render template="../commons/popups/cif_search_popup" />--}%
	<g:render template="/grails-app/views/commons/popups/cif_search_popup" />
	%{--<g:render template="../others/commons/popups/other_import_charges_payment_popup"/>--}%
	<g:render template="/grails-app/views/others/commons/popups/other_import_charges_payment_popup"/>
	%{--<g:render template="../others/commons/popups/partial_amount_refund_popup"/>--}%
	<g:render template="/grails-app/views/others/commons/popups/partial_amount_refund_popup"/>
	</body>
</html>