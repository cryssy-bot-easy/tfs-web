//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateVolumetrics(){
	$("#reportName").val("volumetrics");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#volumetricReport').click(generateVolumetrics);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function generateVolumetricsReport() {
	var tmpVolumetricsUrl = volumetricsUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpVolumetricsUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpVolumetricsUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);	
}

