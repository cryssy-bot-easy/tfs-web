//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateYTDReportonFXLCsOpenedClassifiedbytop30ImporterandAdvisingBankinUSD(){
	$("#reportName").val("ytdFxlcOpenedClassifiedbyBankinUSD");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#ytdReportFXLCOpenedClssfiedbyTop30').click(generateYTDReportonFXLCsOpenedClassifiedbytop30ImporterandAdvisingBankinUSD);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function ytdFxlcOpenedClassifiedbyBankinUSD(){
	var tmpYtdReport_on_FXLCOpenedClssfiedbyBankurl = ytdReport_on_FXLCOpenedClssfiedbyBankurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYtdReport_on_FXLCOpenedClssfiedbyBankurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYtdReport_on_FXLCOpenedClssfiedbyBankurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


