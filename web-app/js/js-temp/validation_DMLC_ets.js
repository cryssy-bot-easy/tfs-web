function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsDmlc();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
//		confirmAlert();
	}else{
		_pageHasErrors=true;
	}
}

function onDmlcSaveClick(){
	/*action = "save";
	openAlert();	*/
	_pageHasErrors=false;
}

function validateBasicDetailsDmlc(){
	var error_msg = "";

	if(error_msg.length > 0){
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	return false;
	}
}

function fireRequiredValidation(){
	var error_msg = "";
	
	if("" != $("#partialCashSettlementFlag").val() && ("NaN" != parseFloat($("#cashAmount").val()) && parseFloat($("#cashAmount").val()) < 0.01)){
		error_msg+="Cash LC Amount required and must not be 0";
	}
	
	
	if(error_msg.length > 0){
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields in this or other tab/s.");
        triggerAlert();
		onSaveClick(true);
		return true;
	} else {
		onSaveClick(false);
		return false;
	}
}

function validateDmlcEts(buttonParentId){
	if(fireRequiredValidation()) return;
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
	break;
	default:
		onDmlcSaveClick();
	break;
	}
}