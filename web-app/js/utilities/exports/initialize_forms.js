//	for basic details tab
function onBasicDetailsClick() {
	formId = "#basicDetailsTabForm";
}
//	for lc details tab
function onLcDetailsClick() {
	formId = "#lcDetailsTabForm";
}
//	for attached documents tab
function onAttachedDocumentsClick() {
	formId = "#attachedDocumentsTabForm";	
}
//	for load setup tab
function onLoanSetupClick() {
	formId = "#loanSetupTabForm";	
}
//	for setup lc details tab
function onSetupLcDetailsClick() {
	formId = "#setupLcDetailsTabForm";	
}
//	for setup non-lc details tab
function onSetupNonLcDetailsClick() {
	formId = "#setupNonLcDetailsTabForm";	
}
//	for documents enclosed and instructions tab
function onDocumentsEnclosedAndinstructionsClick() {
	formId = "#documentsEnclosedAndInstructionsTabForm";	
}
//	for settlement proceeds to seller tab
function onSettlementProceedsSellerClick() {
	formId = "#settlementProceedsSellerTabForm";	
}
//	for mt103 tab
function onMt103TabClick(){
	formId = "#mt103TabForm";
}
//	for pddts tab
function onPddtsTabClick(){
	formId = "#pddtsTabForm";
}
//	for charges payment tab
function onChargesPaymentClick() {
	formId = "#chargesPaymentTabForm";
}
//	for instructions and routing tab
function onInstructionsAndRoutingClick() {
	formId = "#instructionsAndRoutingTabForm";
}

function initializeTabForms(){
	// check if element exists
	if($("#basicDetailsTab").length > 0) {
		$("#basicDetailsTab").click(onBasicDetailsClick);		
	}
	
	if($("#lcDetailsTab").length > 0) {
		$("#lcDetailsTab").click(onLcDetailsClick);		
	}
	
	if($("#attachedDocumentsTab").length > 0) {
		$("#attachedDocumentsTab").click(onAttachedDocumentsClick);		
	}
	
	if($("#loanSetupTab").length > 0) {
		$("#loanSetupTab").click(onLoanSetupClick);		
	}
	
	if($("#setupLcDetailsTab").length > 0) {
		$("#setupLcDetailsTab").click(onSetupLcDetailsClick);		
	}
	
	if($("#setupNonLcDetailsTab").length > 0) {
		$("#setupNonLcDetailsTab").click(onSetupNonLcDetailsClick);		
	}
	
	if($("#documentsEnclosedInstructionsTab").length > 0) {
		$("#documentsEnclosedInstructionsTab").click(onDocumentsEnclosedAndinstructionsClick);		
	}
	
	if($("#settlementProceedsSellerTab").length > 0) {
		$("#settlementProceedsSellerTab").click(onSettlementProceedsSellerClick);		
	}
	
	if($("#mt103Tab").length > 0) {
		$("#mt103Tab").click(onMt103TabClick);		
	}
	
	if($("#pddtsTab").length > 0) {
		$("#pddtsTab").click(onPddtsTabClick);		
	}
	
	if($("#chargesPaymentTab").length > 0) {
		$("#chargesPaymentTab").click(onChargesPaymentClick);		
	}
	
	if($("#instructionsRoutingTab").length > 0) {
		$("#instructionsRoutingTab").click(onInstructionsAndRoutingClick);		
	}
	
}