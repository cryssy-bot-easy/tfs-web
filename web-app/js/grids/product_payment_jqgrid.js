/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/7/13
 * Time: 2:06 PM
 * To change this template use File | Settings | File Templates.
 */

function setupProductGrids(){
    var productChargesPaymentUrl = productChargeUrl;

    if(referenceType == "ETS") {
        if(serviceType.toUpperCase() == "NEGOTIATION") { // special case for negotiation
            if ((serviceType == "Negotiation" && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY")) || ((serviceType == "UA Loan Settlement" || serviceType == "UA_LOAN_SETTLEMENT") && documentType == "DOMESTIC" && (referenceType == "ETS" || referenceType == "DATA_ENTRY"))) {
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment},
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
                setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment},
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
            }
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {width : 780, height: 100, loadui: "disable", scrollOffset : 0, loadComplete: setupProductPayment},
                [ [ 'modeOfPayment', 'Mode of Payment', 14 ],
                    [ 'settlementCurrency', 'Settlement Currency', 14 ],
                    [ 'amountSettlement', 'Amount (in Settlement Currency)', 20, 'right' ],
                    [ 'amount', 'Amount (in LC currency)', 20, 'right' ],
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
    } else if(referenceType == "PAYMENT") {
        if(serviceType.toUpperCase() == "NEGOTIATION") { // special case for negotiation
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: showDebitMemo},
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
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: showDebitMemo},
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
        if (documentClass == "MD") {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0},
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
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], productChargesPaymentUrl);
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_cash_payment_summary', {height:100,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupProductPayment, gridComplete: showDebitMemo},
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
function setupProductPayment() {
    if($("#grid_list_cash_payment_summary").length > 0) {
        var cashpaymentsummarydata = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
        $("#documentPaymentSummary").val(JSON.stringify(cashpaymentsummarydata));
    }
    updateTotalAmountOfPaymentCharges("#cashLcPaymentTabForm");
}

function initProductGrids() {
    setupProductGrids();

    // remove when backend is ready
//	insertToCashForexGrid();
    setupForeignExchangeRatesLc();
//    setupLcPayment();

}

$(initProductGrids);
