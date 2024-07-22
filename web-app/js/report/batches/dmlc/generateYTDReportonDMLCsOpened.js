//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYTDReportonDMLCsOpened(){
	$("#reportName").val("ytdDmlcOpened");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#ytdDMLCOpenedReport').click(generateYTDReportonDMLCsOpened);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function ytdDmlcOpened(){
	var tmpYtdReport_on_DMLCOpenedurl = ytdReport_on_DMLCOpenedurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYtdReport_on_DMLCOpenedurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYtdReport_on_DMLCOpenedurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


