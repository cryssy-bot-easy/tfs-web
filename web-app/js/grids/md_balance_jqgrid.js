function getMdBalance() {
    var id = $("#grid_list_md_application").jqGrid("getGridParam", "selrow");

    var gridData = $("#grid_list_md_application").jqGrid("getRowData", id);

    $("#mdSettlementCurrency").val(gridData.mdSettlementCurrency);
    $("#mdAmountPaid").val(gridData.mdAmountPaid);
}

function clearMdApplication() {
    $("#mdSettlementCurrency").val("");
    $("#mdAmountPaid").val("");
}

function setupMdApplicationGrids() {
	var mdApplicationUrl = outstandingBalanceGridUrl;

	setupJqGridPager('grid_list_md_application', {width : 330, scrollOffset : 0, onSelectRow: getMdBalance, loadui: "disable", loadComplete: clearMdApplication},
        [[ 'mdSettlementCurrency', 'MD Settlement Currency' ],
		 [ 'mdAmountPaid', 'MD Amount Paid' ]],'grid_pager_md_application', mdApplicationUrl);
}

//function insertStaticMdApplication() {
//    // STATIC DATA
//    var mdApplicationGrid = $("#grid_list_md_application");
//
//    mdApplicationGrid.addRowData("1", {
//        mdSettlementCurrency : "PHP",
//        mdAmountPaid :"20,000.00"
//    });
//
//    mdApplicationGrid.addRowData("2", {
//        mdSettlementCurrency : "USD",
//        mdAmountPaid : "1,000.00"
//    });
//
//    mdApplicationGrid.addRowData("3", {
//        mdSettlementCurrency : "EUR",
//        mdAmountPaid : "500.00"
//    });
//}

function initMdApplicationGrid() {
	setupMdApplicationGrids();
//    insertStaticMdApplication();
}

$(initMdApplicationGrid);
