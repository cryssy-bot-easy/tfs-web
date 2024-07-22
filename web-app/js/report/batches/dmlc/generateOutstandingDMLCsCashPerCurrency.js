//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsCashPerCurrency(){
	$("#reportName").val("outsDmlcCashperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingDmLcCashPerCurrency').click(generateOutstandingDMLCsCashPerCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outsDmlcCashperCurr(){
	var tmpOutstandingDomesticCashLcPerCurrencyUrl = OutstandingDomesticCashLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingDomesticCashLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;	
	window.open(tmpOutstandingDomesticCashLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


