function setupNegotiationPaymentSummaryGrid(){
	
//	**********************************************
//	*******FOR DOMESTIC NEGO PAYMENT SUMMARY******
//	**********************************************
	
	var negotiation_details_url="";
	
	setupJqGridPager('grid_list_negotiation_payment_summary', {width : 780, height: "auto", loadui: "disable", scrollOffset : 0, del:true},
			[ [ 'modeOfPayment', 'MODE OF PAYMENT' ],
			  [ 'settlementCurrency', 'SETTLEMENT CURRENCY' ],
			  [ 'amountSettlement', 'AMOUNT (in settlement currency)' ],
			  [ 'amountLc', 'AMOUNT (in Negotiation currency)' ],
			  [ 'editCashPayment', 'Edit' ],
			  [ 'deleteCashPayment', 'Delete' ]], negotiation_details_url);
	
}

//function fillNegoWithData(){
//	var negotiationGrid=$("#grid_list_negotiation_payment_summary");
//
//	negotiationGrid.addRowData("1",{
//		modeOfPayment:"CASA",
//		settlementCurrency:"USD",
//		amountSettlement:"1,000,000.00",
//		amountLc:"1,200,000.00",
//		editCashPayment:'<a href=\"javascript:void(0)\" class=\"edit1\">edit</a>',
//		deleteCashPayment:'<a href=\"javascript:void(0)\" class=\"delete1\" onclick=\"onClickDelete()\">delete</a>'});
//
//	negotiationGrid.addRowData("2",{
//		modeOfPayment:"CASA",
//		settlementCurrency:"USD",
//		amountSettlement:"1,000,000.00",
//		amountLc:"1,300,000.00",
//		editCashPayment:'<a href=\"javascript:void(0)\" class=\"edit1\">edit</a>',
//		deleteCashPayment:'<a href=\"javascript:void(0)\" class=\"delete1\" onclick=\"onClickDelete()\">delete</a>'});
//
//	negotiationGrid.addRowData("3",{
//		modeOfPayment:"CASA",
//		settlementCurrency:"USD",
//		amountSettlement:"1,000,000.00",
//		amountLc:"1,400,000.00",
//		editCashPayment:'<a href=\"javascript:void(0)\" class=\"edit1\">edit</a>',
//		deleteCashPayment:'<a href=\"javascript:void(0)\" class=\"delete1\" onclick=\"onClickDelete()\">delete</a>'});
//}


function initNegotiationPaymentSummaryGrid() {
	setupNegotiationPaymentSummaryGrid();
//	fillNegoWithData();
}

$(initNegotiationPaymentSummaryGrid);
