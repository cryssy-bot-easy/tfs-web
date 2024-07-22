function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsDmlcOpening();
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

function onDmlcOpeningSaveClick(){
	/*action = "save";
	openAlert();*/	
	_pageHasErrors=false;
}

function onChargesTabSaveClick(){
	var errors = validateChargesDmlcOpening();
	onSaveClick(errors);	
}

function onChargesPaymentTabSaveClick(){
	var errors = validateChargesPaymentTab();
	onSaveClick(errors);	
}

function validateChargesDmlcOpening(){
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


function validateBasicDetailsDmlcOpening(){
	var error_msg = ""
	if($("#processingUnitCode").length > 0 && $("#processingUnitCode").val() == "" ){
		error_msg += "Processing Unit Code is not specified."
	}
	if($("#issueDate").length > 0 && $("#issueDate").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "FXLC Issue Date is not set."
	}
	if($("#currency").length > 0 && $("#currency").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "DMLC Currency is not specified."
	}
	if($("#amount").length > 0 && $("#amount").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "DMLC Amount is not specified."
	}
	if($("#expiryDate").length > 0 && $("#expiryDate").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "DMLC Expiry Date is not set."
	}
	if($("#generalDescriptionOfGoods").length > 0 && $("#generalDescriptionOfGoods").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "There is no General Description of Goods."
	}

    if($("#cifNumber").length > 0 && $("#cifNumber").val() == "") {
        if(error_msg.length > 0) {
            error_msg += "\n"
        }

        error_msg += "CIF Number must not be blank."
    }
    
    if(referenceType=="ETS"){
    	if(parseInt($("#amount").val())<=0){
    		$("#alertMessage").text("LC Amount cannot be zero");
    		triggerAlert();
    		return true;
    	}
    }

    if(documentSubType1.toUpperCase() != "CASH") {
        if($("#facilityId").length > 0 && $("#facilityId").val() == "") {
            if(error_msg.length > 0) {
                error_msg += "\n";
            }

            error_msg += "Facility ID must not be blank.";
        }
    }

    if($("#tenor").length > 0 && $("#tenor").val() == "" ){
        if(error_msg.length > 0){
            error_msg += "\n"
        }
        error_msg += "Tenor not set."
    }

    if ($("#tenor").val() == "USANCE" && ($("#usancePeriod").val() == "" || $("#tenorOfDraftNarrative").val() == "")) {
        if(error_msg.length > 0){
            error_msg += "\n"
        }
        error_msg += "Usance Period and Narrative not set."
    }
	
	if(error_msg.length > 0){
//		alert(error_msg);
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	    return false;
	}
}


function validateChargesPaymentTab(){
	var error_msg = ""	
		
	if($("#remainingBalance").val().replace(/,/g,"") * 100 > 0){
		$("#alertMessage").text("Service Payment has not been fully set-up.");
		triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateCashLCPaymentTab(){
	var error_msg = ""	
			
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else if($("#remainingBalanceLc").val().replace(/,/g,"") * 100 > 0){
		$("#alertMessage").text("Product Payment has not been fully set-up.");
		triggerAlert();
		return true
	} else {
		return false;
	}
}


function onCashLcPaymentTabSaveClick(){
	var errors = validateCashLCPaymentTab();
	onSaveClick(errors);	
	
}

function validateDmlcOpeningEts(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
	case "chargesPaymentTabForm":
		onChargesPaymentTabSaveClick();
		break;
	case "cashLcPaymentTabForm":
		onCashLcPaymentTabSaveClick();
		break;
	default:
		onDmlcOpeningSaveClick();
		break;
	}
}

/*
 * uncomment the function for generalDescriptionOfGoods 
 * textarea not to accept special characters
 */
//$(function() {
//    $("#generalDescriptionOfGoods").keyup(function() {
//        if (this.value.match(/[^a-zA-Z0-9 ]/g)) {
//            this.value = this.value.replace(/[^a-zA-Z0-9 ]/g, '');
//        }
//    });
//});
