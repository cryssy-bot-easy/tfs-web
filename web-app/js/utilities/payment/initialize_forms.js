function onLoanDetailsTabClick(){
    formId = "#loanDetailsTabForm";
}

function onMt103TabClick() {
    formId = "#mt103TabForm";
}

function onPddtsClick() {
    formId = "#pddtsTabForm";
}

function onProceedsPaymentClick(){
    formId = "#proceedsDetailsTabForm";
}

// this is used for opening only
function onBasicDetailsClick() {
    formId = "#basicDetailsTabForm";
}

function onChargesClick() {
    formId = "#chargesTabForm";
}

function onChargesPaymentClick() {
    formId = "#chargesPaymentTabForm";
}

// for cash only
function onCashLcPaymentClick() {
    formId = "#cashLcPaymentTabForm";
}

//for negotiation only
function onNegotiationPaymentClick(){
	formId="#negotiationPaymentTab";
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
    // check if element exists
    if($("#negotiationPaymentTab").length > 0) {
        $("#negotiationPaymentTab").click(onNegotiationPaymentClick);
    }

    if($("#proceedsDetailsTab").length > 0) {
        $("#proceedsDetailsTab").click(onProceedsPaymentClick);
    }

    if ($("#pddtsTab").length > 0) {
        $("#pddtsTab").click(onPddtsClick);
    }

    if ($("#mt103Tab").length > 0) {
        $("#mt103Tab").click(onMt103TabClick);
    }

    if($("#loanDetailsTab").length > 0){
        $("#loanDetailsTab").click(onLoanDetailsTabClick);
    }
}

$(initializeForms);