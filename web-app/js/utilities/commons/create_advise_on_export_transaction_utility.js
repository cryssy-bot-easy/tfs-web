$(function(){
	$("#createAdviseOnExportEts").click(openAdviseOnExportPopup);
	$("#createAdviseOnExportCancel, #create_advise_on_export_transaction_popup_close").click(closeAdviseOnExportPopup);
//	$("#createAdviseOnExportRedirect").click(createAdviseOnExportEtsTransaction);
	$("input[name=createAdviseOnExportTransaction]").click(onCreateAdviseOnExportTransactionClick);
});

function onCreateAdviseOnExportTransactionClick(){
	if($("input[name=createAdviseOnExportTransaction]:checked").length > 0){
		$("#createAdviseOnExportRedirect").removeAttr("disabled");
	}
}

function openAdviseOnExportPopup(){
	loadPopup("create_advise_on_export_transaction_popup","popupBackground_create_advise_on_export_transaction")
	centerPopup("create_advise_on_export_transaction_popup","popupBackground_create_advise_on_export_transaction")
}

function closeAdviseOnExportPopup(){
	disablePopup("create_advise_on_export_transaction_popup","popupBackground_create_advise_on_export_transaction")
	$("input[name=createAdviseOnExportTransaction]:checked").removeAttr("checked");
	$("#createAdviseOnExportRedirect").attr("disabled", "disabled");
}

