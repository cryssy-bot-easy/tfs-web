//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateQuarterlyReportonFXLCsStandbyOpened(){
	$("#reportName").val("quarterlyFxlcStandbyOpened");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#QuarterlyFxLcsStandybyOpenedReport').click(generateQuarterlyReportonFXLCsStandbyOpened);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function quarterlyFxlcStandbyOpened(){
	var tmpQuarterlyReportOnForeignStandybyLcsOpenedUrl = QuarterlyReportOnForeignStandybyLcsOpenedUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpQuarterlyReportOnForeignStandybyLcsOpenedUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpQuarterlyReportOnForeignStandybyLcsOpenedUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


