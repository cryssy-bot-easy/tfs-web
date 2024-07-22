//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateWeeklyReportonMaturingUsanceLcs(){
	$("#reportName").val("weeklyMaturingUsance");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#weeklyMaturingUsanceReport').click(generateWeeklyReportonMaturingUsanceLcs);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function weeklyMaturingUsance(){
	var tempWeeklyReportMaturingUsanceLcUrl = WeeklyReport_on_MaturingusanceLCurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tempWeeklyReportMaturingUsanceLcUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tempWeeklyReportMaturingUsanceLcUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


