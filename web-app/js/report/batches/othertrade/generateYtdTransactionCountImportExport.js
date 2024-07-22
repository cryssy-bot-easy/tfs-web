//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateYtdTransactionCountImportExport(){
	$("#reportName").val("ytdTransactionCountImportExport");
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewYtdTransactionCountImportExport').click(generateYtdTransactionCountImportExport);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateYtdTransactionCountImportExportReport() {
	var tmpYtdTransactionCountImportExportUrl = ytdTransactionCountImportExportUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpYtdTransactionCountImportExportUrl += "?branchUnitCode=" + branchUnitCode;
	
	window.open(tmpYtdTransactionCountImportExportUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

