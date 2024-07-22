$(function(){
	$("#createExportBillsEts").click(openExportBillsPopup);
	$("#createExportBillsCancel, #create_export_bills_transaction_popup_close").click(closeExportBillsPopup);
	$("#createExportBillsRedirect").click(createExportBillsEtsTransaction);
	$("input[name=createExportBillsTransaction]").click(onCreateExportBillsTransactionClick);
});

function onCreateExportBillsTransactionClick() {
	if($("input[name=createExportBillsTransaction]:checked").length > 0){
		$("#createExportBillsRedirect").removeAttr("disabled");
	}
}

function openExportBillsPopup(){
	loadPopup("create_export_bills_transaction_popup","popupBackground_create_export_bills_transaction")
	centerPopup("create_export_bills_transaction_popup","popupBackground_create_export_bills_transaction")
	if($("#createExportBillsRedirect").attr("disabled") != "disabled"){
		$("#createExportBillsRedirect").attr("disabled", "disabled");
	}
}

function closeExportBillsPopup(){
	disablePopup("create_export_bills_transaction_popup","popupBackground_create_export_bills_transaction")
	$("input[name=createExportBillsTransaction]:checked").removeAttr("checked");
	$("#createExportBillsRedirect").attr("disabled", "disabled");
}

function createExportBillsEtsTransaction(){
	if($("input[name=createExportBillsTransaction]:checked").length > 0){
		var url = "";
		switch($("input[name=createExportBillsTransaction]:checked").val()){
		case 'dbpNegotiation':
			url = createEtsExportBillsTransactionUrl
			url += '?serviceType=Negotiation';
			url += '&documentType=Domestic';
			url += '&documentClass=Purchase';
			url += '&referenceType=eTS';
			url += '&etsNumber=000-00-000-00-000000';
			break;
		case 'ebpNegotiation':
			url = createEtsExportBillsTransactionUrl
			url += '?serviceType=Negotiation';
			url += '&documentType=Export';
			url += '&documentClass=Purchase';
			url += '&referenceType=eTS';
			url += '&etsNumber=000-00-000-00-000000';
			break;
		case 'dbcNegotiation':
			url = createDataEntryExportBillsTransactionUrl
			url += '?serviceType=Settlement';
			url += '&documentType=Domestic';
			url += '&documentClass=Collection';
			url += '&referenceType=Date Entry';
			break;
		case 'ebcNegotiation':
			url = createDataEntryExportBillsTransactionUrl
			url += '?serviceType=Settlement';
			url += '&documentType=Export';
			url += '&documentClass=Collection';
			url += '&referenceType=Data Entry';
			break;
		}
		location.href = url;
		closeExportBillsPopup()
	}
}