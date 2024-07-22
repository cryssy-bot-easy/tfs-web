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

			//Auto Complete
		    var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
		    var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
		    var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
		    var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';

            var windowed = '${windowed}';
            formId = "#basicDetailsTabForm"

            var modeOfPaymentUrl = '${g.createLink(controller:"modeOfPayment", action: "viewModesOfPayment")}';

			var foreignExchangeUrl = "";
		</script>	
		
		<g:javascript src="grids/foreign_exchange_jqgrid.js"/>
		<g:javascript src="grids/refund_of_cash_lc_and_charges_grid.js"/>
		<g:javascript src="grids/charges_payment_summary_jqgrid.js"/>
		<g:javascript src="grids/payment_jqgrid.js"/>
		<g:javascript src="grids/cash_lc_payment_jqgrid.js"/>
		<g:javascript src="grids/payment_details_for_charges_jqgrid.js"/>
		<g:javascript src="grids/other_imports_foreign_exchange_jqgrid.js"/>

		<g:javascript src="popups/mode_of_payment_charges_popup.js" />
		<g:javascript src="popups/alert_utility.js" />
		<g:javascript src="popups/ets_opening_header_utility.js" />
		<g:javascript src="popups/other_import_charges_payment_popup.js"/>
		
		<g:javascript src="temp/utilities/display_casa.js"/>
		<g:javascript src="temp/utilities/refund_of_cash_lc_and_charges_formats.js"/>
		%{--<g:javascript src="temp/utilities/textarea_utility.js" />--}%
        <g:javascript src="temp/utilities/initialize_forms.js" />
		<g:javascript src="temp/utilities/currency_changer.js" />
		<g:javascript src="temp/utilities/refund_details_lc_amount_utility.js"/>

        <g:javascript src="utilities/commons/ets_index_utility.js"/>

		<script type="text/javascript">
		<%--Used by charges_payment_summary_jqgrid.js--%>
		    var serviceChargeUrl = '${g.createLink(controller:'chargesPayment', action:'findServiceChargesPayments')}';
		    serviceChargeUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
		    serviceChargeUrl += "&referenceType=" + $("#referenceType").val();
		    serviceChargeUrl += "&documentClass=" + $("#documentClass").val();

            var computeTotalUrl = "";

            var documentClass = '${documentClass}';
            var referenceType = '${referenceType}';
            var saveUrl = "";

            var loggedInUser='${session['group']}';
            var userRole='${session.userrole.id}';

            if(documentClass == "CORRES_CHARGE") {
                if(referenceType == "ETS") {

                    saveUrl = '${g.createLink(controller:'corresChargeEtsSettlement', action:'saveSettlementEts')}';
                }
            }

            var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
            var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
            var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
            var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
            var attachedDocumentsUrl = '${g.createLink(controller:'lcEtsOpening', action:'viewAttachments', params:[tradeServiceIdHolder:'xxxx'])}'.replace('xxxx',tradeServiceIdHolder);
            var downloadDocumentUrl = '${g.createLink(controller:'lcEtsOpening', action:'downloadFile')}';
		</script>
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
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			<g:render template="../layouts/header"/>
			
			<%-- ACCORDION --%>
			<g:render template="../layouts/accordion" />
				
			<g:if test="${title.contains('Import Advance')}">
				<g:render template="../others/imports/ets/import_advance/content"/>
			</g:if>
			<g:if test="${title.contains('Actual Corres Charges')}">
				<g:render template="../others/imports/ets/actual_corres_charges_settlement/content"/>
			</g:if>
			<g:if test="${title.contains('Other Import Charges')}">
				<g:render template="../others/imports/ets/other_import_charges_payment/content"/>
			</g:if>
			<g:if test="${title.contains('Refund of Cash LC and/or Charges')}">
				<g:render template="../others/imports/ets/refund_cash_lc_charges/content"/>
			</g:if>
		</div>
			
	<%--<g:render template="../popups/special/accounting_entries_popup" />
	<g:javascript src="popups/dialog_accounting_entries.js"/>--%>
	<g:render template="../layouts/confirm_alert" />
	<g:render template="../layouts/alert" />
	
	<g:render template="../commons/popups/mode_of_payment_charges_popup" />
	<g:render template="../commons/popups/ec_login" />	
	<g:render template="../commons/popups/reverse_button_confirmation" />	
	<g:render template="../commons/popups/cif_search_popup" />
	<g:render template="../others/commons/popups/other_import_charges_payment_popup"/>
	<g:render template="../others/commons/popups/partial_amount_refund_popup"/>

    <g:render template="../commons/popups/create_transaction_popup" />
    <g:render template="../commons/popups/create_ua_popup" />
    <g:render template="../commons/popups/create_ets_popup" />
    <g:render template="../commons/popups/create_non_lc_popup" />
	</body>
</html>