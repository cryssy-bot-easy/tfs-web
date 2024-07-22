function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}

function onChargesClick() {
	formId = "#chargesTabForm";	
}

function onChargesPaymentClick() {
	formId = "#chargesPaymentTabForm";
}

function initializeForms() {
	// check if element exists
	if($("#basicDetailsTab").length > 0) {
		$("#basicDetailsTab").click(onBasicDetailsClick);		
	}
	// check if element exists
	if($("#chargesTab").length > 0) {
		$("#chargesTab").click(onChargesClick);		
	}
	// check if element exists
	if($("#chargesPaymentTab").length > 0) {
		$("#chargesPaymentTab").click(onChargesPaymentClick);		
	}
}

$(initializeForms);