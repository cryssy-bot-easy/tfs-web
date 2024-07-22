function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsApMonitoringApplication();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
		_pageHasErrors=false;
	}else{
		_pageHasErrors=true;
	}
}

function onApMonitoringApplicationSaveClick(){
	/*action = "save";
	openAlert();	*/
	_pageHasErrors=false;
}

function validateBasicDetailsApMonitoringApplication(){
	var error_msg = ""
	var apOutstandingBalance = parseInt($("#apOutstandingBalance").val().split(',').join(''));
	var amount = parseInt($("#amount").val().split(',').join(''));
		
	if($("#applicationReferenceNumber").val()=="") {			
		error_msg+="Application Reference Number is required.<br/>"
	} 
	
	if($("#amount").val()=="") {			
		error_msg+="AP Amount is required."
	}
	
	if(amount > apOutstandingBalance) {
		error_msg+="AP Amount is higher than Outstanding Amount."
	}
	
	if(error_msg.length > 0){
        $("#alertMessage").html
        (error_msg);
        triggerAlert();
		return true
	} else {
	return false;
	}
}

function validateApMonitoringApplicationDataEntry(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	default:
		onApMonitoringApplicationSaveClick();
		break;
	}
}

