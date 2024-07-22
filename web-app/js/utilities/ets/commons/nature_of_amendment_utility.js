/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 9/19/12
 * Time: 10:54 AM
 * To change this template use File | Settings | File Templates.
 */


/**
 * PROLOGUE:
 * (revision)
 * SCR/ER Number: 20160421-087
 * SCR/ER Description: The system allows to approve the transaction when the change in amount(checkbox) was checked but the new Amount was left unfilled. 
 * [Revised by:] Jesse James M. Joson
 * [Date Deployed:] 04/22/2016
 * Program [Revision] Details: Provide validation upon saving if change in amount(checkbox) was checked but the new Amount was left unfilled. 
 * PROJECT: WEB
 * MEMBER TYPE  : JAVASCRIPT
 * Project Name: nature_of_amendment_utility.js
 */

/**
 	(revision)
	SCR/ER Number: SCR# IBD-15-1125-01
	SCR/ER Description: Added functions for Buyer and Seller Info 
	[Revised by:] Jonh Henry Santos Alabin
	[Date revised:] 1/12/2017
	Program [Revision] Details: Added functions for Buyer and Seller Info and validation upon saving if change in Buyer or Seller Info(checkbox) was checked but the new Amount was left unfilled. 
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: nature_of_amendment_utility.js
 
 */

//added by Henry Alabin
var regexp1 = /^[a-zA-Z]{1}/;
var regexp2 = /^[a-zA-Z0-9]{1}/;
if (documentType == "FOREIGN" && documentSubType1 == "STANDBY" && documentClass == "LC" ){
	var buyerNameInForeign = "Importer";
	var sellerNameInForeign = "Expoter";
	} else{
	var buyerNameInForeign = "Buyer";
	var sellerNameInForeign = "Seller";
}




function setLcAmountCheck() {
    var lcAmountCheck = $("#amountSwitch").val();

    if(lcAmountCheck) {
        if(lcAmountCheck.toLowerCase() == "on") {
            $("#amountSwitchDisplay").attr("checked", "checked");
        } else {
            $("#amountSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#amountSwitchDisplay").attr("checked", false);
    }
}

function onLcAmountCheck() {
    if($("#amountSwitchDisplay").attr("checked") == "checked") {
        $("#amountSwitch").val("on");
        $("input[name=lcAmountFlagDisplay]").removeAttr("disabled");
//        onAmountFlagChange();
        var lcAmountFlag = $("input[name=lcAmountFlagDisplay]:checked").val();
        $("#lcAmountFlag").val(lcAmountFlag);

        if(lcAmountFlag != undefined) {
            $("#amountTo").removeAttr("readonly");
        }
    } else {
        $("#amountSwitch").val("off");
        $("input[name=lcAmountFlagDisplay]").attr("disabled", "disabled");
        $("input[name=lcAmountFlagDisplay]").attr("checked", false);
        $("#lcAmountFlag").val("");
        $("#amountTo").attr("readonly", "readonly");
        $("#amountTo").val("");
    }
}

function onAmountFlagChange() {
    var lcAmountFlag = $("input[name=lcAmountFlagDisplay]:checked").val();
    if (lcAmountFlag != $("#lcAmountFlag").val()) {
        $("#lcAmountFlag").val(lcAmountFlag);

        $("#amountTo").val("");
    }

    if(lcAmountFlag != undefined) {
        $("#amountTo").removeAttr("readonly");
    }
}

function onChangeAmountTo() {
	// ER Start: 20160421-087:  Change the verification, from amount to Amount From to validate the correct input needed in the field
	if(($("#amountTo").val().replace(/,/g,"") * 100 <= $("#amountFrom").val().replace(/,/g,"") * 100) && $("#lcAmountFlag").val() == 'INC'){
		$("#alertMessage").text("Value cannot be less than or equal to Original Amount.");
        triggerAlert();
        $("#amountTo").val("");
	} else if($("#lcAmountFlag").val() == 'DEC'){
		if($("#amountTo").val().replace(/,/g,"") * 100 >= $("#amountFrom").val().replace(/,/g,"") * 100){
			$("#alertMessage").text("Value cannot be greater than or equal to Original Amount.");
			triggerAlert();
	        $("#amountTo").val("");
		} else if(($("#amountTo").val().replace(/,/g,"") * 100) <= ($("#amountFrom").val().replace(/,/g,"") * 100 - $("#outstandingBalance").val().replace(/,/g,"") * 100)){
				$("#alertMessage").text("Value must not reduce Outstanding  Balance to zero or to negative value.");
		        triggerAlert();
		        $("#amountTo").val("");
		}
	} else {
	    var amountTo = 0;
	    if($("#amountTo").val() != "") {
	        amountTo = $("#amountTo").val().replace(/,/g,"");
	    }
	
	    var amountFrom = $("#amountFrom").val().replace(/,/g,"");
	
	    var diff = parseFloat(amountTo) - parseFloat(amountFrom);
	
	    if(diff > 0) {
	        $("#cashAmount").val(diff);
	    }
	}
	// ER End: 20160421-087:  
}

function onExpiryDateCheck() {
    if($("#expiryDateSwitchDisplay").attr("checked") == "checked") {
        $("#expiryDateSwitch").val("on");
        $("input[name=expiryDateFlagDisplay]").removeAttr("disabled");
        onExpiryDateFlagChange();
    } else {
        $("#expiryDateSwitch").val("off");
        $("input[name=expiryDateFlagDisplay]").attr("disabled", "disabled");
        $("input[name=expiryDateFlagDisplay]").attr("checked", false);
//        $("#expiryDateTo").datepicker("disable");
        $("#expiryDateFlag").val("");
        $("#expiryDateTo").removeClass("datepicker_field").addClass("input_field").datepicker("destroy");
        $("#expiryDateTo").attr("readonly", "readonly");
        $("#expiryDateTo").val("");
        $("#expiryDateModifiedDays").val("");
    }
}

function setExpiryDateCheck() {
    var expiryDateCheck = $("#expiryDateSwitch").val();

    if(expiryDateCheck) {
        if(expiryDateCheck.toLowerCase() == "on") {
            $("#expiryDateSwitchDisplay").attr("checked", "checked");
        } else {
            $("#expiryDateSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#expiryDateSwitchDisplay").attr("checked", false);
    }
}

function onExpiryDateFlagChange() {
    var expiryDateFlag = $("input[name=expiryDateFlagDisplay]:checked").val();

    $("#expiryDateFlag").val(expiryDateFlag);

    if(expiryDateFlag != undefined) {
        $("#expiryDateTo").addClass("datepicker_field");
        $("#expiryDateTo").datepicker("destroy");
		$("#expiryDateTo").datepicker({
			showOn: 'both',
			buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
			changeMonth: true,
			changeYear: true,
			constrainInput:true,
			defaultDate:null,
			dateFormat:'mm/dd/yy'
	  	}).attr("readonly","readonly");

        if($("input[name=expiryDateFlagDisplay]:checked").val() == 'EXT'){
            $("#expiryDateTo").datepicker("option", "minDate", $("#expiryDate").val());
        } else if($("input[name=expiryDateFlagDisplay]:checked").val() == 'RED'){
            $("#expiryDateTo").datepicker("option", "maxDate", $("#expiryDate").val());
            $("#expiryDateTo").datepicker("option", "minDate", $("#amendmentDate").val());
        }
    }
}

function setNumberOfDays(){
    var oldExpiry = new Date($("#originalExpiryDate").val());
    var newExpiry = new Date($("#expiryDateTo").val())!=null?new Date($("#expiryDateTo").val()):'';

    if($("input[name=expiryDateFlagDisplay]:checked").val() == 'EXT' || $("input[name=expiryDateFlagDisplay]:checked").val() == 'RED'){
        $("#expiryDateModifiedDays").val(parseInt(Math.abs((newExpiry-oldExpiry)/(1000*60*60*24)) || 0));
    }
}

function onTenorCheck() {
//    alert("onTenorCheck : nature_of_amendment_utility.js")
    if($("#tenorSwitchDisplay").attr("checked") == "checked") {
//        alert("d1")
        $("#tenorSwitch").val("on");
//        $("#tenorTo").removeAttr("disabled");
        $("#tenorTo").val("USANCE");
    } else {
//        alert("d2")
        $("#tenorSwitch").val("off");
//        $("#tenorTo").attr("disabled", "disabled");
        $("#tenorTo").val("");
    }
    onTenorToChange();
}

function setTenorCheck() {
    var tenorCheck = $("#tenorSwitch").val();

    if(tenorCheck) {
        if(tenorCheck.toLowerCase() == "on") {
            $("#tenorSwitchDisplay").attr("checked", "checked");
        } else {
            $("#tenorSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#tenorSwitchDisplay").attr("checked", false);
    }
}

function onTenorToChange() {
    var tenorTo = $("#tenorTo").val();
    var originalTenor = $("#originalTenor").val();
//    alert("onTenorToChange : nature_of_amendment_utility.js")
    if(tenorTo) {
        if(tenorTo.toUpperCase() == "USANCE") {
//            alert("e1")
            $("#usancePeriodTo, #tenorOfDraftNarrativeTo").removeAttr("readonly");
        } else {
            $("#usancePeriodTo, #tenorOfDraftNarrativeTo").attr("readonly", "readonly");
            if(originalTenor.toUpperCase() == "SIGHT"){
//                alert("e2")
            	$("#usancePeriodTo, #tenorOfDraftNarrativeTo").val("");
            }
        }
    } else {
//        alert("e3")
        $("#usancePeriodTo, #tenorOfDraftNarrativeTo").attr("readonly", "readonly");
        if(originalTenor && originalTenor.toUpperCase() == "SIGHT"){
//            alert("e4")
        	$("#usancePeriodTo, #tenorOfDraftNarrativeTo").val("");
        }
    }
}

function onConfirmationInstructionsChange(){
	 var confirmationInstructionsFlagTo = $("#confirmationInstructionsFlagTo").val();	 
	
	if(confirmationInstructionsFlagTo.toUpperCase()!="YES"){		
		$("#advisingBank").select2("enable"); 	
		
	}else{		
		$("#advisingBank").select2("disable"); 			
	}
}

function onConfirmationInstructionsLoad(){
	  var confirmationInstructionsFlagTo = $("#originalConfirmationInstructionsFlag").val();	  
		if(confirmationInstructionsFlagTo != null && confirmationInstructionsFlagTo.toUpperCase()!="YES"){				
			$("#advisingBank").select2("enable"); 
		}else{		
			$("#advisingBank").select2("disable"); 		
		}
}

function onConfirmationInstructionsCheck() {
    if($("#confirmationInstructionsFlagSwitchDisplay").attr("checked") == "checked") {
        $("#confirmationInstructionsFlagSwitch").val("on");
        $("#confirmationInstructionsFlagTo").removeAttr("disabled");
    } else {
        $("#confirmationInstructionsFlagSwitch").val("off");
        $("#confirmationInstructionsFlagTo").attr("disabled", "disabled");
        $("#confirmationInstructionsFlagTo").val("");
    }
}

function setConfirmationInstructionsCheck() {
    var confirmationInstructionsCheck = $("#confirmationInstructionsFlagSwitch").val();

    if(confirmationInstructionsCheck) {
        if(confirmationInstructionsCheck.toLowerCase() == "on") {
            $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", "checked");
        } else {
            $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", false);
    }
}

function onNarativeCheck() {

    if($("#narrativeSwitchDisplay").attr("checked") == "checked") {
        $("#narrativeSwitch").val("on");

        $("#amendment_narrative_td :input").removeAttr("readonly");
        //$("#narrative.amendment_narrative").removeAttr("readonly");
    } else {    	
        $("#narrativeSwitch").val("off"); 
        $("#amendment_narrative_td :input").attr("readonly","readonly");
        //$("#narrative.amendment_narrative").attr("readonly","readonly");
        $("#amendment_narrative_td :input").val("");
    }
}

function setNarrativeCheck() {
    var narrativeCheck = $("#narrativeSwitch").val();    
    if(narrativeCheck) {    	
        if(narrativeCheck.toLowerCase() == "on") {
            $("#narrativeSwitchDisplay").attr("checked", "checked");            
        } else {
            $("#narrativeSwitchDisplay").attr("checked", false);          
        }
    }else {
        $("#narrativeSwitchDisplay").attr("checked", false);
    }
}

//added by henry BUYER And Seller INFO functions
//Buyer Info
function setBeneficiaryNameCheck(){
	var beneficiaryNameSwitch = $("#beneficiaryNameSwitch").val();

    if(beneficiaryNameSwitch) {
        if(beneficiaryNameSwitch.toLocaleString() == "on") {
            $("#beneficiaryNameSwitchDisplay").attr("checked", "checked");
        } else {
            $("#beneficiaryNameSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#beneficiaryNameSwitchDisplay").attr("checked", false);
    }
}
function onBeneficiaryNameCheck(){
	if($("#beneficiaryNameSwitchDisplay").attr("checked") == "checked") {
        $("#beneficiaryNameSwitch").val("on");
        $("#beneficiaryNameTo").removeAttr("readonly");
        $(".beneficiaryNameToAsterisk").addClass("asterisk");
        $(".beneficiaryNameToAsterisk").removeClass("clear_font");
    } else {
        $("#beneficiaryNameSwitch").val("off");
        $("#beneficiaryNameTo").attr("readonly", "readonly");
        $("#beneficiaryNameTo").val("");
        $(".beneficiaryNameToAsterisk").removeClass("asterisk");
        $(".beneficiaryNameToAsterisk").addClass("clear_font");
    }
}

function setBeneficiaryAddressCheck(){
	var beneficiaryAddressSwitch = $("#beneficiaryAddressSwitch").val();

    if(beneficiaryAddressSwitch) {
        if(beneficiaryAddressSwitch.toLocaleString() == "on") {
            $("#beneficiaryAddressSwitchDisplay").attr("checked", "checked");
        } else {
            $("#beneficiaryAddressSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#beneficiaryAddressSwitchDisplay").attr("checked", false);
    }
}
function onBeneficiaryAddressCheck(){
	if($("#beneficiaryAddressSwitchDisplay").attr("checked") == "checked") {
        $("#beneficiaryAddressSwitch").val("on");
        $("#beneficiaryAddressTo").removeAttr("readonly");
        $(".beneficiaryAddressToAsterisk").addClass("asterisk");
        $(".beneficiaryAddressToAsterisk").removeClass("clear_font");
    } else {
        $("#beneficiaryAddressSwitch").val("off");
        $("#beneficiaryAddressTo").attr("readonly", "readonly");
        $("#beneficiaryAddressTo").val("");
        $(".beneficiaryAddressToAsterisk").removeClass("asterisk");
        $(".beneficiaryAddressToAsterisk").addClass("clear_font");
    }
}
// Seller info

function setApplicantNameCheck(){
	var applicantNameSwitch = $("#applicantNameSwitch").val();

    if(applicantNameSwitch) {
        if(applicantNameSwitch.toLocaleString() == "on") {
            $("#applicantNameSwitchDisplay").attr("checked", "checked");
        } else {
            $("#applicantNameSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#applicantNameSwitchDisplay").attr("checked", false);
    }
}
function onApplicantNameCheck(){
	if($("#applicantNameSwitchDisplay").attr("checked") == "checked") {
        $("#applicantNameSwitch").val("on");
        $("#applicantNameTo").removeAttr("readonly");
        $(".applicantNameToAsterisk").addClass("asterisk");
        $(".applicantNameToAsterisk").removeClass("clear_font");
    } else {
        $("#applicantNameSwitch").val("off");
        $("#applicantNameTo").attr("readonly", "readonly");
        $("#applicantNameTo").val("");
        $(".applicantNameToAsterisk").removeClass("asterisk");
        $(".applicantNameToAsterisk").addClass("clear_font");
    }
}

function setApplicantAddressCheck(){
	var applicantAddressSwitch = $("#applicantAddressSwitch").val();

    if(applicantAddressSwitch) {
        if(applicantAddressSwitch.toLocaleString() == "on") {
            $("#applicantAddressSwitchDisplay").attr("checked", "checked");
        } else {
            $("#applicantAddressSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#applicantAddressSwitchDisplay").attr("checked", false);
    }
}
function onApplicantAddressCheck(){
	if($("#applicantAddressSwitchDisplay").attr("checked") == "checked") {
        $("#applicantAddressSwitch").val("on");
        $("#applicantAddressTo").removeAttr("readonly");
        $(".applicantAddressToAsterisk").addClass("asterisk");
        $(".applicantAddressToAsterisk").removeClass("clear_font");
    } else {
        $("#applicantAddressSwitch").val("off");
        $("#applicantAddressTo").attr("readonly", "readonly");
        $("#applicantAddressTo").val("");
        $(".applicantAddressToAsterisk").removeClass("asterisk");
        $(".applicantAddressToAsterisk").addClass("clear_font");
    }
}
//For foreign
//importer
function setImporterName() {
    var importerName = $("#importerNameSwitch").val();

    if(importerName) {
        if(importerName.toLowerCase() == "on") {
            $("#importerNameSwitchDisplay").attr("checked", "checked");
        } else {
            $("#importerNameSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#importerNameSwitchDisplay").attr("checked", false);
    }
}

function onCheckImporterName() {
	
    if($("#importerNameSwitchDisplay").attr("checked") == "checked") {
        $("#importerNameSwitch").val("on");
        $("#importerNameTo").removeAttr("readonly");
        $(".importerNameToAsterisk").addClass("asterisk");
        $(".importerNameToAsterisk").removeClass("clear_font");
    } else {
        $("#importerNameSwitch").val("off");
        $("#importerNameTo").attr("readonly", "readonly");
        $("#importerNameTo").val("");
        $(".importerNameToAsterisk").removeClass("asterisk");
        $(".importerNameToAsterisk").addClass("clear_font");
    }
}

function setImporterAddress() {
    var importerAddress = $("#importerAddressSwitch").val();

    if(importerAddress) {
        if(importerAddress.toLowerCase() == "on") {
            $("#importerAddressSwitchDisplay").attr("checked", "checked");
        } else {
            $("#importerAddressSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#importerAddressSwitchDisplay").attr("checked", false);
    }
}

function onCheckImporterAddress() {
	
    if($("#importerAddressSwitchDisplay").attr("checked") == "checked") {
        $("#importerAddressSwitch").val("on");
        $("#importerAddressTo").removeAttr("readonly", "readonly");
        $(".importerAddressToAsterisk").addClass("asterisk");
        $(".importerAddressToAsterisk").removeClass("clear_font");
    } else {
        $("#importerAddressSwitch").val("off");
        $("#importerAddressTo").attr("readonly", "readonly");
        $("#importerAddressTo").val("");
        $(".importerAddressToAsterisk").removeClass("asterisk");
        $(".importerAddressToAsterisk").addClass("clear_font");
    }
}

//Exporter

function setExporterName() {
    var exporterName = $("#exporterNameSwitch").val();

    if(exporterName) {
        if(exporterName.toLowerCase() == "on") {
            $("#exporterNameSwitchDisplay").attr("checked", "checked");
        } else {
            $("#exporterNameSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#exporterNameSwitchDisplay").attr("checked", false);
    }
}

function onCheckExporterName() {
    if($("#exporterNameSwitchDisplay").attr("checked") == "checked") {
        $("#exporterNameSwitch").val("on");
        $("#exporterNameTo").removeAttr("readonly");
        $(".exporterNameToAsterisk").addClass("asterisk");
        $(".exporterNameToAsterisk").removeClass("clear_font");
    } else {
        $("#exporterNameSwitch").val("off");
        $("#exporterNameTo").attr("readonly", "readonly");
        $("#exporterNameTo").val("");
        $(".exporterNameToAsterisk").removeClass("asterisk");
        $(".exporterNameToAsterisk").addClass("clear_font");
    }
}

function setExporterAddress() {
    var exporterAddress = $("#exporterAddressSwitch").val();

    if(exporterAddress) {
        if(exporterAddress.toLowerCase() == "on") {
            $("#exporterAddressSwitchDisplay").attr("checked", "checked");
        } else {
            $("#exporterAddressSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#exporterAddressSwitchDisplay").attr("checked", false);
    }
}

function onCheckExporterAddress() {
    if($("#exporterAddressSwitchDisplay").attr("checked") == "checked") {
    	$("#exporterAddressSwitch").val("on");
        $("#exporterAddressTo").removeAttr("readonly", "readonly");
        $(".exporterAddressToAsterisk").addClass("asterisk");
        $(".exporterAddressToAsterisk").removeClass("clear_font");
        
    } else {
        $("#exporterAddressSwitch").val("off");
        $("#exporterAddressTo").val("");
        $(".exporterAddressToAsterisk").removeClass("asterisk");
        $(".exporterAddressToAsterisk").addClass("clear_font");
        
    }
}
// end of Buyer and Seller info Functions

function disableFieldsNatureOfAmendmentFields() {
    if(sessionUserRole != "BRM") {
        $("#amountSwitchDisplay").attr("disabled", true);
        $("#amountTo").attr("disabled", true);       
        $("input[name=lcAmountFlagDisplay]").attr("disabled", "disabled");
        $("#expiryDateSwitchDisplay").attr("disabled", "disabled");
        $("#expiryDateTo").attr("disabled", true);
        $("#narrativeSwitchDisplay").attr("disabled", true);
        $("#narrative").attr("disabled", true);
        $("#applicantNameSwitchDisplay").attr("disabled", "disabled");
        $("#applicantAddressSwitchDisplay").attr("disabled", "disabled");
        $("#applicantNameTo").attr("disabled", true);
        $("#applicantAddressTo").attr("disabled", true);    
        $("#beneficiaryNameSwitchDisplay").attr("disabled", "disabled");
        $("#beneficiaryAddressSwitchDisplay").attr("disabled", "disabled");
        $("#beneficiaryNameTo").attr("disabled", true);
        $("#beneficiaryAddressTo").attr("disabled", true);
        $("#importerNameSwitchDisplay").attr("disabled", "disabled");
        $("#importerAddressSwitchDisplay").attr("disabled", "disabled");
        $("#importerNameTo").attr("disabled", true);
        $("#importerAddressTo").attr("disabled", true);
        $("#exporterNameSwitchDisplay").attr("disabled", "disabled");
        $("#exporterAddressSwitchDisplay").attr("disabled", "disabled");
        $("#exporterNameTo").attr("disabled", true);
        $("#exporterAddressTo").attr("disabled", true);      
        $("#narrativeSwitchDisplay").attr("disabled", "disabled");
        $("#confirmationInstructionsFlagSwitchDisplay").attr("disabled", true);
        $("#confirmationInstructionsFlagTo").attr("disabled", "disabled");
        $("#advanceCorresChargesSwitchDisplay").attr("disabled", true);
       
    }
}

function initializeNatureOfAmendmentTab() {
    if($("input[name=lcAmountFlagDisplay]:checked").val()) {
        if($("input[name=lcAmountFlagDisplay]:checked").val().toUpperCase() == 'INC'){
            $(".cash_lc_payment_tab").show();
            $("#setupProductPayment").toggleClass("required", true)
        }else{
            $(".cash_lc_payment_tab").hide();
            $("#setupProductPayment").toggleClass("required", false)
        }
    }else{
        $(".cash_lc_payment_tab").hide();
        $("#setupProductPayment").toggleClass("required", false)
    }

    // lc amount behavior
    setLcAmountCheck();
    onLcAmountCheck();
    
    // Start ER 20160421-087:  This will be the validation for the ChangeInAmount and the New LC Amount
    if($("#amountSwitch").val()=='on' && $("#amountTo").val()==0) {
    	console.log("Error here");
    	onChangeAmountTo();
    	$("#alertMessage").text("Change in LC Amount is checked. Please provide new LC Amount.");
		triggerAlert();
    	$("#amountTo").val("");
    }
    // End ER 20160421-087
    
    $("#amountSwitchDisplay").click(onLcAmountCheck);
    $("input[name=lcAmountFlagDisplay]").click(onAmountFlagChange);

    $("#amountTo").change(onChangeAmountTo);

    // expiry date behavior
    setExpiryDateCheck();
    onExpiryDateCheck();
    $("#expiryDateSwitchDisplay").click(onExpiryDateCheck);
    $("input[name=expiryDateFlagDisplay]").click(onExpiryDateFlagChange);
    $("#expiryDateTo").change(setNumberOfDays);

    // tenor behavior
    setTenorCheck();
    onTenorCheck();
    $("#tenorSwitchDisplay").click(onTenorCheck);

    $("#tenorTo").change(onTenorToChange);
    onTenorToChange();

    $("#confirmationInstructionsFlagTo").change(onConfirmationInstructionsChange);
    onConfirmationInstructionsLoad();
    
    // confirmation instructions behavior
    setConfirmationInstructionsCheck();
    $("#confirmationInstructionsFlagSwitchDisplay").click(onConfirmationInstructionsCheck);
    onConfirmationInstructionsCheck();

    setNarrativeCheck();
    onNarativeCheck();
    
    $("#narrativeSwitchDisplay").click(onNarativeCheck);


    // must be called last
    disableFieldsNatureOfAmendmentFields();    
}

//added by henry alabin
$(document).ready(function(){
	setApplicantNameCheck();
	onApplicantNameCheck();
	$("#applicantNameSwitchDisplay").click(onApplicantNameCheck);
		    
	setApplicantAddressCheck();
	onApplicantAddressCheck();
	$("#applicantAddressSwitchDisplay").click(onApplicantAddressCheck);
		
	setBeneficiaryNameCheck();
	onBeneficiaryNameCheck();
	$("#beneficiaryNameSwitchDisplay").click(onBeneficiaryNameCheck);
	    
	setBeneficiaryAddressCheck();
	onBeneficiaryAddressCheck();
	$("#beneficiaryAddressSwitchDisplay").click(onBeneficiaryAddressCheck);
	
	setImporterName();
	onCheckImporterName();
	$("#importerNameSwitchDisplay").click(onCheckImporterName);	

	setImporterAddress();
	onCheckImporterAddress();
	$("#importerAddressSwitchDisplay").click(onCheckImporterAddress);	
	
	setExporterName();
	onCheckExporterName();
    $("#exporterNameSwitchDisplay").click(onCheckExporterName);    

    setExporterAddress();
    onCheckExporterAddress();
    $("#exporterAddressSwitchDisplay").click(onCheckExporterAddress);   
	
	if($("#beneficiaryNameSwitch").val() == 'on'){
		
		if($("#beneficiaryNameTo").val() == "" || $("#beneficiaryNameTo").val() == null){  
			alert_msg = sellerNameInForeign + "  Name";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#beneficiaryNameTo").val() != "" || $("#beneficiaryNameTo").val() != null) {                
			if((!regexp1.test($("#beneficiaryNameTo").val()))  || (!regexp1.test($("#beneficiaryNameTo").val())) ){
				triggerAlertMessage(sellerNameInForeign + "  name should start with a letter");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
	
	//seller address
	
	if($("#beneficiaryAddressSwitch").val() == 'on'){
		
		if($("#beneficiaryAddressTo").val() == "" || $("#beneficiaryAddressTo").val() == null){  
			alert_msg = sellerNameInForeign + "  Address";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#beneficiaryAddressTo").val() != "" || $("#beneficiaryAddressTo").val() != null) {                
			if((!regexp2.test($("#beneficiaryAddressTo").val()))  || (!regexp2.test($("#beneficiaryAddressTo").val())) ){
				triggerAlertMessage(sellerNameInForeign + " Address should start with a letter or number");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
	
	//buyer name
	
	if($("#applicantNameSwitch").val() == 'on'){
		
		if($("#applicantNameTo").val() == "" || $("#applicantNameTo").val() == null){  
			alert_msg = buyerNameInForeign + " Name";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#applicantNameTo").val() != "" || $("#applicantNameTo").val() != null) {                
			if((!regexp1.test($("#applicantNameTo").val()))  || (!regexp1.test($("#applicantNameTo").val())) ){
				triggerAlertMessage(buyerNameInForeign + " Name should start with a letter");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	}
	
	// buyer address
	
	if($("#applicantAddressSwitch").val() == 'on'){
		
		if($("#applicantAddressTo").val() == "" || $("#applicantAddressTo").val() == null){  
			alert_msg = buyerNameInForeign + " Address";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#applicantAddressTo").val() != "" || $("#applicantAddressTo").val() != null) {                
			if((!regexp2.test($("#applicantAddressTo").val()))  || (!regexp2.test($("#applicantAddressTo").val())) ){
				triggerAlertMessage(buyerNameInForeign +" Address should start with a letter or number");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
	
	// foreign 
	
	if($("#exporterNameSwitch").val() == 'on'){
		
		if($("#exporterNameTo").val() == "" || $("#exporterNameTo").val() == null){  
			alert_msg = sellerNameInForeign + "  Name";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#exporterNameTo").val() != "" || $("#exporterNameTo").val() != null) {                
			if((!regexp1.test($("#exporterNameTo").val()))  || (!regexp1.test($("#exporterNameTo").val())) ){
				triggerAlertMessage(sellerNameInForeign + "  name should start with a letter");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
	
	//seller address
	
	if($("#exporterAddressSwitch").val() == 'on'){
		
		if($("#exporterAddressTo").val() == "" || $("#exporterAddressTo").val() == null){  
			alert_msg = sellerNameInForeign + "  Address";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#exporterAddressTo").val() != "" || $("#exporterAddressTo").val() != null) {                
			if((!regexp2.test($("#exporterAddressTo").val()))  || (!regexp2.test($("#exporterAddressTo").val())) ){
				triggerAlertMessage(sellerNameInForeign + " Address should start with a letter or number");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
	
	//buyer name
	
	if($("#importerNameSwitch").val() == 'on'){
		
		if($("#importerNameTo").val() == "" || $("#importerNameTo").val() == null){  
			alert_msg = buyerNameInForeign + " Name";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#importerNameTo").val() != "" || $("#importerNameTo").val() != null) {                
			if((!regexp1.test($("#importerNameTo").val()))  || (!regexp1.test($("#importerNameTo").val())) ){
				triggerAlertMessage(buyerNameInForeign + " Name should start with a letter");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	}
	
	// buyer address
	
	if($("#importerAddressSwitch").val() == 'on'){
		
		if($("#importerAddressTo").val() == "" || $("#importerAddressTo").val() == null){  
			alert_msg = buyerNameInForeign + " Address";
			triggerAlertMessage("Missing Required Fields:<br/>" +  alert_msg );                                    
			_pageHasErrors=true;   
			
		} else if ($("#importerAddressTo").val() != "" || $("#importerAddressTo").val() != null) {                
			if((!regexp2.test($("#importerAddressTo").val()))  || (!regexp2.test($("#importerAddressTo").val())) ){
				triggerAlertMessage(buyerNameInForeign +" Address should start with a letter or number");                                            
				_pageHasErrors = true;                                                                             
			}                                                                                                 
		} 
		
	} 
		
});

// end
$(initializeNatureOfAmendmentTab);
