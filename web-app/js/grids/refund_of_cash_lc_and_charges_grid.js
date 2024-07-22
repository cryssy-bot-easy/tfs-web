function initializeRefundOfCashLcAndChargesGrid() {
	var jqgrid_src = document.createElement('script');
	jqgrid_src.src = 'js/jqgrid-utils.js';    
	jqgrid_src.type='text/javascript';
}

function setupRefundOfCashLcAndChargesGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_partial_amount_for_refund', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['passOnRate', 'Pass-on Rate'],
			['specialRate', 'Special Rate']], var_grid_url, [2,3], [1,2,3], 'text');
}

function setupUpdateCashLcGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_update_cash_lc_popup', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [2,3,4,5], [1,2,3], 'text');
}

function setupRefundDetailsSummaryCashLc(){
	var grid_url='';
	
	setupJqGridPager('grid_list_refund_details_summary_cash_lc', {width: 780,height:"auto", loadui: "disable", scrollOffset:0},
			[['transactionDate', 'Transaction Date'],
			['transactionType', 'Transaction Type'],
			['currency', 'LC Currency'],
			['osLcAmount', 'O/S LC Amount'],
			['specialRate', 'Special Rate'],
			['settlementCurrency', 'Settlement Currency'],
			['settlementAmount', 'Settlement Amount'],
			['newAmount', 'New Amount'],
			['refundAmountSettlement', 'Refund Amount(Settlement Currency)'],
			['refundAmountLc', 'Refund Amount (LC Currency)']], 'grid_pager_refund_details_summary_cash_lc', grid_url);
}

function setupRefundDetailsSummaryCharges(){
	var grid_url='';
	
	setupJqGridPager('grid_list_refund_details_summary_charges', {width: 780,height:"auto", loadui: "disable", scrollOffset:0},
			[['transactionDate', 'Transaction Date'],
			['transactionType', 'Transaction Type'],
			['chargeType', 'Charge Type'],
			['settlementCurrency', 'Settlement Currency'],
			['oldAmount', 'Old Amount'],
			['newAmount', 'New Amount'],
			['refundAmount', 'Refund Amount'],
			['deleteRow', 'Delete']], 'grid_pager_refund_details_summary_charges', grid_url);
}

function setupModeOfRefundForex(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_mode_of_refund', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['passOnRate', 'Pass-on Rate'],
			['specialRate', 'Special Rate']], var_grid_url, [2,3], [1,2,3], 'text');
}

function setupRefundSummaryCharges(){
	var grid_url='';
	
	setupJqGridPager('grid_list_refund_summary_charges', {width: 780, height:"auto" , loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number'],
			['modeOfPayment', 'Mode of Payment'],
			['refundCurrency', 'Refund Currency'],
			['amount', 'Amount'],
			['editRow', 'Edit'],
			['deleteRow', 'Delete']], '', grid_url);
}

function setupRefundSummaryChargesWithStatus(){
	var grid_url='';
	
	setupJqGridPager('grid_list_refund_summary_charges_with_status', {width: 780, height:"auto" , loadui: "disable", scrollOffset:0},
			[['accountNumber', 'Account Number'],
			['modeOfPayment', 'Mode of Payment'],
			['refundCurrency', 'Refund Currency'],
			['amount', 'Amount'],
			['editRow', 'Edit'],
			['statusRow', 'Status'],
			['buttonRow', '&nbsp;']], '', grid_url);
}

/*
REFUND DETAILS FOR CHARGES
*/
function setupRefundTransactionTypeFxlcOpeningGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_opening', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionDmlcOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_opening', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionFxlcAdjustmentTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_adjustment', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionFxlcAmendmentTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_amendment', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionDmlcAmendmentTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_amendment', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionFxlcNegotiationTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_negotiation', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionDmlcNegotiationTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_negotiation', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionBgbeIssuanceTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_bgbe_issuance', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionBgbeCancellationTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_bgbe_cancellation', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionFxNonLcSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fx_non_lc_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupRefundTransactionDmNonLcSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dm_non_lc_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}
/*
	----END REFUND DETAILS FOR CHARGES
*/

//TEMP TEMP TEMP
//TEMP TEMP TEMP
//TEMP TEMP TEMP
//TEMP TEMP TEMP

function setupFxlcCashOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_opening_cash', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxlcRegularOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_opening_regular', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxlcStandbyOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fxlc_opening_standby', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupDmlcCashOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_opening_cash', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupDmlcRegularOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_opening_regular', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupDmlcStandbyOpeningTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_dmlc_opening_standby', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxNonLcDaSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fx_non_lc_da_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxNonLcDpSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fx_non_lc_dp_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxNonLcDrSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fx_non_lc_dr_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

function setupFxNonLcOaSettlementTypeGrid(){
	var var_grid_url = '';
	
	setupJqGridWithEditable('grid_list_refund_transaction_type_fx_non_lc_oa_settlement', {width: 780, height: "auto", loadui: "disable", scrollOffset: 0},
			[['rates', 'Rates'],
			['rateDescription', 'Rate Description'],
			['oldPassOnRate', 'Old Pass-on Rate'],
			['newPassOnRate', 'New Pass-on Rate'],
			['oldspecialRate', 'Old Special Rate'],
			['newSpecialRate', 'New Special Rate']], var_grid_url, [3,5], [1,2,3], 'text');
}

//TEMP TEMP TEMP
//TEMP TEMP TEMP
//TEMP TEMP TEMP
//TEMP TEMP TEMP

function initRefundOfCashLcAndChargesGrid() {
	initializeRefundOfCashLcAndChargesGrid();
	setupRefundOfCashLcAndChargesGrid();
	setupUpdateCashLcGrid();
	setupRefundDetailsSummaryCashLc();
	setupRefundDetailsSummaryCharges();
	setupModeOfRefundForex();
	setupRefundSummaryCharges();
	setupRefundSummaryChargesWithStatus();
	
	setupRefundTransactionTypeFxlcOpeningGrid();
	setupRefundTransactionDmlcOpeningTypeGrid();
	setupRefundTransactionFxlcAdjustmentTypeGrid();
	setupRefundTransactionFxlcAmendmentTypeGrid();
	setupRefundTransactionDmlcAmendmentTypeGrid();
	setupRefundTransactionFxlcNegotiationTypeGrid();
	setupRefundTransactionDmlcNegotiationTypeGrid();
	setupRefundTransactionBgbeIssuanceTypeGrid();
	setupRefundTransactionBgbeCancellationTypeGrid();
	setupRefundTransactionFxNonLcSettlementTypeGrid();
	setupRefundTransactionDmNonLcSettlementTypeGrid();
	
	
	//TEMP
	
	setupFxlcCashOpeningTypeGrid();
	setupFxlcRegularOpeningTypeGrid();
	setupFxlcStandbyOpeningTypeGrid();
	setupDmlcCashOpeningTypeGrid();
	setupDmlcRegularOpeningTypeGrid();
	setupDmlcStandbyOpeningTypeGrid();
	
	setupFxNonLcOaSettlementTypeGrid();
	setupFxNonLcDaSettlementTypeGrid();
	setupFxNonLcDpSettlementTypeGrid();
	setupFxNonLcDrSettlementTypeGrid();
	
//	var gridT=$("#grid_list_refund_transaction_type_fxlc_opening_cash," +
//			"#grid_list_refund_transaction_type_fxlc_opening_regular," +
//			"#grid_list_refund_transaction_type_fxlc_opening_standby," +
//			"#grid_list_refund_transaction_type_dmlc_opening_cash," +
//			"#grid_list_refund_transaction_type_dmlc_opening_standby," +
//			"#grid_list_refund_transaction_type_dmlc_opening_regular," +
//			"#grid_list_refund_transaction_type_fx_non_lc_oa_settlement," +
//			"#grid_list_refund_transaction_type_fx_non_lc_da_settlement," +
//			"#grid_list_refund_transaction_type_fx_non_lc_dr_settlement," +
//			"#grid_list_refund_transaction_type_fx_non_lc_dp_settlement");
//
//	gridT.addRowData("1",{rates:"OFC-USD",rateDescription:"USD - EUR (Bank Note Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	gridT.addRowData("2",{rates:"OFC-PHP",rateDescription:"PHP - EUR (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	gridT.addRowData("3",{rates:"USD-PHP",rateDescription:"USD - PHP (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	gridT.addRowData("4",{rates:"USD-USD",rateDescription:"URR",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//
//	//---TEMP
//
//
//	var grid=$("#grid_list_partial_amount_for_refund,#grid_list_mode_of_refund");
//	grid.addRowData("1",{rates:"OFC-USD",rateDescription:"USD - EUR (Bank Note Sell)",passOnRate:"1.472464",specialRate:"1.472464"});
//	grid.addRowData("2",{rates:"OFC-PHP",rateDescription:"PHP - EUR (Regular LC Sell)",passOnRate:"62.830039",specialRate:"62.830039"});
//	grid.addRowData("3",{rates:"USD-PHP",rateDescription:"USD - PHP (Regular LC Sell)",passOnRate:"42.64",specialRate:"42.64"});
//	grid.addRowData("4",{rates:"USD-USD",rateDescription:"URR",passOnRate:"42.64",specialRate:"42.64"});
//
//	var grid2=$("#grid_list_update_cash_lc_popup," +
//			"#grid_list_refund_transaction_type_fxlc_opening," +
//			"#grid_list_refund_transaction_type_dmlc_opening," +
//			"#grid_list_refund_transaction_type_fxlc_adjustment," +
//			"#grid_list_refund_transaction_type_fxlc_amendment," +
//			"#grid_list_refund_transaction_type_dmlc_amendment," +
//			"#grid_list_refund_transaction_type_fxlc_negotiation," +
//			"#grid_list_refund_transaction_type_dmlc_negotiation," +
//			"#grid_list_refund_transaction_type_bgbe_cancellation," +
//			"#grid_list_refund_transaction_type_fx_non_lc_settlement," +
//			"#grid_list_refund_transaction_type_dm_non_lc_settlement," +
//			"#grid_list_refund_transaction_type_bgbe_issuance");
//
//	grid2.addRowData("1",{rates:"OFC-USD",rateDescription:"USD - EUR (Bank Note Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("2",{rates:"OFC-PHP",rateDescription:"PHP - EUR (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("3",{rates:"USD-PHP",rateDescription:"USD - PHP (Regular LC Sell)",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//	grid2.addRowData("4",{rates:"USD-USD",rateDescription:"URR",oldPassOnRate:"1.472464",newPassOnRate:"",oldSpecialRate:"1.472464",newSpecialRate:""});
//
//	var grid3=$("#grid_list_refund_details_summary_cash_lc");
//	grid3.addRowData("1",{transactionDate:"",transactionType:"Opening",currency:"EUR",osLcAmount:"100",specialRate:"",settlementCurrency:"EUR",settlementAmount:"100",newAmount:"",refundAmountSettlement:"",refundAmountLc:""})
//	grid3.addRowData("2",{transactionDate:"",transactionType:"Opening",currency:"EUR",osLcAmount:"10000",specialRate:"",settlementCurrency:"EUR",settlementAmount:"10000",newAmount:"",refundAmountSettlement:"",refundAmountLc:""})
//
//	var grid4=$("#grid_list_refund_details_summary_charges");
//	grid4.addRowData("1",{transactionDate:"03/02/2012",transactionType:"FXLC Cash Opening",chargeType:"Bank Commission",settlementCurrency:"PHP",oldAmount:"",newAmount:"",refundAmount:"",deleteRow:"X"});
//	grid4.addRowData("2",{transactionDate:"03/02/2012",transactionType:"FXLC Cash Opening",chargeType:"Commitment Fee",settlementCurrency:"PHP",oldAmount:"",newAmount:"",refundAmount:"",deleteRow:"X"});
//	grid4.addRowData("3",{transactionDate:"03/02/2012",transactionType:"FXLC Cash Opening",chargeType:"CILEX",settlementCurrency:"PHP",oldAmount:"",newAmount:"",refundAmount:"",deleteRow:"X"});
//	grid4.addRowData("4",{transactionDate:"03/02/2012",transactionType:"FXLC Cash Opening",chargeType:"Documentary Stamps",settlementCurrency:"PHP",oldAmount:"",newAmount:"",refundAmount:"",deleteRow:"X"});
//
//	var grid5=$("#grid_list_refund_summary_charges");
//	grid5.addRowData("1",{accountNumber:"00-001-183625-3",modeOfPayment:"CASA",refundCurrency:"PHP",amount:"200.00",editRow:"edit",deleteRow:"X"});
//
//	var grid6=$("#grid_list_refund_summary_charges_with_status");
//	grid6.addRowData("1",{accountNumber:"00-001-183625-3",modeOfPayment:"CASA",refundCurrency:"PHP",amount:"200.00",editRow:"edit",statusRow:"Paid",buttonRow:"<input type='button' class='input_button button_override' value='EC' name='ecButton'/>"});
//	grid6.addRowData("2",{accountNumber:"00-001-183625-3",modeOfPayment:"CASA",refundCurrency:"PHP",amount:"200.00",editRow:"edit",statusRow:"Paid",buttonRow:"<input type='button' class='input_button button_override' value='Reverse' name='reverseButton'/>"});
//	grid6.addRowData("3",{accountNumber:"00-001-183625-3",modeOfPayment:"CASA",refundCurrency:"PHP",amount:"200.00",editRow:"edit",statusRow:"Not Paid",buttonRow:"<input type='button' class='input_button button_override' value='Post Credit' name='pcButton'/>"});
		
}

$(initRefundOfCashLcAndChargesGrid);