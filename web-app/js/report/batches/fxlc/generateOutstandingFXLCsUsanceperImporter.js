//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsUsanceperImporter(){
	$("#reportName").val("outFxlcUsanceperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcUsancePerImporter').click(generateOutstandingFXLCsUsanceperImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcUsanceperImporter(){
	var tmpOutstandingForeignUsanceLcPerImporterUrl = outstandingForeignUsanceLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignUsanceLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignUsanceLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


