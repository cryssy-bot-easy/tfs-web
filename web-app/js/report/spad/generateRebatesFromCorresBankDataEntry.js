function openRebatesFromCorresBankDataEntryPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','rebatesFromCorresBankDataEntrySpad');
	mCenterPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
	mLoadPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
}

function generateRebatesFromCorresBankDataEntry() {
	var tmpRebatesFromCorresBankDataEntryUrl = rebatesFromCorresBankDataEntryUrl;
	tmpRebatesFromCorresBankDataEntryUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
	window.open(tmpRebatesFromCorresBankDataEntryUrl);
}

$(document).ready(function() {
//	$("#rebatesFromCorresBankDataEntrySpad").click(generateRebatesFromCorresBankDataEntry);
	
	$("#rebatesFromCorresBankDataEntrySpad").live("click", function(){
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateRebatesFromCorresBankDataEntry();		
		}
	});
});