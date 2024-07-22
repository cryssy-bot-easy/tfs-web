
function setupApMonitoringGrid(){
	var apMainGridUrl = apMainInquiryGridUrl;
	apMainGridUrl += "?unitcode="+unitcode;

	setupJqGridWidthPagerHidden('grid_list_ap_inquiry_main', {width: 780, height: 350, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['unitCode', 'Unit Code', 50, 'center'],
			 ['refNoDocNo', 'Reference No./<br/>Document No.', 100, 'left'],
			 ['cifName', 'CIF Name', 100, 'left'],
			 ['bookingDate', 'Booking Date', 80, 'center'],
			 ['natureOfTransaction', 'Nature of Transaction', 110, 'left'],
			 ['currency', 'Currency', 50, 'center'],
			 ['origninalAP', 'Original AP', 80, 'right'],
			 ['apAmount', 'O/S AP Amount', 80, 'right'],
			 ['status', 'Status', 80, 'center'],
			 ['apAging', 'AP Aging', 50, 'center'],
			 ['action', 'Action', 70, 'center', (userrole.indexOf('TSDM') == -1) ? 'hidden' : '']],'grid_pager_import_advanced_payment', apMainGridUrl);

    var apBranchGridUrl = apBranchInquiryGridUrl;
    apBranchGridUrl += "?unitcode="+unitcode;
	
	setupJqGridPager('grid_list_ap_inquiry_branch', {width: 780, height: 350, loadui: "disable", scrollOffset:0, rowNum: 20},
			[['unitCode', 'Unit Code', 50, 'center'],
			 ['refNoDocNo', 'Reference No./<br/>Document No.', 100, 'left'],
			 ['cifName', 'CIF Name', 100, 'left'],
			 ['bookingDate', 'Booking Date', 80, 'center'],
			 ['natureOfTransaction', 'Nature of Transaction', 110, 'left'],
			 ['currency', 'Currency', 50, 'center'],
			 ['origninalAP', 'Original AP', 80, 'right'],
			 ['apAmount', 'O/S AP Amount', 80, 'right'],
			 ['status', 'Status', 80, 'center'],
			 ['apAging', 'AP Aging', 50, 'center'],
		     ['action', 'Action', 70, 'center']],'grid_pager_import_advanced_payment', apBranchGridUrl);

}

function setupApMonitoringGridValidation(){
	if($("#grid_list_ap_inquiry_branch") && "BRM" != $("#userrole").val()){ //wala namang 'action' for branch jqgrid!
		$("#grid_list_ap_inquiry_branch").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
	if($("#grid_list_ap_inquiry_main") && "TSDM" != $("#userrole").val()){
		$("#grid_list_ap_inquiry_main").jqGrid("hideCol","action").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}


function onApplyToLoanAp(id) {
    var gotoUrl = viewApprovedApUrl;
    gotoUrl += "?id="+id;
    gotoUrl += "&documentClass="+"AP";
    gotoUrl += "&serviceType="+"Apply";
    gotoUrl += "&referenceType="+"DATA_ENTRY";

    location.href = gotoUrl;
}

function onRefundAp(id) {
	var grid = null;

    if($("#grid_list_ap_inquiry_branch").length > 0) {
        grid = $("#grid_list_ap_inquiry_branch");
    } else {
        grid = $("#grid_list_ap_inquiry_main");
    }
	var gridData = grid.jqGrid("getRowData", id);
	$.post(multipleServiceInstructionUrl, {tradeProductNumber: gridData.refNoDocNo, serviceType: "REFUND"}, function (data) {
        if (data.success == "true") {
        	var gotoUrl = viewApprovedApUrl;
        	gotoUrl += "?id="+id;
        	gotoUrl += "&documentClass="+"AP";
        	gotoUrl += "&serviceType="+"Refund";
        	gotoUrl += "&referenceType="+"ETS";
        	gotoUrl += "&natureOfTransaction="+gridData.natureOfTransaction;
        	gotoUrl += "&documentNumber="+gridData.refNoDocNo;
        	
        	location.href = gotoUrl;
        } else {
            triggerAlertMessage(data.message);
        }
    });
}

function onResetApBtnClick() {
	var postUrl = null;
    var grid = null;

    if($("#grid_list_ap_inquiry_branch").length > 0) {
    	postUrl = apBranchInquiryGridUrl;
        grid = $("#grid_list_ap_inquiry_branch");
    } else {
    	postUrl = apMainInquiryGridUrl;
        grid = $("#grid_list_ap_inquiry_main");
    }
    
    postUrl += "?unitcode="+unitcode;
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
    
    $("#referenceNumber, #status, #cifNameSearch, #documentNumber, #natureOfTransaction, #unitCode").val("");
}

function onSearchApBtnClick() {
    var postUrl = null;
    var grid = null;

    if($("#grid_list_ap_inquiry_branch").length > 0) {
    	postUrl = apBranchInquiryGridUrl;
    	grid = $("#grid_list_ap_inquiry_branch");
    } else {
    	postUrl = apMainInquiryGridUrl;
    	grid = $("#grid_list_ap_inquiry_main");
    }

    postUrl += "?"+$("#apInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertApCount}).trigger("reloadGrid");
}

function alertApCount(){
	var grid;
	
	if ($("#grid_list_ap_inquiry_branch").length > 0) {
		grid = $("#grid_list_ap_inquiry_branch");
	} else {
		grid = $("#grid_list_ap_inquiry_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function initApMonitoringGrid(){
	setupApMonitoringGrid();
	setupApMonitoringGridValidation();
	
	$("#searchApBtn").click(onSearchApBtnClick);
	$("#resetApBtn").click(onResetApBtnClick);
}

$(initApMonitoringGrid);