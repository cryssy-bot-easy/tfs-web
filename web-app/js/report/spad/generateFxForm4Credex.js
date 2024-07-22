function openFxForm4CredexPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id', 'fxForm4CredexReport');
	mCenterPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
	mLoadPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
}

function generateFxForm4Credex() {
	var tmpFxForm4CredexUrl = fxForm4CredexUrl;
	tmpFxForm4CredexUrl += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm4CredexUrl += "&cbReportType=report";	
	window.open(tmpFxForm4CredexUrl);
}

$(document).ready(function() {	
	$("#fxForm4CredexReport").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm4Credex();
		}
	});
});