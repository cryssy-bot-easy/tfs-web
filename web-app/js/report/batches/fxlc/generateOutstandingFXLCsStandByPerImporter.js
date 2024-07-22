//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsStandByPerImporter(){
	$("#reportName").val("outFxlcStandbyperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcStandByPerImporter').click(generateOutstandingFXLCsStandByPerImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcStandbyperImporter(){
	var tmpOutstandingForeignStandbyLcPerImporterUrl = OutstandingForeignStandbyLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignStandbyLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignStandbyLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


