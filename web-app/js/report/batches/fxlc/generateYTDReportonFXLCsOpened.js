//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYTDReportonFXLCsOpened(){
	$("#reportName").val("ytdFxlcOpened");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#ytdFXLCOpenedReport').click(generateYTDReportonFXLCsOpened);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function ytdFxlcOpened(){
	var tmpYtdReport_on_FXLCOpenedurl = ytdReport_on_FXLCOpenedurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYtdReport_on_FXLCOpenedurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYtdReport_on_FXLCOpenedurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


