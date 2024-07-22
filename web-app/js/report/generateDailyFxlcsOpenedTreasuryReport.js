//@js/gsp
function generateDailyFxlcsOpenedTreasuryReport(){

	var tmpDailyFxlcsOpenedTreasuryReportUrl = dailyFxlcsOpenedTreasuryReportUrl;
	window.open(tmpDailyFxlcsOpenedTreasuryReportUrl);

}

function init() {
	$('#viewDailyFxlcsOpenedTreasuryReport').click(generateDailyFxlcsOpenedTreasuryReport);
}


$(init);