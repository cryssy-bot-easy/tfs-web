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

		var inquiryOutgoingMtUrl = '${g.createLink(controller:'inquiry',action:'viewOutgoingMt')}';
		//mt monitoring page
		var mtMonitoringPageUrl = '${g.createLink(controller:'mtMonitoringPage', action:'viewMtMonitoringPage')}';
		//just for testing 
		var mtMessagePageUrl = '${g.createLink(controller:'dataentryOutgoingMt', action:'viewOutgoingMt')}';
		
		
		</script>	
		<g:javascript src="grids/mt_monitoring_jqgrid.js"/>
	</head>
	<body style="visibility: hidden;" onload="js_Load()">
		<div id="outer_wrap">
			<%-- HEADER --%>
			<g:render template="../layouts/header"/>
		
			<%-- ACCORDION --%>
			<g:render template="../layouts/accordion" />
				
			<%-- INQUIRY CONTENT --%>
			
		<div id="body_forms">
			<br>
			<div class="grid_wrapper">
				<table id="grid_list_mt_monitoring_inquiry"></table>
				<div id="grid_pager_mt_monitoring_inquiry"></div>
			</div>
		</div>
	</div>	
	
	</body>
</html>