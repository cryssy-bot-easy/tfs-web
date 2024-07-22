function setupImportAdvancePaymentGrids(){
	var importAdvancePaymentGridUrl = '';
	
	setupJqGridPager('grid_list_import_advance_payment', {height:71,width: 780, loadui: "disable", scrollOffset:0},
					[['accountNumber', 'Account Number'],
					['modeOfPayment', 'Mode of Payment'],
					['settlementCurrency', 'Settlement Currency'],
					['amount', 'Import Advance Amount'],
					['editImportAdvancePayment','Edit'],
					['deleteImportAdvancePayment','Delete']], 'grid_pager_import_advance_payment', importAdvancePaymentGridUrl);
}

function initImportAdvancePaymentGrid(){
	setupImportAdvancePaymentGrids();
	
//	var importAdvanceGrid=$("#grid_list_import_advance_payment");
//
//	importAdvanceGrid.addRowData("1",{accountNumber:'000-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',editImportAdvancePayment:'<a href=\"#\">edit</a>',deleteImportAdvancePayment:'<a href=\"#\">delete</a>'});
//	importAdvanceGrid.addRowData("2",{accountNumber:'000-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',editImportAdvancePayment:'<a href=\"#\">edit</a>',deleteImportAdvancePayment:'<a href=\"#\">delete</a>'});
//	importAdvanceGrid.addRowData("3",{accountNumber:'000-000-000',modeOfPayment:'CASH',settlementCurrency:'USD',amount:'1,000,000.00',editImportAdvancePayment:'<a href=\"#\">edit</a>',deleteImportAdvancePayment:'<a href=\"#\">delete</a>'});
}

$(initImportAdvancePaymentGrid);

