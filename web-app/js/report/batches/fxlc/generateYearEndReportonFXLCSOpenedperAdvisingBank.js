//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYearEndReportonFXLCSOpenedperAdvisingBank(){
	$("#reportName").val("yearEndFxlcOpenedperAdvising");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#yearEndFxLcsOpenedPerAdvisingBankReport').click(generateYearEndReportonFXLCSOpenedperAdvisingBank);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function yearEndFxlcOpenedperAdvising(){
	var tmpYearEndReportOnForeignLcsOpenedPerAdvisingBankUrl = YearEndReportOnForeignLcsOpenedPerAdvisingBankUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYearEndReportOnForeignLcsOpenedPerAdvisingBankUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYearEndReportOnForeignLcsOpenedPerAdvisingBankUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


