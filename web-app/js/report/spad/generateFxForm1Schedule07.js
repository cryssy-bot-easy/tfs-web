function openFxForm1Schedule7PopUp(type){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id', type);
	mCenterPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
	mLoadPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
}

function generateFxForm1Schedule7(cbReportType) {
	var tmpFxForm1Schedule7Url = fxForm1Schedule7Url;
	tmpFxForm1Schedule7Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule7Url += "&cbReportType=" + cbReportType;	
	window.open(tmpFxForm1Schedule7Url);
}

$(document).ready(function() {	
	$("#schedule7Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule7('report');
		}
	});
	
	$("#schedule7Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule7('text');
		}
	});
});