//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsSightperCurrency(){
	$("#reportName").val("outFxlcSightperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcSightPerCurrency').click(generateOutstandingFXLCsSightperCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcSightperCurr(){
	var tmpOutstandingForeignSightLcPerCurrencyUrl = outstandingForeignSightLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignSightLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignSightLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


