function setupRefundGrids(){
	var refundGridUrl = refundChargesUrl;

    setupJqGridWidthNoPagerHidden('grid_list_refund_branch', {width: 780, height: 100, loadui: "disable", scrollOffset:0, gridComplete: setupChargesRefund},
					[['accountNumber', 'Account Number', 120],
					['modeOfPayment', 'Mode of Payment', 100],
					['currency', 'Refund Currency', 120],
				    ['amount', 'Amount (in Refund Currency)', 220],
                    ['deletePaymentSummary','Delete', 40],
                    ['status','Status', 1, 'center', 'hidden'],
                    ['pay', '&nbsp;', 1, 'center', 'hidden'],
                    ['tradeSuspenseAccount', 'tradeSuspenseAccount', 1, 'center', 'hidden'],
                    ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
                    ['accountName','Account Name', 300 , 'center','hidden'],
                    ['referenceId', 'referenceId', 4, 'left', 'hidden']], refundGridUrl);

    setupJqGridWidthNoPagerHidden('grid_list_refund_main', {width: 780, height: 100, loadui: "disable", scrollOffset:0, 
    	gridComplete: function() {
    		setupChargesRefund();
    		showCreditMemo();}},
        [['accountNumber', 'Account Number', 120, 'left'],
            ['modeOfPayment', 'Mode of Payment', 100, 'center'],
            ['currency', 'Refund Currency', 120, 'center'],
            ['amount', 'Amount (in Refund Currency)', 220, 'right'],
            ['deletePaymentSummary','Delete', 40, 'center'],
            ['status','Status', 60, 'center'],
            ['pay', '&nbsp;', 70, 'center'],
            ['tradeSuspenseAccount', 'tradeSuspenseAccount', 1, 'center', 'hidden'],
            ['paymentMode', 'Payment Mode', 1, 'center', 'hidden'],
            ['accountName','Account Name', 300 , 'center','hidden'],
            ['referenceId', 'referenceId', 4, 'left', 'hidden']], refundGridUrl);
}

function setupChargesRefund(){
	var grid;

	if ($("#grid_list_refund_branch").length > 0) {
		grid = $("#grid_list_refund_branch")
	} else {
		grid = $("#grid_list_refund_main")
	}
	
	var ids = grid.jqGrid("getDataIDs");
    var totalPayments = 0;
    for(i in ids) {
        var data = grid.jqGrid("getRowData",ids[i]);
        var amount;
        if(data.amount != undefined) {
            amount = stripCommas(data.amount);
        }else{
            amount = stripCommas(data.amountSettlement);
        }
        totalPayments += parseFloat(amount);
    }


    $("#totalAmountOfRefund").val(formatCurrency(totalPayments));
  
    if (serviceType == 'Application' && documentType == 'REFUND'){
    	$("#amountOfRefund").val(formatCurrency(parseFloat($("#amountOfMdToApply").val().replace(",","")) - parseFloat(totalPayments)));
    }else{
    	updateTotalAmountOfPaymentCharges("#cashLcPaymentTabForm");
    	$("#apAmount").val(parseFloat($("#amountOfMdToApply").val()) - parseFloat(totalPayments));
    }
    
}

function initRefundGrid(){
	setupRefundGrids();
}

$(initRefundGrid);