// this is used for opening only
function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}

function onAttachedDocumentsClick() {
	formId = "#attachedDocumentsTabForm";	
}

//for amendment
function onNatureOfAmendmentClick(){
	formId = "#natureOfAmendmentTabForm"
}

function onChargesClick() {
	formId = "#chargesTabForm";	
}

function onChargesPaymentClick() {
	formId = "#chargesPaymentTabForm";
}

// for opening-cash, negotiation payment, ua loan settlement payment only
function onCashLcPaymentClick() {
	formId = "#cashLcPaymentTabForm";
}

//for Proceeds
function onProceedsPaymentClick(){
	formId = "#proceedsDetailsTabForm";
}

// for instruction and routing
function onInstructionsAndRoutingClick() {
	formId = "#instructionsAndRoutingTabForm";
}

function initializeForms() {
	// check if element exists
	if($("#basicDetailsTab").length > 0) {
		$("#basicDetailsTab").click(onBasicDetailsClick);		
	}
	// check if element exists	
	if($("#attachedDocumentsTab").length > 0) {
		$("#attachedDocumentsTab").click(onAttachedDocumentsClick);		
	}
	// check if element exist for amendment
	if($("#natureOfAmendmentTab").length > 0){
		$("#natureOfAmendmentTab").click(onNatureOfAmendmentClick);
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
		// for opening-cash, negotiation payment, ua loan settlement payment only
		$("#cashLcPaymentTab").click(onCashLcPaymentClick);
	}
	// check if element exist for proceeds
	if($("#proceedsDetailsTab").length > 0) {
		$("#proceedsDetailsTab").click(onProceedsPaymentClick);		
	}
	// check if element exists
	if($("#instructionsRoutingTab").length > 0) {
		$("#instructionsRoutingTab").click(onInstructionsAndRoutingClick);		
	}
}

$(initializeForms);