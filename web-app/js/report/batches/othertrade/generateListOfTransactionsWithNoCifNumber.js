//@js/gsp
var popup_puc2 = "popup_processing_unit_code2";
var popup_bg_puc2= "popupBackground_processing_unit_code2";

function generateListOfTransactionsWithNoCifNumber(){
	$("#reportName").val("listOfTransactionsWithNoCifNumber");
	centerPopup(popup_puc2, popup_bg_puc2);
	loadPopup(popup_puc2, popup_bg_puc2);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewListOfTransactionsWithNoCifNumber').click(generateListOfTransactionsWithNoCifNumber);
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc2, popup_bg_puc2);
}

function generateListOfTransactionsWithNoCifNumberReport() {
	var tmpListOfTransactionsWithNoCifNumberUrl = listOfTransactionsWithNoCifNumberUrl;
	
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpListOfTransactionsWithNoCifNumberUrl += "?branchUnitCode=" + branchUnitCode;
	
	window.open(tmpListOfTransactionsWithNoCifNumberUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc2, popup_bg_puc2);	
}

