<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/2029/xhtml">
<%@ page import="net.ipc.utils.DateUtils" %>
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="outgoing_mt" />
</head>
<body style="visibility: hidden;" onload="js_Load()">
	<content tag="header">
		<g:render template="../layouts/header" model="${[title : 'Outgoing MT - 202']}"/>
	</content>

    <content tag="basicDetails">
        <g:render template="/others/imports/dataentry/outgoing_mt/mt202/mt_details_tab" />
        <g:render template="../layouts/alert_confirmation" model="${[popupId:'mtPopup',
			yesBtnId:'mtConfirm',noBtnId:'mtCancel',popupTitle:'Save mt202',
			popupMessage:'Are you sure you want to save mt202?'] }"/>
		<g:render template="../commons/popups/mt202_popup" />
    </content>
    
    <content tag="additionalResources">
    	<g:javascript src="utilities/dataentry/incoming_mt/mt202/mt202_popup.js" />
    	<g:javascript src="utilities/other_imports/mt/outgoing/mt202_basic_details_utility.js"/>
    </content>
</body>
</html>