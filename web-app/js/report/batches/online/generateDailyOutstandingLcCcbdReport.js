//@js/gsp
function generateDailyOutstandingLcCcbdReport(){
	var tmpDailyOutstandingLcCcbdReportUrl = dailyOutstandingLcsCCBDUrl;
	
	tmpDailyOutstandingLcCcbdReportUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyOutstandingLcCcbdReportUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpDailyOutstandingLcCcbdReportUrl);

}

function init() {
	$('#viewDailyOutstandingLcCcbdReport').click(generateDailyOutstandingLcCcbdReport);
}


$(init);