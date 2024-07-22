function validateCharges(){
	var error_msg = ""
		if($("#settlementCurrency").val()==""){
			error_msg+="Settlement currency is empty."
		}

		if($("#forex_charges tr").length >= 3 && $("#passOnRateConfirmedByCharges").val()==""){
			error_msg+="Pass on rates is empty."
		}
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {			
			return false;
		}
}

function onChargesTabSaveClick(){
	var errors = validateCharges();
	onSaveClick(errors);
}

function onCashLcPaymentTabSaveClick(){
	var errors = validateCashLcPaymentTab2();
	onSaveClick(errors);	
}

function validateCashLcPaymentTab2() {
    var error_msg=""

    if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
        return true
    } else {
        return false;
    }
}

function onSaveClick(errors){
//    alert("onSaveClick " + errors)
	if(!errors){
//        alert("onSaveClick 1")
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
//		confirmAlert();
	}else{
//        alert("onSaveClick 2")
		_pageHasErrors=true;
	}
}

//function onDefaultSaveClick(){
//	/*action = "save";
//	openAlert();*/	
//	_pageHasErrors=false;
//}


//on alert_utility.js
function validateChargesTab(buttonParentId){
	switch(buttonParentId){
//	case "basicDetailsTabForm":
//		onBasicDetailsSaveClick();
//		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
//	default:
//		onDefaultSaveClick();
//		break;
	}
}

