function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}

function onChargesClick() {
	formId = "#chargesTabForm";	
}

function onChargesPaymentClick() {
	formId = "#chargesPaymentTabForm";
}

function onCashLcPaymentClick() {
	formId = "#cashLcPaymentTabForm";
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
	// check if element exists
	if($("#cashLcPaymentTab").length > 0) {
		// for cash only
		$("#cashLcPaymentTab").click(onCashLcPaymentClick);		
	}
}

$(initializeForms);