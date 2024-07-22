//@js/gsp
function generateDailyFxlcOpenedReportCdtDetails(){
			
	var tmpDailyFxlcOpenedReportCdtDetailsUrl = dailyFxlcOpenedReportCdtDetailsUrl;
	
	tmpDailyFxlcOpenedReportCdtDetailsUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	tmpDailyFxlcOpenedReportCdtDetailsUrl += "&branchUnitCode=" + $("#onlineReportPuc").val();
	
	window.open(tmpDailyFxlcOpenedReportCdtDetailsUrl);
}

function init() {
	$('#viewDailyFxlcOpenedReportCdtDetails').click(generateDailyFxlcOpenedReportCdtDetails);
}

$(init);