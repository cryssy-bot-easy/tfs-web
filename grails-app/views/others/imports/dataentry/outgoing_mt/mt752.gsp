<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/7529/xhtml">
<%@ page import="net.ipc.utils.DateUtils" %>
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="outgoing_mt" />
</head>
<body style="visibility: hidden;" onload="js_Load()">
	<content tag="header">
		<g:render template="../layouts/header" model="${[title : 'Outgoing MT - 752']}"/>
	</content>

    <content tag="basicDetails">
        <g:render template="/others/imports/dataentry/outgoing_mt/mt752/mt_details_tab" />
        <g:render template="../layouts/alert_confirmation" model="${[popupId:'mtPopup',
			yesBtnId:'mtConfirm',noBtnId:'mtCancel',popupTitle:'Save mt752',
			popupMessage:'Are you sure you want to save mt752?'] }"/>
			<g:render template="../commons/popups/mt752_popup" />
    </content>
        
    <content tag="additionalResources">
    	<g:javascript src="utilities/other_imports/mt/outgoing/mt752_basic_details_utility.js"/>
    	<g:javascript src="utilities/dataentry/incoming_mt/mt752/mt752_popup.js" />
    </content>
</body>
</html>