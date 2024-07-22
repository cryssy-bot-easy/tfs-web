//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingExportNegotiationForeign(){
	$("#reportName").val("outExportNegoForeign");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$("#outstandingExportNegotiationForeign").click(generateOutstandingExportNegotiationForeign);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outExportNegoForeign() {
	var tmpOutstandingExportNegotiationForeignUrl = outstandingExportNegotiationForeignUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingExportNegotiationForeignUrl += "?branchUnitCode=" + branchUnitCode;
	tmpOutstandingExportNegotiationForeignUrl += "&onlineReportDate=" + $("#onlineReportDate").val();
	window.open(tmpOutstandingExportNegotiationForeignUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);	
}


//$(initOutstandingExportNegotiationDomestic);