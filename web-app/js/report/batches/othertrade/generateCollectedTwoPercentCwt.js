//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateCollectedTwoPercentCwt(){
	$("#reportName").val("collectedTwoPercentCwt");
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewCollectedTwoPercentCwt').click(generateCollectedTwoPercentCwt);
});


function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateCollectedTwoPercentCwtReport() {
	var tmpCollectedTwoPercentCwtUrl = collectedTwoPercentCwtUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpCollectedTwoPercentCwtUrl += "?branchUnitCode=" + branchUnitCode;
	
	window.open(tmpCollectedTwoPercentCwtUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

