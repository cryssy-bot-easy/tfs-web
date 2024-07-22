//@js/gsp
var popup_outbills = "popup_processing_unit_code";
var popup_bg_outbills= "popupBackground_processing_unit_code";

function generateDmNonLcsNegofortheYear(){
	$("#reportName").val("dmNonLcNegofortheYear");
	centerPopup(popup_outbills,popup_bg_outbills);
	loadPopup(popup_outbills,popup_bg_outbills);
	  $("#batchProcessingUnitCodeTxt").focus(); 
}

$(function () {
	$('#dmNonLcsNegofortheYear').click(generateDmNonLcsNegofortheYear);
});

function closePopUpProcessingCode(){
	disablePopup(popup_outbills,popup_bg_outbills);
}

function dmNonLcNegofortheYear(){
	var tmpdmNonLcsNegofortheYearurl = dmNonLcsNegofortheYearurl;
	var branchUnitCode = $("#batchProcessingUnitCodeTxt").val();
	tmpdmNonLcsNegofortheYearurl += "?branchUnitCode=" + branchUnitCode;
	window.open(tmpdmNonLcsNegofortheYearurl);
	$("#batchProcessingUnitCodeTxt").val("");	
	disablePopup(popup_outbills,popup_bg_outbills);
}
	


