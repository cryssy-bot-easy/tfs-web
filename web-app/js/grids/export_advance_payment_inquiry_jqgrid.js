function setupExportAdvancePaymentGrids(){
    var exportAdvancePaymentMainGridUrl = searchExportAdvanceInquiry;
    var exportAdvancePaymentBranchGridUrl = searchExportAdvanceInquiry;


    setupJqGridPager('grid_list_export_advanced_payment_main', {height:340, width: 780, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['unitCoder', 'Unit Code'],
         	['documentNumber', 'Document Number'],
            ['cifName', 'Client Name'],
            ['currency', 'Currency'],
            ['amount', 'Export Advance Amount']], 'grid_pager_export_advanced_payment', exportAdvancePaymentMainGridUrl);

    setupJqGridPager('grid_list_export_advanced_payment_branch', {height:340,width: 780, loadui: "disable", scrollOffset:0, rowNum: 20},
        [['documentNumber', 'Document Number'],
            ['cifName', 'Client Name'],
            ['settlementCurrency', 'Settlement Currency'],
            ['amount', 'Export Advance Amount'],
            ['createEts','Action']], 'grid_pager_export_advanced_payment', exportAdvancePaymentBranchGridUrl);
}

function searchExportAdvance() {
    var postUrl = searchExportAdvanceInquiry;
    postUrl += "?"+$("#exportAdvanceInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;

    if($("#grid_list_export_advanced_payment_branch").length > 0) {
        grid = $("#grid_list_export_advanced_payment_branch");
    } else {
        grid = $("#grid_list_export_advanced_payment_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertExportAdvanceCount}).trigger("reloadGrid");
}	

function alertExportAdvanceCount(){
	var grid;
	
	if ($("#grid_list_export_advanced_payment_branch").length > 0) {
		grid = $("#grid_list_export_advanced_payment_branch");
	} else {
		grid = $("#grid_list_export_advanced_payment_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function resetExportAdvance() {
	var postUrl = searchExportAdvanceInquiry;
	var grid = null;
		
	if($("#grid_list_export_advanced_payment_branch").length > 0) {
	    grid = $("#grid_list_export_advanced_payment_branch");
	} else {
	    grid = $("#grid_list_export_advanced_payment_main");
	}

    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
	
//  $("#cifName, #documentNumber, #amountFrom, #amountTo").val("");
    $("#currency").select2('data',null);
}

function initExportAdvancePaymentGrid(){
    setupExportAdvancePaymentGrids();
    setUpExportAdvancePaymentGridsValidation
    $("#searchExportAdvance").click(searchExportAdvance);

    $("#resetExportAdvance").click(resetExportAdvance)
}

function refundExportAdvance(id) {
    var gotoUrl = refundExportAdvanceUrl;
    gotoUrl += "?referenceType=ets";
    gotoUrl += "&documentNumber="+id;
    location.href = gotoUrl;
}

function setUpExportAdvancePaymentGridsValidation(){
	if($("#grid_list_export_advanced_payment_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_export_advanced_payment_branch").jqGrid("hideCol","createEts").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}

$(initExportAdvancePaymentGrid);


/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 2/5/13
 * Time: 2:02 PM
 * To change this template use File | Settings | File Templates.
 */
