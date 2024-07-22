function initializePaymentDetailsForChargesImports() {
	var jqgrid_src = document.createElement('script');
	jqgrid_src.src = 'js/jqgrid-utils.js';
}

function modeOfPayment(){
	$("#popup_btn_mode_of_payment").click();
}

function setupPaymentDetailsForChargesGrids() {
	var paymentDetailsForChargesUrl = '';

	setupJqGridPager('grid_list_payment_details_for_charges', {
		width : 780, height: "auto",
		loadui: "disable", 
		scrollOffset : 0
	}, [ [ 'dateOfTransaction', 'Date of Transaction' ],
			[ 'transactionType', 'Transaction Type' ],
			[ 'chargeType', 'Charge Type' ],
			[ 'settlementCurrency', 'Settlement Currency' ],
			[ 'oldAmonut', 'Old Amount' ], [ 'newAmount', 'New Amount' ],
			[ 'amountDue', 'Amount Due' ], [ 'delete1', 'Delete' ] ],
			'grid_pager_payment_details_for_charges',
			paymentDetailsForChargesUrl);

//	// STATIC DATA Payment Summary of Other Charges Due
//	var paymentDetailsForChargesGrid = $("#grid_list_payment_details_for_charges");
//	paymentDetailsForChargesGrid.addRowData("1", {
//		dateOfTransaction : "03/02/2012",
//		transactionType : "FX Cash LC Opening",
//		chargeType : "Bank Commission",
//		settlementCurrency : "PHP",
//		oldAmonut : "&nbsp;",
//		newAmount : "&nbsp;",
//		amountDue : "&nbsp;",
//		delete1 : "<a href='#' style=\"color: red; text-decoration: none;\">X</a>"
//	});
//	paymentDetailsForChargesGrid.addRowData("2", {
//		dateOfTransaction : "03/02/2012",
//		transactionType : "FX Cash LC Opening",
//		chargeType : "Commitment Fee",
//		settlementCurrency : "PHP",
//		oldAmonut : "&nbsp;",
//		newAmount : "&nbsp;",
//		amountDue : "&nbsp;",
//		delete1 : "<a href='#' style=\"color: red; text-decoration: none;\">X</a>"
//	});
//	paymentDetailsForChargesGrid.addRowData("3", {
//		dateOfTransaction : "03/02/2012",
//		transactionType : "FX Cash LC Opening",
//		chargeType : "CILEX",
//		settlementCurrency : "PHP",
//		oldAmonut : "&nbsp;",
//		newAmount : "&nbsp;",
//		amountDue : "&nbsp;",
//		delete1 : "<a href='#' style=\"color: red; text-decoration: none;\">X</a>"
//	});
//	paymentDetailsForChargesGrid.addRowData("4", {
//		dateOfTransaction : "03/02/2012",
//		transactionType : "FX Cash LC Opening",
//		chargeType : "Documentary Stamps",
//		settlementCurrency : "PHP",
//		oldAmonut : "&nbsp;",
//		newAmount : "&nbsp;",
//		amountDue : "&nbsp;",
//		delete1 : "<a href='#' style=\"color: red; text-decoration: none;\">X</a>"
//	});

}

function initPaymentDetailsForChargesGrid() {
	initializePaymentDetailsForChargesImports();
	setupPaymentDetailsForChargesGrids();
}

$(initPaymentDetailsForChargesGrid);
