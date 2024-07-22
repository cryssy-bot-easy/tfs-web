//@js/gsp
function generateBillingStatementReport(){
			
	var tmpBillingStatementUrl = billingStatementUrl;
		
	var countCharges = 0;
	
	tmpBillingStatementUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpBillingStatementUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpBillingStatementUrl += "&expiryDate=" + $("#expiryDate").val();
	tmpBillingStatementUrl += "&priceTerm=" + $("#priceTerm").val();
	tmpBillingStatementUrl += "&tenor=" + $("#tenor").val();
	tmpBillingStatementUrl += "&usancePeriod=" + $("#usancePeriod").val();
	
	if($("#currency").val()!="" && $("#currency").val()!=undefined) {
		tmpBillingStatementUrl += "&currency=" + $("#currency").val();
	} else if($("#originalCurrency").val()!="" && $("#originalCurrency").val()!=undefined) {
		tmpBillingStatementUrl += "&currency=" + $("#originalCurrency").val();
	} else {
		tmpBillingStatementUrl += "&currency=" + $("#shipmentCurrency").val();
	}
	
	if($("#amount").val()!="" && $("#amount").val()!=undefined) {
		tmpBillingStatementUrl += "&amount=" + $("#amount").val();
	}  else {
		tmpBillingStatementUrl += "&amount=" + $("#originalAmount").val();
	}

	tmpBillingStatementUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
	tmpBillingStatementUrl += "&tenorOfDraftNarrative=" + $("#tenorOfDraftNarrative").val();
	tmpBillingStatementUrl += "&settlementCurrency=" + $("#settlementCurrency").val();
	
	if($("#documentClass").val() == "CORRES_CHARGE") {
		tmpBillingStatementUrl += "&forexTableRowCount=" + $("#forex_product tr").length;
	} else {
		tmpBillingStatementUrl += "&forexTableRowCount=" + $("#forex_charges tr").length;	
	}
	
	//charges
	tmpBillingStatementUrl += "&advisingFee=" + $("#CORRES-ADVISING").val();
	tmpBillingStatementUrl += "&bankCommission=" + $("#BC").val();
	tmpBillingStatementUrl += "&bookingCommission=" + $("#BOOKING").val();
	tmpBillingStatementUrl += "&bspFee=" + $("#BSP").val();
	tmpBillingStatementUrl += "&cableFee=" + $("#CABLE").val();
	tmpBillingStatementUrl += "&cancellationFee=" + $("#CANCEL").val();
	tmpBillingStatementUrl += "&cilexFee=" + $("#CILEX").val();
	tmpBillingStatementUrl += "&commitmentFee=" + $("#CF").val();
	tmpBillingStatementUrl += "&confirmingFee=" + $("#CORRES-CONFIRMING").val();
	tmpBillingStatementUrl += "&documentaryStamp=" + $("#DOCSTAMPS").val();
	tmpBillingStatementUrl += "&interestFee=" + $("#INTEREST").val();
	tmpBillingStatementUrl += "&notarialFee=" + $("#NOTARIAL").val();
	tmpBillingStatementUrl += "&remittanceFee=" + $("#REMITTANCE").val();
	tmpBillingStatementUrl += "&suppliesFee=" + $("#SUP").val();
	tmpBillingStatementUrl += "&exportsAdvisingFee=" + $("#ADVISING-EXPORT").val();
	tmpBillingStatementUrl += "&otherAdvisingFee=" + $("#OTHER-EXPORT").val();
	tmpBillingStatementUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();
	
	if($("#documentClass").val() != "CORRES_CHARGE") {
		tmpBillingStatementUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentCharges").val();
		var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
	} else {
		tmpBillingStatementUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentLc").val();
		var gridDataChargesPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	}
	$.each(gridDataChargesPayment,function(idx, data) {	
		countCharges = countCharges + 1;
		tmpBillingStatementUrl += "&modeOfPaymentCharges" + countCharges + "=" + data.modeOfPayment;
		tmpBillingStatementUrl += "&amountCharges" + countCharges + "=" + data.amount;
		tmpBillingStatementUrl += "&amountSettlement" + countCharges + "=" + data.amountSettlement;
	});
		
	window.open(tmpBillingStatementUrl);

}

function init() {
	$('#viewBillingStatement').click(generateBillingStatementReport);
}


$(init);