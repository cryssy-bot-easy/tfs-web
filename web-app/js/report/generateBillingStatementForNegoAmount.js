//@js/gsp

/**
 * (revision)
SCR/ER Number: 
SCR/ER Description: Redmine Issue #4172 - Charges Details in Billing Statement are incomplete in EBP Nego eTS
[Revised by:] John Patrick C. Bautista
[Date deployed:] 06/16/2017
Program [Revision] Details: Added postage fee to be passed as a parameter in GenericReportsController
Member Type: JavaScript file (JS)
Project: WEB
Project Name: generateBillingStatementForNegoAmount.js
 */

function generateBillingStatementForNegoAmountReport(){
	var tmpBillingStatementForNegoAmountUrl = billingStatementForNegoAmountUrl;
		
	var count = 0;
	var countCharges = 0;
	var showCilex = false;
	var amount = "";
	
	tmpBillingStatementForNegoAmountUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpBillingStatementForNegoAmountUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpBillingStatementForNegoAmountUrl += "&expiryDate=" + $("#expiryDate").val();
	tmpBillingStatementForNegoAmountUrl += "&priceTerm=" + $("#priceTerm").val();
	tmpBillingStatementForNegoAmountUrl += "&usancePeriod=" + $("#usancePeriod").val();
	
	if($("#currency").val()!="" && $("#currency").val()!=undefined) {
		tmpBillingStatementForNegoAmountUrl += "&currency=" + $("#currency").val();
	} else {
		tmpBillingStatementForNegoAmountUrl += "&currency=" + $("#originalCurrency").val();
	}
	
	if($("#serviceType").val().toUpperCase() == "NEGOTIATION" && $("#documentClass").val() != "BP") {
 		amount = $("#negotiationAmount").val();
 	} else if($("#serviceType").val().toUpperCase() == "SETTLEMENT") {
 		amount = $("#productAmount").val();
 	} else if($("#serviceType").val() == "NEGOTIATION" && $("#documentClass").val() == "BP"){
 		amount = $("#amount").val();
 	} else {
 		amount = $("#amount").val();
 	}
	
	tmpBillingStatementForNegoAmountUrl += "&amount=" + amount;
	tmpBillingStatementForNegoAmountUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
	tmpBillingStatementForNegoAmountUrl += "&totalAmountOfPaymentLc=" + $("#totalAmountOfPaymentLc").val();
	tmpBillingStatementForNegoAmountUrl += "&settlementCurrency=" + $("#settlementCurrency").val();
	tmpBillingStatementForNegoAmountUrl += "&totalAmountOfPaymentCharges=" + $("#totalAmountOfPaymentCharges").val();
	tmpBillingStatementForNegoAmountUrl += "&forexTableRowCount=" + $("#forex_product tr").length;
	
	//charges
	tmpBillingStatementForNegoAmountUrl += "&advisingFee=" + $("#CORRES-ADVISING").val();
	tmpBillingStatementForNegoAmountUrl += "&bankCommission=" + $("#BC").val();
	tmpBillingStatementForNegoAmountUrl += "&bookingCommission=" + $("#BOOKING").val();
	tmpBillingStatementForNegoAmountUrl += "&bspFee=" + $("#BSP").val();
	tmpBillingStatementForNegoAmountUrl += "&cableFee=" + $("#CABLE").val();
	tmpBillingStatementForNegoAmountUrl += "&cancellationFee=" + $("#CANCEL").val();
	tmpBillingStatementForNegoAmountUrl += "&cilexFee=" + $("#CILEX").val();
	tmpBillingStatementForNegoAmountUrl += "&commitmentFee=" + $("#CF").val();
	tmpBillingStatementForNegoAmountUrl += "&confirmingFee=" + $("#CORRES-CONFIRMING").val();
	tmpBillingStatementForNegoAmountUrl += "&documentaryStamp=" + $("#DOCSTAMPS").val();
	// Redmine 4172 - Added postage fee to be passed as a parameter in GenericReportsController (added by Pat)
	tmpBillingStatementForNegoAmountUrl += "&postageFee=" + $("#POSTAGE").val();
	tmpBillingStatementForNegoAmountUrl += "&interestFee=" + $("#INTEREST").val();
	tmpBillingStatementForNegoAmountUrl += "&notarialFee=" + $("#NOTARIAL").val();
	tmpBillingStatementForNegoAmountUrl += "&remittanceFee=" + $("#REMITTANCE").val();
	tmpBillingStatementForNegoAmountUrl += "&suppliesFee=" + $("#SUP").val();
	tmpBillingStatementForNegoAmountUrl += "&totalAmountCharges=" + $("#totalAmountCharges").val();
	
	var gridDataCashPayment = $("#grid_list_cash_payment_summary").jqGrid("getRowData");
	$.each(gridDataCashPayment,function(idx, data) {
		count = count + 1;
		tmpBillingStatementForNegoAmountUrl += "&modeOfPayment" + count + "=" + data.modeOfPayment;
		tmpBillingStatementForNegoAmountUrl += "&settlementCurrency" + count + "=" + data.settlementCurrency;
		tmpBillingStatementForNegoAmountUrl += "&amountSettlement" + count + "=" + data.amountSettlement;
		tmpBillingStatementForNegoAmountUrl += "&amount" + count + "=" + data.amount;
		if(data.settlementCurrency != "PHP") {
			showCilex = true; 
		}
	});
	
	if(showCilex==true){
		tmpBillingStatementForNegoAmountUrl += "&showCilex=true";
	}
	
	var gridDataChargesPayment = $("#grid_list_charges_payment").jqGrid("getRowData");
	$.each(gridDataChargesPayment,function(idx, data) {	
		countCharges = countCharges + 1;
		tmpBillingStatementForNegoAmountUrl += "&modeOfPaymentCharges" + countCharges + "=" + data.modeOfPayment;
		tmpBillingStatementForNegoAmountUrl += "&amountCharges" + countCharges + "=" + data.amount;
	});		
		
	window.open(tmpBillingStatementForNegoAmountUrl);

}

function init() {
	$('#viewBillingStatementForNegoAmount').click(generateBillingStatementForNegoAmountReport);
}

$(init);