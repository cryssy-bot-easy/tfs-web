//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateDwException(){
	$("#reportName").val("dwExceptionReport");
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewDwExceptionReport').click(generateDwException);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateDwExceptionReport() {
	var tmpDwExceptionReportUrl = dwExceptionReportUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpDwExceptionReportUrl += "?branchUnitCode=" + branchUnitCode;
	
	window.open(tmpDwExceptionReportUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

