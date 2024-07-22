/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/23/13
 * Time: 2:42 PM
 * To change this template use File | Settings | File Templates.
 */

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

function setupProductGrids(){
    var productChargesPaymentUrl = productChargeUrl;

    if(referenceType == "ETS") {
        if(serviceType.toUpperCase() == "NEGOTIATION") { // special case for negotiation
            if ((serviceType == "Negotiation" && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY")) || ((serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT") && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY"))) {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable, gridComplete: viewLoanDetailsTab},
                    [ [ 'modeOfPayment', 'Mode of Payment', 1 ],
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
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
            } else {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable, gridComplete: viewLoanDetailsTab},
                    [ [ 'modeOfPayment', 'Mode of Payment', 1 ],
                        [ 'settlementCurrency', 'Settlement Currency', 1 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 1, 'right' ],
                        [ 'amount', 'Amount (in Nego Currency)', 1, 'right' ],
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
            }
        } else {
            if (documentClass == "CORRES_CHARGE") {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable, 
                	gridComplete: function() {
                		setCashAmountInSettlement();
                		viewLoanDetailsTab();
                		}},
                    [ [ 'modeOfPayment', 'Mode of Payment', 14 ],
                        [ 'settlementCurrency', 'Settlement Currency', 14 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                        [ 'amount', 'Amount (in Billing currency)', 20, 'right' ],
                        ['deletePaymentSummary','Delete', 4, 'center' ],
                        ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                        ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                        ['rates', 'Rates', 4, 'left', 'hidden'],
                        ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                        ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
            } else if (documentClass == "IMPORT_CHARGES" && serviceType == "PAYMENT") {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable, gridComplete: viewLoanDetailsTab},
                    [ [ 'modeOfPayment', 'Mode of Payment', 14 ],
                        [ 'settlementCurrency', 'Settlement Currency', 14 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                        [ 'amount', 'Amount (in Billing currency)', 20, 'right' ],
                        ['deletePaymentSummary','Delete', 4, 'center' ],
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
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable, gridComplete: viewLoanDetailsTab},
                    [ [ 'modeOfPayment', 'Mode of Payment', 14 ],
                        [ 'settlementCurrency', 'Settlement Currency', 14 ],
                        [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                        [ 'amount', 'Amount (in Nego Currency)', 20, 'right' ],
                        ['deletePaymentSummary','Delete', 4, 'center' ],
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
        if(serviceType.toUpperCase() == "NEGOTIATION") { // special case for negotiation
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: onPaymentGridComplete, afterInsertRow: disableRatesTable},
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
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: onPaymentGridComplete, afterInsertRow: disableRatesTable},
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
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        }
    } else if((referenceType == "DATA_ENTRY")) { // for MD
        if (documentClass == "CORRES_CHARGE" || documentClass == "IMPORT_ADVANCE") {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, 
            	gridComplete: function() {
            		if(documentClass == "CORRES_CHARGE"){
            			setCashAmountInSettlement();
            		}
            		onPaymentGridComplete();
            		showPaymentSummary();
            	}, afterInsertRow: disableRatesTable, shrinkToFit: false},
                [['accountNumber', 'Account Number', 120, 'left'],
                    ['pnNumber', 'PN Number', 20 , 'left'],
                    ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                    ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                    ['amountSettlement', 'Amount (in settlement currency)', 210, 'right'],
                    ['deletePaymentSummary','Delete', 40, 'center' ],
                    ['status','Status', 60, 'center'],
                    ['pay','&nbsp;', 70, 'center'],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                    ['rates', 'Rates', 4, 'left', 'hidden'],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                    ['amount', 'Amount', 40, 'left', 'hidden'],
                    ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else if (documentClass == "BP" || documentClass == "BC") {
        	setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, afterInsertRow: disableRatesTable,
        		gridComplete: function() {
        			onPaymentGridComplete();
                    showDebitMemo();
                    showPaymentSummary();}, shrinkToFit: false},
                    [['accountNumber', 'Account Number', 115, 'left'],
                        ['pnNumber', 'PN Number', 80 , 'left'],
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
                        ['setupString', 'Setup String', 20 , 'center', 'hidden'],
                        ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                        ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                        ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                        ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: onPaymentGridComplete, afterInsertRow: disableRatesTable},
                [['accountNumber', 'Account Number', 120, 'left'],
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
                    ['facilityId', 'Facility Id', 20 , 'center', 'hidden'],
                    ['facilityType', 'Facility Type', 20 , 'center', 'hidden'],
                    ['facilityReferenceNumber', 'facilityReferenceNumber', 20 , 'center', 'hidden'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        }
    }
}

function onPaymentGridComplete() {
	showDebitMemo();
	viewLoanDetailsTab();
	$.post(paymentStatusUrl, {tradeServiceId: $("#tradeServiceId").val()}, function (data2) {
        if (data2.paymentStatus == "PAID") {

            $("#btnPrepare").removeAttr("disabled");
        } else {
            $("#btnPrepare").attr("disabled", "disabled");
        }
    });
}

// setup foreign exchange rates for lc payment
function setupForeignExchangeRatesLc() {
    if($("#grid_list_cash_forex").length > 0) {
        var forexcashdata = $("#grid_list_cash_forex").jqGrid("getRowData");
        $("#foreignExchangeRatesLc").val(JSON.stringify(forexcashdata));
    }
}

// setup lc payment
function setupProductPayment() {
    if($("#grid_list_cash_payment_summary").length > 0) {
        var cashpaymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
        $("#documentPaymentSummary").val(JSON.stringify(cashpaymentsummarydata));

        if (cashpaymentsummarydata.length > 0) {
            disableRatesTable();
        }
    }
    updateTotalAmountOfPaymentCharges("#cashLcPaymentTabForm");
}

function viewLoanDetailsTab() {
	if(loanCount == 0) {
		$("#loanSetupTab").hide();
	} else if(loanCount > 0) {
		$("#loanSetupTab").show();
	}
}

function setCashAmountInSettlement(){
	var grid;

	grid = $("#grid_list_cash_payment_summary");
	
	var ids = grid.jqGrid("getDataIDs");
    var totalPayments = 0;
    for(i in ids) {
        var data = grid.jqGrid("getRowData",ids[i]);
        var amount;
        if(data.amountSettlement != undefined) {
            amount = stripCommas(data.amountSettlement);
        }else{
        	amount = 0.00;
        }
        totalPayments += parseFloat(amount);
    }

    $("#totalAmountOfPaymentLc").val(formatCurrency(totalPayments));
	$("#cashAmountInSettlement").val(parseFloat($("#netBillingAmountInBillingCurrency").val().replace(/\,/g,"")) - ($("#totalAmountOfPaymentLc").val() ? parseFloat($("#totalAmountOfPaymentLc").val().replace(/\,/g,"")) : 0.00)).blur();
}

function initProductGrids() {
    setupProductGrids();

    // remove when backend is ready
//	insertToCashForexGrid();
    setupForeignExchangeRatesLc();
//    setupLcPayment();

}

$(initProductGrids);

