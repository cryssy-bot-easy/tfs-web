//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingBankGuarantyReport(){
	$("#reportName").val("outstandingBankGuaranty");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewOutstandingBankGuaranty').click(generateOutstandingBankGuarantyReport);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outstandingBankGuaranty(){
	var tmpOutstandingBankGuarantyUrl = outstandingBankGuarantyUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingBankGuarantyUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpOutstandingBankGuarantyUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


