function onBasicDetailsLcCancellationSaveClick(){
	var errors = validateBasicDetailsLcCancellation();
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

function validateBasicDetailsLcCancellation(){
	var error_msg = ""
		if($("#reasonForCancellation").length > 0 && $("#reasonForCancellation").val() == "" ){
			error_msg += "No Reason for Cancellation specified."
		}
	if($("input[name=originalLcSubmittedFlag]").length > 0 && $("input[name=originalLcSubmittedFlag]:checked").length == 0 ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "The Original LC Submitted is not set."
	}
	if($("input[name=originalLcSubmittedFlag]").length > 0 && $("input[name=originalLcSubmittedFlag]:checked").val() == 'N' ){
		$("#alertMessage").text("The Original LC must be submitted for transaction to continue.");
		triggerAlert();
		return true
	}
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateLcCancellation(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsLcCancellationSaveClick();
		break;
	}
}