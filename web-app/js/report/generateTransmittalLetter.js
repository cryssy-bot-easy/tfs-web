//@js/gsp
function generateTransmittalLetterReport(){
			
	var tmpTransmittalLetterUrl = transmittalLetterUrl;
	var amount = "";
	
	tmpTransmittalLetterUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpTransmittalLetterUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpTransmittalLetterUrl += "&lcNumber=" + $("#lcNumber").val();
	tmpTransmittalLetterUrl += "&documentType=" + $("#documentType").val();
	tmpTransmittalLetterUrl += "&serviceType=" + $("#serviceType").val();
	
	if($("#currency").val()!="" && $("#currency").val()!=undefined) {
		tmpTransmittalLetterUrl += "&currency=" + $("#currency").val();
	} else {
		tmpTransmittalLetterUrl += "&currency=" + $("#originalCurrency").val();
	}
	
	if($("#serviceType").val().toUpperCase() == "NEGOTIATION") {
		amount = $("#negotiationAmount").val();
	} else if($("#serviceType").val().toUpperCase() == "AMENDMENT") {
		if($("#amountTo").val() == "" || $("#amountTo").val() == "0.00") {
			amount = $("#amountFrom").val();
		} else {
			amount = $("#amountTo").val();
		}
	} else {
		amount = $("#amount").val();
	}
	
	tmpTransmittalLetterUrl += "&amount=" + amount;
	tmpTransmittalLetterUrl += "&outstandingBalance=" + $("#outstandingBalance").val();
	tmpTransmittalLetterUrl += "&issueDate=" + $("#issueDate").val();
	tmpTransmittalLetterUrl += "&authorizedSign=" + $("#authorizedSign").val();
	tmpTransmittalLetterUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();
	
	window.open(tmpTransmittalLetterUrl);

}

function init() {
	$('#viewTransmittalLetterPayment').click(generateTransmittalLetterReport);
	$('#viewTransmittalLetterDataEntryDomestic').click(generateTransmittalLetterReport);
}


$(init);