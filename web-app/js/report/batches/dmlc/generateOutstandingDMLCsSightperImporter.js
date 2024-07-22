//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsSightperImporter(){
	$("#reportName").val("outDmlcSightperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingDmSightLcPerImporter').click(generateOutstandingDMLCsSightperImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcSightperImporter(){
	var tmpOutstandingDomesticSightLcPerImporterUrl = outstandingDomesticSightLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingDomesticSightLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;	
	window.open(tmpOutstandingDomesticSightLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


