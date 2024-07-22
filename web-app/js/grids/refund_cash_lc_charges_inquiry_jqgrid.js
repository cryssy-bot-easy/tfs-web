function setupRefundGrids(){
	var refundGridUrl = searchImportProductsUrl;
	refundGridUrl += "?unitcode="+unitcode;
	
	setupJqGridPagerWithHidden('grid_list_refund_cash_lc_charges', {width: 780, height: 395, loadui: "disable", scrollOffset:0, rowNum: 20},
					[['documentNumber', 'Document Number'],
					['cifName', 'CIF Name'],
					['osLcAmount', 'O/S LC Amount', 'right'],
					['lastTransaction', 'Last Transaction'],
					['action', 'Action'],
					['documentClass', 'Document Class', 'center', 'hidden']],'grid_pager_refund_cash_lc_charges', refundGridUrl);
}

function searchRefunds() {
    var postUrl = searchImportProductsUrl;
    postUrl += "?"+$("#refundInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    $("#grid_list_refund_cash_lc_charges").jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertRefundsCount}).trigger("reloadGrid");
}

function alertRefundsCount(){
	triggerAlertMessage($("#grid_list_refund_cash_lc_charges").jqGrid('getGridParam', 'records') + " record/s found.");
	$("#grid_list_refund_cash_lc_charges").jqGrid('setGridParam', {gridComplete: ""});
}

function resetRefundFields() {
//    $("#documentNumber, #cifName").val("");
//    $("#grid_list_refund_cash_lc_charges").jqGrid('setGridParam', {gridComplete: ""}.trigger("reloadGrid"));
	
	$("#documentNumber, #cifName").val("");
    var resetUrl = searchImportProductsUrl;
    resetUrl += "?unitcode="+unitcode;

    var grid = $("#grid_list_refund_cash_lc_charges");
    
    grid.jqGrid('setGridParam', {page: 1, url: resetUrl}).trigger("reloadGrid");
}

function refundPayments(id) {
	var grid = $("#grid_list_refund_cash_lc_charges");
	var data = grid.jqGrid('getRowData',id);
    var url = refundPaymentsUrl;
    location.href = url + "?referenceType=ets&documentNumber="+id+"&documentClass="+data.documentClass;
}

function initRefundGrid(){
	setupRefundGrids();
	$("#refundSearch").click(searchRefunds);
    $("#refundReset").click(resetRefundFields);
}

$(initRefundGrid);