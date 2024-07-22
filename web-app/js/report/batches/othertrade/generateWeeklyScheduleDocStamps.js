//@js/gsp
var popup_puc = "popup_processing_unit_code";
var popup_bg_puc= "popupBackground_processing_unit_code";

function generateWeeklyScheduleDocStamps(){
	$("#reportName").val("weeklyScheduleDocStamps");
	centerPopup(popup_puc, popup_bg_puc);
	loadPopup(popup_puc, popup_bg_puc);
	$("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#viewWeeklyScheduleDocStampsTR').click({param:"viewWeeklyScheduleDocStampsTR"},generateWeeklyScheduleDocStampsReport);
	$('#viewWeeklyScheduleDocStamps108').click({param:"viewWeeklyScheduleDocStamps108"},generateWeeklyScheduleDocStampsReport);
	$('#viewWeeklyScheduleDocStamps113').click({param:"viewWeeklyScheduleDocStamps113"},generateWeeklyScheduleDocStampsReport);
	$('#weeklyForeignDomesticOpenLC').click({param:"weeklyForeignDomesticOpenLC"},generateWeeklyScheduleDocStampsReport);
	
});

function closePopUpProcessingCode(){
	disablePopup(popup_puc, popup_bg_puc);
}

function generateWeeklyScheduleDocStampsReport(event) {
	var tmpWeeklyScheduleDocStampsUrl = weeklyScheduleDocStampsUrl;
	
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	
	tmpWeeklyScheduleDocStampsUrl += "?branchUnitCode=" + branchUnitCode;
	tmpWeeklyScheduleDocStampsUrl += "&reportType=" + event.data.param;

	window.open(tmpWeeklyScheduleDocStampsUrl);
	
	$("#batchProcessingUnitCodeTxt").val("");	
	
	disablePopup(popup_puc, popup_bg_puc);	
}

