var popup_online_reports_div = $("#onlineReportsPopup");
var popup_online_reports_bg = $("#popupBackground_online_reports");

function openDailyForeignRegularLcOpenedPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyFxRegularLcOpened');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyForeignCashLcOpenedPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyFxCashLcOpened');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyOutstandingForeignLcPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyOutstandingForeignLc');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyFundingReportPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyFundingReport');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyOutstandingLcCcbdReportPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyOutstandingLcCcbdReport');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailySummaryAccountingEntriesPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").show();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailySummaryAccountingEntries');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyExceptionReportAccountingEntriesPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").show();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyExceptionReportAccountingEntries');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openAMLAReportedTransactionsPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").show();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("909");
	$(".buttonPopupGenDocument").attr('id','generateTradeServicesAMLAReportedTransactions');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openTFSCASAPostingPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").show();
	$(".viewOnlineReportTellerID").show();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateOpenTFSCASAPosting');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyReportProcessedRefundsPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").hide();
	$(".viewDateTransaction").show();
	$(".viewOnlineReportPuc").show();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyReportProcessedRefunds');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openConsolidatedDailyReportsDepositCollected(consolidatedReportType){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	
	if(consolidatedReportType == 'remittance') {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedDailyReportDepositsCollectedRemittance');
	} else {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedDailyReportDepositsCollected');
	}
	
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openConsolidatedDailyCollectionsDutiesTaxes(consolidatedReportType){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	
	if(consolidatedReportType == 'remittance') {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsCdtOtherLeviesRemittance');
	} else {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsCdtOtherLevies');
	}

	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openConsolidatedReportDailyExportStamp(consolidatedReportType){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	
	if(consolidatedReportType == 'remittance') {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsExportDocumentaryStampFeesRemittance');
	} else {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsExportDocumentaryStampFees');
	}

	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openConsolidatedReportDailyImportProcessing(consolidatedReportType){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	
	if(consolidatedReportType == 'remittance') {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsImportProcessingFeesRemittance');
	} else {
		$(".buttonPopupGenDocument").attr('id', 'viewConsolidatedReportDailyCollectionsImportProcessingFees');
	}
	
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openDailyFxlcOpenedReportCdtDetailsPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateDailyFxlcOpenedReportCdtDetails');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openTramsReportPopUp(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateTramsReport');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openBankCertificationPopUp () {
	$(".viewClientName").show();
	$(".viewAuthorizedSignatory").show();
	$(".viewDate").hide();
	$(".viewDateTransaction").show();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$("#onlineReportPuc").removeAttr("readonly");
	$("#onlineReportPuc").val("");
	$(".buttonPopupGenDocument").attr('id','generateBankCertification');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openAdhocBatchReportPopup(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").show();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$(".buttonPopupGenDocument").attr('id','generateSelectedAdhoc');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openAdhocBatchReportPopupBetween(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").hide();
	$(".viewDateTransaction").show();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").hide();
	$(".viewNewApprover").hide();
	$(".buttonPopupGenDocument").attr('id','generateSelectedAdhoc');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function openReRouteApproverPopup(){
	$(".viewClientName").hide();
	$(".viewAuthorizedSignatory").hide();
	$(".viewDate").hide();
	$(".viewDateTransaction").hide();
	$(".viewOnlineReportPuc").hide();
	$(".viewOnlineReportTellerID").hide();
	$(".viewDocumentNumber").show();
	$(".viewNewApprover").show();
	$(".buttonPopupGenDocument").attr('id','generateSelectedAdhoc');
	mCenterPopup(popup_online_reports_div, popup_online_reports_bg);
	mLoadPopup(popup_online_reports_div, popup_online_reports_bg);
}

function closeOnlineReportsPopUp() {
	mDisablePopup(popup_online_reports_div, popup_online_reports_bg);
}

$(document).ready(function() {	

	
	$("#generateDailyFxRegularLcOpened").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyForeignRegularLcOpenedReports();		
		}
	});
	
	$("#generateDailyFxCashLcOpened").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyForeignCashLcOpenedReports();		
		}
	});
	
	$("#generateDailyOutstandingForeignLc").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyOutstandingForeignLcReports();		
		}
	});
	
	$("#generateDailyFundingReport").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyFundingReport();		
		}
	});
	
	$("#generateDailyOutstandingLcCcbdReport").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyOutstandingLcCcbdReport();		
		}
	});
	
	$("#generateDailySummaryAccountingEntries").live("click",function(){	
		if($("#onlineReportDate").val() == ""
			|| $("#onlineReportPuc").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailySummaryAccountingEntries("original");		
		}
	});
	
	$("#generateDailyExceptionReportAccountingEntries").live("click",function(){	
		if($("#onlineReportDate").val() == ""
			|| $("#onlineReportPuc").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailySummaryAccountingEntries("exception");		
		}
	});
	
	$("#generateTradeServicesAMLAReportedTransactions").live("click",function(){	
		if($("#onlineReportDate").val() == ""
			|| $("#onlineReportPuc").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateTradeServicesAMLAReportedTransactions();		
		}
	});
	
	$("#generateOpenTFSCASAPosting").live("click",function(){	
		if($("#onlineReportDate").val() == ""
			|| $("#onlineReportPuc").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateOpenTFSCASAPosting();		
		}
	});
	
	$("#generateDailyReportProcessedRefunds").live("click",function(){	
		if($("#onlineReportDate").val() == ""
			|| $("#onlineReportPuc").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyReportProcessedRefunds();		
		}
	});

	$("#viewConsolidatedDailyReportDepositsCollected").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedDailyReportDepositsCollected('collection');		
		}
	});
	
	$("#viewConsolidatedDailyReportDepositsCollectedRemittance").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedDailyReportDepositsCollected('remittance');		
		}
	});

	$("#viewConsolidatedReportDailyCollectionsCdtOtherLevies").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsCdtOtherLevies('collection');		
		}
	});
	
	$("#viewConsolidatedReportDailyCollectionsCdtOtherLeviesRemittance").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsCdtOtherLevies('remittance');		
		}
	});

	$("#viewConsolidatedReportDailyCollectionsExportDocumentaryStampFees").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsExportDocumentaryStampFees('collection');		
		}
	});
	
	$("#viewConsolidatedReportDailyCollectionsExportDocumentaryStampFeesRemittance").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsExportDocumentaryStampFees('remittance');		
		}
	});
	
	$("#viewConsolidatedReportDailyCollectionsImportProcessingFees").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsImportProcessingFees('collection');		
		}
	});

	$("#viewConsolidatedReportDailyCollectionsImportProcessingFeesRemittance").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateConsolidatedReportDailyCollectionsImportProcessingFees('remittance');		
		}
	});
	
	$("#generateDailyFxlcOpenedReportCdtDetails").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateDailyFxlcOpenedReportCdtDetails();		
		}
	});
		
	$("#generateTramsReport").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{			
			closeOnlineReportsPopUp();
			generateTramsReport();		
		}
	});
	
	$("#generateBankCertification").live("click",function(){
		if($("#clientName").val() == "" || $("#dateOfTransactionFrom").val() == "" 
			|| $("#dateOfTransactionFrom").val() == "" || $("#authorizedSignatoryOnline").val() == ""){
			alert("Please fill in the required fields.");
		} else{	
			closeOnlineReportsPopUp();
			generateBankCertificationReports();
		}
	});

	$("#generateSelectedAdhoc").live("click",function(){	
		if($("#onlineReportDate").val() == ""){
			alert("Please fill in the required fields.");
		}else{
			closeOnlineReportsPopUp();
			showConfirmPopup();		
		}
	});
});