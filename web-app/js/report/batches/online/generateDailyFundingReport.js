//@js/gsp
function generateDailyFundingReport(){
	var tmpDailyFundingReportUrl = dailyFundingUrl;
	
	tmpDailyFundingReportUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyFundingReportUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	window.open(tmpDailyFundingReportUrl);

}

function init() {
	$('#viewDailyFundingReport').click(generateDailyFundingReport);
}


$(init);