function openFxForm1Schedule4PopUp(type){
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

function generateFxForm1Schedule4(cbReportType) {
	var tmpFxForm1Schedule4Url = fxForm1Schedule4Url;
	tmpFxForm1Schedule4Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule4Url += "&cbReportType=" + cbReportType;	
	
	if(cbReportType == "report"){
		window.open(tmpFxForm1Schedule4Url);
	} else {
		$.getJSON(tmpFxForm1Schedule4Url,{},function(data){}); 
	}
}

$(document).ready(function() {	
	$("#schedule4Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule4('report');
		}
	});
	
	$("#schedule4Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule4('text');
		}
	});
});