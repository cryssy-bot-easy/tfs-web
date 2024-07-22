/**
 * Created with IntelliJ IDEA.
 * User: Marv
 * Date: 2/1/13
 * Time: 2:52 PM
 * To change this template use File | Settings | File Templates.
 */

function setupSettlementToBenEtsGrid() {
    var url = settlementToBenGridUrl;
    url += "?tradeServiceId="+$("#tradeServiceId").val();

    setupJqGridWidthNoPagerHidden("grid_list_proceeds_payment_summary", {width : 780, height: 40, loadui: "disable", scrollOffset : 0,
    	gridComplete: function() {
    		showCreditMemo();
        	showPddtsMt103Report();
        	setupProceedsPayment();
    	}, shrinkToFit: false},
        [["modeOfPayment", "Mode of Settlement", 250],
            ["settlementCurrency", "Settlement Currency", 200],
            ["amountSettlement", "Amount", 200, "right"],
            ["deletePaymentSummary","Delete", 110, "center"],
            ["paymentMode", "Payment Mode", 4, "left", "hidden"],
            ["referenceId", "referenceId", 4, "left", "hidden"],
            ["rates", "Rates", 4, "left", "hidden"],
            ["tradeSuspenseAccount", "Trade Suspense Account", 4, "left", "hidden"],
            ["accountNumber", "Account Number", 4, "left", "hidden"],
            ['accountName', 'Account Name', 300 , 'center', 'hidden']], url);
}

function setupSettlementToBenDataEntryGrid() {
    var url = settlementToBenGridUrl;
    url += "?tradeServiceId="+$("#tradeServiceId").val();

    setupJqGridWidthNoPagerHidden('grid_list_proceeds_payment_summary', {height: 45, width: 780, loadui: "disable", scrollOffset:0,
    	gridComplete: function() {
    		showCreditMemo();
        	showPddtsMt103Report();
    		setupProceedsPayment();
		}, shrinkToFit: false},
        [['accountNumber', 'Account Number', 135, 'left'],
            ['modeOfPayment', 'Mode of Payment', 100, 'center'],
            ['settlementCurrency', 'Settlement Currency', 120, 'center'],
            ['amountSettlement', 'Amount (in settlement currency)', 220, 'right'],
            ['deletePaymentSummary','Delete', 40, 'center' ],
            ['status','Status', 60, 'center'],
            ['pay','&nbsp;', 70, 'center'],
            ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
            ['referenceId', 'referenceId', 4, 'left', 'hidden'],
            ['rates', 'rates', 4, 'left', 'hidden'],
            ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
            ['amount', 'Amount', 40, 'left', 'hidden'],
            ['accountName', 'Account Name', 300 , 'center', 'hidden']], url);
}

function setupProceedsPayment() {
    if($("#grid_list_proceeds_payment_summary").length > 0) {
        var cashpaymentsummarydata = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
        $("#proceedsPaymentSummary").val(JSON.stringify(cashpaymentsummarydata));

        var amounts = [];

        $.each(cashpaymentsummarydata,function(idx, data) {
            if (data.paymentMode == 'PDDTS') {
                //pddtsAmount = data.amountSettlement.replace(/,/g,"")
                setupPddtsFormFields(data);
            }

            if (data.paymentMode == "SWIFT") {
                setupMt103Tabs(data);
            }
            amounts.push(data.amountSettlement.replace(/,/g,""));
        });



        $.post(computeTotalUrl,{amounts: amounts.toString()},function(data) {
            var due = $('[name="proceedsAmount"]').val() ? parseFloat($('[name="proceedsAmount"]').val().replace(/,/g,"")) : $('[name="amountForCredit"]').val() ? parseFloat($('[name="amountForCredit"]').val().replace(/,/g,"")) : 0;
            var totalPaymentsMade = parseFloat(data.totalAmount.replace(/,/g,""));

            var balance = due - totalPaymentsMade;

            if (balance > 0) {
                $("#remainingAmountBalance").val(formatCurrency(balance));
            } else {
                $("#remainingAmountBalance").val(formatCurrency(0));
            }

            $("#totalProceedsPayment").val(formatCurrency(data.totalAmount));
        });
        
    }
}

function setupPddtsFormFields(data) {
	var currency = $("#negotiationCurrency").val() ? $("#negotiationCurrency").val() : $("#currency").val();
	var toUsdConversion = (currency == 'USD') ? 1 : (currency == 'PHP') ? parseFloat(1 / $("#USD-PHP_urr").val()) : parseFloat($("#" + currency + "-USD_special_rate_charges").val());

	var remittanceFee = 0;
	var pddtsAmount = parseFloat(data.amountSettlement.replace(/,/g,"")) * parseFloat(toUsdConversion);

	if($("#REMITTANCE").length > 0) {
		//remittanceFee = parseFloat($("#REMITTANCE").val()) / parseFloat($("#USD-PHP_urr").val());
		remittanceFee = parseFloat("18.00");
	}

	if($("#remittanceFee2").length > 0) {
		if ($("#remittanceFee2").val() == ""){
			$("#remittanceFee2").val(formatCurrency(remittanceFee))
		}else{
			
		}
	}
	$("#pddtsAmount").val(formatCurrency(pddtsAmount));
	
	$("#totalAmount").val(formatCurrency(pddtsAmount + remittanceFee));
}

function setupMt103Tabs(data) {
//    $("#currency").val(data.settlementCurrency);
    $("#swiftAmount").val(data.amountSettlement);
}