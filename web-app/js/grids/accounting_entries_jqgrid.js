//function initializeAccountingEntriesImports() {
//	var jqgrid_src = document.createElement('script');
//	jqgrid_src.src = 'js/jqgrid-utils.js';
//}

function displayGltsCreditDebit() {
	var data = $("#grid_list_accounting_entries").getGridParam("userData");

    $("#gltsNumber").val(data.gltsNumber);
    $("#totalCredit").val(data.totalCredit);
    $("#totalDebit").val(data.totalDebit);
    $("#totalCreditBase").val(data.totalCreditBase);
    $("#totalDebitBase").val(data.totalDebitBase);
}

function setupAccountingEntriesTypeGrids() {
	setupJqGridWidthPagerHidden('grid_list_accounting_entries', {
		width : 950, height: 250,
		scrollOffset : 0,
        userDataOnFooter: true,
        loadui: "disable",
        gridComplete: displayGltsCreditDebit
	}, [ [ 'transactionBranch', 'Transaction Branch ', 40, 'left' ],
			[ 'respondingBranch', 'Responding Branch', 40, 'left', 'hidden'],
			[ 'bookCode', 'Book Code', 40, 'left'],
			[ 'glCode', 'GL Code', 80, 'left'],
			[ 'accountingDescription', 'Accounting Description', 190, 'left' ],
			[ 'bookingCurrency', 'Booking CCY', 85, 'center' ],
			[ 'dbtOriginalAmount', 'Debit Orig Amt', 100, 'right'],
			[ 'cdtOriginalAmount', 'Credit Orig Amt', 100, 'right'],
			[ 'dbtBaseAmount', 'Debit Base Amt', 100, 'right'],
			[ 'cdtBaseAmount', 'Credit Base Amt', 100, 'right'],
			//[ 'gltsNumber', 'GLTS Number', 85, 'center']],'grid_pager_accounting_entries');
			[ 'gltsNumber', 'GLTS Number', 85, 'center', 'hidden']],'grid_pager_accounting_entries', accountingEntriesUrl);

}

function initAccountingEntriesTypeGrid() {
//	initializeAccountingEntriesImports();
	setupAccountingEntriesTypeGrids();
}


$(initAccountingEntriesTypeGrid);
