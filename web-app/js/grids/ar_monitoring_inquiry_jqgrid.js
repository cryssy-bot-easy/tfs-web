function setupDocumentTypeGrids() {
    var arMainGridUrl = arMainInquiryGridUrl;
    arMainGridUrl += "?unitcode="+unitcode;

    setupJqGridPager('grid_list_ar_inquiry_main', {width: 780, height: 400, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCode', 'Unit Code', 50, 'center'],
         	['refNoDocNo', 'Reference No./Document No.', 100, 'left'],
            ['cifName', 'CIF Name', 100, 'left'],
            ['bookingDate', 'Booking Date', 80, 'center'],
            ['natureOfTransaction', 'Nature of Transaction', 110, 'center'],
            ['currency', 'Currency', 50, 'center'],
            ['origninalAr', 'Original AR', 80, 'right'],
            ['arAmount', 'O/S AR Amount', 80, 'right'],
            ['status', 'Status', 80, 'center'],
            ['arAging', 'AR Aging', 50, 'center'],
            ['action', 'Action', 70, 'center']],'grid_pager_ar_monitoring_inquiry', arMainGridUrl);

    var arBranchGridUrl = arBranchInquiryGridUrl;
    arBranchGridUrl += "?unitcode="+unitcode;

    setupJqGridPager('grid_list_ar_inquiry_branch', {width: 780, height: 395, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCode', 'Unit Code', 50, 'center'],
      		['refNoDocNo', 'Reference No./<br/>Document No.', 100, 'left'],
            ['cifName', 'CIF Name', 100, 'left'],
            ['bookingDate', 'Booking Date', 80, 'center'],
            ['natureOfTransaction', 'Nature of Transaction', 110, 'center'],
            ['currency', 'Currency', 50, 'center'],
            ['origninalAr', 'Original AR', 80, 'right'],
            ['arAmount', 'O/S AR Amount', 80, 'right'],
            ['status', 'Status', 80, 'center'],
            ['arAging', 'AR Aging', 50, 'center'],
            ['action', 'Action', 70, 'center']],'grid_pager_ar_monitoring_inquiry', arBranchGridUrl);
}

function onSettleAr(id) {
	var grid = null;

    if($("#grid_list_ar_inquiry_branch").length > 0) {
        grid = $("#grid_list_ar_inquiry_branch");
    } else {
        grid = $("#grid_list_ar_inquiry_main");
    }
	var gridData = grid.jqGrid("getRowData", id);
	$.post(multipleServiceInstructionUrl, {tradeProductNumber: gridData.refNoDocNo, serviceType: "SETTLE"}, function (data) {
        if (data.success == "true") {
        	var gotoUrl = viewApprovedArUrl;
        	gotoUrl += "?id="+id;
        	gotoUrl += "&documentClass="+"AR";
        	gotoUrl += "&serviceType="+"Settle";
        	gotoUrl += "&referenceType="+"ETS";
        	gotoUrl += "&natureOfTransaction="+gridData.natureOfTransaction;
        	gotoUrl += "&documentNumber="+gridData.refNoDocNo;
        	
        	location.href = gotoUrl;
        } else {
        	triggerAlertMessage(data.message);
        }
    });
}

function setUpArMonitoringGridsValidation(){
	if($("#grid_list_ar_inquiry_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_ar_inquiry_branch").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}
	


function initDocumentTypeGrid() {
	setupDocumentTypeGrids();
	setUpArMonitoringGridsValidation();
	
	$("#searchArBtn").click(onSearchArBtnClick);
	$("#resetArBtn").click(onResetArBtnClick);
}

function onResetArBtnClick() {
	var postUrl = null;
    var grid = null;

    if($("#grid_list_ar_inquiry_branch").length > 0) {
    	postUrl = arBranchInquiryGridUrl;
        grid = $("#grid_list_ar_inquiry_branch");
    } else {
    	postUrl = arMainInquiryGridUrl;
        grid = $("#grid_list_ar_inquiry_main");
    }
    
    postUrl += "?unitcode="+unitcode;
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    
    $("#referenceNumber, #status, #cifNameSearch, #documentNumber, #unitCode" ).val("");
}

function onSearchArBtnClick() {
    var postUrl = null;
    var grid = null;

    if($("#grid_list_ar_inquiry_branch").length > 0) {
    	postUrl = arBranchInquiryGridUrl;
    	grid = $("#grid_list_ar_inquiry_branch");
    } else {
    	postUrl = arMainInquiryGridUrl;
    	grid = $("#grid_list_ar_inquiry_main");
    }

    postUrl += "?"+$("#arInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertArCount}).trigger("reloadGrid");
}

function alertArCount(){
	var grid;
	
	if ($("#grid_list_ar_inquiry_branch").length > 0) {
		grid = $("#grid_list_ar_inquiry_branch");
	} else {
		grid = $("#grid_list_ar_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

$(initDocumentTypeGrid);

