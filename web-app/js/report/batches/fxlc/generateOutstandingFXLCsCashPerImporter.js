//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsCashPerImporter(){
	$("#reportName").val("outFxlcCashperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcCashPerImporter').click(generateOutstandingFXLCsCashPerImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcCashperImporter(){
	var tmpOutstandingForeignCashLcPerImporterUrl = OutstandingForeignCashLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignCashLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignCashLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


