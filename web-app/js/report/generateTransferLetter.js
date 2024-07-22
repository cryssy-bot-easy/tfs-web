//@js/gsp
function generateTransferLetterReport(){
	
	var tmpTransferLetterUrl = transferLetterUrl;

	var receivingBankAddress = $("#receivingBankAddress").val();
	var receivingBankAddressWithNewLine = receivingBankAddress.split('\n').join('*');
	
	var documentsLists = $("#documentsLists").val();
	var documentsListsWithNewLine = documentsLists.split('\n').join('~');
	var documentsListsWithIndention = documentsListsWithNewLine.split(' ').join('^');
	
	tmpTransferLetterUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpTransferLetterUrl += "&tradeServiceId=" +$("#tradeServiceId").val();
	tmpTransferLetterUrl += "&recevingBank=" + $("#recevingBank").val();
	tmpTransferLetterUrl += "&receivingBankAddress=" + receivingBankAddressWithNewLine;
	tmpTransferLetterUrl += "&recipient=" + $("#recipient").val();
	tmpTransferLetterUrl += "&recipientPosition=" + $("#recipientPosition").val();
	tmpTransferLetterUrl += "&documentsLists=" + documentsListsWithIndention;
	tmpTransferLetterUrl += "&remittingBank=" + $("#remittingBank").val();
	tmpTransferLetterUrl += "&beneficiaryName=" + $("#beneficiaryName").val();
	tmpTransferLetterUrl += "&draftCurrency=" + $("#currency").val();
	tmpTransferLetterUrl += "&draftAmount=" + $("#outstandingAmount").val();
	tmpTransferLetterUrl += "&remittingBankReferenceNumber=" + $("#remittingBankReferenceNumber").val();
	tmpTransferLetterUrl += "&authorizedSignatory=" + $("#authorizedSignatory").val();
	tmpTransferLetterUrl += "&authorizedSignatoryPosition=" + $("#authorizedSignatoryPosition").val();

	window.open(tmpTransferLetterUrl);
}

function showLetterOfTransfer() {
	
	if($("#willTheFxNonLcDocumentsBeTransferredToAnotherBankFlag[checked]").val() == 'Y' || $("#settleFlagCheck").val() == 'Y'){
		$("#showLetterOfTransfer").show();
	}
		
	else {
		$("#showLetterOfTransfer").hide();
	}
		
}

function init() {
	$("#showLetterOfTransfer").hide();
	
	showLetterOfTransfer();
	
	$('#viewTransferLetterDataEntry').click(generateTransferLetterReport);
}

$(init);