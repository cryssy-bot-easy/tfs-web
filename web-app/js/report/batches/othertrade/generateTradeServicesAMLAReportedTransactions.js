//@js/gsp
function generateTradeServicesAMLAReportedTransactions(){
	var tmpAMLAReportedTransactionsUrl = amlaReportedTransactionsUrl;
	
	tmpAMLAReportedTransactionsUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpAMLAReportedTransactionsUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpAMLAReportedTransactionsUrl);

}