//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateExportNegofortheMonthperClient(){
	$("#reportName").val("exportNegoperClient");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#exportNegofortheMonthperClient').click(generateExportNegofortheMonthperClient);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function exportNegoperClient(){
	var tmpExportNegofortheMonthperClienturl = exportNegofortheMonthperClienturl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpExportNegofortheMonthperClienturl += "?branchUnitCode=" + branchUnitCode;	
	window.open(tmpExportNegofortheMonthperClienturl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


