function openActualCorresChargesDataEntryPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','actualCorresChargesDataEntrySpad');
	mCenterPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
	mLoadPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
}

function generateActualCorresChargesDataEntry() {
	var tmpActualCorresChargesDataEntryUrl = actualCorresChargesDataEntryUrl;
	tmpActualCorresChargesDataEntryUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	window.open(tmpActualCorresChargesDataEntryUrl);
}

function generateFxForm1Schedule5() {
	var tmpFxForm1Schedule5Url = fxForm1Schedule5Url;
	tmpFxForm1Schedule5Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	window.open(tmpFxForm1Schedule5Url);
}

$(document).ready(function() {
//	$("#actualCorresChargesDataEntrySpad").click(generateActualCorresChargesDataEntry);
	
	$("#actualCorresChargesDataEntrySpad").live("click", function(){
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule5();		
		}
	});
});