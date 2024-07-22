function setupExportAdvanceRefundGrids(){
	var exportAdvanceRefundGridUrl = '';
	if (referenceType.toLowerCase() == 'ets'){
		setupJqGridPagerWithHidden('grid_list_export_advance_refund', {height:25,width: 780, loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number','center'],
			['modeOfPayment', 'Mode of Payment','center'],
			['exportAdvanceCurrency', 'Export Advance Currency','center'],
			['exportAdvanceAmount','Export Advance Amount','right'],
			['settlementCurrency', 'Settlement Currency','center'],
			['amount', 'Amount','right'],
			//['edit','Edit'],
			['deleteExportAdvanceRefund','Delete','center'],
			['status','Status', 10, 'left','hidden'],
			['action',' ', 10, 'left','hidden']], 'grid_pager_export_advance_payment', exportAdvanceRefundGridUrl); //hide action if branch users
	}else if(referenceType.toLowerCase() == 'data entry'){
		setupJqGridPagerWithHidden('grid_list_export_advance_refund', {height:25,width: 780, loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number','center'],
			['modeOfPayment', 'Mode of Payment','center'],
			['exportAdvanceCurrency', 'Export Advance Currency','center'],
			['exportAdvanceAmount','Export Advance Amount','right'],
			['settlementCurrency', 'Settlement Currency','center'],
			['amount', 'Amount','right'],
			//['edit','Edit'],
			['status','Status','center'],
			['action',' ','center'],
			['deleteExportAdvanceRefund','Delete', 10, 'left','hidden']], 'grid_pager_export_advance_payment', exportAdvanceRefundGridUrl);
	}
}

function initExportAdvanceRefundGrid(){
	setupExportAdvanceRefundGrids();

//	var exportAdvanceRefundGrid=$("#grid_list_export_advance_refund");
//	exportAdvanceRefundGrid.addRowData("1",{
//		accountNumber:'100-000-000',
//		modeOfPayment:'CASA',
//		exportAdvanceCurrency: 'USD',
//		exportAdvanceAmount: '200',
//		settlementCurrency:'USD',
//		amount:'1,000,000.00',
//		//edit:'<a href=\"javascript:void(0)\">edit</a>',
//		deleteExportAdvanceRefund:'<a href=\"#\">delete</a>',
//		status: "Unpaid",
//		action: '<button class=\"input_button button_override\">Settle</button>'
//	});

}

$(initExportAdvanceRefundGrid);
