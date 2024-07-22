function openBatchDebitMemoPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id', "batchDebitMemo");
	mCenterPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
	mLoadPopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
}

function initGenerateBatchDebitMemo() {
	var paidDateFormat = null;
	var onlineReportDateFormat = null;
	
	$("#batchDebitMemo").live("click", function() {
		if($("#onlineReportDate").val() == "") {
			alert("Please fill in the required fields.");
		} else {
			var tmpBatchDebitMemoUrl = null;
			
			mDisablePopup($("#onlineReportsPopup"), $("#popupBackground_online_reports"));
			
		    tmpBatchDebitMemoUrl = batchDebitMemoUrl;
			tmpBatchDebitMemoUrl += "?onlineReportDate=" + $("#onlineReportDate").val();
			tmpBatchDebitMemoUrl += "&unitCode=" + unitcode;
			
			window.open(tmpBatchDebitMemoUrl)
		}
	});
	
}

$(initGenerateBatchDebitMemo);