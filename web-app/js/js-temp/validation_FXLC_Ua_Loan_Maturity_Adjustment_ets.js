function onBasicDetailsUaLoanMaturityAdjustmentSaveClick(){
	var errors = validateBasicDetailsUaLoanMaturityAdjustmentFxlc();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
	}else{
		_pageHasErrors=true;
	}
}

function validateBasicDetailsUaLoanMaturityAdjustmentFxlc(){
	if ($("input[name=beneficiaryConformityFlag]").length > 0 && $("input[name=beneficiaryConformityFlag]:checked").val() != 'Y'){
		$("#alertMessage").text("Creation of e-TS is not allowed. Obtain Beneficiary's conformity first.");
        triggerAlert();
		return true
	} else {
	var error_msg = ""		
		if($("#loanMaturityDateTo").length > 0 && $("#loanMaturityDateTo").val()==""){
			error_msg+="New Maturity Date is required."
		}
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
	}
}

function validateFxlcUaLoanMaturityAdjustmentEts(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsUaLoanMaturityAdjustmentSaveClick();
	break;
	default:
//		onFxlcSaveClick();
	break;
	}
}