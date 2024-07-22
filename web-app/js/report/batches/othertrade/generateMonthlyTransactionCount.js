//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateMonthlyTransactionCount(){
	$("#reportName").val("monthlyTransactionCount");
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewMonthlyTransactionCount').click(generateMonthlyTransactionCount);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateMonthlyTransactionCountReport() {
	var tmpMonthlyTransactionCountUrl = monthlyTransactionCountUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpMonthlyTransactionCountUrl += "?branchUnitCode=" + branchUnitCode;
	
	window.open(tmpMonthlyTransactionCountUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

