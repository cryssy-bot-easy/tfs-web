//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateAPOthers(){
	$("#reportName").val("APOthersReport");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#APOthers').click(generateAPOthers);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function APOthersReport() {
	var tmpapOthersurl = apOthersurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpapOthersurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpapOthersurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);	
}

