/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/6/12
 * Time: 10:59 AM
 * To change this template use File | Settings | File Templates.
 */

function setAmountCheckDataEntry() {
    var amountSwitch = $("#amountSwitch").val();

    if(amountSwitch) {
        if(amountSwitch.toLocaleString() == "on") {
            $("#amountSwitchDisplay").attr("checked", "checked");
        } else {
            $("#amountSwitchDisplay").attr("checked", false);
        }
    } else {
        $("#amountSwitchDisplay").attr("checked", false);
    }
}

function onLcAmountCheckDataEntry() {
    if($("#amountSwitchDisplay").attr("checked") == "checked") {
        $("#amountSwitch").val("on");
        $("#amountTo").removeAttr("readonly");
    } else {
        $("#amountSwitch").val("off");
        $("#amountTo").attr("readonly", "readonly");
        $("#amountTo").val("");
    }
}

function onExpiryCountryCodeCheckDataEntry() {
    if($("#expiryCountryCodeSwitchDisplay").attr("checked") == "checked") {
        $("#expiryCountryCodeSwitch").val("on");
//        $("#expiryCountryCodeTo").removeAttr("disabled");
        $("#expiryCountryCodeTo").select2("enable");
    } else {
        $("#expiryCountryCodeSwitch").val("off");
//        $("#expiryCountryCodeTo").attr("disabled", "disabled");
        $("#expiryCountryCodeTo").select2("disable");
//        $("#expiryCountryCodeTo").val("");
        $("#expiryCountryCodeTo").select2("data", {id:""});
    }
}

function setExpiryCountryCodeDataEntry() {
    var expiryCountryCodeSwitch = $("#expiryCountryCodeSwitch").val();

    if(expiryCountryCodeSwitch) {
        if(expiryCountryCodeSwitch.toLowerCase() == "on") {
            $("#expiryCountryCodeSwitchDisplay").attr("checked", "checked");
        } else {
            $("#expiryCountryCodeSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#expiryCountryCodeSwitchDisplay").attr("checked", false);
    }
}

function onDestinationBankCheckDataEntry() {
    if($("#destinationBankSwitchDisplay").attr("checked") == "checked") {
        $("#destinationBankSwitch").val("on");
//        $("#destinationBankTo").removeAttr("disabled");
        $("#destinationBankTo").select2("enable");
    } else {
        $("#destinationBankSwitch").val("off");
//        $("#destinationBankTo").attr("disabled", "disabled");
        $("#destinationBankTo").select2("disable");
//        $("#destinationBankTo").val("");
        $("#destinationBankTo").select2("data",  {id:""});
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

function onTenorCheckDataEntry() {
//    alert("onTenorCheckDataEntry : standby_amendment_dataentry_basic_details_utility.js")
    if($("#tenorSwitchDisplay").attr("checked") == "checked") {
//        alert("e1")
        $("#tenorSwitch").val("on");
        $("#tenorTo").removeAttr("disabled");
    } else {
//        alert("e2")
        $("#tenorSwitch").val("off");
        $("#tenorTo").attr("disabled", "disabled");
        $("#tenorTo").val("");

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
    var tenorTo = $("#tenorTo").val();
//    alert("onTenorToChangeDataEntry : standby_amendment_dataentry_basic_details_utility.js")
    if(tenorTo) {
        if(tenorTo.toUpperCase() == "USANCE") {
//            alert("b1")
            $("#usancePeriodTo").removeAttr("readonly");
            $("#tenorOfDraftNarrativeTo").removeAttr("readonly");
        } else {
//            alert("b2")
            $("#usancePeriodTo").attr("readonly", "readonly");
            $("#usancePeriodTo").val("");
            $("#tenorOfDraftNarrativeTo").attr("readonly", "readonly");
            $("#tenorOfDraftNarrativeTo").val("");
        }
    }else {
//        alert("b3")
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
    } else {
        $("#applicableRulesSwitch").val("off");
        $("#applicableRulesTo").attr("disabled", "disabled");
        $("#applicableRulesTo").val("");
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
    } else {
        $("#confirmationInstructionsFlagSwitch").val("off");
        $("#confirmationInstructionsFlagTo").attr("disabled", "disabled");
        $("#confirmationInstructionsFlagTo").val("");
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
    } else {
        $("#expiryDateSwitch").val("off");
        $("#expiryDateTo").removeClass("datepicker_field").addClass("input_field").datepicker("destroy");
        $("#expiryDateTo").attr("readonly", "readonly");
        $("#expiryDateTo").val("");
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

function onFormOfDocumentaryCheckDataEntry() {
    if($("#formOfDocumentaryCreditSwitchDisplay").attr("checked") == "checked") {
        $("#formOfDocumentaryCreditSwitch").val("on");
        $("#formOfDocumentaryCreditTo").removeAttr("disabled");
    } else {
        $("#formOfDocumentaryCreditSwitch").val("off");
        $("#formOfDocumentaryCreditTo").attr("disabled", "disabled");
        $("#formOfDocumentaryCreditTo").val("");
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

function disableBasicDetailsFields() {
    $("form#basicDetailsTabForm :input").each(function(){
        var input = $(this); // This is the jquery object of the input, do what you will

        if(input.attr("name") != undefined) {
            var name = input.attr("name");

            if(name.substring(name.length -2, name.length) == "To") {
                if(input.attr("type") == "text" || input.attr("type") == "textarea") {
                    input.attr("readonly", "readonly");
                }else {
                    input.attr("disabled", "disabled");
                }
            }
        }
    });
}

function setSenderToReceiver() {
    var senderToReceiver = $("#senderToReceiverSwitch").val();

    if(senderToReceiver) {
        if(senderToReceiver.toLowerCase() == "on") {
            $("#senderToReceiverSwitchDisplay").attr("checked", "checked");
        } else {
            $("#senderToReceiverSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#senderToReceiverSwitchDisplay").attr("checked", false);
    }
}

function onCheckSenderToReceiver() {
    if($("#senderToReceiverSwitchDisplay").attr("checked") == "checked") {
        $("#senderToReceiverSwitch").val("on");
        $("#senderToReceiverTo").removeAttr("disabled");
        $("#sender_info").show();
    } else {
        $("#senderToReceiverSwitch").val("off");
        $("#senderToReceiverTo").attr("disabled", "disabled");
        $("#sender_info").hide();
        $("#senderToReceiverTo").val("");
        $("#senderToReceiverInformationTo").val("");
    }
}

function onFurtherIdentificationCheckDataEntry() {
    if($("#furtherIdentificationSwitchDisplay").attr("checked") == "checked") {
        $("#furtherIdentificationSwitch").val("on");
        $("#furtherIdentificationTo").removeAttr("disabled");
    } else {
        $("#furtherIdentificationSwitch").val("off");
        $("#furtherIdentificationTo").attr("disabled", "disabled");
        $("#furtherIdentificationTo").val("");
    }
}

function setFurtherIdentificationCheckDataEntry() {
    var furtherIdentificationSwitch = $("#furtherIdentificationSwitch").val();

    if(furtherIdentificationSwitch) {
        if(furtherIdentificationSwitch.toLowerCase() == "on") {
            $("#furtherIdentificationSwitchDisplay").attr("checked", "checked");
        } else {
            $("#furtherIdentificationSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#furtherIdentificationSwitchDisplay").attr("checked", false);
    }
}

function onApplicableRulesChange(){
	
	if ($("#applicableRulesTo :selected").val()=="OTH"){		
		$(".othr_label").show();
		$(".othr_fieldTo").show();	
		$(".othr_labelTo").show();	
	}else{		
		$(".othr_label").hide();
		$(".othr_fieldTo").hide();
		$(".othr_labelTo").hide();
	}
	
	if ($("#applicableRules").val()=="OTH"){		
		$(".othr_field").show();			
	}else{		
		$(".othr_field").hide();		
	}
}

function initializeBasicDetailsAmendmentDataEntry() {
    disableBasicDetailsFields();

    setAmountCheckDataEntry();
    $("#amountSwitchDisplay").click(onLcAmountCheckDataEntry);
    onLcAmountCheckDataEntry();

    setExpiryCountryCodeDataEntry();
    $("#expiryCountryCodeSwitchDisplay").click(onExpiryCountryCodeCheckDataEntry);
    onExpiryCountryCodeCheckDataEntry();

    setDestinationBankDataEntry();
    $("#destinationBankSwitchDisplay").click(onDestinationBankCheckDataEntry);
    onDestinationBankCheckDataEntry();

    setTenorDataEntry();
    $("#tenorSwitchDisplay").click(onTenorCheckDataEntry);
    onTenorCheckDataEntry();
    onTenorToChangeDataEntry();
    $("#tenorTo").change(onTenorToChangeDataEntry);
    onTenorToChangeDataEntry();

    setApplicableRulesDataEntry();
    $("#applicableRulesSwitchDisplay").click(onApplicableRulesCheckDataEntry);
    onApplicableRulesCheckDataEntry();

    setConfirmationInstructionsFlagDataEntry();
    $("#confirmationInstructionsFlagSwitchDisplay").click(onConfirmationInstructionCheckDataEntry);
    onConfirmationInstructionCheckDataEntry();

    setExpiryDateDateEntry();
    $("#expiryDateSwitchDisplay").click(onExpiryDateCheckDataEntry);
    onExpiryDateCheckDataEntry();

    setFormOfDocumentaryCreditDataEntry();
    $("#formOfDocumentaryCreditSwitchDisplay").click(onFormOfDocumentaryCheckDataEntry);
    onFormOfDocumentaryCheckDataEntry();

    setSenderToReceiver();
    $("#senderToReceiverSwitchDisplay").click(onCheckSenderToReceiver);
    onCheckSenderToReceiver();

    setFurtherIdentificationCheckDataEntry();
    $("#furtherIdentificationSwitchDisplay").click(onFurtherIdentificationCheckDataEntry);
    onFurtherIdentificationCheckDataEntry();
    
    onApplicableRulesChange();
    $("#applicableRulesTo").change(onApplicableRulesChange);
    
    

}

$(initializeBasicDetailsAmendmentDataEntry);