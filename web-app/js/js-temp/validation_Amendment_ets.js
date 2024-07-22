function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsAmendment();
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

function onAmendmentSaveClick(){
	/*action = "save";
	openAlert();*/	
	_pageHasErrors=false;
}

function validateBasicDetailsAmendment(){
	var error_msg = ""
	if($("#amendmentDate").length > 0 && $("#amendmentDate").val() == "" ){
		error_msg += "Amendment Date cannot be blank."
	}
	
	if(error_msg.length > 0){
//		alert(error_msg);
		//alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	return false;
	}
}


function validateCharges(){
	var error_msg = ""
		if($("#settlementCurrency").val()==""){
			error_msg+="Settlement currency is empty."
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

//on alert_utility.js
function validateAmendmentEts(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
	default:
		onAmendmentSaveClick();
		break;
	}
}
