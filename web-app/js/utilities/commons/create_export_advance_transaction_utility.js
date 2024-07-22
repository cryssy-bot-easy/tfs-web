$(function(){
	$("#createExportAdvanceEts").click(createExportAdvancePaymentTransaction);
	$("#createExportAdvanceCancel, #create_export_advance_transaction_popup_close").click(closeExportAdvancePopup);
	//$("#createExportAdvanceRedirect").click(createExportAdvanceEtsTransaction);
	$("input[name=createExportAdvanceTransaction]").click(onCreateExportAdvanceTransactionClick);
});

function onCreateExportAdvanceTransactionClick() {
	if($("input[name=createExportAdvanceTransaction]:checked").length > 0 ){
		$("#createExportAdvanceRedirect").removeAttr("disabled");
	}
}

function createExportAdvancePaymentTransaction() {
    var url = exportPaymentUrl;
    url += '?referenceType=ets';
    location.href = url;
}

function openExportAdvancePopup(){
	loadPopup("create_export_advance_transaction_popup","popupBackground_create_export_advance_transaction")
	centerPopup("create_export_advance_transaction_popup","popupBackground_create_export_advance_transaction")
	if($("#createExportAdvanceRedirect").attr("disabled") != "disabled"){
		$("#createExportAdvanceRedirect").attr("disabled", "disabled");
	}
}

function closeExportAdvancePopup(){
	disablePopup("create_export_advance_transaction_popup","popupBackground_create_export_advance_transaction")
	$("input[name=createExportAdvanceTransaction]:checked").removeAttr("checked");
	$("#createExportAdvanceRedirect").attr("disabled", "disabled");
}

function createExportAdvanceEtsTransaction(){
	if($("input[name=createExportAdvanceTransaction]:checked").length > 0){
		var url = "";
		switch($("input[name=createExportAdvanceTransaction]:checked").val()){
		case 'eap':
			url = exportPaymentUrl;
			break;
		case 'ear':
			url = exportRefundUrl;
			break;
		}
		url += '?referenceType=ets';
		location.href = url;
//		closeExportAdvancePopup()
	}
}