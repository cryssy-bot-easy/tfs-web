//@js/gsp
function generateDailyOutstandingFxlcsTreasuryReport(){

	var tmpDailyOutstandingFxlcsTreasuryReportUrl = dailyOutstandingFxlcsTreasuryReportUrl;
	window.open(tmpDailyOutstandingFxlcsTreasuryReportUrl);

}

function init() {
	$('#viewDailyOutstandingFxlcsTreasuryReport').click(generateDailyOutstandingFxlcsTreasuryReport);
}


$(init);