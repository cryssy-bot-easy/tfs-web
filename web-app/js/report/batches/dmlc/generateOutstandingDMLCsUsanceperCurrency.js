//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingDMLCsUsanceperCurrency(){
	$("#reportName").val("outDmlcUsanceperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingDomesticLcUsancePerCurrency').click(generateOutstandingDMLCsUsanceperCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outDmlcUsanceperCurr(){
		var tmpOutstandingDomesticUsanceLcPerCurrencyUrl = outstandingDomesticUsanceLcPerCurrencyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingDomesticUsanceLcPerCurrencyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingDomesticUsanceLcPerCurrencyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


