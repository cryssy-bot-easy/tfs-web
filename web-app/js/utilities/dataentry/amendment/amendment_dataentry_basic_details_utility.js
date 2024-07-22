/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/6/12
 * Time: 10:59 AM
 * To change this template use File | Settings | File Templates.
 */

/**
     (revision)
    [Revised by:] Cedrick C. Nungay
    [Date revised:] October 20, 2018
    [Date deployed:]
    Program [Revision] Details: Fixed fields for MT707.
    Member Type: JavaScript file (JS)
    Project: WEB
    Project Name: amendment_dataentry_basic_details_utility.js
 */
function setAmountCheckDataEntry() {
    var amountSwitch = $("#amountSwitch").val();

    if(amountSwitch) {
        if(amountSwitch.toLowerCase() == "on") {
            $("#amountSwitchDisplay").attr("checked", "checked");
        } else {
            $("#amountSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#amountSwitchDisplay").attr("checked", false);
    }
}

function onLcAmountCheckDataEntry() {
	if($("#amountTo").val() && $("#amountSwitchDisplay").attr("disabled") != "disabled"){
		if($("#amountTo").val() != 0.00) {
			$("#amountTo").removeAttr("readonly");
		} else {
			$("#amountTo").val("");
			$("#amountTo").attr("readonly", "readonly");
		}
	}
}

function onDestinationBankCheckDataEntry() {
    if($("#destinationBankSwitchDisplay").attr("checked") == "checked") {
        $("#destinationBankSwitch").val("on");
        $("#destinationBankTo").select2("enable");
        $(".destinationBankToAsterisk").addClass("asterisk");
        $(".destinationBankToAsterisk").removeClass("clear_font");
    } else {
        $("#destinationBankSwitch").val("off");
        $("#destinationBankTo").select2("disable");
        $("#destinationBankTo").select2('data', {
            id : ""
        });
        $(".destinationBankToAsterisk").removeClass("asterisk");
        $(".destinationBankToAsterisk").addClass("clear_font");
    }
}

function setDestinationBankDataEntry() {
    var destinationBankSwitch = $("#destinationBankSwitch").val();

    if(destinationBankSwitch) {
        if(destinationBankSwitch.toLowerCase() == "on") {
            $("#destinationBankSwitchDisplay").attr("checked", "checked");
        } else {
            $("#destinationBankSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#destinationBankSwitchDisplay").attr("checked", false);
    }
}

function onRequestedConfirmationPartyCheckDataEntry() {
    if($("#requestedConfirmationPartySwitchDisplay").attr("checked") == "checked") {
        $("#requestedConfirmationPartySwitch").val("on");
        $("#requestedConfirmationPartyTo").select2("enable");
        $(".requestedConfirmationPartyToAsterisk").addClass("asterisk");
        $(".requestedConfirmationPartyToAsterisk").removeClass("clear_font");
    } else {
        $("#requestedConfirmationPartySwitch").val("off");
        $("#requestedConfirmationPartyTo").select2('data',{id: null});
        $("#requestedConfirmationPartyTo").select2("disable");
        $(".requestedConfirmationPartyToAsterisk").removeClass("asterisk");
        $(".requestedConfirmationPartyToAsterisk").addClass("clear_font");
    }
}

function setRequestedConfirmationPartyDataEntry() {
    var requestedConfirmationPartySwitch = $("#requestedConfirmationPartySwitch").val();
    
    if(requestedConfirmationPartySwitch) {
        if(requestedConfirmationPartySwitch.toLowerCase() == "on") {
            $("#requestedConfirmationPartySwitchDisplay").attr("checked", "checked");
        } else {
            $("#requestedConfirmationPartySwitchDisplay").attr("checked", false);
        }
    } else {
        $("#requestedConfirmationPartySwitchDisplay").attr("checked", false);
    }
}

function onTenorCheckDataEntry() {
    if($("#tenorSwitchDisplay").attr("checked") == "checked") {
        $("#tenorSwitch").val("on");
        $("#tenorTo2").removeAttr("disabled");
        $(".tenorToAsterisk").addClass("asterisk").removeClass("clear_font");
    } else {
        $("#tenorSwitch").val("off");
        $("#tenorTo2").attr("disabled", "disabled");
        $("#tenorTo2").val("");
        $(".tenorToAsterisk").addClass("clear_font").removeClass("asterisk");
        onTenorToChangeDataEntry();
    }
}

function setTenorDataEntry() {
    var tenorSwitch = $("#tenorSwitch").val();

    if(tenorSwitch) {
        if(tenorSwitch.toLowerCase() == "on") {
            $("#tenorSwitchDisplay").attr("checked", "checked");
        } else {
            $("#tenorSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#tenorSwitchDisplay").attr("checked", false);
    }
}

function onTenorToChangeDataEntry() {
    var tenorTo = $("#tenorTo2").val();
    if(tenorTo) {
        if(tenorTo.toUpperCase() == "USANCE") {
            $("#usancePeriodTo").removeAttr("readonly");
            $("#tenorOfDraftNarrativeTo").removeAttr("readonly");
        } else {
            $("#usancePeriodTo").attr("readonly", "readonly");
            $("#usancePeriodTo").val("");
            $("#tenorOfDraftNarrativeTo").attr("readonly", "readonly");
            $("#tenorOfDraftNarrativeTo").val("");
        }
    }else {
        $("#usancePeriodTo").attr("readonly", "readonly");
        $("#usancePeriodTo").val("");
        $("#tenorOfDraftNarrativeTo").attr("readonly", "readonly");
        $("#tenorOfDraftNarrativeTo").val("");
    }
}

function onApplicableRulesCheckDataEntry() {
    if($("#applicableRulesSwitchDisplay").attr("checked") == "checked") {
        $("#applicableRulesSwitch").val("on");
        $("#applicableRulesTo").removeAttr("disabled");
        $("#applicableRulesTo").addClass("required");
        $(".applicableRulesToAsterisk").addClass("asterisk");
        $(".applicableRulesToAsterisk").removeClass("clear_font");
    } else {
        $("#applicableRulesSwitch").val("off");
        $("#applicableRulesTo").attr("disabled", "disabled");
        $("#applicableRulesTo").val("");
        $("#applicableRulesTo").removeClass("required");
        $(".applicableRulesToAsterisk").removeClass("asterisk");
        $(".applicableRulesToAsterisk").addClass("clear_font");
    }
}

function setApplicableRulesDataEntry() {
    var applicableRulesSwitch = $("#applicableRulesSwitch").val();

    if(applicableRulesSwitch) {
        if(applicableRulesSwitch.toLowerCase() == "on") {
            $("#applicableRulesSwitchDisplay").attr("checked", "checked");
        } else {
            $("#applicableRulesSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#applicableRulesSwitchDisplay").attr("checked", false);
    }
}

function onConfirmationInstructionCheckDataEntry() {
    if($("#confirmationInstructionsFlagSwitchDisplay").attr("checked") == "checked") {
        $("#confirmationInstructionsFlagSwitch").val("on");
        $("#confirmationInstructionsFlagTo").removeAttr("disabled");
        $(".confirmationInstructionsToAsterisk").addClass("asterisk");
        $(".confirmationInstructionsToAsterisk").removeClass("clear_font");
    } else {
        $("#confirmationInstructionsFlagSwitch").val("off");
        $("#confirmationInstructionsFlagTo").attr("disabled", "disabled");
        $("#confirmationInstructionsFlagTo").val("");
        $(".confirmationInstructionsToAsterisk").removeClass("asterisk");
        $(".confirmationInstructionsToAsterisk").addClass("clear_font");
    }
}

function setConfirmationInstructionsFlagDataEntry() {
    var confirmationInstructionsFlagSwitch = $("#confirmationInstructionsFlagSwitch").val();

    if(confirmationInstructionsFlagSwitch) {
        if(confirmationInstructionsFlagSwitch.toLowerCase() == "on") {
            $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", "checked");
        } else {
            $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#confirmationInstructionsFlagSwitchDisplay").attr("checked", false);
    }
}

function setAdvisingBankDataEntry() {
    var advisingBankSwitch = $("#advisingBankSwitch").val();

    if(advisingBankSwitch) {
        if(advisingBankSwitch.toLowerCase() == "on") {
            $("#advisingBankSwitchDisplay").attr("checked", "checked");
        } else {
            $("#advisingBankSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#advisingBankSwitchDisplay").attr("checked", false);
    }
}

function onAdvisingBankDataEntry() {
    if($("#advisingBankSwitchDisplay").attr("checked") == "checked") {
    	$("#advisingBankSwitch").val("on");
        $("#confirmingBankTo").removeAttr("readonly");
        $(".advisingBankToAsterisk").addClass("asterisk");
        $(".advisingBankToAsterisk").removeClass("clear_font");
    } else {
    	$("#advisingBankSwitch").val("off");
        $("#confirmingBankTo").attr("readonly", "readonly");
        $("#confirmingBankTo").val("");
        $(".advisingBankToAsterisk").removeClass("asterisk");
        $(".advisingBankToAsterisk").addClass("clear_font");
    }
}

function onExpiryDateCheckDataEntry() {
    if($("#expiryDateSwitchDisplay").attr("checked") == "checked") {
        $("#expiryDateSwitch").val("on");

        $("#expiryDateTo").addClass("datepicker_field");

        $("#expiryDateTo").datepicker({
            showOn: 'both',
            buttonImage:$("#_datepickerImage").val(), //hidden field from main.gsp
            changeMonth: true,
            changeYear: true,
            constrainInput:true,
            defaultDate:null,
            dateFormat:'mm/dd/yy'
        }).attr("readonly","readonly");

        $("#expiryDateTo").removeAttr("readonly");
        $("#expiryDateTo").addClass("required");
        $(".expiryDateToAsterisk").addClass("asterisk");
        $(".expiryDateToAsterisk").removeClass("clear_font");
    } else {
        $("#expiryDateSwitch").val("off");
        $("#expiryDateTo").removeClass("datepicker_field").addClass("input_field").datepicker("destroy");
        $("#expiryDateTo").attr("readonly", "readonly");
        $("#expiryDateTo").val("");
        $("#expiryDateTo").removeClass("required");
        $(".expiryDateToAsterisk").removeClass("asterisk");
        $(".expiryDateToAsterisk").addClass("clear_font");
    }
}

function setExpiryDateDateEntry() {
    var expiryDateSwitch = $("#expiryDateSwitch").val();

    if(expiryDateSwitch) {
        if(expiryDateSwitch.toLowerCase() == "on") {
            $("#expiryDateSwitchDisplay").attr("checked", "checked");
        } else {
            $("#expiryDateSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#expiryDateSwitchDisplay").attr("checked", false);
    }
}

function setOtherPlaceOfExpiry() {
    var otherPlaceOfExpiry = $("#otherPlaceOfExpirySwitch").val();

    if(otherPlaceOfExpiry) {
        if(otherPlaceOfExpiry.toLowerCase() == "on") {
            $("#otherPlaceOfExpirySwitchDisplay").attr("checked", "checked");
        } else {
            $("#otherPlaceOfExpirySwitchDisplay").attr("checked", false);
        }
    }else {
        $("#otherPlaceOfExpirySwitchDisplay").attr("checked", false);
    }
}

function onCheckOtherPlaceOfExpiry() {
    if($("#otherPlaceOfExpirySwitchDisplay").attr("checked") == "checked") {
        $("#otherPlaceOfExpirySwitch").val("on");
        $("#otherPlaceOfExpiryTo").addClass("required");
        $(".amend_other_place_of_expiry").show();
        $(".otherPlaceOfExpiryToAsterisk").addClass("asterisk");
        $(".otherPlaceOfExpiryToAsterisk").removeClass("clear_font");
    } else {
        $("#otherPlaceOfExpirySwitch").val("off");
        $(".amend_other_place_of_expiry").hide();
        $("#otherPlaceOfExpiryTo").val("");
        $("#otherPlaceOfExpiryTo").removeClass("required");
        $(".otherPlaceOfExpiryToAsterisk").removeClass("asterisk");
        $(".otherPlaceOfExpiryToAsterisk").addClass("clear_font");
    }
}

function onFormOfDocumentaryCheckDataEntry() {
    if($("#formOfDocumentaryCreditSwitchDisplay").attr("checked") == "checked") {
        $("#formOfDocumentaryCreditSwitch").val("on");
        $("#formOfDocumentaryCreditTo").removeAttr("disabled");
        $("#formOfDocumentaryCreditTo").addClass("required");
        $(".formOfDocumentaryCreditToAsterisk").addClass("asterisk");
        $(".formOfDocumentaryCreditToAsterisk").removeClass("clear_font");
    } else {
        $("#formOfDocumentaryCreditSwitch").val("off");
        $("#formOfDocumentaryCreditTo").attr("disabled", "disabled");
        $("#formOfDocumentaryCreditTo").val("");
        $("#formOfDocumentaryCreditTo").removeClass("required");
        $(".formOfDocumentaryCreditToAsterisk").removeClass("asterisk");
        $(".formOfDocumentaryCreditToAsterisk").addClass("clear_font");
    }
}

function setFormOfDocumentaryCreditDataEntry() {
    var formOfDocumentaryCreditSwitch = $("#formOfDocumentaryCreditSwitch").val();

    if(formOfDocumentaryCreditSwitch) {
        if(formOfDocumentaryCreditSwitch.toLowerCase() == "on") {
            $("#formOfDocumentaryCreditSwitchDisplay").attr("checked", "checked");
        } else {
            $("#formOfDocumentaryCreditSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#formOfDocumentaryCreditSwitchDisplay").attr("checked", false);
    }
}

function onPurposeOfMessageCheckDataEntry() {
    if($("#purposeOfMessageSwitchDisplay").attr("checked") == "checked") {
        $("#purposeOfMessageSwitch").val("on");
        $("#purposeOfMessageTo").removeAttr("disabled");
        $(".purposeOfMessageToAsterisk").addClass("asterisk");
        $(".purposeOfMessageToAsterisk").removeClass("clear_font");
        $("#purposeOfMessageTo").addClass("required");
    } else {
        $("#purposeOfMessageSwitch").val("off");
        $("#purposeOfMessageTo").attr("disabled", "disabled");
        $("#purposeOfMessageTo").val($("#purposeOfMessageTo").attr("default-value"));
        $(".purposeOfMessageToAsterisk").removeClass("asterisk");
        $(".purposeOfMessageToAsterisk").addClass("clear_font");
//        $("#purposeOfMessageTo").removeClass("required");
    }
}

function setPurposeOfMessageDataEntry() {
    var purposeOfMessageSwitch = $("#purposeOfMessageSwitch").val();

    if(purposeOfMessageSwitch) {
        if(purposeOfMessageSwitch.toLowerCase() == "on") {
            $("#purposeOfMessageSwitchDisplay").attr("checked", "checked");
        } else {
            $("#purposeOfMessageSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#purposeOfMessageSwitchDisplay").attr("checked", false);
    }
}

function onDraweeCheckDataEntry() {
    if($("#draweeSwitchDisplay").attr("checked") == "checked") {
        $("#draweeSwitch").val("on");
        $("#draweeTo").removeAttr("disabled");
        $("#draweeTo").removeAttr("readonly");
        $(".draweeToAsterisk").addClass("asterisk");
        $(".draweeToAsterisk").removeClass("clear_font");
        $("#draweeTo").addClass("required");
        
        var confirmationInstructionsFlag = $("#confirmationInstructionsFlagTo").val();
        if(confirmationInstructionsFlag == "") {
            confirmationInstructionsFlag = $("#confirmationInstructionsFlagFrom").val() == 'N' ? 'NO' : 'YES';
        }
        if(confirmationInstructionsFlag == "YES") {
            $("#draweeTo").val($("#availableWithTo").val() == '' ? $("#availableWithFrom").val() : $("#availableWithTo").val());
        } else if(confirmationInstructionsFlag == "NO") {
            $("#draweeTo").val("TLBPPHMM");
        }
    } else {
        $("#draweeSwitch").val("off");
        $("#draweeTo").attr("disabled", "disabled");
        $("#draweeTo").val("");
        $(".draweeToAsterisk").removeClass("asterisk");
        $(".draweeToAsterisk").addClass("clear_font");
        $("#draweeTo").removeClass("required");
    }
}

function setDraweeDataEntry() {
    var draweeSwitch = $("#draweeSwitch").val();

    if(draweeSwitch) {
        if(draweeSwitch.toLowerCase() == "on") {
            $("#draweeSwitchDisplay").attr("checked", "checked");
        } else {
            $("#draweeSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#draweeSwitchDisplay").attr("checked", false);
    }
}

function onMixedPaymentDetailsCheckDataEntry() {
    if($("#mixedPaymentDetailsSwitchDisplay").attr("checked") == "checked") {
        $("#mixedPaymentDetailsSwitch").val("on");
        $(".amend_mixed_payment_details").show();
        $(".mixedPaymentDetailsToAsterisk").addClass("asterisk");
        $(".mixedPaymentDetailsToAsterisk").removeClass("clear_font");
        $("#mixedPaymentDetailsTo").addClass("required");
        $("#bankAddressComment").limitCharAndLines(35, 4);
    } else {
        $("#mixedPaymentDetailsSwitch").val("off");
        $(".amend_mixed_payment_details").hide();
        $("#mixedPaymentDetailsTo").val("");
        $(".mixedPaymentDetailsToAsterisk").removeClass("asterisk");
        $(".mixedPaymentDetailsToAsterisk").addClass("clear_font");
        $("#mixedPaymentDetailsTo").removeClass("required");
    }
}

function setMixedPaymentDetailsDataEntry() {
    var mixedPaymentDetailsSwitch = $("#mixedPaymentDetailsSwitch").val();

    if(mixedPaymentDetailsSwitch) {
        if(mixedPaymentDetailsSwitch.toLowerCase() == "on") {
            $("#mixedPaymentDetailsSwitchDisplay").attr("checked", "checked");
        } else {
            $("#mixedPaymentDetailsSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#mixedPaymentDetailsSwitchDisplay").attr("checked", false);
    }
}

function onDeferredPaymentDetailsCheckDataEntry() {
    if($("#deferredPaymentDetailsSwitchDisplay").attr("checked") == "checked") {
        $("#deferredPaymentDetailsSwitch").val("on");
        $(".amend_deferred_payment_details").show();
        $(".deferredPaymentDetailsToAsterisk").addClass("asterisk");
        $(".deferredPaymentDetailsToAsterisk").removeClass("clear_font");
        $("#deferredPaymentDetailsTo").addClass("required");
        $("#bankAddressComment").limitCharAndLines(35, 4);
    } else {
        $("#deferredPaymentDetailsSwitch").val("off");
        $(".amend_deferred_payment_details").hide();
        $("#deferredPaymentDetailsTo").val("");
        $(".deferredPaymentDetailsToAsterisk").removeClass("asterisk");
        $(".deferredPaymentDetailsToAsterisk").addClass("clear_font");
        $("#deferredPaymentDetailsTo").removeClass("required");
    }
}

function setDeferredPaymentDetailsDataEntry() {
    var deferredPaymentDetailsSwitch = $("#deferredPaymentDetailsSwitch").val();
    
    if(deferredPaymentDetailsSwitch) {
        if(deferredPaymentDetailsSwitch.toLowerCase() == "on") {
            $("#deferredPaymentDetailsSwitchDisplay").attr("checked", "checked");
        } else {
            $("#deferredPaymentDetailsSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#deferredPaymentDetailsSwitchDisplay").attr("checked", false);
    }
}

function disableBasicDetailsFields() {
    $("form#basicDetailsTabForm :input").each(function(){
        var input = $(this); // This is the jquery object of the input, do what you will

        if(input.attr("name") != undefined) {
            var name = input.attr("name");

            if(name.substring(name.length -2, name.length) == "To") {
                if(input.attr("type") == "text" || input.attr("type") == "textarea" || $("textarea")) {
                    input.attr("readonly", "readonly");
                }else {
                    input.attr("disabled", "disabled");
                }
            }
        }
    });
}

function onConfirmationInstructionsFlagToChange(){	 
	 if($("#confirmationInstructionsFlagTo").val()=="YES"){
		$("#availableWithSwitchDisplay").attr("disabled","disabled");		 
	 }else{
		 $("#availableWithSwitchDisplay").removeAttr("disabled");
	 }
}

function onApplicableRulesChange(){
	if ($("#applicableRulesTo :selected").val()=="OTHR"){
		$(".othr_label").show();
		$(".othr_fieldTo").show();	
		$(".othr_labelTo").show();	
		$(".othr_labelTo").show();	
        $("#otherRuleTo").removeAttr("readonly");
	}else{
		$(".othr_label").hide();
		$(".othr_fieldTo").hide();
		$(".othr_labelTo").hide();
		$("#amountTo").attr("readonly", "readonly");
	}
	
	if ($("#applicableRules").val()=="OTHR"){		
		$(".othr_field").show();			
        $("#otherRuleTo").removeAttr("readonly");
	}else{		
		$(".othr_field").hide();	
		$("#amountTo").attr("readonly", "readonly");	
	}
}


function initializeBasicDetailsAmendmentDataEntry() {
	if($("#remaining_char_narrative_ac1").length > 0 && $("#remaining_line_narrative_ac1").length > 0){
	$("#narrative_ac1").limitCharAndLines(35, 4);
	}
    disableBasicDetailsFields();

    setAmountCheckDataEntry();
    $("#amountSwitchDisplay").click(onLcAmountCheckDataEntry);
    onLcAmountCheckDataEntry();

    setDestinationBankDataEntry();
    $("#destinationBankSwitchDisplay").click(onDestinationBankCheckDataEntry);
    onDestinationBankCheckDataEntry();

    setRequestedConfirmationPartyDataEntry();
    $("#requestedConfirmationPartySwitchDisplay").click(onRequestedConfirmationPartyCheckDataEntry);
    onRequestedConfirmationPartyCheckDataEntry();

    setTenorDataEntry();
    $("#tenorSwitchDisplay").click(onTenorCheckDataEntry);
    onTenorCheckDataEntry();
    $("#tenorTo2").change(onTenorToChangeDataEntry);
    onTenorToChangeDataEntry();

    setApplicableRulesDataEntry();
    $("#applicableRulesSwitchDisplay").click(onApplicableRulesCheckDataEntry);
    onApplicableRulesCheckDataEntry();

    setConfirmationInstructionsFlagDataEntry();
    $("#confirmationInstructionsFlagSwitchDisplay").click(onConfirmationInstructionCheckDataEntry);
    onConfirmationInstructionCheckDataEntry();
    
    setAdvisingBankDataEntry();
    $("#advisingBankSwitchDisplay").click(onAdvisingBankDataEntry);
    onAdvisingBankDataEntry();
    
    setExpiryDateDateEntry();
    $("#expiryDateSwitchDisplay").click(onExpiryDateCheckDataEntry);
    onExpiryDateCheckDataEntry();

    setOtherPlaceOfExpiry();
    $("#otherPlaceOfExpirySwitchDisplay").click(onCheckOtherPlaceOfExpiry);
    onCheckOtherPlaceOfExpiry();

    setFormOfDocumentaryCreditDataEntry();
    $("#formOfDocumentaryCreditSwitchDisplay").click(
            onFormOfDocumentaryCheckDataEntry);
    onFormOfDocumentaryCheckDataEntry();

    setPurposeOfMessageDataEntry();
    $("#purposeOfMessageSwitchDisplay").click(onPurposeOfMessageCheckDataEntry);
    onPurposeOfMessageCheckDataEntry();
    
    setDraweeDataEntry();
    $("#draweeSwitchDisplay").click(onDraweeCheckDataEntry);
    onDraweeCheckDataEntry();
    
    setMixedPaymentDetailsDataEntry();
    $("#mixedPaymentDetailsSwitchDisplay").click(onMixedPaymentDetailsCheckDataEntry);
    onMixedPaymentDetailsCheckDataEntry();
    
    setDeferredPaymentDetailsDataEntry();
    $("#deferredPaymentDetailsSwitchDisplay").click(onDeferredPaymentDetailsCheckDataEntry);
    onDeferredPaymentDetailsCheckDataEntry();

    onApplicableRulesChange();
    $("#applicableRulesTo").change(onApplicableRulesChange);
    
    $("#sendersReference").keydown(function(event) {
        // Allow: backspace, delete, tab, escape, and enter
        if ( event.keyCode == 46 || event.keyCode == 8 || event.keyCode == 9 || event.keyCode == 27 || event.keyCode == 13 || 
             // Allow: Ctrl+A
            (event.keyCode == 65 && event.ctrlKey === true) || 
             // Allow: home, end, left, right
            (event.keyCode >= 35 && event.keyCode <= 39)) {
                 // let it happen, don't do anything
                 return;
        }
        else {
            // Ensure that it is a number and stop the keypress
            if (event.shiftKey || (event.keyCode < 48 || event.keyCode > 57) && (event.keyCode < 96 || event.keyCode > 105 )) {
                event.preventDefault(); 
            }   
        }
    });
    
    $("#confirmationInstructionsFlagTo").change(onConfirmationInstructionsFlagToChange);
    
    //Hide narrative is user is TSD
    if(loggedInUser && loggedInUser=="TSD"){
 	   $("#dmlc_amendment_narrative").hide();
    }
    
    //create a new datepicker with restraint on max date
    $("#valueDate").datepicker({ showOn: 'both', buttonImage:$("#_datepickerImage").val(),	  
 		  changeMonth: true, changeYear: true, maxDate:new Date()
 	}).attr("readonly","readonly");



    $("#expiryCountryCodeTo").setCountryDropdown($(this).attr("id")).select2('data',{id: '${expiryCountryCodeTo}'})
    .on("change",function(e){
        if("" == e.val){
            $("#expiryCountryLabelTo").val("");
        }else{
            $("#expiryCountryLabelTo").val($.trim($(this).select2('data').label));
        }
    });
}

$(initializeBasicDetailsAmendmentDataEntry);