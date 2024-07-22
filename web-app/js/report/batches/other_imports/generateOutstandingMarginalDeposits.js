//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingMarginalDepositsReport(){
	$("#reportName").val("OutstandingMarginalDeposit");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewOutstandingMarginalDeposits').click(generateOutstandingMarginalDepositsReport);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function OutstandingMarginalDeposit(){
		var tmpOutstandingMarginalDepositsUrl = outstandingMarginalDepositsUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingMarginalDepositsUrl += "?branchUnitCode=" + branchUnitCode;
//	tmpOutstandingMarginalDepositsUrl += "&processingUnitCode=" + processingUnitCode;

	window.open(tmpOutstandingMarginalDepositsUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


