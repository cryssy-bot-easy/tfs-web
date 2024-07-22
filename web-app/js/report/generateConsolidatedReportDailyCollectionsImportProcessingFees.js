//@js/gsp
function generateConsolidatedReportDailyCollectionsImportProcessingFees(consolidatedReportType){
			
	var tmpConsolidatedReportDailyCollectionsImportProcessingFeesUrl = consolidatedReportDailyCollectionsImportProcessingFeesUrl;

	tmpConsolidatedReportDailyCollectionsImportProcessingFeesUrl += "?consolidatedReportType=" + consolidatedReportType;
	tmpConsolidatedReportDailyCollectionsImportProcessingFeesUrl += "&onlineReportDate=" + $("#onlineReportDate").val();
	
	window.open(tmpConsolidatedReportDailyCollectionsImportProcessingFeesUrl);
}

function init() {
//	$('#viewConsolidatedReportDailyCollectionsImportProcessingFees').click(generateConsolidatedReportDailyCollectionsImportProcessingFees);
}

$(init);