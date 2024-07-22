//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generaterunDailySummaryOfAccountingEntries(){
	$("#reportName").val("dailSummOfAccEntry");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#dailySummaryOfAccountingEntries').click(generaterunDailySummaryOfAccountingEntries); //id @ accordion
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function dailSummOfAccEntry(){
	var tmpDailySummaryOfAccountingEntriesUrl = dailySummaryOfAccountingEntriesUrl; //var @ accordion
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpDailySummaryOfAccountingEntriesUrl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpDailySummaryOfAccountingEntriesUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}


