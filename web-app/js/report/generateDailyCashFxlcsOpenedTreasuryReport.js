//@js/gsp
function generateDailyCashFxlcsOpenedTreasuryReport(){

	var tmpDailyCashFxlcsOpenedTreasuryReportUrl = dailyCashFxlcsOpenedTreasuryReportUrl;
	window.open(tmpDailyCashFxlcsOpenedTreasuryReportUrl);

}

function init() {
	$('#viewDailyCashFxlcsOpenedTreasuryReport').click(generateDailyCashFxlcsOpenedTreasuryReport);
}


$(init);