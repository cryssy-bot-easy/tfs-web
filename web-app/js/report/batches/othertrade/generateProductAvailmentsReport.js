//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateProductAvailments(productAvailType){
	if(productAvailType == "ne") {
		$("#reportName").val("productAvailmentsReport");
	} else {
		$("#reportName").val("productAvailmentsExceptionReport");
	}
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewProductAvailmentsReport').click(generateProductAvailments);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateProductAvailmentsReport(productAvailReportType) {
	var tmpProductAvailmentsReportUrl = productAvailmentsReportUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpProductAvailmentsReportUrl += "?branchUnitCode=" + branchUnitCode;
	
	if(productAvailReportType == "notException") {
		tmpProductAvailmentsReportUrl += "&productAvailReportType=notException";
	} else {
		tmpProductAvailmentsReportUrl += "&productAvailReportType=exception";
	}
	
	window.open(tmpProductAvailmentsReportUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

