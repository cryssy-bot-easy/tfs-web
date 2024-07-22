//@js/gsp
function generateDailyReportProcessedRefunds(){
			
	var tmpDailyReportProcessedRefundsUrl = dailyReportProcessedRefundsUrl;
	
	tmpDailyReportProcessedRefundsUrl += "?dateOfTransactionFrom=" + $("#dateOfTransactionFrom").val();
	tmpDailyReportProcessedRefundsUrl += "&dateOfTransactionTo=" + $("#dateOfTransactionTo").val();
	tmpDailyReportProcessedRefundsUrl += "&brUnitCode=" + $("#onlineReportPuc").val();
		
	window.open(tmpDailyReportProcessedRefundsUrl);
}

function init() {
	$('#viewDailyReportProcessedRefunds').click(generateDailyReportProcessedRefunds);
}

$(init);