//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateAROthers(){
	$("#reportName").val("AROthersReport");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#AROthers').click(generateAROthers);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function AROthersReport(){
	var tmparOthersurl = arOthersurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmparOthersurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmparOthersurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


