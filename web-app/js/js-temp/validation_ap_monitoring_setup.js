function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsApMonitoringSetup();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
		_pageHasErrors=false;
	}else{
		_pageHasErrors=true;
	}
}

function onApMonitoringSetupSaveClick(){
	/*action = "save";
	openAlert();	*/
	_pageHasErrors=false;
}

function validateBasicDetailsApMonitoringSetup(){
	var error_msg = ""
		
	if($("#documentNumber").val()=="") {			
		error_msg+="Reference Number is required.<br/>"
	} 
	
	if($("#currency").val()=="") {			
		error_msg+="AP Currency is required.<br/>"
	}
	
	if($("#amount").val()=="") {			
		error_msg+="AP Amount is required."
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

function validateApMonitoringSetupDataEntry(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	default:
		onApMonitoringSetupSaveClick();
		break;
	}
}

