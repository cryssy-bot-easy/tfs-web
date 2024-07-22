//@js/gsp
function generateDailyForeignCashLcOpenedReports(){
	var tmpDailyForeignCashLcOpenedUrl = dailyForeignCashLcOpenedUrl;
	
	tmpDailyForeignCashLcOpenedUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyForeignCashLcOpenedUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpDailyForeignCashLcOpenedUrl);

}

function init() {
	$('#viewDailyForeignCashLcOpened').click(generateDailyForeignCashLcOpenedReports);
}


$(init);