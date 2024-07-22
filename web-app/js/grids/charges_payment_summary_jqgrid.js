function disableChargesRatesTable() {
    if ($("#forex_charges").length > 0) {

        $("#forex_charges :input").attr("readonly", "readonly");
    }
}

function enableChargesRatesTable() {
    if ($("#forex_charges").length > 0) {

        $("#forex_charges :input").removeAttr("readonly");
    }
}

function setupChargesPaymentGrids(){
	var serviceChargesPaymentUrl = serviceChargeUrl;
	
//    var serviceChargesPaymentUrl = "";
	
    /*if(referenceType.toUpperCase() == "ETS" || referenceType.toUpperCase()=="DATA ENTRY") {
        setupJqGridWidthNoPagerHidden('grid_list_charges_payment', {height:90,width: 780, scrollOffset:0},
            [['accountNumber', 'Account Number', 120, 'left'],
                ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                ['amount', 'Amount (in settlement currency', 220, 'right'],
                ['deletePaymentSummary','Delete', 40, 'center' ],
                ['status','Status', 60, 'center'],
                ['pay','&nbsp;', 70, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden']
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden']], serviceChargesPaymentUrl);
    } else {	//Added by Arvin Guiam  << - PLEASE DO NOT UNDO MY CHANGES - MARVIN
    	setupJqGridWidthNoPagerHidden('grid_list_charges_payment', {width: 780, height:90, scrollOffset:0, loadComplete: setupChargesPayment},
                [['accountNumber', 'Account Number', 14 ],
                    ['modeOfPayment', 'Mode of Payment', 14 ],
                    ['settlementCurrency', 'Settlement Currency', 14 ],
                    ['amount', 'Amount (in settlement currency)', 20, 'right' ],
                    ['deletePaymentSummary','Delete', 4, 'center' ],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden']
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden']], serviceChargesPaymentUrl);
    }*/
	
    if(referenceType == "ETS") {
    	if(!windowed && userRole.indexOf("TSD") == -1 && userRole == "BRM" && (reverseEts == "false" || reverseEts == '')) {
			setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {width: 780, height:90, scrollOffset:0, loadui: "disable", loadComplete: setupChargesPayment, afterInsertRow: disableChargesRatesTable, gridComplete: chargesSettlementCurrency,
				shrinkToFit: false},
				[['accountNumber', 'Account Number', 150 ],
				 ['modeOfPayment', 'Mode of Payment', 150 ],
				 ['settlementCurrency', 'Settlement Currency', 150 ],
				 ['amount', 'Amount (in settlement currency)', 205, 'right' ],
				 ['deletePaymentSummary','Delete', 100, 'center' ],
				 ['paymentMode', 'Payment Mode', 4, 'left', 'hidden' ],
				 ['referenceId', 'referenceId', 4, 'left', 'hidden' ],
				 ['rates','Rates', 4, 'left', 'hidden' ],
				 ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden' ],
                 ['accountName','Account Name', 300 , 'center','hidden']], serviceChargesPaymentUrl);
    	} else {
			setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {width: 780, height:90, scrollOffset:0, loadui: "disable", loadComplete: setupChargesPayment, afterInsertRow: disableChargesRatesTable, gridComplete: chargesSettlementCurrency,
				shrinkToFit: false},
				[['accountNumber', 'Account Number', 150 ],
				['modeOfPayment', 'Mode of Payment', 150 ],
				['settlementCurrency', 'Settlement Currency', 150 ],
				['amount', 'Amount (in settlement currency)', 205, 'right' ],
				['deletePaymentSummary','Delete', 100, 'center' ],
				['paymentMode', 'Payment Mode', 4, 'left', 'hidden' ],
				['referenceId', 'referenceId', 4, 'left', 'hidden' ],
				['rates','Rates', 4, 'left', 'hidden' ],
				['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden' ],
                ['accountName','Account Name', 300 , 'center','hidden']], serviceChargesPaymentUrl);
    	}

    } else if(referenceType.toUpperCase() == "PAYMENT") {
        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupChargesPayment, gridComplete: function() {
        	showDebitMemo();
        	showPaymentSummary();
        	chargesSettlementCurrency();
        	enableDisableAccountingentriesLink();}, afterInsertRow: disableChargesRatesTable, shrinkToFit: false},
            [['accountNumber', 'Account Number', 135, 'left'],
                ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                ['deletePaymentSummary','Delete', 40, 'center' ],
                ['status','Status', 60, 'center'],
                ['pay','&nbsp;', 70, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['rates','Rates', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['accountName','Account Name', 300 , 'center','hidden']], serviceChargesPaymentUrl);
    } else if (referenceType == "DATA_ENTRY" && documentClass == "IMPORT_ADVANCE") {
        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupChargesPayment, gridComplete: showDebitMemo, afterInsertRow: disableChargesRatesTable},
            [['accountNumber', 'Account Number', 120, 'left'],
                ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                ['deletePaymentSummary','Delete', 40, 'center' ],
                ['status','Status', 60, 'center'],
                ['pay','&nbsp;', 70, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['rates','Rates', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['accountName','Account Name', 300 , 'center','hidden']], serviceChargesPaymentUrl);
    }
    
}

function setupChargesPayment() {
    if($("#grid_list_charges_payment").length > 0) {
        var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData");
        $("#chargesPaymentSummary").val(JSON.stringify(paymentsummarydata));

        if (paymentsummarydata.length > 0) {
            disableChargesRatesTable();
        }
    }

    var ids = $("#grid_list_charges_payment").jqGrid("getDataIDs");
    var totalPayments = 0;
    for(i in ids) {
        var data = $("#grid_list_charges_payment").jqGrid("getRowData",ids[i]);
        var amount;
        if(data.amount != undefined) {
            amount = stripCommas(data.amount);
        }else{
            amount = stripCommas(data.amountSettlement);
        }
        totalPayments += parseFloat(amount);
    }


    $("#totalAmountOfPaymentCharges").val(formatCurrency(totalPayments));
}

function initChargesPaymentGrid(){
	setupChargesPaymentGrids();

    // remove when backend is ready
//    setupChargesPayment();
}

$(initChargesPaymentGrid);

