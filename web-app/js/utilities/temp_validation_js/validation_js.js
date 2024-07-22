var error_validation = false;

function validationAdjustment() {
	if (formId == "#basicDetailsTabForm" && $("#negotiationNumber").val() == "" || $("#uaLoanMaturityDateTo").val() == "" || $("input:radio[name='beneficiaryConformityFlag']:checked").val() == undefined){
		error_validation = true
	}else{
		error_validation = false
	}
}

function validationUaLoanMaturityAdjustment() {
	if (formId == formId == "#basicDetailsTabForm" && ($("#loanMaturityDateTo").val() == "")){
		error_validation = true
	}else{
		error_validation = false
	}
}

function validationAdditionalConditions1Tab() {
	if (formId == "#additionalCondition1TabForm" && ($("#discrepancyCurrency").val() == "" || $("#discrepancyAmount").val() == "")){
		error_validation = true
	}else{
		error_validation = false
	}
}

function validationAdditionalConditions2Tab() {
	if (formId == "#additionalCondition2TabForm" && ($("#reimbursingCurrency").val() == "")){
		error_validation = true
	}else{
		error_validation = false
	}
}

function validationAdditionalDetailsTab() {
	if(formId == "#additionalDetailsTabForm" && ($("#partialDelivery").val() == "")) {
		error_validation = true
	} else {
		error_validation = false
	}
}

function validationDetailsOfGuaranteeTab() {
	if(formId == "#detailsOfGuaranteeTabForm" && ($("#detailsOfGuarantee").val() == "")){
		error_validation = true
	} else {
		error_validation = false
	}
}

function validationDetailsForMt202Tab() {
	if(formId == "#detailsForMT202TabForm" && ($("#reimburseBank").val() == "" 
		|| $("#negoBankReferenceNumber").val() == "" 
		|| $("#valueDate").val() == ""
		|| $("input:radio[name='orderInstitution ']:checked").val() == undefined 
		|| $("input:radio[name='beneficiaryInstitution ']:checked").val() == undefined)){
		error_validation = true
	} else {
		error_validation = false
	}
}

function validationImporterExporterDetailsTab() {
	if(formId == "#importerExporterDetailsTabForm" && ($("#exporterCbCode").val() == ""
		|| $("#importerCifNumber").val() == "" || $("#exporterName").val() == "" || $("#importerName").val() == ""
		|| $("#importerAddress").val() == "" || $("#exporterAddress").val() == "" || $("#availableWith").val() == ""
		|| $("#availableByDisplay").val() == "" || $("#countryCode").val() == "" || $("#patialShipment").val() == ""
		|| $("#transShipment").val() == "" || $("#portOfLoadingOrDeparture").val() == ""
		|| $("#portOfDischargeOrDestination").val() == "")){
		error_validation = true
	} else {
		error_validation = false
	}
}


function onSaveClick() {

	validationAdjustment();
	validationUaLoanMaturityAdjustment();
	validationAdditionalConditions1Tab();
	validationAdditionalConditions2Tab();
	validationAdditionalDetailsTab();
	validationDetailsOfGuaranteeTab();
	validationDetailsForMt202Tab();
	validationImporterExporterDetailsTab();
	
	if (error_validation == true){
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        _pageHasErrors=true;
        triggerAlert();
	}else{
		action = "save";
		_pageHasErrors=false;
		openAlert();
	}
//    else{
//		_pageHasErrors=true;
//	}
}

// $(".openSaveConfirmation").click(onSaveClick);
