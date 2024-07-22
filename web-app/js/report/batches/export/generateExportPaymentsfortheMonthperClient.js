//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateExportPaymentsfortheMonthperClient(){
	$("#reportName").val("exportPaymentperClient");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#exportPaymentsfortheMonthperClient').click(generateExportPaymentsfortheMonthperClient);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function exportPaymentperClient(){
	var tmpExportPaymentsfortheMonthperClienturl = exportPaymentsfortheMonthperClienturl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpExportPaymentsfortheMonthperClienturl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpExportPaymentsfortheMonthperClienturl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


