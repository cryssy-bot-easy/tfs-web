/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/3/12
 * Time: 3:01 PM
 * To change this template use File | Settings | File Templates.
 */
function onBasicDetailsClick() {
    formId = "#basicDetailsTabForm";
}

function onPaymentDetailsClick() {
	if (serviceType == 'Application' && documentType == 'REFUND'){
		formId = "#cashLcPaymentTabForm";
	}else{
		formId = "#paymentDetailsTabForm";
	}
}

function onInstructionsAndRoutingClick(){
    formId = "#instructionsAndRoutingTabForm";
}

function initializeFormsMdCollection() {
    if($("#basicDetailsTab").length > 0) {
        $("#basicDetailsTab").click(onBasicDetailsClick);
    }

    if($("#paymentDetailsTab").length > 0) {
        $("#paymentDetailsTab").click(onPaymentDetailsClick);
    }

    if($("#instructionsRoutingTab").length > 0){
        $("#instructionsRoutingTab").click(onInstructionsAndRoutingClick);
    }
}

$(initializeFormsMdCollection);
