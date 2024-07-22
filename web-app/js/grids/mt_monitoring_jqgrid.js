
function setUpMtMonitoring(){
	var mtMonitoringUrl=inquiryOutgoingMtUrl;
	

	setupJqGridWidthPagerHidden('grid_list_mt_monitoring_inquiry', {width: 780, height: 540, loadui: "disable", scrollOffset:0, rowNum: 30},
			[['refNumber', 'Reference Number', 180],
			['mtType','MT Type', 120, 'center'],
			['dateTsdApproval','Date of TSD Approval', 120, 'center'],
			['timeTsdApproval','Time of TSD Approval', 120, 'center'],
			['status','Status', 70, 'center'],
			['action', 'Action', 70, 'center'],
			['referenceType', 'Import Type',30, 'left', 'hidden'],
			['documentType','Document Type', 30,'left', 'hidden'],
			['serviceType','Service Type',30, 'left', 'hidden']], 'grid_pager_mt_monitoring_inquiry', mtMonitoringUrl);

	
}

function onViewMtMonitoringClick(id){
	
	var grid = $("#grid_list_mt_monitoring_inquiry").jqGrid("getRowData",id);
	var url = "";
	
		url = mtMonitoringPageUrl;
		url += '?mtType='+grid.mtType;
	
		location.href = url;
}


//just for testing
function onViewMtSomething(id){
	var grid = $("#grid_list_mt_monitoring_inquiry").jqGrid("getRowData",id);
	var url = "";
	
	
	alert('Message Transmit...');

	
}


function initMtMonitoring(){
	setUpMtMonitoring();

//	var gridList = $('#grid_list_mt_monitoring_inquiry');
//
//	gridList.addRowData("1", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 103",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='1'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='1'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 103",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("2", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 199",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='2'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='2'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 199",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("3", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 202",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='3'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='3'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 202",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("4", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 299",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='4'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='4'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 299",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("5", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 499",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='5'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='5'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 499",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("6", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 742",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='6'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='6'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 742",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("7", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 752",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='7'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='7'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 752",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("8", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 799",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='8'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='8'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 799",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
//
//	gridList.addRowData("9", {
//		refNumber:"909-01-930-11-123455",
//		mtType:"MT 999",
//		dateTsdApproval:"08/16/2012",
//		timeTsdApproval:"10:44:12 am",
//		status:"<a href=\"javascript:void(0)\" onclick=\"var id='9'; onViewMtSomething(id);\">Transmit</a>",
//		action:"<a href=\"javascript:void(0)\" onclick=\"var id='9'; onViewMtMonitoringClick(id);\">View</a>",
//		referenceType:"MT 999",
//		documentType:"Processing",
//		serviceType:"Other%20Outgoing%20MT"
//	});
	
}


$(initMtMonitoring);