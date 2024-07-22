//@js/gsp
function generateConsolidatedRerportonFXLCsOpenedfortheMonth(){
	$("#reportName").val("consolidatedReportFxlcOpenedForTheMonth");
	centerPopup("popup_processing_unit_code","popupBackground_processing_unit_code");
	loadPopup("popup_processing_unit_code","popupBackground_processing_unit_code");
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

//CLOSE POPUP FUNCTION IN generateConsolidatedReportonDMLCsOpenedfortheMonth.js

function consolidatedReportFxlcOpenedForTheMonth(){
	var generateConsolidatedReportFXLCUrl = consolidated_Report_OnFXLcsOpened_for_dMonth_url;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();		
		
	generateConsolidatedReportFXLCUrl += "?branchUnitCode=" + branchUnitCode;
	$("#batchProcessingUnitCodeTxt").val("");	
	window.open(generateConsolidatedReportFXLCUrl);
	disablePopup("popup_processing_unit_code","popupBackground_processing_unit_code");
}

function init() {
	$('#monthlyConsolidatedFxlcReport').click(generateConsolidatedRerportonFXLCsOpenedfortheMonth);
}


$(init);