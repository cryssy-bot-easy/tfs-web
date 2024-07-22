var popup_accting = $("#popup_accountingEntries");
var popup_bg_accting = $("#popupBackground_accountingEntries");

function openAccountingEntries() {
    var viewAccountingEntriesUrl = accountingEntriesUrl;
    viewAccountingEntriesUrl += "?tradeServiceId="+$("#tradeServiceId").val();

    $('#grid_list_accounting_entries').jqGrid('setGridParam', {url: viewAccountingEntriesUrl, page: 1, datatype: "json"}).trigger("reloadGrid");

	mCenterPopup(popup_accting,popup_bg_accting);
	mLoadPopup(popup_accting,popup_bg_accting);
}

function openTransactionAccountingEntries() {
    var viewTransactionAccountingEntriesUrl = transactionAccountingEntriesUrl;
    viewTransactionAccountingEntriesUrl += "?tradeServiceId="+$("#tradeServiceId").val();

    $('#grid_list_accounting_entries').jqGrid('setGridParam', {url: viewTransactionAccountingEntriesUrl, page: 1, datatype: "json"}).trigger("reloadGrid");

    mCenterPopup(popup_accting,popup_bg_accting);
    mLoadPopup(popup_accting,popup_bg_accting);
}

function closeAccountingEntries() {
	mDisablePopup(popup_accting,popup_bg_accting);
}


function validateAccountingEntries(){
	
	$.get(validateAccountingUrl,{tradeServiceId:$("#tradeServiceId").val()},function(data){
	//$.get(validateAccountingUrl,{},function(data){
		
		var resultParam = data.validationResult

		if(resultParam == "FOUND"){//found in glmast
			//nothing to do
		}else{
			
			triggerAlertMessage(resultParam);
		}
		
	});
	
}


function checkAccountingError(){
	
	$.get(checkAccountingErrorUrl,{tradeServiceId:$("#tradeServiceId").val()},function(data){
	//$.get(validateAccountingUrl,{},function(data){
		
		var resultParam = data.checkResult

		if(resultParam == "NONE"){//found in glmast
			//nothing to do
		}else{
			
			triggerAlertMessage(resultParam);
		}
		
	});
	
}



$(document).ready(function() {
	$("#openAccountingEntries").live("click",function(){
		openAccountingEntries();
	});

	$("#openTransactionAccountingEntries").live("click",function(){	
		openTransactionAccountingEntries();
	});
	
	$("#openAccountingEntries").on("click",function(){
		
		validateAccountingEntries();
	});
	
	
});