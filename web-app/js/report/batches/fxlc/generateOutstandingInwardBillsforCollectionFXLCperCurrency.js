//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingInwardBillsforCollectionFXLCperCurrency(){
	$("#reportName").val("outInwardBillsforCollectionperCurr");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#OutstandingInwardBillsforCollectionFXLCperCurr').click(generateOutstandingInwardBillsforCollectionFXLCperCurrency);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outInwardBillsforCollectionperCurr(){
	var tmpOutstandingInwardBillsforCollectionFXLCperCurrurl = outstandingInwardBillsforCollectionFXLCperCurrurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpOutstandingInwardBillsforCollectionFXLCperCurrurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingInwardBillsforCollectionFXLCperCurrurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


