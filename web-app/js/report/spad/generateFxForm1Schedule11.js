function openFxForm1Schedule11PopUp(type){
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

function generateFxForm1Schedule11(cbReportType) {
	var tmpFxForm1Schedule11Url = fxForm1Schedule11Url;
	tmpFxForm1Schedule11Url += "?onlineReportDate=" + $("#onlineReportDate").val();	
	tmpFxForm1Schedule11Url += "&cbReportType=" + cbReportType;	

//	if(cbReportType == "report"){
		window.open(tmpFxForm1Schedule11Url);
//	} else {
//		$.getJSON(tmpFxForm1Schedule11Url,{},function(data){}); 
//	}
}

$(document).ready(function() {	
	$("#schedule11Report").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule11('report');
		}
	});
	
	$("#schedule11Text").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			generateFxForm1Schedule11('text');
		}
	});
});