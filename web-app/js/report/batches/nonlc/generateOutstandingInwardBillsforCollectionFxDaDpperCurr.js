//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingInwardBillsforCollectionFxDaDpperCurr(){
	$("#reportName").val("OutstandingInwardBillsCollectionFX");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingInwardBillsforCollectionFxDaDpperCurr').click(generateOutstandingInwardBillsforCollectionFxDaDpperCurr);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function OutstandingInwardBillsCollectionFX(){
	var tmpOutstandingInwardBillsForCollectionFxDaDpPerCurrurl = outstandingInwardBillsForCollectionFxDaDpPerCurrurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpOutstandingInwardBillsForCollectionFxDaDpPerCurrurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingInwardBillsForCollectionFxDaDpPerCurrurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


