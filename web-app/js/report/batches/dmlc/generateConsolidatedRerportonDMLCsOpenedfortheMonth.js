//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateConsolidatedReportDmlcOpenedForTheMonth(){
	$("#reportName").val("consolidatedReportDmlcOpenedForTheMonth");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#monthlyConsolidatedDmLcsOpenedReport').click(generateConsolidatedReportDmlcOpenedForTheMonth);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function consolidatedReportDmlcOpenedForTheMonth(){
	var tmpConsolidated_Report_OnDmLcsOpened_for_dMonth_url = consolidated_Report_OnDmLcsOpened_for_dMonth_url;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();

	tmpConsolidated_Report_OnDmLcsOpened_for_dMonth_url += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpConsolidated_Report_OnDmLcsOpened_for_dMonth_url);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


