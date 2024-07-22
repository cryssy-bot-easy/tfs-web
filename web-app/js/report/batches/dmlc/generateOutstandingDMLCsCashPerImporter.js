//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsCashPerImporter(){
	$("#reportName").val("outDmlcCashperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#OutstandingDmLcCashPerImporter').click(generateOutstandingDMLCsCashPerImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcCashperImporter(){
	var tmpOutstandingDomesticCashLcPerImporterUrl = OutstandingDomesticCashLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpOutstandingDomesticCashLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingDomesticCashLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


