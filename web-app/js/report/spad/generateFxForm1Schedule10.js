function openFxForm1Schedule10PopUp(type){
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

function generateFxForm1Schedule10(cbReportType) {
	var tmpFxForm1Schedule10Url = fxForm1Schedule10Url;
	tmpFxForm1Schedule10Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule10Url += "&cbReportType=" + cbReportType;	
	window.open(tmpFxForm1Schedule10Url);
}

$(document).ready(function() {	
	$("#schedule10Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule10('report');
		}
	});
	
	$("#schedule10Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule10('text');
		}
	});
});