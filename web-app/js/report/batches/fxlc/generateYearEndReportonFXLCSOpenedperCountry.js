//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYearEndReportonFXLCSOpenedperCountry(){
	$("#reportName").val("yearEndFxlcOpenedperCountry");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#yearEndFxLcsOpenedPerCountryReport').click(generateYearEndReportonFXLCSOpenedperCountry);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function yearEndFxlcOpenedperCountry(){
	var tmpYearEndReportOnForeignLcsOpenedPerCountryUrl = YearEndReportOnForeignLcsOpenedPerCountryUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYearEndReportOnForeignLcsOpenedPerCountryUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYearEndReportOnForeignLcsOpenedPerCountryUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


