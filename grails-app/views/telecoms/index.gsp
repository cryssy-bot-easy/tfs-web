<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd"> 
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="layout" content="main" />
    <%@ page import="net.ipc.utils.DateUtils" %>
    <title>Trade Finance System</title>
   	<script type="text/javascript">
   		var outgoingMtUrl = '${g.createLink(base:grailsApplication.config.tfs.report.location.base, controller:"genericReports", action:"runOutgoingMtReport")}';
		
		var unactedOutgoingMtUrl = '${g.createLink(controller:'telecoms',action:'getOutgoingMtGridData')}?outputType=${outputType}';
		var transmitAllMtsUrl = '${g.createLink(controller:'telecoms',action:'transmitAllMts')}';
		var indexUrl = '${g.createLink(controller:'telecoms',action:'index')}';
		var transmitUrl = '${g.createLink(controller: "outgoingMt", action: "transmitMtMessage")}';
		var discardUrl = '${g.createLink(controller: "outgoingMt", action: "discardMtMessage")}';
		var reverseUrl = '${g.createLink(controller: "outgoingMt", action: "reverseMtMessage")}';
		var viewMtUrl = '${g.createLink(controller:'unactedTransactions',action:'viewMt')}';
   	</script>
	<g:javascript src="grids/outgoing_mt_telecom.js"/>
	<g:javascript src="report/generateOutgoingMt.js"/>
</head>
<body style="visibility: hidden;">
	
	
	<div id="outer_wrap">
		<g:render template="/layouts/header"/>
		<g:render template="/telecoms/telecoms_accordion"/>
	    <g:if test="${sourceType.equals('OUTGOING')}">
	    	<g:render template="/mt/outgoing/content"></g:render>
	    </g:if>
	    <g:else>
			<div id="telecom">
				<div class="grid_wrapper_telecom">
					<table id="grid_list_mt_monitoring_inquiry"></table>
					<div id="grid_pager_mt_monitoring_inquiry"></div>
				</div>
				<br/>
				<g:if test="${flash.message}">
					<span style="margin-left: 21em;color:red;">${flash.message}</span>
				</g:if>
				<g:if test="${title?.toString().toUpperCase().contains('UNACTED') && 
					!session?.userrole?.description?.toString()?.toUpperCase().contains('PROCESSOR')}">
					<input type="button" class="input_button2" id="transmitAll" value="Transmit All" />
				</g:if>
			</div>
	    </g:else>
	</div>
    <g:render template="../commons/popups/telecom_reports_popup"/>
    <g:render template="/layouts/confirm_alert"/>
</body>
</html>
