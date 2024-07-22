//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateFxNonLcsNegofortheYear(){
	$("#reportName").val("fxnonLcNegofortheYear");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#fxNonLcsNegofortheYear').click(generateFxNonLcsNegofortheYear);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function fxnonLcNegofortheYear(){
	var tmpFxNonLcsNegofortheYearurl = fxNonLcsNegofortheYearurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpFxNonLcsNegofortheYearurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpFxNonLcsNegofortheYearurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


