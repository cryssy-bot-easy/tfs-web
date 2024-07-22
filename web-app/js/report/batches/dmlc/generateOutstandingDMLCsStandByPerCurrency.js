//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsStandByPerCurrency(){
	$("#reportName").val("outDmlcStandbyperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#OutstandingDmLcStandbyPerCurrency').click(generateOutstandingDMLCsStandByPerCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcStandbyperCurr(){
	var tmpOutstandingDomesticStandbyLcPerCurrencyUrl = OutstandingDomesticStandbyLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpOutstandingDomesticStandbyLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingDomesticStandbyLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


