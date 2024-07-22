function generateBankCertificationReports() {
	var tmpBankCertificationUrl = bankCertificationUrl;
	
	tmpBankCertificationUrl  += "?clientName=" + $("#clientName").val();	
	tmpBankCertificationUrl  += "&dateOfTransactionFrom=" + $("#dateOfTransactionFrom").val();	
	tmpBankCertificationUrl  += "&dateOfTransactionTo=" + $("#dateOfTransactionTo").val();	
	tmpBankCertificationUrl  += "&authorizedSignatoryOnline=" + $("#authorizedSignatoryOnline").val();	
	tmpBankCertificationUrl  += "&authorizedSignatoryOnlinePosition=" + $("#authorizedSignatoryOnlinePosition").val();
	
	window.open(tmpBankCertificationUrl);
}

function init() {
	$("#generateBankCertification").click(generateBankCertificationReports);
}

$(init);