function openFxForm1Schedule5PopUp(type){
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

function generateFxForm1Schedule5(cbReportType) {
	var tmpFxForm1Schedule5Url = fxForm1Schedule5Url;
	tmpFxForm1Schedule5Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule5Url += "&cbReportType=" + cbReportType;	
	window.open(tmpFxForm1Schedule5Url);
	/*
	if(cbReportType == "report"){
		window.open(tmpFxForm1Schedule5Url);
	} else {
		$.getJSON(tmpFxForm1Schedule5Url,{},function(data){}); 
	}
	*/
}

$(document).ready(function() {	
	$("#schedule5Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule5('report');
		}
	});
	
	$("#schedule5Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule5('text');
		}
	});
});