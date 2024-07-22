//@js/gsp
function generateConsolidatedReportDailyCollectionsExportDocumentaryStampFees(consolidatedReportType){
			
	var tmpConsolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl = consolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl;

	tmpConsolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl += "?consolidatedReportType=" + consolidatedReportType;
	tmpConsolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl += "&onlineReportDate=" + $("#onlineReportDate").val();

	window.open(tmpConsolidatedReportDailyCollectionsExportDocumentaryStampFeesUrl);
}

function init() {
//	$('#viewConsolidatedReportDailyCollectionsExportDocumentaryStampFees').click(generateConsolidatedReportDailyCollectionsExportDocumentaryStampFees);
}

$(init);