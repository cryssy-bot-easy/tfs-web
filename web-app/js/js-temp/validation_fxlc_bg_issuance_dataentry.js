function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsAmendment();
	onSaveClick(errors);
}

function onSaveClick(errors){
	if(!errors){
		_pageHasErrors=false;
	}else{
		_pageHasErrors=true;
	}
}

function onAmendmentSaveClick(){
	/*action = "save";
	openAlert();	*/
	_pageHasErrors=false;
}

function validateBasicDetailsAmendment(){
	var error_msg = ""
		
	if($("#blAirwayBillNumber").val()=="") {			
		error_msg+="BL/Airway Bill Number is required."
	} 
	
	if(error_msg.length > 0){
        $("#alertMessage").text(error_msg);
        triggerAlert();
		return true
	} else {
	return false;
	}
}

function validateFxlcIndemnityIssuanceDataEntry(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	default:
		onAmendmentSaveClick();
		break;
	}
}

