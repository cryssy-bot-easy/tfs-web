function disableRatesTable() {
    if ($("#forex_product").length > 0) {
        $("#forex_product :input").attr("readonly", "readonly");
    }
//
//    if ($("#forex_charges").length > 0) {
//        $("#forex_charges :input").attr("readonly", "readonly");
//    }
}

function enableRatesTable() {
    if ($("#forex_product").length > 0) {
        $("#forex_product :input").removeAttr("readonly");
    }
//
//    if ($("#forex_charges").length > 0) {
//        $("#forex_charges :input").attr("readonly", "readonly");
//    }
}

function setupCashGrids(){
	/*var var_grid_url = foreignExchangeUrl;
	
	if (windowed){
		setupJqGridWidth('grid_list_cash_forex', {width: 780, scrollOffset: 0, loadComplete: setupForeignExchangeRatesLc},
			[['rates', 'Rates', 10],
			 ['rateDescription', 'Rate Description', 25],
			 ['passOnRate', 'Pass-on Rate', 35, 'right'],
			 ['specialRate', 'Special Rate', 35, 'right']], var_grid_url);
	}else {
		setupJqGridWidthEditable('grid_list_cash_forex', {width: 780, scrollOffset: 0, loadComplete: setupForeignExchangeRatesLc},
			[['rates', 'Rates', 10],
			['rateDescription', 'Rate Description', 25],
			['passOnRate', 'Pass-on Rate', 35, 'right'],
			['specialRate', 'Special Rate', 35, 'right']], var_grid_url, [2,3], [1,2,3], 'text');
	}*/
	var productChargesPaymentUrl = productChargeUrl;
//    var productChargesPaymentUrl = "";
//    alert(documentClass + "\n" + serviceType + "\n" + referenceType)
    if(referenceType == "ETS") {
    	
        if(serviceType.toUpperCase() == "NEGOTIATION" || serviceType.toUpperCase() == "UA LOAN SETTLEMENT" || serviceType.toUpperCase() == "UA_LOAN_SETTLEMENT") { // special case for negotiation
        	
        	if (documentType == "DOMESTIC") {
        		if(userRole.indexOf("TSD") == -1){
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: function() {
                	viewLoanDetailsTab();
                	if(serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT" ||
        			(documentClass == "LC" && (serviceType == "Negotiation" || serviceType == "NEGOTIATION") &&
					(documentSubType1 == "STANDBY" || (documentSubType1 == "REGULAR" && documentSubType2 == "SIGHT")))) {
                		if('undefined' !== typeof proceedsSummaryViewChargesTab){
                			proceedsSummaryViewChargesTab();
                		}
                	}}, afterInsertRow: disableRatesTable},
                    [   ['accountNumber', 'Account Number', 1, 'center'],
                        [ 'modeOfPayment', 'Mode of Payment', 1 ],
                        [ 'settlementCurrency', 'Settlement Currency', 1 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 1, 'right' ],
                        ['deletePaymentSummary','Delete', 1, 'center' ],
                        ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 1, 'center', 'hidden'],
                        ['accountNumber', 'Account Number', 1, 'center','hidden'],
                        ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['amount', 'Amount', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        		} else {
        			setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: viewLoanDetailsTab, afterInsertRow: disableRatesTable},
                    [   ['accountNumber', 'Account Number', 1, 'center'],
                        [ 'modeOfPayment', 'Mode of Payment', 1 ],
                        [ 'settlementCurrency', 'Settlement Currency', 1 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 1, 'right' ],
                        ['deletePaymentSummary','Delete', 1, 'center', 'hidden' ],
                        ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 1, 'center', 'hidden'],
                        ['accountNumber', 'Account Number', 1, 'center','hidden'],
                        ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['amount', 'Amount', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        		}
            } else {
            	if(userRole.indexOf("TSD") == -1 ){
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, afterInsertRow: disableRatesTable, 
                	gridComplete: viewLoanDetailsTab},
                    [ [ 'modeOfPayment', 'Mode of Payment', 1 ],
                        [ 'settlementCurrency', 'Settlement Currency', 1 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 1, 'right' ],
                        [ 'amount', 'Amount (in LC currency)', 1, 'right' ],
                        ['deletePaymentSummary','Delete', 1, 'center' ],
                        ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 1, 'center', 'hidden'],
                        ['accountNumber', 'Account Number', 1, 'center','hidden'],
                        ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
            	} else {
            		setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: viewLoanDetailsTab, afterInsertRow: disableRatesTable},
                    [ [ 'modeOfPayment', 'Mode of Payment', 1 ],
                        [ 'settlementCurrency', 'Settlement Currency', 1 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 1, 'right' ],
                        [ 'amount', 'Amount (in LC currency)', 1, 'right' ],
                        ['deletePaymentSummary','Delete', 1, 'center', 'hidden'],
                        ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 1, 'center', 'hidden'],
                        ['accountNumber', 'Account Number', 1, 'center','hidden'],
                        ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
            	}
            }
        } else if(documentClass.toUpperCase() == 'DA' || documentClass.toUpperCase() == 'DP' || documentClass.toUpperCase() == 'OA' || documentClass.toUpperCase() == 'DR') {
        	if(userRole.indexOf("TSD") == -1 && !reverseEts){
        	setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, afterInsertRow: disableRatesTable},
                [   ['accountNumber', 'Account Number', 14, 'center'],
                    [ 'modeOfPayment', 'Mode of Payment', 14 ],
                    [ 'settlementCurrency', 'Settlement Currency', 14 ],
                    [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                    [ 'amount', 'Amount (in ' + documentClass + ' currency)', 20, 'right' ],
                    ['deletePaymentSummary','Delete', 4, 'center' ],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                    ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        	} else {
        		setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, afterInsertRow: disableRatesTable},
                [   ['accountNumber', 'Account Number', 14, 'center'],
                    [ 'modeOfPayment', 'Mode of Payment', 14 ],
                    [ 'settlementCurrency', 'Settlement Currency', 14 ],
                    [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                    [ 'amount', 'Amount (in ' + documentClass + ' currency)', 20, 'right' ],
                    ['deletePaymentSummary','Delete', 4, 'center', 'hidden'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                    ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        	}
        } else {
        	if(userRole.indexOf("TSD") == -1 ){
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, afterInsertRow: disableRatesTable, gridComplete: function(){
            	if('function' === typeof checkSettlementCurrency){
            		checkSettlementCurrency();
            	}
            }, shrinkToFit: false},
                [   [ 'modeOfPayment', 'Mode of Payment', 150 ],
                    [ 'settlementCurrency', 'Settlement Currency', 150 ],
                    [ 'amountSettlement', 'Amount (in Settlement Currency)', 150, 'right' ],
                    [ 'amount', 'Amount (in Cash LC currency)', 205, 'right' ],
                    ['deletePaymentSummary','Delete', 100, 'center' ],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        	} else { 
        		setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable", loadComplete: setupLcPayment, afterInsertRow: disableRatesTable},
                [   [ 'modeOfPayment', 'Mode of Payment', 14 ],
                    [ 'settlementCurrency', 'Settlement Currency', 14 ],
                    [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                    [ 'amount', 'Amount (in Cash LC currency)', 20, 'right' ],
                    ['deletePaymentSummary','Delete', 4, 'center', 'hidden'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        	}
        }
    } else if(referenceType == "PAYMENT") {

        if(serviceType.toUpperCase() == "NEGOTIATION" && documentType != 'DOMESTIC' && documentSubType1 != 'CASH') { // special case for negotiation
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: function() {
            	showDebitMemo();
            	showPaymentSummary();
            	viewLoanDetailsTab();
            	enableDisableAccountingentriesLink();}, afterInsertRow: disableRatesTable},
                [['accountNumber', 'Account Number', 120, 'left'],
                    ['pnNumber', 'PN Number', 20 , 'left'],
                    ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                    ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                    ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                    ['deletePaymentSummary','Delete', 40, 'center' ],
                    ['status','Status', 60, 'center'],
                    ['pay','&nbsp;', 70, 'center'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['amount', 'Amount', 40, 'left', 'hidden'],
                    ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                    ['sequenceNumber','Sequence Number', 12, 'left', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else {
            if (documentClass == "DA" || documentClass == "DP" || documentClass == "DR" || documentClass == "OA") {

                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: function() {
                        showDebitMemo();
                        showPaymentSummary();
                        enableDisableAccountingentriesLink();}, afterInsertRow: disableRatesTable, shrinkToFit: false},
                    [['accountNumber', 'Account Number', 115, 'left'],
                    ['pnNumber', 'PN Number', 80 , 'center'],
                        ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                        ['settlementCurrency', 'Settlement Currency', 105, 'center'],
                        ['amountSettlement', 'Amount (in settlement currency)', 170, 'right'],
                        ['deletePaymentSummary','Delete', 40, 'center' ],
                        ['status','Status', 60, 'center'],
                        ['pay','&nbsp;', 70, 'center'],
                        ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                        ['amount', 'Amount', 40, 'left', 'hidden'],
                        ['setupString', 'Setup String', 40, 'left', 'hidden'],
                        ['sequenceNumber','Sequence Number', 12, 'left', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);

            } else {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: function() {
                        showDebitMemo();
                        showPaymentSummary();
                        enableDisableAccountingentriesLink();
                        viewLoanDetailsTab();
                        if(serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT" ||
            			(documentClass == "LC" && (serviceType == "Negotiation" || serviceType == "NEGOTIATION") &&
    					(documentSubType1 == "STANDBY" || (documentSubType1 == "REGULAR" && documentSubType2 == "SIGHT")))) {
                        	if('undefined' !== typeof proceedsSummaryViewChargesTab){
                        		proceedsSummaryViewChargesTab();                        		
                        	}
                        }}, afterInsertRow: disableRatesTable, shrinkToFit: false},
                    [['accountNumber', 'Account Number', 115, 'left'],
                    ['pnNumber', 'PN Number', 80 , 'center'],
                        ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                        ['settlementCurrency', 'Settlement Currency', 105, 'center'],
                        ['amountSettlement', 'Amount (in settlement currency)', 170, 'right'],
                        ['deletePaymentSummary','Delete', 40, 'center' ],
                        ['status','Status', 60, 'center'],
                        ['pay','&nbsp;', 70, 'center'],
                        ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                        ['amount', 'Amount', 40, 'left', 'hidden'],
                        ['setupString', 'Setup String', 40, 'left', 'hidden'],
                        ['sequenceNumber','Sequence Number', 12, 'left', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
            }
        }
    } else if((referenceType == "DATA_ENTRY")) { // for MD
    	
        if (documentClass == "MD") {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100, width: 780, loadui: "disable", shrinkToFit: false, gridComplete: function() {
                showDebitMemo();
                showPaymentSummary();}, scrollOffset:0},
                [['accountNumber', 'Account Number', 120, 'left'],
                    ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                    ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                    ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                    ['deletePaymentSummary','Delete', 50, 'center' ],
                    ['status','Status', 65, 'center'],
                    ['pay','&nbsp;', 70, 'center'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['amount', 'Amount', 40, 'left', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupLcPayment, gridComplete: showDebitMemo, afterInsertRow: disableRatesTable},
                [['accountNumber', 'Account Number', 120, 'left'],
                    ['pnNumber', 'PN Number', 20 , 'center'],
                    ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                    ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                    ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                    ['deletePaymentSummary','Delete', 40, 'center' ],
                    ['status','Status', 60, 'center'],
                    ['pay','&nbsp;', 70, 'center'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['amount', 'Amount', 40, 'left', 'hidden'],
                    ['setupString', 'Setup String', 40, 'left', 'hidden'],
                    ['sequenceNumber','Sequence Number', 12, 'left', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        }
    }
}

// setup foreign exchange rates for lc payment
function setupForeignExchangeRatesLc() {
    if($("#grid_list_cash_forex").length > 0) {
        var forexcashdata = $("#grid_list_cash_forex").jqGrid("getRowData");
        $("#foreignExchangeRatesLc").val(JSON.stringify(forexcashdata));
    }
}

// setup lc payment
function setupLcPayment() {
    if($("#grid_list_cash_payment_summary").length > 0) {
        var cashpaymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
        $("#documentPaymentSummary").val(JSON.stringify(cashpaymentsummarydata));

        if (cashpaymentsummarydata.length > 0) {
            disableRatesTable();
        }
    }


//    if (referenceType != "PAYMENT") {
        updateTotalAmountOfPaymentCharges("#cashLcPaymentTabForm");
//    }
}

function containsLoan() {
    var loanCount = 0;

    var data = $("#grid_list_cash_payment_summary").jqGrid("getRowData");

    $.each(data,function(idx,val) {
        if((val.paymentMode.indexOf("LOAN") != -1) && (referenceType == "PAYMENT")) {
            loanCount ++;
        }
    });

    return loanCount;
}

function viewLoanDetailsTab() {
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
		
	var loanCount = 0;
	
	$.each(gridDataCashPayment,function(idx, data) {
		if(data.paymentMode.toUpperCase().indexOf("LOAN") != -1 || data.paymentMode.toUpperCase().indexOf("DBP") != -1){
			loanCount ++;
		}
	});
	
	if(gridDataCashPayment == "" || loanCount == 0) {
		$(".showLoanDetailsTab").hide();
	} else if(loanCount > 0) {
		$(".showLoanDetailsTab").show();
	}
	
}

function initCashGrids() {
	setupCashGrids();
	
	// remove when backend is ready
//	insertToCashForexGrid();
    setupForeignExchangeRatesLc();
//    setupLcPayment();
}

$(initCashGrids);