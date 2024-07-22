//@js/gsp
function generateBillingStatementForCashReport(){
	var tmpBillingStatementForCashUrl = billingStatementForCashUrl;

	var count = 0;
	var countCharges = 0;
	var showCilex = false;
	
	tmpBillingStatementForCashUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpBillingStatementForCashUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpBillingStatementForCashUrl += "&longName=" + $("#longName").val();
	tmpBillingStatementForCashUrl += "&tenor=" + $("#tenor").val();
	tmpBillingStatementForCashUrl += "&usancePeriod=" + $("#usancePeriod").val();
	tmpBillingStatementForCashUrl += "&amount=" + $("#amount").val();
	
	if($("#currency").val()!="" && $("#currency").val()!=undefined) {
		tmpBillingStatementForCashUrl += "&currency=" + $("#currency").val();
	} else {
		tmpBillingStatementForCashUrl += "&currency=" + $("#originalCurrency").val();
	}
	
	tmpBillingStatementForCashUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
	tmpBillingStatementForCashUrl += "&totalAmountOfPaymentLc=" + $("#totalAmountOfPaymentLc").val();
	tmpBillingStatementForCashUrl += "&settlementCurrency=" + $("#settlementCurrency").val();
	tmpBillingStatementForCashUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentCharges").val();
	tmpBillingStatementForCashUrl += "&forexTableRowCount=" + $("#forex_product tr").length;
	
	//charges
	tmpBillingStatementForCashUrl += "&advisingFee=" + $("#CORRES-ADVISING").val();
	tmpBillingStatementForCashUrl += "&bankCommission=" + $("#BC").val();
	tmpBillingStatementForCashUrl += "&bookingCommission=" + $("#BOOKING").val();
	tmpBillingStatementForCashUrl += "&bspFee=" + $("#BSP").val();
	tmpBillingStatementForCashUrl += "&cableFee=" + $("#CABLE").val();
	tmpBillingStatementForCashUrl += "&cancellationFee=" + $("#CANCEL").val();
	tmpBillingStatementForCashUrl += "&cilexFee=" + $("#CILEX").val();
	tmpBillingStatementForCashUrl += "&commitmentFee=" + $("#CF").val();
	tmpBillingStatementForCashUrl += "&confirmingFee=" + $("#CORRES-CONFIRMING").val();
	tmpBillingStatementForCashUrl += "&documentaryStamp=" + $("#DOCSTAMPS").val();
	tmpBillingStatementForCashUrl += "&interestFee=" + $("#INTEREST").val();
	tmpBillingStatementForCashUrl += "&notarialFee=" + $("#NOTARIAL").val();
	tmpBillingStatementForCashUrl += "&remittanceFee=" + $("#REMITTANCE").val();
	tmpBillingStatementForCashUrl += "&suppliesFee=" + $("#SUP").val();
	tmpBillingStatementForCashUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();
	
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	$.each(gridDataCashPayment,function(idx, data) {
		count = count + 1;
		tmpBillingStatementForCashUrl += "&modeOfPayment" + count + "=" + data.modeOfPayment;
		tmpBillingStatementForCashUrl += "&settlementCurrency" + count + "=" + data.settlementCurrency;
		tmpBillingStatementForCashUrl += "&amountSettlement" + count + "=" + data.amountSettlement;
		tmpBillingStatementForCashUrl += "&amount" + count + "=" + data.amount;
		if(data.settlementCurrency != "PHP") {
			showCilex = true; 
		}
	});
	
	if(showCilex==true){
		tmpBillingStatementForCashUrl += "&showCilex=true";
	}
	
	var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
	$.each(gridDataChargesPayment,function(idx, data) {	
		countCharges = countCharges + 1;
		tmpBillingStatementForCashUrl += "&modeOfPaymentCharges" + countCharges + "=" + data.modeOfPayment;
		tmpBillingStatementForCashUrl += "&amountCharges" + countCharges + "=" + data.amount;
	});
		
	window.open(tmpBillingStatementForCashUrl);

}

function enableBillingStatement() {
	if($("input[type=checkbox][name=partialCashSettlementFlagBox]:checked").val() == "on") {
		$(".enableBillingStatement").attr("id", "viewBillingStatementForCash");
        $(".enableBillingStatement").removeClass("disableBillingStatement");
	} else {
		 $(".enableBillingStatement").removeAttr("id");
	     $(".enableBillingStatement").addClass("disableBillingStatement");
	}
}

function init() {
	
	if($("#serviceType").val()=="Adjustment") {
		enableBillingStatement();
		$("input[type=checkbox][name=partialCashSettlementFlagBox]").click(enableBillingStatement);
	}
		
	$('#viewBillingStatementForCash').click(generateBillingStatementForCashReport);
}

$(init);