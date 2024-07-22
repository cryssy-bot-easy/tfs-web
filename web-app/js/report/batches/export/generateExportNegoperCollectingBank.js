//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateExportNegoperCollectingBank(){
	$("#reportName").val("exportNegoperCollectionBank");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#exportNegoperCollectingBank').click(generateExportNegoperCollectingBank);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function exportNegoperCollectionBank(){
	var tmpExportNegoperCollectingBankurl = exportNegoperCollectingBankurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpExportNegoperCollectingBankurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpExportNegoperCollectingBankurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


