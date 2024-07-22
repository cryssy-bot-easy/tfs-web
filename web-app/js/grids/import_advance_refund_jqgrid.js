function setupImportAdvanceRefundGrids(){
	var importAdvanceRefundGridUrl = '';
	
	setupJqGridPager('grid_list_import_advance_refund', {height:"auto",width: 780, loadui: "disable", scrollOffset:0},
					[['accountNumberRefund', 'Account Number'],
					['modeOfPaymentRefund', 'Mode of Payment'],
					['settlementCurrencyRefund', 'Settlement Currency'],
					['refund', 'Import Advance Refund'],
					['editRefund','Edit'],
					['deleteRefund','Delete']], 'grid_pager_import_advance_refund', importAdvanceRefundGridUrl);
}

function initImportAdvanceRefundGrid(){
	setupImportAdvanceRefundGrids();
	
//	var chargesGrid=$("#grid_list_import_advance_refund");
	
//	chargesGrid.addRowData("1",{accountNumberRefund:'000-000-000',modeOfPaymentRefund:'CASH',settlementCurrencyRefund:'USD',refund:'1,000,000.00',editRefund:'<a href=\"#\">edit</a>',deleteRefund:'<a href=\"#\">delete</a>'});
}

$(initImportAdvanceRefundGrid);

