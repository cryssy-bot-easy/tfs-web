<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="main" />
    <script type="text/javascript">
        var sourceType = '${sourceType}';
        var formId = "#incomingMtForm";
        var saveUrl = ""; // to avoid alert error
        var updateUrl = '${g.createLink(controller: "incomingMt", action: "updateIncomingMtMessage")}';
        var routeUrl = '${g.createLink(controller: "incomingMt", action: "routeMtMessage")}';
        var closeUrl = '${g.createLink(controller: "incomingMt", action: "closeMtMessage")}';
        var returnUrl = '${g.createLink(controller: "incomingMt", action: "returnMtMessage")}';

      	//Auto Complete
        var autoCompleteCBCodeUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCBCode')}';
        var autoCompleteCountryUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCountry')}';
        var autoCompleteBankUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteBanks')}';
        var autoCompleteCurrencyUrl = '${g.createLink(controller:'autoComplete', action:'autoCompleteCurrency')}';
        
    </script>
    <g:javascript src="popups/alert_utility.js" />

</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <g:render template="../layouts/header"/>

    <g:render template="../layouts/accordion" />

    <g:if test="${sourceType.equalsIgnoreCase('INCOMING')}">
        <form id="incomingMtForm">
            <g:render template="../mt/incoming/content"/>
        </form>
    </g:if>
    <g:if test="${sourceType.equalsIgnoreCase('OUTGOING')}">
        <g:render template="../mt/outgoing/content"/>
    </g:if>

</div>

<g:render template="../layouts/confirm_alert" />
<g:render template="../layouts/alert" />

<g:render template="../commons/popups/create_transaction_popup" />
<g:render template="../commons/popups/create_ua_popup" />
<g:render template="../commons/popups/create_ets_popup" />

<g:render template="../commons/popups/create_ets_main_popup" />

<g:render template="../commons/popups/create_non_lc_popup" />
<g:render template="../commons/popups/view_transaction_main_popup"/>

</body>
</html>