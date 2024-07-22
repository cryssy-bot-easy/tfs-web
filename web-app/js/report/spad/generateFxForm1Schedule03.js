function openFxForm1Schedule3PopUp(type){
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

function generateFxForm1Schedule3(cbReportType) {
	var tmpFxForm1Schedule3Url = fxForm1Schedule3Url;
	tmpFxForm1Schedule3Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule3Url += "&cbReportType=" + cbReportType;	
	window.open(tmpFxForm1Schedule3Url);
}

$(document).ready(function() {	
	$("#schedule3Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule3('report');
		}
	});
	
	$("#schedule3Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule3('text');
		}
	});
});