function generateTsdExportBankCommission() {
	var tmpTsdExportBankCommissionUrl = tsdExportBankCommissionUrl;
	
	window.open(tmpTsdExportBankCommissionUrl);
}

$(document).ready(function() {
	$("#tsdExportBankCommissionSpad").click(generateTsdExportBankCommission);
});