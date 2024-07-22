//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateProfitabilityMonitoring(profitMonitoringType){
	if(profitMonitoringType == 'ne') {
		$("#reportName").val("profitabilityMonitoringReport");
	} else {
		$("#reportName").val("profitabilityMonitoringExceptionReport");
	}
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewProfitabilityMonitoringReport').click(generateProfitabilityMonitoring);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateProfitabilityMonitoringReport(profitMonitoringReportType) {
	var tmpProfitabilityMonitoringReportUrl = profitabilityMonitoringReportUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpProfitabilityMonitoringReportUrl += "?branchUnitCode=" + branchUnitCode;
	
	if(profitMonitoringReportType == "notException") {
		tmpProfitabilityMonitoringReportUrl += "&profitMonitoringReportType=notException";
	} else {
		tmpProfitabilityMonitoringReportUrl += "&profitMonitoringReportType=exception";
	}
	
	window.open(tmpProfitabilityMonitoringReportUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

