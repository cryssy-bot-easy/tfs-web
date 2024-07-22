//@js/gsp
function generateDailyForeignRegularLcOpenedReports(){
	var tmpDailyForeignRegularLcOpenedUrl = dailyForeignRegularLcOpenedUrl;
	
	tmpDailyForeignRegularLcOpenedUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyForeignRegularLcOpenedUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpDailyForeignRegularLcOpenedUrl);
}

function init() {
	$('#viewDailyForeignRegularLcOpened').click(generateDailyForeignRegularLcOpenedReports);
}


$(init);