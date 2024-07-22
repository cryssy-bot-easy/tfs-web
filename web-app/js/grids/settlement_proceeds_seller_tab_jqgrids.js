function setupSettlementProceedsSellerGrid(){
	var var_grid_url = '',
	grid_url = '';
	
	setupJqGridWidthEditable('grid_list_settlement_proceeds_seller', {width: 780, scrollOffset: 0, loadui: "disable", loadComplete: setupSettlementProceedsSellerRates},
			[['rates', 'Rates', 10],
			['rateDescription', 'Rate Description', 25],
			['passOnRate', 'Pass-on Rate', 35, 'right'],
			['specialRate', 'Special Rate', 35, 'right']], var_grid_url, [2,3], [1,2,3], 'text');
	
	if($("#grid_list_settlement_proceeds_seller_payment_summary_dataentry").length > 0){
		setupJqGridWidthPagerHidden('grid_list_settlement_proceeds_seller_payment_summary_dataentry', {width: 780, height:"auto", loadui: "disable", scrollOffset:0, loadComplete: setupSettlementProceedsSellerPayment},
				[['accountNumber', 'Account Number', 14 ],
				['modeOfSettlement', 'Mode of Settlement', 14 ],
				['settlementCurrency', 'Settlement Currency', 14 ],
				['amount', 'Amount (in settlement currency)', 20, 'right' ],
				['edit','Edit', 3, 'center' ],
				['statusColCharges','Status', 6, 'center'],
				['buttonsColCharges','&#160;', 7, 'center']], grid_url);
	}
	if($("#grid_list_settlement_proceeds_seller_payment_summary_ets").length > 0){
		setupJqGridWidthPagerHidden('grid_list_settlement_proceeds_seller_payment_summary_ets', {width: 780, height:"auto", loadui: "disable", scrollOffset:0, loadComplete: setupSettlementProceedsSellerPayment},
				[['accountNumber', 'Account Number', 14 ],
				 ['modeOfSettlement', 'Mode of Settlement', 14 ],
				 ['settlementCurrency', 'Settlement Currency', 14 ],
				 ['amount', 'Amount (in settlement currency)', 20, 'right' ],
				 ['edit','Edit', 3, 'center' ],
				 ['deleteRow','Delete', 4, 'center' ]], grid_url);
	}
}

function initSettlementProceedsSellerGrid(){
	setupSettlementProceedsSellerGrid();
//	insertToSettlementProceedsSellerGrid();
}

function setupSettlementProceedsSellerRates() {
    if($("#grid_list_settlement_proceeds_seller").length > 0) {
        var forexdata = $("#grid_list_settlement_proceeds_seller").jqGrid("getRowData");
        $("#SettlementProceedsSellerRates").val(JSON.stringify(forexdata));
    }
}

function setupSettlementProceedsSellerPayment() {
	if($("#grid_list_settlement_proceeds_seller_payment_summary_dataentry").length > 0) {
		var proceedsdata = $("#grid_list_settlement_proceeds_seller_payment_summary_dataentry").jqGrid("getRowData");
		$("#SettlementProceedsSellerSummary").val(JSON.stringify(proceedsdata));
	}
	if($("#grid_list_settlement_proceeds_seller_payment_summary_ets").length > 0) {
		var proceedsdata = $("#grid_list_settlement_proceeds_seller_payment_summary_ets").jqGrid("getRowData");
		$("#SettlementProceedsSellerSummary").val(JSON.stringify(proceedsdata));
	}
	
	
}

//function insertToSettlementProceedsSellerGrid() {
//	var forex_cash = $("#grid_list_settlement_proceeds_seller");
//	forex_cash.addRowData("1",{rates: 'OFC-USD', rateDescription: 'USD - EUR (Bank Note-Sell)', passOnRate: '1.472464', specialRate: '1.472464'});
//	forex_cash.addRowData("2",{rates: 'OFC-PHP', rateDescription: 'PHP - EUR (Regular LC Sell)', passOnRate: '62.830039', specialRate: '62.830039'});
//	forex_cash.addRowData("3",{rates: 'USD-PHP', rateDescription: 'USD - PHP (Cash LC Sell)', passOnRate: '42.45', specialRate: '42.45'});
//	forex_cash.addRowData("4",{rates: 'URR', rateDescription: 'URR', passOnRate: '42.50', specialRate: '42.50'});
//
//	if($("#grid_list_settlement_proceeds_seller_payment_summary_dataentry").length > 0) {
//		var dataentryGrid = $("#grid_list_settlement_proceeds_seller_payment_summary_dataentry");
//		dataentryGrid.addRowData("1",{
//			accountNumber:'00-001-183625-3',
//			modeOfSettlement:'CASH',
//			settlementCurrency:'USD',
//			amount:'1,000,000.00',
//			edit:'<a href=\"javascript:void(0)\">edit</a>',
//			statusColCharges:"",
//			buttonsColCharges:"<input type=\"button\" class=\"input_button\" value=\"Settle\"/>"
//		});
//	}
//	if($("#grid_list_settlement_proceeds_seller_payment_summary_ets").length > 0) {
//		var etsGrid = $("#grid_list_settlement_proceeds_seller_payment_summary_ets");
//		etsGrid.addRowData("1",{
//			accountNumber:'00-001-183625-3',
//			modeOfSettlement:'CASH',
//			settlementCurrency:'USD',
//			amount:'1,000,000.00',
//			edit:'<a href=\"javascript:void(0)\">edit</a>',
//			deleteRow:'<a href=\"javascript:void(0)\">delete</a>'
//		});
//	}
//}

$(initSettlementProceedsSellerGrid);