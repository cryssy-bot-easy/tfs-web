//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsSightperCurrency(){
	$("#reportName").val("outDmlcSightperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingDmLcSightPerCurrency').click(generateOutstandingDMLCsSightperCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcSightperCurr(){
	var tmpOutstandingDomesticSightLcPerCurrencyUrl = outstandingDomesticSightLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingDomesticSightLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;	
	window.open(tmpOutstandingDomesticSightLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


