//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsUsanceperImporter(){
	$("#reportName").val("outDmlcUsanceperImporter");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingDomesticLcUsancePerImporter').click(generateOutstandingDMLCsUsanceperImporter);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcUsanceperImporter(){
	var tmpOutstandingDomesticUsanceLcPerImporterUrl = outstandingDomesticUsanceLcPerImporterUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingDomesticUsanceLcPerImporterUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingDomesticUsanceLcPerImporterUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


