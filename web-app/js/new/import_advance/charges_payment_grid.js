/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 1/23/13
 * Time: 2:58 PM
 * To change this template use File | Settings | File Templates.
 */

function setupChargesPaymentGrids(){
    var serviceChargesPaymentUrl = serviceChargeUrl;

    if(referenceType == "ETS") {

        if(windowed == 'true') {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {width: 780, height:90, loadui: "disable", scrollOffset:0, loadComplete: setupChargesPayment},
                [['accountNumber', 'Account Number', 14 ],
                    ['modeOfPayment', 'Mode of Payment', 14 ],
                    ['settlementCurrency', 'Settlement Currency', 14 ],
                    ['amount', 'Amount (in settlement currency)', 20, 'right' ],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden' ],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden' ],
                    ['rates','Rates', 4, 'left', 'hidden' ],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden' ],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
        } else {
            setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {width: 780, height:90, loadui: "disable", scrollOffset:0, loadComplete: setupChargesPayment,
            	gridComplete: chargesSettlementCurrency, shrinkToFit: false},
                [['accountNumber', 'Account Number', 150 ],
                    ['modeOfPayment', 'Mode of Payment', 150 ],
                    ['settlementCurrency', 'Settlement Currency', 150 ],
                    ['amount', 'Amount (in settlement currency)', 200, 'right' ],
                    ['deletePaymentSummary','Delete', 105, 'center' ],
                    ['paymentMode', 'Payment Mode', 4, 'left', 'hidden' ],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden' ],
                    ['rates','Rates', 4, 'left', 'hidden' ],
                    ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden' ],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
        }

    } else if(referenceType.toUpperCase() == "PAYMENT") {

        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupChargesPayment, gridComplete: function() {
                showDebitMemo();
                showPaymentSummary();
                enableDisableAccountingentriesLink();
                chargesSettlementCurrency();},
                shrinkToFit: false},
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
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
    } else if (referenceType == "DATA_ENTRY" && documentClass == "IMPORT_ADVANCE") {

        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupChargesPayment, 
        	gridComplete: function() {
                showDebitMemo();
                showPaymentSummary();
                enableDisableAccountingentriesLink();}},
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
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
    } else if (referenceType == "DATA_ENTRY" && documentClass == "EXPORT_ADVANCE") {

        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, loadui: "disable", scrollOffset:0, loadComplete: setupChargesPayment, gridComplete: showDebitMemo},
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
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
    } else if (referenceType == "DATA_ENTRY" && documentClass in {"BP":1, "BC":1, "IMPORT_CHARGES":1, "EXPORT_CHARGES":1}) {
        setupJqGridWidthNoPagerHiddenNotSortable('grid_list_charges_payment', {height:90,width: 780, scrollOffset:0, loadui: "disable", loadComplete: setupChargesPayment, shrinkToFit: false, 
        	gridComplete: function() {
                showDebitMemo();
                showPaymentSummary();
                chargesSettlementCurrency();}},
            [['accountNumber', 'Account Number', 135, 'left'],
                ['modeOfPayment', 'Mode of Payment', 120, 'center'],
                ['settlementCurrency', 'Settlement Currency', 100, 'center'],
                ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
                ['deletePaymentSummary','Delete', 40, 'center' ],
                ['status','Status', 60, 'center'],
                ['pay','&nbsp;', 70, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['rates','Rates', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], serviceChargesPaymentUrl);
    }
}

function chargesSettlementCurrency() {
	var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getGridParam", "reccount");
	if(gridDataChargesPayment != 0 ){
		$("#settlementCurrency").select2("disable");
		$("table.charges_table a").hide();
	} else {
		$("#settlementCurrency").select2("enable");
		$("table.charges_table a").show();
	}
}

function setupChargesPayment() {
    if($("#grid_list_charges_payment").length > 0) {
        var paymentsummarydata = $("#grid_list_charges_payment").jqGrid("getRowData");
        $("#chargesPaymentSummary").val(JSON.stringify(paymentsummarydata));
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

function enableChargesRatesTable() {
    if ($("#forex_charges").length > 0) {

        $("#forex_charges :input").removeAttr("readonly");
    }
}

$(initChargesPaymentGrid);


