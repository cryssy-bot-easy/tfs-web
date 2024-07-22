//@js/gsp
function generateOutgoingMtReport(){
	var tmpOutgoingMtUrl = outgoingMtUrl;
	
	tmpOutgoingMtUrl += "?telecomReportDate=" + $("#telecomReportDate").val();

	window.open(tmpOutgoingMtUrl);
	mDisablePopup(popup_telecom_reports_div, popup_telecom_reports_bg);
}

function init() {
	$(".generateOutgoingMt").click(function(){
		mCenterPopup($("#telecomReportsPopup"), $("#popupBackground_telecom_reports"));
		mLoadPopup($("#telecomReportsPopup"), $("#popupBackground_telecom_reports"));
	});
	$("#generateOutgoingMt").click(generateOutgoingMtReport);
}

function closeTelecomReportsPopUp() {
	mDisablePopup($("#telecomReportsPopup"), $("#popupBackground_telecom_reports"));
}

$(init);