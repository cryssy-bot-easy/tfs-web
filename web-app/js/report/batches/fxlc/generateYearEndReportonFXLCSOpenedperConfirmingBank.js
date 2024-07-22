//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYearEndReportonFXLCSOpenedperConfirmingBank(){
	$("#reportName").val("yearEndFxlcOpenedperConfirming");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#yearEndFxLcsOpenedPerConfirmingBankReport').click(generateYearEndReportonFXLCSOpenedperConfirmingBank);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function yearEndFxlcOpenedperConfirming(){
	var tmpYearEndReportOnForeignLcsOpenedPerConfirmingBankUrl = YearEndReportOnForeignLcsOpenedPerConfirmingBankUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYearEndReportOnForeignLcsOpenedPerConfirmingBankUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYearEndReportOnForeignLcsOpenedPerConfirmingBankUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


