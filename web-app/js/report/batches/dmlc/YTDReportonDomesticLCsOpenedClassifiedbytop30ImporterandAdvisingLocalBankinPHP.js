//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function YTDReportonDomesticLCsOpenedClassifiedbytop30ImporterandAdvisingLocalBankinPHP(){
	$("#reportName").val("ytdDmlcOpenedClassifiedbyBankingPHP");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#ytdDMLCOpenedClssfiedbyBankReport').click(YTDReportonDomesticLCsOpenedClassifiedbytop30ImporterandAdvisingLocalBankinPHP);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function ytdDmlcOpenedClassifiedbyBankingPHP(){
	var tmpYtdReport_on_DMLCOpenedClssfiedbyBankurl = ytdReport_on_DMLCOpenedClssfiedbyBankurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpYtdReport_on_DMLCOpenedClssfiedbyBankurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpYtdReport_on_DMLCOpenedClssfiedbyBankurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


