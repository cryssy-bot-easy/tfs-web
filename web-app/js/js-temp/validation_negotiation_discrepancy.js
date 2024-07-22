/**
 * (revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy Module
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 19, 2017
	[Date deployed:]
	Program [Revision] Details: Added function to enable and disable prepare button under certain conditions.
								Added another function to validate fields in Discrepancy tab.
	PROJECT: WEB
	MEMBER TYPE  : JavaScript file (JS)
	Project Name: validation_negotiation_discrepancy.js
 */

/**
 * (revision)
	SCR/ER Number: 
	SCR/ER Description: 
	[Created by:] John Patrick C. Bautista
	[Date revised:] July 27, 2017
	[Date deployed:]
	Program [Revision] Details: Added validations for both Basic Details and Discrepancy tab.
	PROJECT: WEB
	MEMBER TYPE  : JavaScript file (JS)
	Project Name: validation_negotiation_discrepancy.js
 */

function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsNegoDiscrepancy();
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

function validateBasicDetailsNegoDiscrepancy(){
	var error_msg = "";

	if($("#cifAddress").length > 0 && $("#cifAddress").val() == ""){
		error_msg += "Cif Address required.";
	}
	
	if($("#negotiationAmount").length > 0 && $("#negotiationAmount").val() == ""){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Negotiation Amount required.";
	}
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	return false;
	}
}

function validateNegoDiscrepancDataEntry(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
	break;
	}
}

//07182017 - FX/DM LC Cash/Regular/Standby Nego Discrepancy validations -- START
function enablePrepareBtn(){
	if( $("#btnPrepare").val() != undefined ){
		$("#btnPrepare").removeAttr("disabled");
	}
}

function disablePrepareBtn(){
	if( $("#btnPrepare").val() != undefined ){
		$("#btnPrepare").attr("disabled", true);
	}
}

function validateDiscrepancyTab(){
	// Checkbox
	var expiredLcSwitch = $("#expiredLcSwitch").val();
	var overdrawnForAmountSwitch = $("#overdrawnForAmountSwitch").val();
	// Textarea
	var overdrawnForAmount = $("#overdrawnForAmount").val();
	var descriptionOfGoodsNotAsPerLc = $("#descriptionOfGoodsNotAsPerLc").val();
	var documentsNotPresented = $("#documentsNotPresented").val();
	var others = $("#others").val();
	if( expiredLcSwitch != 'off' || overdrawnForAmountSwitch != 'off' || overdrawnForAmount != "" 
		|| descriptionOfGoodsNotAsPerLc != "" || documentsNotPresented != "" || others != "" ){
			$("#generateDiscrepancyLetterLink").live("click", function() {
				openDiscrepancyLetterAuthorizedSignatoryPopUp();
			})
			$("#viewMt734Link").live("click", function() {
				goToViewMt(734);
			})
			enablePrepareBtn();
	} else {
		disablePrepareBtn();
	}
}

// For FX & DM, function to check field Negotiation Amount if value is zero or negative, then show prompt
function validateNegoAmt(){
	var negoAmt = $("#negotiationAmount").val();
	negoAmt = negoAmt.replace(/,/g, '');
	negoAmt = parseFloat(negoAmt);
	if( negoAmt <= 0 ){
		triggerAlertMessage("The value for Negotiation Amount should not be zero or negative.")
		$("#negotiationAmount").val("");
		// Return focus to field
		if( $("#btnAlertOk").val() != undefined ){
			$("#btnAlertOk").click(function() {
				$("#negotiationAmount").focus();
			});
		}
	}
}

// For FX & DM, function to check field Overdrawn for (Amount) if value is zero or negative, then show prompt
function validateOverdrawnAmt(){
    var overdrawnForAmt = $("#overdrawnForAmount").val();
    overdrawnForAmt = overdrawnForAmt.replace(/,/g, '');
    overdrawnForAmt = parseFloat(overdrawnForAmt);
    if( overdrawnForAmt <= 0 ){
  		triggerAlertMessage("The value for Overdrawn for (Amount) should not be zero or negative.")
  		$("#overdrawnForAmount").val("");
  		// Return focus to field
  		if( $("#btnAlertOk").val() != undefined ){
  			$("#btnAlertOk").click(function() {
  				$("#overdrawnForAmount").focus();
            });
  		}
    }
}


// For DM only, limit user input in CIF Address field
$(function() {  
    $("#cifAddress").bind('input propertychange', function() {  
        var maxLength = $(this).attr('maxlength');  
        if ($(this).val().length > maxLength) {  
            $(this).val($(this).val().substring(0, maxLength));  
        }  
    })  
});
// -- END