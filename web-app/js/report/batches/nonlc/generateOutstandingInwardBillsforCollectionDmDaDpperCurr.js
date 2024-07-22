//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingInwardBillsforCollectionDmDaDpperCurr(){
	$("#reportName").val("outstandingInwardBillsCollectionDM");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#outstandingInwardBillsforCollectionDmDaDpperCurr').click(generateOutstandingInwardBillsforCollectionDmDaDpperCurr);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outstandingInwardBillsCollectionDM(){
	var tmpOutstandingInwardBillsForCollectionDmDaDpPerCurrurl = outstandingInwardBillsForCollectionDmDaDpPerCurrurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpOutstandingInwardBillsForCollectionDmDaDpPerCurrurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingInwardBillsForCollectionDmDaDpPerCurrurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


