function onFxlcDataEntryAmendmentBasicDetailsSaveClick(){
//	if($("#documentSubType1").val() == "CASH") {
	var errors = validateFxlcDataEntryAmendmentBasicDetailsCash();
//	}
	onSaveClick(errors);
}

function onFxlcDataEntryAmendmentShipmentDetailsSaveClick(){
	var errors = validateFxlcDataEntryAmendmentShipmentDetails();
	onSaveClick(errors);
}

function validateFxlcDataEntryAmendmentImporterExporterDetailsSaveClick(){
	var errors = validateFxlcDataEntryAmendmentImporterExporterDetails();
	onSaveClick(errors);
}

function validateFxlcDataEntryReimbursementDetailsSaveClick(){
	var errors = validateFxlcDataEntryReimbursementDetails();
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

function onFxlcDataEntryAmendmentSaveClick(){
	_pageHasErrors=false;
}

function validateFxlcDataEntryAmendmentBasicDetailsCash(){
	var error_msg = "";
	var amountTo = $("#amountTo").length > 0 ? parseInt($("#amountTo").val().replace(",", "").replace(",", "")) : 0;
	var amountToFromEts = parseInt($("#amountToFromEts").val());
	
	if($("input[name=importerCifNumberSwitchDisplay]:checked").val() == "on" && $("#importerCifNumberTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=importerCbCodeSwitchDisplay]:checked").val() == "on" && $("#importerCbCodeTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=importerNameSwitchDisplay]:checked").val() == "on" && $("#importerNameTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=importerAddressSwitchDisplay]:checked").val() == "on" && $("#importerAddressTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=exporterCbCodeSwitchDisplay]:checked").val() == "on" && $("#exporterCbCodeTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=exporterNameSwitchDisplay]:checked").val() == "on" && $("#exporterNameTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=exporterAddressSwitchDisplay]:checked").val() == "on" && $("#exporterAddressTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=positiveToleranceLimitSwitchDisplay]:checked").val() == "on" && $("#positiveToleranceLimitTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=negativeToleranceLimitSwitchDisplay]:checked").val() == "on" && $("#negativeToleranceLimitTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=maximumCreditAmountSwitchDisplay]:checked").val() == "on" && $("#maximumCreditAmountTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=additionalAmountsCoveredSwitchDisplay]:checked").val() == "on" && $("#additionalAmountsCoveredTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=confirmationInstructionsFlagSwitchDisplay]:checked").val() == "on" && $("#confirmationInstructionsFlagTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=destinationBankSwitchDisplay]:checked").val() == "on" && $("#destinationBankTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=availableWithSwitchDisplay]:checked").val() == "on" && ($("#availableWithTo").val().length == 0 || $("#availableWithTo").val() == "ANY BANK")) {
		error_msg += "Invalid Input."
	}
	if($("input[name=availableBySwitchDisplay]:checked").val() == "on" && $("#availableByTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	
	if($("input[name=amountSwitchDisplay]:checked").val() == "on" && $("#amountTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	
	if($("#amountTo").length > 0 && $("#amountTo").val().length != 0){
		if($("#lcAmountFlag").val() == "INC" && amountTo<amountToFromEts) {
			error_msg += "Invalid Input inc."
		} else if($("#lcAmountFlag").val() == "DEC" && amountTo>amountToFromEts) {
			error_msg += "Invalid Input dec."
		}
	}
		
	if($("input[name=expiryCountryCodeSwitchDisplay]:checked").val() == "on" && $("#expiryCountryCodeTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	if($("input[name=tenorSwitchDisplay]:checked").val() == "on" && $("#tenorTo2").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=applicableRulesSwitchDisplay]:checked").val() == "on" && $("#applicableRulesTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	if($("input[name=advisingBankSwitchDisplay]:checked").val() == "on" && $("#confirmingBankTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	if($("input[name=expiryDateSwitchDisplay]:checked").val() == "on" && $("#expiryDateTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=formOfDocumentaryCreditSwitchDisplay]:checked").val() == "on" && $("#formOfDocumentaryCreditTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	if($("input[name=generalDescriptionOfGoodsSwitchDisplay]:checked").val() == "on" && $("#generalDescriptionOfGoodsTo").val().length == 0) {
		error_msg += "Invalid Input."
	}	
	if($("input[name=senderToReceiverSwitchDisplay]:checked").val() == "on" && $("#senderToReceiverTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=purposeOfStandbySwitchDisplay]:checked").val() == "on" && $("#purposeOfStandbyTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=standbyTaggingSwitchDisplay]:checked").val() == "on" && $("#standbyTaggingTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	
	if(error_msg.length > 0){
//		$("#alertMessage").text(error_msg);
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateFxlcDataEntryAmendmentImporterExporterDetails() {
	var error_msg = "";
	
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateFxlcDataEntryAmendmentShipmentDetails() {
	var error_msg = "";
	
	if($("input[name=latestShipmentDateSwitchDisplay]:checked").val() == "on" && $("#latestShipmentDateTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	
	if($("input[name=shipmentPeriodSwitchDisplay]:checked").val() == "on" && $("#shipmentPeriodTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	
	if($("input[name=generalDescriptionOfGoodsSwitchDisplay]:checked").val() == "on" && $("#generalDescriptionOfGoodsTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=partialShipmentSwitchDisplay]:checked").val() == "on" && $("#partialShipmentTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=commodityCodeSwitchDisplay]:checked").val() == "on" && $("#commodityTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=transShipmentSwitchDisplay]:checked").val() == "on" && $("#transShipmentTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=placeOfTakingDispatchOrReceiptSwitchDisplay]:checked").val() == "on" && $("#placeOfTakingDispatchOrReceiptTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=portOfLoadingOrDepartureSwitchDisplay]:checked").val() == "on" && $("#portOfLoadingOrDepartureTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=bspCountryCodeSwitchDisplay]:checked").val() == "on" && $("#bspCountryCodeTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=portOfDischargeOrDestinationSwitchDisplay]:checked").val() == "on" && $("#portOfDischargeOrDestinationTo").val().length == 0) {
		error_msg += "Invalid Input."
	}
	if($("input[name=placeOfFinalDestinationSwitchDisplay]:checked").val() == "on" && $("#placeOfFinalDestinationTo").val().length == 0) {
		error_msg += "Invalid Input."
	}

	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateFxlcDataEntryReimbursementDetails() {
	var error_msg = "";
	
	if($("input[name=periodForPresentation1SwitchDisplay]:checked").val() == "on" && $("#periodForPresentation1To").val().length == 0) {
		error_msg += "Invalid Input."
	}
	
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateFxlcDataEntryAmendment(buttonParentId){
	switch(buttonParentId){
		case "basicDetailsTabForm":
			onFxlcDataEntryAmendmentBasicDetailsSaveClick();
			break;
		case "importerExporterDetailsTabForm":
			validateFxlcDataEntryAmendmentImporterExporterDetailsSaveClick();
			break;
		case "shipmentOfGoodsTabForm":
			onFxlcDataEntryAmendmentShipmentDetailsSaveClick();
			break;
		case "additionalCondition2TabForm":
			validateFxlcDataEntryReimbursementDetailsSaveClick();
			break;
		default:
			onFxlcDataEntryAmendmentSaveClick();
			break;
	}
}