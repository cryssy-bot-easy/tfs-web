$(function(){
	$("#modifyExportBillsCancel, #modify_export_bills_transaction_popup_close").click(closeExportBillsPopup);
	$("#modifyExportBillsRedirect").click(modifyExportBillsEtsTransaction);
});

function openExportBillsModifyPopup(){
	loadPopup("modify_export_bills_transaction_popup","popupBackground_modify_export_bills_transaction")
	centerPopup("modify_export_bills_transaction_popup","popupBackground_modify_export_bills_transaction")
}

function closeExportBillsPopup(){
	disablePopup("modify_export_bills_transaction_popup","popupBackground_modify_export_bills_transaction")
	$("input[name=modifyExportBillsTransaction]:checked").removeAttr("checked");
}

function modifyExportBillsEtsTransaction(){
	if($("input[name=modifyExportBillsTransaction]:checked").length > 0){
		var url = modifyDataEntryExportBillsTransactionUrl;
		switch($("input[name=modifyExportBillsTransaction]:checked").val()){
		case 'ebpSettlement':
			url += '?serviceType=Settlement';
			url += '&documentType=Export';
			url += '&documentClass=Purchase';
			url += '&referenceType=Data Entry';
			break;
		case 'ebcCancellation':
			url += '?serviceType=Cancellation';
			url += '&documentType=Export';
			url += '&documentClass=Collection';
			url += '&referenceType=Data Entry';
			break;
		}
		location.href = url;
		closeExportBillsPopup()
	}
}
