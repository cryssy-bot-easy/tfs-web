//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsStandByPerImporter(){
	$("#reportName").val("outDmlcStandbyperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#OutstandingDmLcStandbyPerImporter').click(generateOutstandingDMLCsStandByPerImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcStandbyperImporter(){
	var tmpOutstandingDomesticStandbyLcPerImporterUrl = OutstandingDomesticStandbyLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpOutstandingDomesticStandbyLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingDomesticStandbyLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


