function setupUnactedIncomingMT(){
	var gridMakerUrl = unactedRoutedIncomingMtUrl;
    var _opt ={width: 780, loadui: "disable", scrollOffset:0};

    if(('undefined' !== typeof checkTsdTableId && '' == checkTsdTableId && "BRANCH" != sessionGroup) ||
    	('undefined' !== typeof setTsdGrid && '' != setTsdGrid)){
    		$.extend(_opt,{height:'565',scroll:true,forceFit:true,rowNum:1000000});
	}
		setupJqGridWidthPagerHidden('grid_list_incoming_mt_unacted', _opt,
				[/*['dateReceived', 'Date Received', 120],
					['timeReceived', 'Time Received', 120],
					['mtType', 'MT Type', 100, 'center'],
					['routedTo', 'Routed To',220],
					['status', 'Status (TSD/FS Maker)', 140],
					['action', 'Action',80, 'center']*/
				 ['dateReceived', 'Date Received', 120],
					['timeReceived', 'Time Received', 120],
					['mtType', 'MT Type', 120, 'center'],
					['instructions', 'Instructions',320],
					['messageClass', 'Message Class',140],
					['documentNumber', 'DocumentNumber',140],
					['action', 'Action',100, 'center']
					], 'grid_pager_incoming_mt_unacted', gridMakerUrl);

    var gridUrlTsd = unactedIncomingMtMainUrl;
		setupJqGridWidthPagerHidden('grid_list_incoming_mt_unacted_tsd', _opt,
				[/*['dateReceived', 'Date Received', 120],
					['timeReceived', 'Time Received', 120],
					['mtType', 'MT Type', 120, 'center'],
					['instructions', 'Instructions',320],
					['action', 'Action',100, 'center']*/
				 ['dateReceived', 'Date Received', 120],
				 	['timeReceived', 'Time Received', 120],
				 	['mtType', 'MT Type', 100, 'center'],
				 	['routedTo', 'Routed To',220],
				 	['status', 'Status (TSD/FS Maker)', 140],
				 	['messageClass', 'Message Class', 140],
				 	['documentNumber', 'Document Number', 140],
				 	['action', 'Action',80, 'center']
					], 'grid_pager_incoming_mt_unacted', gridUrlTsd);
}

function onViewMtTsd(id,userType) {
    var gotoUrl = viewMtUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"INCOMING";
    gotoUrl += "&userType="+userType;

    location.href = gotoUrl;
}

function onViewMtMaker(id,userType) {
    var gotoUrl = viewMtUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&type="+"INCOMING";
    gotoUrl += "&userType="+userType;

    location.href = gotoUrl;
}

function initUnactedIncomingMT(){
	setupUnactedIncomingMT();
}

$(initUnactedIncomingMT);
