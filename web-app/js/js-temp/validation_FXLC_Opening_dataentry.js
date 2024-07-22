/* Modified by: Rafael Ski Poblete
 * Date Modified: 9/03/18
 * Description: Added condition for Narrative Checkbox.
 * */
function onBasicDetailsSaveClick(){
	var errors = validateBasicDetailsFxlcOpening();
	onSaveClick(errors);
}

function onImporterExporterDetailsSaveClick(){
	var errors = validateImporterExporterDetailsFxlcOpening();
	onSaveClick(errors);
}

function onShipmentGoodsSaveClick(){
	var errors = validateShipmentGoodsFxlcOpening();
	onSaveClick(errors);
}

function onAdditionalConditionsSaveClick(){
    if(!activePopup) {
        var errors = validateAdditionalConditionsFxlcOpening();
        onSaveClick(errors);
    } else {
//        action = "save";
//        openAlert();
//        confirmAlert();
        _pageHasErrors=false;
    }
}

function onReimbursementDetailsSaveClick(){
	var errors = validateReimbursementDetailsFxlcOpening();
	onSaveClick(errors);
}

function onDetailsOfGuaranteeSaveClick(){
	var errors = validateDetailsOfGuaranteeFxlcOpening();
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

function onFxlcOpeningSaveClick(){
	/*action = "save";
	openAlert();*/	
	_pageHasErrors=false;
}

function validateBasicDetailsFxlcOpening(){
	var error_msg = "";
	if($("#expiryCountryCode").length > 0 && $("#expiryCountryCode").val() == "" ){
		error_msg += "No Expiry Country Code specified."
	}
	
	
	if($("#destinationBank").length > 0 && $("#destinationBank").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Destination Bank specified."
	}
	if($("#applicableRules").length > 0 && $("#applicableRules").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Applicant Rules is not specified."
	}
	if($("#formOfDocumentaryCredit").length > 0 && $("#formOfDocumentaryCredit").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Form of Documentary Credit specified."
	}
	if($("#furtherIdentification").length > 0 && $("#furtherIdentification").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "No Further Identification set."
	}
	if($("#purposeOfStandby").length > 0 && $("#purposeOfStandby").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Purpose of Standby not set."
	}
	if($("input[name=standbyTagging]").length > 0 && $("input[name=standbyTagging]:checked").length == 0 ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Standby Tagging not specified."
	}
	if(!$("#importerCbCode").val()) {
        if($("#importerCifNumber").length > 0 && $("#importerCifNumber").val() == "" ){
            /*if(error_msg.length > 0){
                error_msg += "\n"
            }*/
            error_msg += "Importer CIF Number was not set."
        }
    }

    if($("#exporterName").length > 0 && $("#exporterName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Exporter Name was not set."
	}
	if((documentSubType1 != 'STANDBY') && $("#importerName").length > 0 && $("#importerName").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Importer Name was not set."
	}
	if((documentSubType1 != 'STANDBY') && $("#importerAddress").length > 0 && $("#importerAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Importer Address was not set."
	}
	if($("#exporterAddress").length > 0 && $("#exporterAddress").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Exporter Address was not set."
	}
	if(($("#availableWith").length > 0 && $("#availableWith").val() == "") && ($("#nameAndAddress").length > 0 && $("#nameAndAddress").val() == "")){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
        //if($("input[name=confirmationInstructionsFlag]:checked").val() != "Y") {
            error_msg += "Available With was not set."
        //}
	}
	if($("#availableByDisplay").length > 0 && $("#availableByDisplay").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
        error_msg += "Transaction is not available by anything."
	}
	if($("#countryCode").length > 0 && $("#countryCode").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Country Code was not specified."
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

function validateImporterExporterDetailsFxlcOpening(){
	var error_msg = "";
	/*if($("#exporterCbCode").length > 0 && $("#exporterCbCode").val() == "" ){
		error_msg += "Exporter CB Code was not set."
	}*/

    // checks importer cif number only if there is no importer cb code selected
	
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

function validateShipmentGoodsFxlcOpening(){
	var error_msg = "";
	var ship_date=new Date($("#latestShipmentDate").val());
	
	if($("#latestShipmentDate").length > 0 && $("#latestShipmentDate").val() == "" && ($("#shipmentPeriod").length > 0 && $("#shipmentPeriod").val() == "")){
		error_msg += "Latest Date of Shipment was not set.";
	}
	
	if (ship_date=="Invalid Date" && ($("#shipmentPeriod").length > 0 && $("#shipmentPeriod").val() == "")){
		if(error_msg.length > 0){
			error_msg+="\n";
		}
		error_msg+="Invalid Date Format";
	}
	
	
	if(ship_date!="Invalid Date" && ship_date >new Date($("#expiryDate").val())){
		if(error_msg.length > 0){
			error_msg+="\n";
		}
		error_msg+="Latest Shipment Date must not be greater than Expiry Date.";
	}
	
	if($("#generalDescriptionOfGoods").length > 0 && $("#generalDescriptionOfGoods").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n";
		}
		error_msg += "No Description of Goods and/or Services specified.";
	}
	if($("#commodityCode").length > 0 && $("#commodityCode").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Commodity Code not set."
	}
	if($("#partialShipment").length > 0 && $("#partialShipment").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Condition for Partial Shipment not set."
	}
	if($("#transShipment").length > 0 && $("#transShipment").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Condition for Transshipment not set."
	}
	if($("#portOfLoadingOrDeparture").length > 0 && $("#portOfLoadingOrDeparture").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Landing/Airport of Departure not set."
	}
	if($("#bspCountryCode").length > 0 && $("#bspCountryCode").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Landing/Airport of Departure BSP Code not set."
	}
	if($("#portOfDischargeOrDestination").length > 0 && $("#portOfDischargeOrDestination").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Discharge/Airport of Destination not set."
	}
	if($("#partialShipment").length > 0 && $("#partialShipment").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Condition for Partial Shipment not set."
	}
	if($("#transShipment").length > 0 && $("#transShipment").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Condition for Transshipment not set."
	}
	if($("#portOfLoadingOrDeparture").length > 0 && $("#portOfLoadingOrDeparture").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Landing/Airport of Departure not set."
	}
	if($("#bspCountryCode").length > 0 && $("#bspCountryCode").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Landing/Airport of Departure BSP Code not set."
	}
	if($("#portOfDischargeOrDestination").length > 0 && $("#portOfDischargeOrDestination").val() == "" ){
		if(error_msg.length > 0){
			error_msg += "\n"
		}
		error_msg += "Port of Discharge/Airport of Destination not set."
	}
	
	if(error_msg.length > 0){
//		alert(error_msg);
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
//        $("#alertMessage").text(error_msg);
        triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateAdditionalConditionsFxlcOpening(){
	var error_msg = "";	 	
//	var formName = document.getElementById('additionalCondition1TabForm');
//    var inputTags = formName.getElementsByTagName('input');
//    var checked = 0;
//    for (var i=0, length = inputTags.length; i<length; i++) {
//	      if (inputTags[i].type == 'checkbox') {
//	          if(inputTags[i].checked == true){
//	        	  checked++;
//	          }
//	      }
//	 }
//if($("#jqg_add_conditions1_list_AC-006").is(':checked')){
	
//	if(checked>0){
		if($("#discrepancyCurrency").length > 0 && $("#discrepancyCurrency").val() == "" ){			
			error_msg += "Discrepancy Currency not specified."
		}
		if($("#discrepancyAmount").length > 0 && $("#discrepancyAmount").val() == "" ){
			if(error_msg.length > 0){
				error_msg += "\n"
			}
			error_msg += "Discrepancy Amount not specified."
		}
		if($("#reimbursingBankIdentifierCode").val()){
			if($("#reimbursingBankIdentifierCode").val() != $("#destinationBank").val() && !(document.getElementById('swiftNarrativeCheckbox').checked)) {
				error_msg += "Narrative not specified."
			}
		}
//	}
//}	
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

function validateReimbursementDetailsFxlcOpening(){
	var error_msg = "";	
	var reimbursingBankFlag = $("input[type=radio][name=reimbursingBankFlag]:checked").val();
	
//	if(reimbursingBankFlag=="A" || reimbursingBankFlag=="B"){
//		if($("#reimbursingCurrency").length > 0 && $("#reimbursingCurrency").val() == "" ){
//			error_msg += "Reimbursing Currency not specified."
//		}
//	}
//
//	if('undefined' == typeof $("#reimbursingAccountTypeWrapper :checked").val() || "" == $("#reimbursingBankAccountNumber").val()){
//		error_msg +="Account Type and Reimbursing Bank Account Number not specified"
//	}
//	
//	if("" == $("#reimbursingBankIdentifierCode").val()){
//		error_msg +="Reimbursing Bank Idenfier Code not specified."
//	}
	
	if(error_msg.length > 0){
//		alert(error_msg);
//		alert("Please fill-up required fields.");
        $("#alertMessage").text("Please fill in all the required fields.");
        triggerAlert();
		return true
	} else {
//		  $("#alertMessage").text("Please fill in all the required fields.");
//	        triggerAlert();
//			return true
		return false;
	}
}

function validateDetailsOfGuaranteeFxlcOpening(){
	var error_msg = "";
	if($("#detailsOfGuarantee").length > 0 && $("#detailsOfGuarantee").val() == "" ){
		error_msg += "Details of Guarantee not set."
	}
	
	if(error_msg.length > 0){
//		alert(error_msg);
//		alert("Please fill-up required fields.");

		return true
	} else {
		return false;
	}
}


function validateFxlcOpeningDataEntry(buttonParentId, id){
	switch(buttonParentId){
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "importerExporterDetailsTabForm":
		onImporterExporterDetailsSaveClick();
		break;
	case "shipmentOfGoodsTabForm":
		onShipmentGoodsSaveClick();
		break;
	case "additionalCondition1TabForm":
		onAdditionalConditionsSaveClick();
		break;
	case "additionalCondition2TabForm":
		if (id = "saveInstructionsToBank"){
			onFxlcOpeningSaveClick();
		} else {
			onReimbursementDetailsSaveClick();
		}
		break;
	case "detailsOfGuaranteeTabForm":
		onDetailsOfGuaranteeSaveClick();
		break;
	default:
		onFxlcOpeningSaveClick();
		break;
	}
}


function applicableRulesChange(){
	
	if ($("#applicableRules :selected").val()=="OTHR"){
		$(".othr_field").removeAttr("disabled");
	}else{
		$(".othr_field").attr("disabled","disabled");
		$(".othr_field").val("");
	}
}

function priceTermChange(){
	if ($("#priceTerm :selected").val()=="OTH" && userRole.indexOf("TSDM")!=-1){
		$("#priceTermNarrative").removeAttr("disabled");
	}else{
		$("#priceTermNarrative").attr("disabled","disabled");
		$("#priceTermNarrative").val("");
	}
}
	

$(function(){
$("document").ready(function(){	
	var reimbursingBankFlag = $("input[type=radio][name=reimbursingBankFlag]:checked").val();
	
		if(reimbursingBankFlag=="A" || reimbursingBankFlag=="B"){	 
			$(".reimburstmentCurrencyAsterisk").show();	 			
		}else{
			$(".reimburstmentCurrencyAsterisk").hide();			
		}
	
		$(".reimbursingBankFlagB").click(function() {					
				$(".reimburstmentCurrencyAsterisk").show();					
		});
		
		$(".reimbursingBankFlagA").click(function() {			
				$(".reimburstmentCurrencyAsterisk").show();					
		});
	
		$("#applicableRules").change(applicableRulesChange);
		applicableRulesChange();
		
		$("#priceTerm").change(priceTermChange);
		priceTermChange();
		
	});
	


});
