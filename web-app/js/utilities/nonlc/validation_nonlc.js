if (!window.console) {
    console = {
        log: function(){
            // do nothing
            // this is to avoid errors in ie7
        }
    };
}

function onBasicDetailsNonLcSaveClick(){

	var errors = validateBasicDetailsNonLc();
	onNonLcSaveClick(errors);
}

//function onNonLcSaveClick(errors){
//	if(!errors){
////		action = "save";
//		_pageHasErrors=false;
////		openAlert();
//	}else{
//		_pageHasErrors=true;
//	}
//}

function onNonLcSaveClick(errors){
	/*action = "save";
	openAlert();	*/
//	_pageHasErrors=false;
	if(!errors){
		_pageHasErrors=false;
	}else{
		_pageHasErrors=true;
	}
}

function onChargesTabNonLcSaveClick(){
	var errors = validateChargesNonLc();
	onNonLcSaveClick(errors);	
}

function onNegotiationPaymentTabNonLcSaveClick(){
	var errors = validateNegotiationPaymentNonLc();
	onNonLcSaveClick(errors);
}

/* function onMt400202TabNonLcSaveClick(){
	var errors = validateMt400202TabNonLc()
	onNonLcSaveClick(errors);
}

 function onMt400TabNonLcSaveClick(){
	var errors = validateMt400TabNonLc()
	onNonLcSaveClick(errors);
} */

function onMt103TabNonLcSaveClick(){

	var errors = validateMt103TabNonLc()
	onNonLcSaveClick(errors);
}

function validateMt103TabNonLc(){
	
	var senderCtr=0;
	var error = 0
//		if($("#bankOperationCode").val()==""){
//			error_msg+="Bank Operation Code is empty."
//		}
//		if($(("#senderIdentifierCode").val()=="") && ("#sendersPartyIdentifier").val()=="") && 
//			("#senderLocation").val()=="") && ("#senderNameAndAddress").val()=="") ){
//				error_msg+="Sender's Correspondent is empty."
//		}
//		if($("#detailsOfCharges").val()==""){
//			error_msg+="Details of Charges is empty."
//		}
		
	$("#mt103TabForm :input").each(function(){
        if ($(this).attr("class") != undefined && $(this).attr("class") != null && $(this).attr("class").indexOf("required") != -1) {
           if ($(this).val() == "") {
               error ++;
               console.log("required\nid : " + $(this).attr("id") + "\nname : " + $(this).attr("name"));
           }
       }
	});
	
	//sender correspondent	
	$("#sendersLocation, #senderNameAndAddress, #senderIdentifierCode").each(function(){
		if("" == $(this).val()){
			senderCtr++;
		}
	});
	
	if(senderCtr == 3){
		error ++;
	}
	//--sender
	
	if(error > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
	
}

function onMt202TabNonLcSaveClick(){

	var errors = validateMt202TabNonLc()
	onNonLcSaveClick(errors);
}

function validateMt202TabNonLc(){
	
	var error_msg = ""
//		if($("input[name=sendersCorrespondentFlagMt202]").length > 0 && $("input[name=sendersCorrespondentFlagMt202]:checked").length == 0){
//			error_msg+="Sender's Correspondent is required."
//		}else if($("input[name=sendersCorrespondentFlagMt202]:checked").length == 1 && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == "A"){
//			if($("#senderIdentifierCodeMt202").length > 0 && $("#senderIdentifierCodeMt202").val() == ""){
//				error_msg+="Sender's Correspondent Identifier Code is required."
//			}
//		}else if($("input[name=sendersCorrespondentFlagMt202]:checked").length == 1 && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == "A"){
//			if($("#senderPartyIdentifierMt202").length > 0 && $("#senderPartyIdentifierMt202").val() == ""){
//				error_msg+="Sender's Correspondent Party Identifier is required."
//			}
//		}else if($("input[name=sendersCorrespondentFlagMt202]:checked").length == 1 && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == "B"){
//			if($("#senderLocationMt202").length > 0 && $("#senderLocationMt202").val() == ""){
//				error_msg+="Sender's Correspondent Location is required."
//			}
//		}else if($("input[name=sendersCorrespondentFlagMt202]:checked").length == 1 && $("input[name=sendersCorrespondentFlagMt202]:checked").val() == "D"){
//			if($("#senderNameAndAddressMt202").length > 0 && $("#senderNameAndAddressMt202").val() == ""){
//				error_msg+="Sender's Correspondent Name and Address is required."
//			}
//		}
		
		if($("input[name=beneficiaryBankFlagMt202]").length > 0 && $("input[name=beneficiaryBankFlagMt202]:checked").length == 0){
			if(error_msg.length > 0){
				error_msg += "\n"
			}
			error_msg+="Beneficiary Bank is required."
		}else if($("input[name=beneficiaryBankFlagMt202]:checked").length == 1 && $("input[name=beneficiaryBankFlagMt202]:checked").val() == "A"){
			if($("#beneficiaryIdentifierCode").length > 0 && $("#beneficiaryIdentifierCode").val() == ""){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg+="Beneficiary Bank Identifier Code is required."
			}
		}else if($("input[name=beneficiaryBankFlagMt202]:checked").length == 1 && $("input[name=beneficiaryBankFlagMt202]:checked").val() == "D"){
			if($("#beneficiaryNameAndAddress").length > 0 && $("#beneficiaryNameAndAddress").val() == ""){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg+="Beneficiary Bank Name and Address is required."
			}
		}
		
//	sendersCorrespondentFlagMt202 ABD
//	beneficiaryBankFlagMt202 AD
	
	switch($("input[name=sendersCorrespondentFlagMt202]:checked").val()){
		case "A":
			if("" == $("#senderIdentifierCodeMt202").val()){
				error_msg+="Sender Id Required.";
			}
			break;
		case "B":
			if("" == $("#senderLocationMt202").val()){
				error_msg+="Sender Location Required.";
			}
			break;
		case "D":
			if("" == $("#senderNameAndAddressMt202").val()){
				error_msg+="Sender Name/Address Required.";
			}
			break;
		default:
			error_msg+="Sender Correspondent required.";
	};
	
	switch($("input[name=beneficiaryBankFlagMt202]:checked").val()){
	case "A":
		if("" == $("#beneficiaryIdentifierCodeMt202").val()){
			error_msg+="Bene Id Required.";
		}
		break;
	case "D":
		if("" == $("#beneficiaryNameAndAddressMt202").val()){
			error_msg+="Bene Name/Address Required.";
		}
		break;
	default:
		error_msg+="Beneficiary required.";
	};
	
	
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
}

/* function validateMt400202TabNonLc(){
	var error_msg = ""
		if($("input[name=sendersCorrespondentFlag]").length > 0 && $("input[name=sendersCorrespondentFlag]:checked").length == 0){
			error_msg+="Sender's Correspondent is required."
		}else if($("input[name=sendersCorrespondentFlag]:checked").length == 1 && $("input[name=sendersCorrespondentFlag]:checked").val() == "A"){
			if($("#senderIdentifierCode").length > 0 && $("#senderIdentifierCode").val() == ""){
				error_msg+="Sender's Correspondent Identifier Code is required."
			}
		}else if($("input[name=sendersCorrespondentFlag]:checked").length == 1 && $("input[name=sendersCorrespondentFlag]:checked").val() == "B"){
			if($("#senderLocation").length > 0 && $("#senderLocation").val() == ""){
				error_msg+="Sender's Correspondent Location is required."
			}
		}else if($("input[name=sendersCorrespondentFlag]:checked").length == 1 && $("input[name=sendersCorrespondentFlag]:checked").val() == "D"){
			if($("#senderNameAndAddress").length > 0 && $("#senderNameAndAddress").val() == ""){
				error_msg+="Sender's Correspondent Name and Address is required."
			}
		}
		
		if($("input[name=beneficiaryBankFlag]").length > 0 && $("input[name=beneficiaryBankFlag]:checked").length == 0){
			if(error_msg.length > 0){
				error_msg += "\n"
			}
			error_msg+="Beneficiary Bank is required."
		}else if($("input[name=beneficiaryBankFlag]:checked").length == 1 && $("input[name=beneficiaryBankFlag]:checked").val() == "A"){
			if($("#beneficiaryIdentifierCode").length > 0 && $("#beneficiaryIdentifierCode").val() == ""){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg+="Beneficiary Bank Identifier Code is required."
			}
		}else if($("input[name=beneficiaryBankFlag]:checked").length == 1 && $("input[name=beneficiaryBankFlag]:checked").val() == "D"){
			if($("#beneficiaryNameAndAddress").length > 0 && $("#beneficiaryNameAndAddress").val() == ""){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg+="Beneficiary Bank Name and Address is required."
			}
		}
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
}*/

function validateNegotiationPaymentNonLc(){
	var error_msg = ""
		
		if(error_msg.length > 0){
	        $("#alertMessage").text("Please fill in all the required fields.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
}

function validateChargesNonLc(){
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

function validateBasicDetailsNonLc(){
	var error_msg = "";
//	if(documentClass == 'DP' && serviceType.toUpperCase() == 'NEGOTIATION' && documentType.toUpperCase() == 'DOMESTIC'){
		if($("#cifNumber").length > 0 && $("#cifNumber").val() == "") {
			error_msg += "CIF Number must not be blank."
		}
//	}
	if((documentClass == 'DA' && !(serviceType.toUpperCase() == 'NEGOTIATION_ACCEPTANCE' || serviceType.toUpperCase() == 'NEGOTIATION ACCEPTANCE') || documentClass == 'DP') && !(serviceType.toUpperCase() == 'SETTLEMENT' && referenceType.toUpperCase() == 'ETS')){
		if($("#remittingBank").length > 0){
			if($("#remittingBank").val() == "" ){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg += "Remitting Bank is not specified."
			}
			if($("#remittingBank").val() != "" && $("#remittingBank").val().length > 11){
				if(error_msg.length > 0){
					error_msg += "\n"
				}
				error_msg += "Remitting Bank code length cannot exceed 11 characters."
			}
		}
		if($("#remittingBankReferenceNumber").length > 0 && $("#remittingBankReferenceNumber").val() == "" ){
			if(error_msg.length > 0){
				error_msg += "\n"
			}
			error_msg += "Remitting Bank Reference Number is not specified."
		}
	}
	if(!(serviceType.toUpperCase() == 'NEGOTIATION_ACCEPTANCE' || serviceType.toUpperCase() == 'NEGOTIATION ACCEPTANCE' || serviceType.toUpperCase() == 'SETTLEMENT')){
	if($("#currency").length > 0 && $("#currency").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Draft Currency is not specified."
	}
	if($("#amount").length > 0 && $("#amount").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Draft Amount is not specified."
	}
	if($("#amount").val() == "0.00" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Draft Amount should not be zero."
	}
	}
	if ((documentClass == 'OA' || (documentClass == 'DA' && (serviceType.toUpperCase() == 'NEGOTIATION_ACCEPTANCE' || serviceType.toUpperCase() == 'NEGOTIATION ACCEPTANCE')))
			&& ($("#maturityDate").length > 0 && $("#maturityDate").val() == "")) {
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Maturity Date is not set."
	}

	if($("#originalPort").length > 0 && $("#originalPort").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Original Port cannot be blank."
	}
	if(referenceType.toUpperCase() == 'DATA_ENTRY' && !(serviceType.toUpperCase() == 'NEGOTIATION_ACCEPTANCE' || serviceType.toUpperCase() == 'NEGOTIATION ACCEPTANCE')){
	if($("#dateOfBlAirwayBill").length > 0 && $("#dateOfBlAirwayBill").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += (documentType.toUpperCase() == 'FOREIGN') ? "Date of BL/Airway Bill is not set." : "Date of BL/Airway Bill is not set."
	}
	if($("#importerName").length > 0 && $("#importerName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Importer Name must be specified."
	}
	if($("#importerAddress").length > 0 && $("#importerAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Importer Address must be specified."
	}
	}
	if(serviceType.toUpperCase() != 'SETTLEMENT' && !(serviceType.toUpperCase() == 'NEGOTIATION_ACCEPTANCE' || serviceType.toUpperCase() == 'NEGOTIATION ACCEPTANCE')){
	if(($("#importerCifNumber").length > 0 && $("#importerCifNumber").val() == "") && ($("#importerCbCode").length > 0 && $("#importerCbCode").val() == "")) {
		if(error_msg.length > 0){
			error_msg += "\n"
		}
        error_msg += "Either Importer CIF Number of Importer CB Code must be specified."
	}
	if($("#beneficiaryName").length > 0 && $("#beneficiaryName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Beneficiary Name must be specified."
	}
	if($("#beneficiaryAddress").length > 0 && $("#beneficiaryAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Beneficiary Address must be specified."
	}
	}
	if($("#productAmount").length > 0 && $("#productAmount").val() == "" && (($("#settleFlagCheck").length > 0 && $("#settleFlagCheck").val() != 'Y') || $("#settleFlagCheck").length <= 0)){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Settlement Amount is not specified."
	}
	if($("#productAmount").length > 0 && $("#productAmount").val() == "0.00" && (($("#settleFlagCheck").length > 0 && $("#settleFlagCheck").val() != 'Y') || $("#settleFlagCheck").length <= 0)){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Settlement Amount should not be zero."
	}
	if($("#settlementMode").length > 0 && $("#settlementMode").val() == "" && (($("#settleFlagCheck").length > 0 && $("#settleFlagCheck").val() != 'Y') || $("#settleFlagCheck").length <= 0)){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Settlement Mode must be specified."
	}
	if(referenceType.toUpperCase() == "DATA_ENTRY"){
	if($("#reimbursingBankName").length > 0 && $("#reimbursingBankName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Reimbursing Bank Name must be specified."
	}
	if($("input[name=accountType]").length > 0 && $("input[name=accountType]:checked").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Reimbursing Account Type must be specified."
	}
	if($("#depositoryAccountNumber").length > 0 && $("#depositoryAccountNumber").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Reimbursement Account Number has been generated."
	}
	if($("#reimbursingBankCurrency").length > 0 && $("#reimbursingBankCurrency").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Reimbursement Bank Currency has been generated."
	}
	}
	if(referenceType.toUpperCase() != "DATA_ENTRY"){
		if($("#valueDate").length > 0 && $("#valueDate").val() == "" && $("#settlementMode").val() == "TR"){
			if(error_msg.length > 0){
				error_msg += "\n"
			}
			error_msg += "Value Date must be specified."
		}
	}
	if(error_msg.length > 0){
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}


function validateNonLc(buttonParentId){	
	
	/*alert("validateNonLc!")*/
	
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsNonLcSaveClick();
		break;
	case "cashLcPaymentTabForm":
		onNegotiationPaymentTabNonLcSaveClick();
		break;
	case "chargesTabForm":
		onChargesTabNonLcSaveClick();
		break;
	case "mt202_DetailsTabForm":		
		onMt202TabNonLcSaveClick();
		break;
	case "mt103TabForm":		
		onMt103TabNonLcSaveClick();
		break;		
//	default:
//		onNonLcSaveClick();
//		break;
	}
}