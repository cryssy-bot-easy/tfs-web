//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingFXLCsStandByPerCurrency(){
	$("#reportName").val("outFxlcStandbyperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingFxlcStandByPerCurrency').click(generateOutstandingFXLCsStandByPerCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outFxlcStandbyperCurr(){
	var tmpOutstandingForeignStandbyLcPerCurrencyUrl = OutstandingForeignStandbyLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingForeignStandbyLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingForeignStandbyLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


