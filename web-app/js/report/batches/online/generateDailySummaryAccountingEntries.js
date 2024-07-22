//@js/gsp
function generateDailySummaryAccountingEntries(reportType){
	var tmpDailySummaryAccountingEntriesUrl = dailySummaryOfAccountingEntriesUrl;
	
	tmpDailySummaryAccountingEntriesUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailySummaryAccountingEntriesUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	tmpDailySummaryAccountingEntriesUrl += "&reportType=" + reportType;
	
	window.open(tmpDailySummaryAccountingEntriesUrl);

}

//function init() {
//	$('#viewDailySummaryAccountingEntries').click(generateDailySummaryAccountingEntries);
//}


//$(init);