<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="main" />
    <g:javascript src="popups/mode_of_payment_charges_popup.js" />
    <script type="text/javascript">
        var referenceType = "ETS";
        var routingUrl = '${g.createLink(controller:'instructionsAndRouting', action:'getRoutes')}';
        var addRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'addInstruction')}';
        var getRemarks =  '${g.createLink(controller:'instructionsAndRouting', action:'getInstructions')}';
        var updateRemarksUrl = '${g.createLink(controller:'instructionsAndRouting', action:'updateInstruction')}';
        var recomputeCurrency_IMPORT_ADVANCE_PAYMENT_Url = '${g.createLink(controller: 'recompute',action: 'recomputeCurrency_IMPORT_ADVANCE_PAYMENT')}';
    </script>
</head>
<body style="visibility: hidden;" onload="js_Load()">
`<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

    <%-- ACCORDION --%>
    <g:render template="../layouts/accordion" />

    <g:render template="../others/imports/importadvance/content"/>

    </div>

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