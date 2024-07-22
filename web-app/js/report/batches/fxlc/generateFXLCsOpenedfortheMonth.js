//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateFXLCsOpenedfortheMonth(){
	$("#reportName").val("fxlcOpenedfortheMonth");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#monthlyfxLcOpenedReport').click(generateFXLCsOpenedfortheMonth);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function fxlcOpenedfortheMonth(){
	var tmpfxLcOpendfordMnthUrl = fxLcOpendfordMnthUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpfxLcOpendfordMnthUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpfxLcOpendfordMnthUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


