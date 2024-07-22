function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}

function onAttachedDocumentsClick(){
	formId ="#attachedDocumentsTabForm"
}

function onPaymentDetailsForChargesClick(){
	formId = "#paymentDetailsForChargesTabForm"
}

function onExportAdvanceDetailsClick(){
	formId = "#exportAdvanceDetailsTabForm";
}

function onChargesClick() {
	formId = "#chargesTabForm";	
}

function onChargesPaymentClick() {
	formId = "#chargesPaymentTabForm";
}

function onRefundDetailsChargesClick(){
	formId = "#refundDetailsChargesTabForm";
}

function onInstructionsAndRoutingClick() {
	formId = "#instructionsAndRoutingTabForm";
}

function initializeForms() {
	// check if element exists
	if($("#basicDetailsTab").length > 0) {
		$("#basicDetailsTab").click(onBasicDetailsClick);		
	}
	
	// check if element exists
	if($("#exportAdvanceDetailsTab").length > 0) {
		$("exportAdvanceDetailsTab").click(onExportAdvanceDetailsClick);
	}
	
	// check if elements exists
	if($("#paymentdetailsForChargesTab").length > 0 ) {
		$("paymentDetailsForChargesTab").click(onPaymentDetailsForChargesClick);
	}
	
	// check if element exists
	if($("#chargesTab").length > 0) {
		$("#chargesTab").click(onChargesClick);		
	}
	
	// check if element exists
	if($("#chargesPaymentTab").length > 0) {
		$("#chargesPaymentTab").click(onChargesPaymentClick);		
	}
	
	// check if element exists
	if($("#cashLcPaymentTab").length > 0) {
		$("#cashLcPaymentTab").click(onCashLcPaymentClick);		
	}
	
	if($("#refundDetailsCharges").length > 0) {
		$("#refundDetailsCharges").click(onRefundDetailsChargesClick);
	}

	// check if element exists
	if($("#instructionsRoutingTab").length > 0) {
		$("#instructionsRoutingTab").click(onInstructionsAndRoutingClick);		
	}
}

$(initializeForms);