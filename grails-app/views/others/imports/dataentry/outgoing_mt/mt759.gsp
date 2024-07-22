<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/7529/xhtml">
<%@ page import="net.ipc.utils.DateUtils" %>
<head>
    <title> Trade Finance System </title>
    <meta name="layout" content="outgoing_mt" />
</head>
<body style="visibility: hidden;" onload="js_Load()">
	<content tag="header">
		<g:render template="../layouts/header" model="${[title : 'Outgoing MT - 759']}"/>
	</content>

    <content tag="basicDetails">
        <g:render template="/others/imports/dataentry/outgoing_mt/mt759/mt_details_tab" />
    </content>
</body>
<r:require module="mt759Details"/>
</html>
