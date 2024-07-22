//@js/gsp
function generateBillingStatementForMarginalDepositReport(){
			
	var tmpBillingStatementForMarginalDepositUrl = billingStatementForMarginalDepositUrl;
	
	var documentNumber = $("#documentNumber").val();
	var tradeServiceId = $("#tradeServiceId").val();
	var expiryDate = $("#expiryDate").val();
	var priceTerm = $("#priceTerm").val();
	var usancePeriod = $("#usancePeriod").val();
	var outstandingBalance = $("#outstandingBalance").val();
	var totalAmountOfPaymentLc = $("#totalAmountOfPaymentLc").val();
	
	var count = 0;
	
	tmpBillingStatementForMarginalDepositUrl += "?documentNumber=" + documentNumber;
	tmpBillingStatementForMarginalDepositUrl += "&tradeServiceId=" + tradeServiceId;
	tmpBillingStatementForMarginalDepositUrl += "&expiryDate=" + expiryDate;
	tmpBillingStatementForMarginalDepositUrl += "&priceTerm=" + priceTerm;
	tmpBillingStatementForMarginalDepositUrl += "&usancePeriod=" + usancePeriod;
	tmpBillingStatementForMarginalDepositUrl += "&outstandingBalance=" + outstandingBalance;
	tmpBillingStatementForMarginalDepositUrl += "&totalAmountOfPaymentLc=" + totalAmountOfPaymentLc;
	
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	$.each(gridDataCashPayment,function(idx, data) {
		count = count + 1;
		tmpBillingStatementForMarginalDepositUrl += "&modeOfPayment" + count + "=" + data.modeOfPayment;
		tmpBillingStatementForMarginalDepositUrl += "&settlementCurrency" + count + "=" + data.settlementCurrency;
		tmpBillingStatementForMarginalDepositUrl += "&amountSettlement" + count + "=" + data.amountSettlement;
		tmpBillingStatementForMarginalDepositUrl += "&amount" + count + "=" + data.amount;
	});
	
	window.open(tmpBillingStatementForMarginalDepositUrl);

}

function init() {
	$('#viewBillingStatementForMarginalDeposit').click(generateBillingStatementForMarginalDepositReport);
}


$(init);