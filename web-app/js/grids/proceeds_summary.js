function setupPddtsFormFields(data) {
	var settlementCurrency = $("#settlementCurrency").val();
	var currency = $("#negotiationCurrency").val() ? $("#negotiationCurrency").val() : $("#currency").val();
	var toUsdConversion = (currency == 'USD') ? 1 : (currency == 'PHP') ? parseFloat(1 / $("#USD-PHP_urr").val()) : parseFloat($("#" + currency + "-USD_special_rate_charges").val());
	var toUsdConversionSettlement = (settlementCurrency == 'USD') ? 1 : (settlementCurrency == 'PHP') ? parseFloat(1 / $("#USD-PHP_urr").val()) : parseFloat($("#" + settlementCurrency + "-USD_special_rate_charges").val());
	
    var remittanceFee = 0;
    var pddtsAmount = parseFloat(data.amountSettlement.replace(/,/g,"")) * parseFloat(toUsdConversion);

    if($("#REMITTANCE").length > 0) {
    	//remittanceFee = parseFloat($("#REMITTANCE").val()) * parseFloat(toUsdConversionSettlement);
    	remittanceFee = parseFloat("18.00");
    }
    if($("#remittanceFee2").length > 0) {
    	$("#remittanceFee2").val(formatCurrency(remittanceFee))
    }
    $("#pddtsAmount").val(formatCurrency(pddtsAmount));

    $("#totalAmount").val(formatCurrency(pddtsAmount + remittanceFee));
}

function setupMt103Tabs(data) {
//    $("#currency").val(data.settlementCurrency);
    $("#swiftAmount").val(data.amountSettlement);
}

// setup lc payment
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
            var due = parseFloat($("#proceedsAmount").val().replace(/,/g,""));
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

$(document).ready(function (){
	
	var proceedsPaymentGridUrl = proceedsChargeUrl;
	
	//prevents readonly fields with autoNumeric scripts from being edited
	$("#proceedsAmount").focus(function(){
		$(this).blur();
	});
	
	
//	var proceedsGridList = $('#grid_list_proceeds_payment_summary');
//	var proceedsRowNum = $(proceedsGridList).getRowData().length;

//	var modeValue= $('#modeOfPaymentProceeds');
//	var proceedsCurrency = $('#proceedsCurrency');
//	var proceedsAmount = $('#proceedsAmount');
	
//	var wrapper_div=$("#popup_modeOfPaymentProceeds").attr("id");
//	var div_bg=$("#mode_of_payment_proceeds_bg").attr("id");


     //alert(2)
    if(referenceType == "ETS" || referenceType == "DATA_ENTRY") {
    	if(referenceType == "ETS" && (userRole.indexOf("TSD") > -1 || reverseEts)){
    		setupJqGridWidthNoPagerHiddenNotSortable('grid_list_proceeds_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable",shrinkToFit: false, loadComplete: setupProceedsPayment,
    			gridComplete: function() {
    				proceedsSummaryViewChargesTab()}},
            [ [ 'modeOfPayment', (documentClass == 'DA' || documentClass == 'DP' || documentClass == 'OA' || documentClass == 'DR') ? 'Mode of Settlement' : 'Mode of Payment', 250 ],
                [ 'settlementCurrency', 'Settlement Currency', 200 ],
                [ 'amountSettlement', 'Amount (in ' + ((documentClass == 'DA' || documentClass == 'DP' || documentClass == 'OA' || documentClass == 'DR') ? 'Nego' : 'LC') +' currency)', 200, 'right' ],
                ['deletePaymentSummary','Delete', 110, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], proceedsPaymentGridUrl);
    	} else {
    		setupJqGridWidthNoPagerHiddenNotSortable('grid_list_proceeds_payment_summary', {width : 780, height: 100, scrollOffset : 0, loadui: "disable",shrinkToFit: false, loadComplete: setupProceedsPayment,
    			gridComplete: function() {
    				proceedsSummaryViewChargesTab()}},
            [ [ 'modeOfPayment', (documentClass == 'DA' || documentClass == 'DP' || documentClass == 'OA' || documentClass == 'DR') ? 'Mode of Settlement' : 'Mode of Payment', 250 ],
                [ 'settlementCurrency', 'Settlement Currency', 200 ],
                [ 'amountSettlement', 'Amount (in ' + ((documentClass == 'DA' || documentClass == 'DP' || documentClass == 'OA' || documentClass == 'DR') ? 'Nego' : 'LC') +' currency)', 200, 'right' ],
                ['deletePaymentSummary','Delete', 110, 'center' ],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['accountNumber', 'Account Number', 4, 'left', 'hidden'],
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], proceedsPaymentGridUrl);
    	}
    } else if(referenceType == "PAYMENT") {
    	setupJqGridWidthNoPagerHiddenNotSortable('grid_list_proceeds_payment_summary', {height:100,width: 780, scrollOffset:0, loadui: "disable",shrinkToFit: false, loadComplete: setupProceedsPayment, gridComplete: function() {
        	showCreditMemo();
        	showPddtsMt103Report();
        	checkPddts();
        	proceedsSummaryViewChargesTab();
        	showPaymentSummary();
    		}},
            [['accountNumber', 'Account Number', 100, 'left'],
                ['modeOfPayment', 'Mode of Payment', 100, 'center'],
                ['settlementCurrency', 'Settlement Currency', 120, 'center'],
                ['amountSettlement', 'Amount (in settlement currency)', 200, 'right'],
                ['deletePaymentSummary','Delete', 40, 'center' ],
                ['status','Status', 60, 'center'],
                ['pay','&nbsp;', 70, 'center'],
                ['paymentMode', 'Payment Mode', 4, 'left', 'hidden'],
                ['referenceId', 'referenceId', 4, 'left', 'hidden'],
                ['rates', 'rates', 4, 'left', 'hidden'],
                ['tradeSuspenseAccount', 'Trade Suspense Account', 4, 'left', 'hidden'],
                ['amount', 'Amount', 40, 'left', 'hidden'],
                ['accountName', 'Account Name', 300 , 'center', 'hidden']], proceedsPaymentGridUrl);
    }
    else{
    	setupJqGridWidthNoPagerHiddenNotSortable('grid_list_proceeds_payment_summary', {height: 72,width: 780,shrinkToFit: false, loadui: "disable", scrollOffset:1},
                [['paymentMode', 'Payment Mode', 160, 'center'],
                    ['proceedsCurrency', 'Proceeds Currency', 120, 'center'],
                    ['proceedsAmount', 'Proceeds Amount',340, 'right'],
                    ['editProceeds','Edit', 80, 'center'],
                    ['deleteProceeds','Delete', 80, 'center'],
                    ['accountName', 'Account Name', 300 , 'center', 'hidden']], proceedsPaymentGridUrl);

    }

	
	//proceedsGridList.addRowData("1", {paymentMode:"CASA", proceedsCurrency:"USD", proceedsAmount:"18,000.00",editProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: blue\">edit</a>",deleteProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\">delete</a>" });
	//proceedsGridList.addRowData("2", {paymentMode:"CASH", proceedsCurrency:"PHP", proceedsAmount:"150,000.00",editProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: blue\">edit</a>",deleteProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\">delete</a>" });
	//proceedsGridList.addRowData("3", {paymentMode:"CHECK", proceedsCurrency:"EUR", proceedsAmount:"10,000.00",editProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: blue\">edit</a>",deleteProceeds:"<a href=\"javascript:void(0)\" class=\"deleteFile\" style=\"color: red\">delete</a>" });

 
    
});


function checkPddts(){
    var gridForPddtsTab = $("#grid_list_proceeds_payment_summary").jqGrid("getRowData");
    
	$.each(gridForPddtsTab,function(idx, data) {
		
		if(data.modeOfPayment.indexOf("PDDTS") != -1){
	        $("#pddtsTabLi").show();
	        $(".viewPddtsLi").show();
		} else {
			$("#pddtsTabLi").hide();
	        $(".viewPddtsLi").hide();
		} 
		if(data.modeOfPayment.indexOf("SWIFT") != -1){
            $("#mt103TabLi").show();
            $(".viewMt103Li").show();
		} else {
			$("#mt103TabLi").hide();
			$(".viewMt103Li").hide();
		}
	});
}

function validateProceedsSummary(){
	var error_msg = ""
		if($("#totalProceedsPayment").val()=="0.00"){
			error_msg+="Transaction requires Payment of Proceeds."
		}
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
	        _pageHasErrors=true;
		} else {			
//			action = "save";
			_pageHasErrors=false;
//			openAlert();
		}
}