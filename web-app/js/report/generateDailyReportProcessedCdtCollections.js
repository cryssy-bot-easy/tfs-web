//@js/gsp
function generateDailyReportProcessedCdtCollections(){
			
	var tmpDailyReportProcessedCdtCollectionsUrl = dailyReportProcessedCdtCollectionsUrl;
	
	tmpDailyReportProcessedCdtCollectionsUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyReportProcessedCdtCollectionsUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	
	window.open(tmpDailyReportProcessedCdtCollectionsUrl);
}

function init() {
	$('#viewDailyReportProcessedCdtCollections').click(generateDailyReportProcessedCdtCollections);
}

$(init);