<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!-- Modified by: Rafael Ski Poblete
	 Date: 7/26/18 
	 Description : Added charges_narative_popup.gsp and charges_narative_popup.js 
	 
	 Date: 8/01/18 
	 Description : Added charges_narative_popup_for_MT742.gsp and charges_narative_popup_for_MT742.js -->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="${referenceType != 'ETS' ? 'main_loading' : 'main_ets' }" />
    <g:javascript src="popups/bank_address_popup.js" />
</head>
<body style="visibility: hidden;" onload="js_Load()">
<div id="outer_wrap">
    <%-- HEADER --%>
    <g:render template="../layouts/header"/>

	<g:if test="${!windowed?.equalsIgnoreCase('true')}">
	    <%-- ACCORDION --%>
	    <g:render template="../layouts/accordion" />
    </g:if>

    <%-- render tab container--%>
    <g:render template="../product/tab_container"/>

</div>

<g:render template="../commons/popups/bank_address_popup" />
<g:render template="../commons/popups/sender_receiver_popup"/>
<g:render template="../commons/popups/charges_narative_popup"/>
<g:render template="../commons/popups/charges_narative_popup_for_MT742"/>
<g:javascript src="popups/sender_receiver_popup.js" />
<g:javascript src="popups/charges_narative_popup.js" />
<g:javascript src="popups/charges_narative_popup_for_MT742.js" />

</body>
</html>