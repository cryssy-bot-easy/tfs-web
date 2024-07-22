//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsSightperImporter(){
	$("#reportName").val("outFxlcSightperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcSightPerImporter').click(generateOutstandingFXLCsSightperImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcSightperImporter(){
	var tmpOutstandingForeignSightLcPerImporterUrl = outstandingForeignSightLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignSightLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignSightLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


