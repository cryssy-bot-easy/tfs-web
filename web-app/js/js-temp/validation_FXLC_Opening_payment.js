function onSaveClick(errors){
	if(!errors){
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
	}else{
		_pageHasErrors=true;
	}
}

function onChargesTabSaveClick(){
	var errors = validateChargesFxlcOpening();
	onSaveClick(errors);	
}

function validateChargesFxlcOpening(){
	var error_msg = ""
		if($("#settlementCurrency").val()==""){
			error_msg+="Settlement currency is empty."
		}
		if($("#passOnRateConfirmedBy").val()==""){
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

function validateFxlcOpeningPayment(buttonParentId){
	onChargesTabSaveClick();	
}


