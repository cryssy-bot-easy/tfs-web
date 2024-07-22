function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsFxlcOpening();
	onSaveClickOpening(errors);
}

function onSaveClickOpening(errors){
	if(!errors){
//		action = "save";
		_pageHasErrors=false;
//		openAlert();
//		confirmAlert();
	}else{
		_pageHasErrors=true;
	}
}

function onFxlcOpeningSaveClick(){
	/*action = "save";
	openAlert();*/	
	_pageHasErrors=false;
}

function onChargesTabSaveClick(){
	var errors = validateChargesFxlcOpening();
	onSaveClickOpening(errors);	
}


function onCashLcPaymentTabSaveClick(){
	var errors = validateCashLCPaymentTab();
	onSaveClickOpening(errors);	
	
}

function validateCashLCPaymentTab(){
	var error_msg = ""
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
}
function validateChargesFxlcOpening(){
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

function validateBasicDetailsFxlcOpening(){
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
		error_msg += "FXLC Currency is not specified."
	}
	if($("#amount").length > 0 && $("#amount").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "FXLC Amount is not specified."
	}
	
	if($("#amount").val() == "0.00" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "FXLC Amount should not be zero."
	}
	if($("#expiryDate").length > 0 && $("#expiryDate").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "FXLC Expiry Date is not set."
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

    if ($("#tenor").val() == "USANCE" && $("#usancePeriod").val() == "") {
        if(error_msg.length > 0){
            error_msg += "\n"
        }
        error_msg += "Usance Period not set."
    }
    
    if ($("#tenor").val() == "USANCE" && $("#tenorOfDraftNarrative").val() == "") {
        if(error_msg.length > 0){
            error_msg += "\n"
        }
        error_msg += "Narrative not set."
    }
    
    if($("#priceTerm").val()=="OTH" && $("#otherPriceTerm").val()==""){
        	error_msg+="Specification not specified.";
    }
    
    if(referenceType=="ETS"){
    	if(parseInt($("#amount").val())<=0){
    		$("#alertMessage").text("LC Amount cannot be zero");
    		triggerAlert();
    		return true;
    	}
    }
    
	if(error_msg.length > 0){
//        alert(error_msg);
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

//on alert_utility.js
function validateFxlcOpeningEts(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
	case "cashLcPaymentTabForm":
		onCashLcPaymentTabSaveClick();
		break;
	default:
		onFxlcOpeningSaveClick();
		break;
	}
}



$(function(){
	$("document").ready(function(){		 		
		
		if($("#priceTerm").val()=="OTH"){		 
			 $(".othersPriceTermAsterisk").show();
		 }else{
			 $("#otherPriceTerm").removeClass("required");
			 $(".othersPriceTermAsterisk").hide();
		 }
			
		$("#priceTerm").change(function() {
			if($("#priceTerm").val()=="OTH"){
				 $(".othersPriceTermAsterisk").show();	 
				 $("#otherPriceTerm").addClass("required");
				 $("#otherPriceTerm").removeAttr("readonly");
			 }else{
				 $(".othersPriceTermAsterisk").hide();
				 $("#otherPriceTerm").removeClass("required");
				 $("#otherPriceTerm").attr("readonly", "readonly");
			 }
		});
	});
});


$(function() {
    $("#generalDescriptionOfGoods").keyup(function() {
        if (this.value.match(/[^a-zA-Z0-9 \n\r\/\.\,\'\:\(\)-]/g)) {
            this.value = this.value.replace(/[^a-zA-Z0-9 \n\r\/\.\,\'\:\(\)-]/g, '');
        }
    });
});

