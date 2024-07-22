function openFxForm1Schedule9PopUp(type){
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

function generateFxForm1Schedule9(cbReportType) {
	var tmpFxForm1Schedule9Url = fxForm1Schedule9Url;
	tmpFxForm1Schedule9Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule9Url += "&cbReportType=" + cbReportType;	
	window.open(tmpFxForm1Schedule9Url);
}

$(document).ready(function() {	
	$("#schedule9Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule9('report');
		}
	});
	
	$("#schedule9Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule9('text');
		}
	});
});