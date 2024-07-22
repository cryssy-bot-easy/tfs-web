function onBasicDetailsClick() {
    formId = "#basicDetailsTabForm";
}

function onImportAdvanceAmountDetailsTabClick() {
    formId = "#importAdvanceAmountDetailsTabForm";
}

function onChargesDetailsTabClick() {
    formId = "#chargesDetailsTabForm";
}

function onChargesTabClick() {
    formId = "#chargesTabForm";
}

function onInstructionsTabClick(){
	formId="#instructionsAndRoutingTabForm";
}

function onArPaymentTabClick(){
	
	formId = "#arPaymentTabForm";
}

function onArPaymentTabClick(){
	
	formId = "#arPaymentTabForm";
}

function onMtDetailsTab1Click(){
	
	formId = "#mtDetailsTabForm1";
}

function onProcessRefundTabClick(){
	
	formId = "#processRefundTabForm";
}

function onMtDetailsTab2Click(){
	
	formId = "#mtDetailsTabForm2";
}

function onPaymentDetailsTabClick(){
	
	formId = "#paymentDetailsTabForm";
}

function onAttachedDocumentsTabClick(){
	
	formId = "#attachedDocumentsTabForm";
}

function onMt202DetailsTabClick(){
	
	formId = "#mt202DetailsTabForm";
}

function onActualCorresChargesTab(){
	
	formId = "actualCorresChargesTabForm";
}


function initializeForms() {
    // check if element exists
    if($("#basicDetailsTab").length > 0) {
        $("#basicDetailsTab").click(onBasicDetailsClick);
    }
    // check if element exists
    if($("#importAdvanceAmountDetailsTab").length > 0) {
        $("#importAdvanceAmountDetailsTab").click(onImportAdvanceAmountDetailsTabClick);
    }
    // check if element exists
    if($("#chargesDetailsTab").length > 0) {
        $("#chargesDetailsTab").click(onChargesDetailsTabClick);
    }
    // check if element exists
    if($("#chargesTab").length > 0) {
        $("#chargesTab").click(onChargesTabClick);
    }

    // check if element exists
    if($("#arPaymentTab").length > 0) {
        $("#arPaymentTab").click(onArPaymentTabClick);
    }
    
    // check if element exists
    if($("#apPaymentTab").length > 0) {
        $("#apPaymentTab").click(onApPaymentTabClick);
    }
    
    if($("#mtDetailsTab1").length > 0) {
        $("#mtDetailsTab1").click(onMtDetailsTab1Click);
    }
    
    if($("#mtDetailsTab2").length > 0) {
        $("#mtDetailsTab2").click(onMtDetailsTab2Click);
    }
    
    // check if element exists
    if($("#processRefundTab").length > 0) {
        $("#processRefundTab").click(onProcessRefundTabClick);
    }
    
    if($("#paymentDetailsTab").length > 0){
    	$("#paymentDetailsTab").click(onPaymentDetailsTabClick);
    }
    
    // check if element exists
    if($("#instructionsTab").length > 0) {
        $("#instructionsTab").click(onInstructionsTabClick);
    }
    // check if element exists
    if($("#paymentTab").length > 0) {
        $("#paymentTab").click(onPaymentTabClick);
    }
    // check if element exists
    if($("#chargesTab").length > 0) {
        $("#chargesTab").click(onChargesTabClick);
    }
    
    if($("#attachedDocumentsTab").length > 0){
    	$("#attachedDocumentsTab").click(onAttachedDocumentsTabClick);
    }
    
    if($("#mt202DetailsTab").length > 0){
    	$("#mt202DetailsTab").click(onMt202DetailsTabClick);
    }
    
    if($("#actualCorresChargesTab").length > 0){
    	$("#actualCorresChargesTab").click(onActualCorresChargesTab);
    }
    
}

$(initializeForms);