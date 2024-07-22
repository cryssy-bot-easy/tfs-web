function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsDmlcOpening();
	onSaveClick(errors);
}

function onShipmentGoodsSaveClick(){
	var errors = validateShipmentGoodsDmlcOpening();
	onSaveClick(errors);
}

function onDocumentsRequiredSaveClick(){
	var errors = validateDocumentsRequiredDmlcOpening();
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

function validateBasicDetailsDmlcOpening(){
	var error_msg = "";
	if($("input[name=standbyTagging]").length > 0 && $("input[name=standbyTagging]:checked").length <= 0 ){
		error_msg += "No Standby Tagging was specified."
	}
	if($("#purposeNarrative").length > 0 && $("#purposeNarrative").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Standby Purpose was specified."
	}
	if($("#formOfDocumentaryCredit").length > 0 && $("#formOfDocumentaryCredit").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Form of Documentary Credit is not specified."
	}
	if($("#applicantName").length > 0 && $("#applicantName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Applicant's Name was not specified."
	}
	if($("#applicantAddress").length > 0 && $("#applicantAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Applicant's Address was not specified."
	}
	if($("#beneficiaryName").length > 0 && $("#beneficiaryName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Beneficiary's Name was not specified."
	}
	if($("#beneficiaryAddress").length > 0 && $("#beneficiaryAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Beneficiary's Address was not specified."
	}
	if($("#basic_details_tab #narrative").length > 0 && $("#basic_details_tab #narrative").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Narrative format is not set."
	}
	if($("#descriptionOfGoodsServices").length > 0 && $("#descriptionOfGoodsServices").val() == "" && $("#documentSubType1").val() != "STANDBY"){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "There is no Description of Goods and/or Services."
	}
	
	if(error_msg.length > 0){
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
	return false;
	}
}

function validateShipmentGoodsDmlcOpening(){
	var error_msg = "";
	if($("#generalDescriptionOfGoods").length > 0 && $("#generalDescriptionOfGoods").val() == "" ){
		error_msg += "There is no General Description of Goods and/or Services."
	}
	if($("#by").length > 0 && $("#by").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No mode of Agreement was specified."
	}
	if($("input[name=partialDelivery]").length > 0 && $("input[name=partialDelivery]:checked").length <= 0 ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "The condtions for Partial Delivery was not Specified."
	}
	
	if($("#usancePeriod").length > 0 && $("#usancePeriod").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Usance Period is not set."
	}
	
	if($("#tenorOfDraftNarrative").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Tenor Of Draft Narrative is not set."
	}
	
	if(error_msg.length > 0){
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateDocumentsRequiredDmlcOpening(){
	if($("#requiredDocumentsList").length > 0){
		var requiredDocuments = $("#doc_required_list").jqGrid("getGridParam","selarrrow");
	    var requiredDocumentsList = new Array();
	
	    for(var i in requiredDocuments) {
	        var id = requiredDocuments[i]
	
	        var data = $("#doc_required_list").jqGrid("getRowData", id);
	
	        var requiredDocumentItem = {documentCode: id, description: data.description};
	
	        requiredDocumentsList.push(requiredDocumentItem);
	    }
	
	    $("#requiredDocumentsList").val(JSON.stringify(requiredDocumentsList));
	    
	    if($("#requiredDocumentsList").val().length <= 2){
	    	$("#alertMessage").text("Please complete the Required Documents Tab.");
	        triggerAlert();
			return true
		} else {
			return false;
		}
	}
}

function validateDmlcOpeningDataEntry(buttonParentId){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
	break;
	case "shipmentOfGoodsTabForm":
		onShipmentGoodsSaveClick();
	break;
	case "documentsRequiredTabForm":
		onDocumentsRequiredSaveClick();
	break;
	default:
		onDmlcOpeningSaveClick();
	break;
	}
}