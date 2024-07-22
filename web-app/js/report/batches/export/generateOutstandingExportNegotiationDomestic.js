//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateOutstandingExportNegotiationDomestic(){
	
	$("#reportName").val("outExportNegoDomestic");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$("#outstandingExportNegotiationDomestic").click(generateOutstandingExportNegotiationDomestic);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function outExportNegoDomestic() {
	
	var tmpOutstandingExportNegotiationDomesticUrl = outstandingExportNegotiationDomesticUrl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpOutstandingExportNegotiationDomesticUrl += "?branchUnitCode=" + branchUnitCode;	
	tmpOutstandingExportNegotiationDomesticUrl += "&onlineReportDate=" + $("#onlineReportDate").val();
	window.open(tmpOutstandingExportNegotiationDomesticUrl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);	
}


//$(initOutstandingExportNegotiationDomestic);