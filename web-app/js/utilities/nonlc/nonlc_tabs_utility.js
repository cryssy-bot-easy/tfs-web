/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/17/12
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */

function onPddtsClick() {
    formId = "#pddtsTabForm";
}

function onClickBasicDetails() {
    formId = "#basicDetailsTabForm"
}

function onClickTransmittalLetter() {
    formId = "#detailsTransmittalLetterTabForm";
}

function onClickMt400Details() {
    formId = "#detailsForMT400TabForm";
}

function onClickMt202Details() {
    formId = "#detailsForMT202TabForm";
}

function onClickLoanDetails() {
    formId = "#loanDetailsTabForm";
}

function onClickInstructionsAndRouting() {
    formId = "#instructionsAndRoutingTabForm";
}

function onClickAttachedDocuments() {
	formId = "#attachedDocumentsTabForm";
}

function onClickCharges() {
	formId = "#chargesTabForm";
}

function onClickChargesPayment() {
	formId = "#chargesPaymentTabForm";
}

function onClickNegotiationPayment() {
	formId = "#cashLcPaymentTabForm";
}

function onClickProceedsToTeller() {
	formId = "#proceedsDetailsTabForm";
}

function onClickMt103Details() {
	formId = "#mt103TabForm";
}

function onClickMt400Details() {
	formId = "#mt400_DetailsTabForm";
}

function onClickMt202Details() {
	formId = "#mt202_DetailsTabForm";
}



function initializeNonLcTabs() {
    $("#basicDetailsTab").click(onClickBasicDetails);
    							
    $("#detailsTransmittalLetterTab").click(onClickTransmittalLetter);

//    $("#mt400_202DetailsTab").click(onClickMt400Details);

//    $("#mt202DetailsTab").click(onClickMt202Details);

    $("#loanDetailsTab").click(onClickLoanDetails);

    $("#instructionsRoutingTab").click(onClickInstructionsAndRouting);
    
    //added 12/07/2012
    $("#attachedDocumentsTab").click(onClickAttachedDocuments);
    
    $("#chargesTab").click(onClickCharges);
    
    $("#chargesPaymentTab").click(onClickChargesPayment);
    
    $("#cashLcPaymentTab").click(onClickNegotiationPayment);
    
    $("#proceedsDetailsTab").click(onClickProceedsToTeller);

    if ($("#pddtsTab").length > 0) {
        $("#pddtsTab").click(onPddtsClick);
    }

    if ($("#mt103Tab").length > 0) {
        $("#mt103Tab").click(onClickMt103Details);
    }

    //added 01/10/2013
    $("#mt103DetailsTab").click(onClickMt103Details);
    
    //Added: March 23, 2013
    $("#mt400_DetailsTab").click(onClickMt400Details)

    $("#mt202_DetailsTab").click(onClickMt202Details);
    
}


$(initializeNonLcTabs);
