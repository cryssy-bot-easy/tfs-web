function setupImportAdvancePaymentGrids(){
	var importAdvancePaymentGridUrl = searchImportAdvanceInquiry;
	importAdvancePaymentGridUrl += "?unitcode="+unitcode;
	
	
	if($("#grid_list_import_advanced_payment_branch").length > 0) {
		setupJqGridPager('grid_list_import_advanced_payment_branch', {height:340,width: 780, loadui: "disable", scrollOffset:0, rowNum: 20},
				[['documentNumber', 'Document Number'],
				['cifName', 'Client Name'],
				['settlementCurrency', 'Settlement Currency'],
				['amount', 'Import Advance Amount'],
				['createEts','Action']], 'grid_pager_import_advanced_payment', importAdvancePaymentGridUrl);
	}else{
		setupJqGridPager('grid_list_import_advanced_payment_main', {height:100,width: 780, height: 340, loadui: "disable", scrollOffset:0, rowNum: 20},
				[['unitCoder', 'Unit Code'],
				['documentNumber', 'Document Number'], 
				['cifName', 'Client Name'],
				['currency', 'Currency'],
				['amount', 'Import Advance Amount']], 'grid_pager_import_advanced_payment', importAdvancePaymentGridUrl);
	}
}

function setupImportAdvancePaymentGridsValidation(){
	if($("#grid_list_import_advanced_payment_branch") && "BRM" != $("#userrole").val()){
		$("#grid_list_import_advanced_payment_branch").jqGrid("hideCol","createEts").jqGrid("setGridWidth",780).trigger("reloadGrid");
	}
}


function searchImportAdvance() {
    var postUrl = searchImportAdvanceInquiry;
    postUrl += "?"+$("#importAdvanceInquiry").serialize();
    postUrl += "&unitcode="+unitcode;

    var grid = null;

    if($("#grid_list_import_advanced_payment_branch").length > 0) {
        grid = $("#grid_list_import_advanced_payment_branch");
    } else {
        grid = $("#grid_list_import_advanced_payment_main");
    }

    grid.jqGrid('setGridParam', {url: postUrl, page: 1, gridComplete: alertImportAdvanceCount}).trigger("reloadGrid");
}

function alertImportAdvanceCount(){
	var grid;
	
	if ($("#grid_list_import_advanced_payment_branch").length > 0) {
		grid = $("#grid_list_import_advanced_payment_branch");
	} else {
		grid = $("#grid_list_import_advanced_payment_main");
	}
	
	triggerAlertMessage(grid.jqGrid('getGridParam', 'records') + " record/s found.");
	grid.jqGrid('setGridParam', {gridComplete: ""});
}

function resetImportAdvance() {
	$("#cifNameSearch, #documentNumber, #amountFrom, #amountTo, #unitCode").val("");
    $("#currency").select2('data',null);

    var postUrl = searchImportAdvanceInquiry;
    postUrl += "?unitcode="+unitcode;
    
    var grid = null;
    
    if ($("#grid_list_import_advanced_payment_branch").length > 0) {
		grid = $("#grid_list_import_advanced_payment_branch");
	} else {
		grid = $("#grid_list_import_advanced_payment_main");
	}
    
    grid.jqGrid('setGridParam', {url: postUrl, page: 1}).trigger("reloadGrid");
}

function initImportAdvancePaymentGrid(){
	setupImportAdvancePaymentGrids();
	setupImportAdvancePaymentGridsValidation();
	
	$("#searchImportAdvance").click(searchImportAdvance);

    $("#resetImportAdvance").click(resetImportAdvance)
}

function refundImportAdvance(id) {
    var gotoUrl = refundImportAdvanceUrl;
    gotoUrl += "?referenceType=ets";
    gotoUrl += "&documentNumber="+id;
    location.href = gotoUrl;
}


$(initImportAdvancePaymentGrid);


