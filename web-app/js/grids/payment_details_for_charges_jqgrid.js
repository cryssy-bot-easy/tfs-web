function modeOfPayment(){
	$("#popup_btn_mode_of_payment").click();
}

function modeOfPaymentMarineFireInsurance(){
	$("#popup_btn_mop_payment_details_for_charges").click();
}

function setupPaymentDetailsForChargesGrids() {
	var paymentDetailsForChargesUrl = '';
	var paymentDetailsForChargesUrl2 = '';
	var paymentDetailsForChargesMainUrl = '';

	setupJqGridWidth('grid_list_payment_details_for_charges', {width : 780, height: "auto",	loadui: "disable", scrollOffset : 0},
			[ [ 'dateOfTransaction', 'Date of Transaction', 100, 'center' ],
			[ 'transactionType', 'Transaction Type', 133, 'left' ],
			[ 'chargeType', 'Charge Type', 120, 'left' ],
			[ 'settlementCurrency', 'Settlement Currency', 102, 'center' ],
			[ 'oldAmonut', 'Old Amount', 95, 'right' ], [ 'newAmount', 'New Amount', 95, 'right' ],
			[ 'amountDue', 'Amount Due', 95, 'right' ], [ 'delete1', 'Delete', 40, 'center'] ],
			'grid_pager_payment_details_for_charges',
			paymentDetailsForChargesUrl);
	
	setupJqGridPager('grid_list_payment_details_for_charges2', {width : 780, height: "auto", loadui: "disable", scrollOffset : 0},
			[ [ 'accountNumber', 'ACCOUNT NUMBER' ],
			[ 'modeOfPayment', 'MODE OF PAYMENT' ],
			[ 'settlementCurrency2', 'SETTLEMENT CURRENCY' ],
			[ 'amount', 'AMOUNT' ],
			[ 'edit', 'Edit' ], [ 'status', 'Status' ], [ 'action', '&nbsp;' ] ],
			'grid_pager_payment_details_for_charges2',
			paymentDetailsForChargesUrl);
	
	setupJqGridPager('grid_list_payment_details_for_charges_main', {
		width : 780, height: "auto",
		loadui: "disable", 
		scrollOffset : 0
	}, [ [ 'accountNumber_main', 'ACCOUNT NUMBER' ],
	     [ 'chargeType_main', 'CHARGE TYPE' ],
			[ 'modeOfPayment_main', 'MODE OF PAYMENT' ],			
			[ 'amount_main', 'AMOUNT' ],
			[ 'edit_main', 'Edit' ], [ 'status_main', 'Status' ], [ 'action_main', '&nbsp;' ] ],
			'grid_pager_payment_details_for_charges_main',
			paymentDetailsForChargesMainUrl);

	// STATIC DATA Payment Summary of Other Charges Due
//	var paymentDetailsForChargesGrid = $("#grid_list_payment_details_for_charges");
//	paymentDetailsForChargesGrid.addRowData("1", {dateOfTransaction : "03/02/2012",	transactionType : "FX Cash LC Opening",	chargeType : "Bank Commission",	settlementCurrency : "PHP",	oldAmonut : "&nbsp;", newAmount : "&nbsp;",	amountDue : "&nbsp;", delete1 : "<a href='javascript:void(0)' style=\"color: red; text-decoration: none;\">delete</a>"});
//	paymentDetailsForChargesGrid.addRowData("2", {dateOfTransaction : "03/02/2012",	transactionType : "FX Cash LC Opening",	chargeType : "Commitment Fee", settlementCurrency : "PHP", oldAmonut : "&nbsp;", newAmount : "&nbsp;", amountDue : "&nbsp;", delete1 : "<a href='javascript:void(0)' style=\"color: red; text-decoration: none;\">delete</a>"});
//	paymentDetailsForChargesGrid.addRowData("3", {dateOfTransaction : "03/02/2012",	transactionType : "FX Cash LC Opening",	chargeType : "CILEX", settlementCurrency : "PHP", oldAmonut : "&nbsp;",	newAmount : "&nbsp;", amountDue : "&nbsp;",	delete1 : "<a href='javascript:void(0)' style=\"color: red; text-decoration: none;\">delete</a>"});
//	paymentDetailsForChargesGrid.addRowData("4", {dateOfTransaction : "03/02/2012",	transactionType : "FX Cash LC Opening",	chargeType : "Documentary Stamps", settlementCurrency : "PHP", oldAmonut : "&nbsp;", newAmount : "&nbsp;", amountDue : "&nbsp;", delete1 : "<a href='javascript:void(0)' style=\"color: red; text-decoration: none;\">delete</a>"});
//
//	// STATIC DATA Payment Summary for Additional LC and Charges
//	var paymentDetailsForChargesGrid2 = $("#grid_list_payment_details_for_charges2");
//	paymentDetailsForChargesGrid2.addRowData("1", {accountNumber : "&nbsp;", modeOfPayment : "MC", settlementCurrency2 : "PHP",	amount : "&nbsp;", edit : "<a href='javascript:void(0)' onclick=\"modeOfPayment()\">Edit</a>", status : "&nbsp;", action : "<button class=\"input_button button_override\">Pay</button>"});
//	paymentDetailsForChargesGrid2.addRowData("2", {accountNumber : "00-001-183625-8", modeOfPayment : "CASA", settlementCurrency2 : "PHP", amount : "&nbsp;", edit : "<a href='javascript:void(0)' onclick=\"modeOfPayment()\">Edit</a>", status : "&nbsp;",	action : "<button class=\"input_button button_override\">Pay</button>"});
//	paymentDetailsForChargesGrid2.addRowData("3", {accountNumber : "&nbsp;", modeOfPayment : "&nbsp;", settlementCurrency2 : "&nbsp;", amount : "&nbsp;", edit : "&nbsp;", status : "&nbsp;", action : "<button class=\"input_button button_override\">Pay</button>"});
//
//	// STATIC DATA Payment Summary for Additional LC and Charges for TSD
//	var paymentDetailsForChargesMainGrid = $("#grid_list_payment_details_for_charges_main");
//	paymentDetailsForChargesMainGrid.addRowData("1", {accountNumber_main : "00-001-183625-3", chargeType_main : "Bank Commission", modeOfPayment_main : "CASA", amount_main : "1,000.00", edit_main : "<a href='javascript:void(0)' onclick=\"modeOfPaymentMarineFireInsurance()\">Edit</a>", status_main : "&nbsp;", action_main : "<button class=\"input_button button_override\">Pay</button>"});
//	paymentDetailsForChargesMainGrid.addRowData("2", {accountNumber_main : "&nbsp;", chargeType_main : "Bank Commission", modeOfPayment_main : "CASH", amount_main : "1,000.00", edit_main : "<a href='javascript:void(0)' onclick=\"modeOfPaymentMarineFireInsurance()\">Edit</a>", status_main : "&nbsp;", action_main : "<button class=\"input_button button_override\">Pay</button>"});
//	paymentDetailsForChargesMainGrid.addRowData("3", {accountNumber_main : "00-001-183625-8", chargeType_main : "Marine/Fire Insurance", modeOfPayment_main : "CASA", amount_main : "1,000.00",	edit_main : "<a href='javascript:void(0)' onclick=\"modeOfPaymentMarineFireInsurance()\">Edit</a>",	status_main : "&nbsp;",	action_main : "<button class=\"input_button button_override\">Pay</button>"});

}

function initPaymentDetailsForChargesGrid() {
	setupPaymentDetailsForChargesGrids();
}

$(initPaymentDetailsForChargesGrid);
