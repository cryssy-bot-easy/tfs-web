//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateDMLCsOpenedfortheMonth(){
	$("#reportName").val("dmlcOpenedfortheMonth");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#monthlyDMLcOpenedReport').click(generateDMLCsOpenedfortheMonth);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function dmlcOpenedfortheMonth(){
	var tmpDMLcOpenedfordMonthUrl = dMLcOpenedfordMonthUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpDMLcOpenedfordMonthUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpDMLcOpenedfordMonthUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


