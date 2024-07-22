//@js/gsp
function generateDailyOutstandingForeignLcReports(){
	var tmpDailyOutstandingForeignLcUrl = dailyOutstandingForeignLcUrl;
	
	tmpDailyOutstandingForeignLcUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyOutstandingForeignLcUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpDailyOutstandingForeignLcUrl);

}

function init() {
	$('#viewDailyOutstandingForeignLc').click(generateDailyOutstandingForeignLcReports);
}


$(init);