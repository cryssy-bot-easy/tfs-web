//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsUsanceperCurrency(){
	$("#reportName").val("outFxlcUsanceperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcUsancePerCurrency').click(generateOutstandingFXLCsUsanceperCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcUsanceperCurr(){
	var tmpOutstandingForeignUsanceLcPerCurrencyUrl = outstandingForeignUsanceLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignUsanceLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignUsanceLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


