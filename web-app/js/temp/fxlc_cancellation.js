var error_validation=false;

function formValidatorFXLC_Cancellation(){	
	var reasonForCancellation=$("#reasonForCancellation").val()
	var originalLcSubmittedFlag=$("input:radio[name='originalLcSubmittedFlag']:checked").val();
	
	if (reasonForCancellation=="" || originalLcSubmittedFlag == undefined){
		error_validation = true;
//		alert("Please fill-up required fields");
        $("#alertMessage").text("Please fill-up required fields.");
        triggerAlert();
	}else{
		error_validation=false;
	}	
}

function onSaveClick() {
	formValidatorFXLC_Cancellation();
	
	if (error_validation==false){		
		action = "save";
		_pageHasErrors=false;
		openAlert();
	}else{
		_pageHasErrors=true;
	}	
}

//obsolete, check alert_utility.js
//$(".openSaveConfirmation").click(onSaveClick);