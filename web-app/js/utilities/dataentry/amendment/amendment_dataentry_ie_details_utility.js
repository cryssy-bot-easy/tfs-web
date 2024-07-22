/**
 * Created by IntelliJ IDEA.
 * User: Marv
 * Date: 10/6/12
 * Time: 11:41 PM
 * To change this template use File | Settings | File Templates.
 */

/**
	(revision)
	[Modified by:] Cedrick C. Nungay
	[Date deployed:] 08/09/2018
	[Description: ] Modified check available functions for MT707.
 */

function disableIEFields() {
    $("form#importerExporterDetailsTabForm :input").each(function(){
        var input = $(this); // This is the jquery object of the input, do what you will

        if(input.attr("name") != undefined) {
            var name = input.attr("name");
//              alert(name + " " + input.attr("type"));
            if(name.substring(name.length -2, name.length) == "To") {
                if(input.attr("type") == "text" || this.tagName=="TEXTAREA" || $("textarea")) {
                    input.attr("readonly", "readonly");
                }else {
                    input.attr("disabled", "disabled");
                }
            }
        }
    });
}

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
        $("#importerNameTo").addClass("required");
    } else {
        $("#importerNameSwitch").val("off");
        $("#importerNameTo").attr("readonly", "readonly");
        $("#importerNameTo").val("");
        $(".importerNameToAsterisk").removeClass("asterisk");
        $(".importerNameToAsterisk").addClass("clear_font");
        $("#importerNameTo").removeClass("required");
    }
}

function onCheckCountryCode() {	 
	 $("#countryCodeTo").removeAttr("readonly");      
     $("#countryCodeTo").removeAttr("disabled");
    if($("#countryCodeSwitchDisplay").attr("checked") == "checked") {    	
        $("#countryCodeSwitch").val("on");        
        $("#countryCodeTo").removeAttr("readonly");      
        $("#countryCodeTo").removeAttr("disabled");
        $(".countryCodeToAsterisk").addClass("asterisk");
        $(".countryCodeToAsterisk").removeClass("clear_font");
        
    } else {
        $("#countryCodeSwitch").val("off");
//        $("#countryCodeTo").attr("readonly", "readonly");
//        $("#countryCodeTo").attr("disabled", "disabled");
        $("#countryCodeTo").val("");       
        $(".countryCodeToAsterisk").removeClass("asterisk");
        $(".countryCodeToAsterisk").addClass("clear_font");
    }
}


function setContryCode() {
    var countryCode = $("#countryCodeSwitch").val();
    if(countryCode) {
        if(countryCode.toLowerCase() == "on") {
            $("#countryCodeSwitchDisplay").attr("checked", "checked");
        } else {
            $("#countryCodeSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#countryCodeSwitchDisplay").attr("checked", false);
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
        $(".amend_importer_address").show();
        $(".importerAddressToAsterisk").addClass("asterisk");
        $(".importerAddressToAsterisk").removeClass("clear_font");
    } else {
        $("#importerAddressSwitch").val("off");
        $(".amend_importer_address").hide();
        $("#importerAddressTo").val("");
        $(".importerAddressToAsterisk").removeClass("asterisk");
        $(".importerAddressToAsterisk").addClass("clear_font");
    }
}

function setExporterCbCode() {
    var exporterCbCode = $("#exporterCbCodeSwitch").val();

    if(exporterCbCode) {
        if(exporterCbCode.toLowerCase() == "on") {
            $("#exporterCbCodeSwitchDisplay").attr("checked", "checked");
        } else {
            $("#exporterCbCodeSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#exporterCbCodeSwitchDisplay").attr("checked", false);
    }
}

function onCheckExporterCbCode() {
    if($("#exporterCbCodeSwitchDisplay").attr("checked") == "checked") {
        $("#exporterCbCodeSwitch").val("on");
//        $("#popup_btn_exporter_cb_code").show();
//        $("#exporterCbCodeTo").removeAttr("disabled");
        $("#exporterCbCodeTo").select2("enable");
        $(".exporterCbCodeToAsterisk").addClass("asterisk");
        $(".exporterCbCodeToAsterisk").removeClass("clear_font");

    } else {
        $("#exporterCbCodeSwitch").val("off");
//        $("#popup_btn_exporter_cb_code").hide();
//        $("#exporterCbCodeTo").attr("disabled", "disabled");
//        $("#exporterCbCodeTo").val("");
        $("#exporterCbCodeTo").select2("enable");
        $("#exporterCbCodeTo").select2('data', {id:""});
        $(".exporterCbCodeToAsterisk").removeClass("asterisk");
        $(".exporterCbCodeToAsterisk").addClass("clear_font");
    }
}

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
        $(".amend_exporter_address").show();
        $(".exporterAddressToAsterisk").addClass("asterisk");
        $(".exporterAddressToAsterisk").removeClass("clear_font");
        
    } else {
        $("#exporterAddressSwitch").val("off");
        $(".amend_exporter_address").hide();
        $("#exporterAddressTo").val("");
        $(".exporterAddressToAsterisk").removeClass("asterisk");
        $(".exporterAddressToAsterisk").addClass("clear_font");
        
    }
}

function setPositiveToleranceLimit() {
    var positiveToleranceLimit = $("#positiveToleranceLimitSwitch").val();

    if(positiveToleranceLimit) {
        if(positiveToleranceLimit.toLowerCase() == "on") {
            $("#positiveToleranceLimitSwitchDisplay").attr("checked", "checked");
        } else {
            $("#positiveToleranceLimitSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#positiveToleranceLimitSwitchDisplay").attr("checked", false);
    }
}

function onCheckPositveToleranceLimit() {
	
    if($("#positiveToleranceLimitSwitchDisplay").attr("checked") == "checked") {
        $("#positiveToleranceLimitSwitch").val("on");
        $("#positiveToleranceLimitTo").removeAttr("readonly");
        $("#positiveToleranceLimitTo").addClass("required");
        $("#maximumCreditAmountSwitchDisplay").attr("disabled","disabled");
        $(".positiveToleranceLimitToAsterisk").addClass("asterisk");
        $(".positiveToleranceLimitToAsterisk").removeClass("clear_font");
        
    } else {
        $("#positiveToleranceLimitSwitch").val("off");
        $("#positiveToleranceLimitTo").attr("readonly", "readonly");
        $("#positiveToleranceLimitTo").val("");
        $("#positiveToleranceLimitTo").removeClass("required");
        $(".positiveToleranceLimitToAsterisk").removeClass("asterisk");
        $(".positiveToleranceLimitToAsterisk").addClass("clear_font");
        if($("#negativeToleranceLimitSwitchDisplay").attr("checked") == "checked"){        	
        	 $("#maximumCreditAmountSwitchDisplay").attr("disabled","disabled");
        	
        }else{
        	 $("#maximumCreditAmountSwitchDisplay").removeAttr("disabled");
        	 
        }
    }
}

function setNegativeToleranceLimit() {
    var negativeToleranceLimit = $("#negativeToleranceLimitSwitch").val();

    if(negativeToleranceLimit) {
        if(negativeToleranceLimit.toLowerCase() == "on") {
            $("#negativeToleranceLimitSwitchDisplay").attr("checked", "checked");
        } else {
            $("#negativeToleranceLimitSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#negativeToleranceLimitSwitchDisplay").attr("checked", false);
    }
}

function onCheckNegativeToleranceLimit() {
    if($("#negativeToleranceLimitSwitchDisplay").attr("checked") == "checked") {
        $("#negativeToleranceLimitSwitch").val("on");
        $("#negativeToleranceLimitTo").removeAttr("readonly");
        $("#negativeToleranceLimitTo").addClass("required");
        $("#maximumCreditAmountSwitchDisplay").attr("disabled","disabled");
        $(".negativeToleranceLimitToAsterisk").addClass("asterisk");
        $(".negativeToleranceLimitToAsterisk").removeClass("clear_font");
    } else {
        $("#negativeToleranceLimitSwitch").val("off");
        $("#negativeToleranceLimitTo").attr("readonly", "readonly");
        $("#negativeToleranceLimitTo").val("");
        $("#negativeToleranceLimitTo").removeClass("required");
        $(".negativeToleranceLimitToAsterisk").removeClass("asterisk");
        $(".negativeToleranceLimitToAsterisk").addClass("clear_font");
        if($("#positiveToleranceLimitSwitchDisplay").attr("checked") == "checked"){        	
       	 	$("#maximumCreditAmountSwitchDisplay").attr("disabled","disabled");
       }else{
       		$("#maximumCreditAmountSwitchDisplay").removeAttr("disabled");
       }
    }
}

function setMaximumCreditAmount() {
    var maximumCreditAmount = $("#maximumCreditAmountSwitch").val();

    if(maximumCreditAmount) {
        if(maximumCreditAmount.toLowerCase() == "on") {
            $("#maximumCreditAmountSwitchDisplay").attr("checked", "checked");
        } else {
            $("#maximumCreditAmountSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#maximumCreditAmountSwitchDisplay").attr("checked", false);
    }
}

function onCheckMaximumCreditAmount() {
    if($("#maximumCreditAmountSwitchDisplay").attr("checked") == "checked") {
        $("#maximumCreditAmountSwitch").val("on");
        $("#maximumCreditAmountTo").removeAttr("readonly");
        $("#positiveToleranceLimitSwitchDisplay").attr("disabled","disabled");
        $("#negativeToleranceLimitSwitchDisplay").attr("disabled","disabled");
        $(".maximumCreditAmountToAsterisk").addClass("asterisk");
        $(".maximumCreditAmountToAsterisk").removeClass("clear_font");
    } else {
        $("#maximumCreditAmountSwitch").val("off");
        $("#maximumCreditAmountTo").attr("readonly", "readonly");
        $("#maximumCreditAmountTo").val("");
        $("#positiveToleranceLimitSwitchDisplay").removeAttr("disabled");
        $("#negativeToleranceLimitSwitchDisplay").removeAttr("disabled");
        $(".maximumCreditAmountToAsterisk").removeClass("asterisk");
        $(".maximumCreditAmountToAsterisk").addClass("clear_font");
    }
}

function setAdditionalAmountsCovered() {
    var additionalAmountsCovered = $("#additionalAmountsCoveredSwitch").val();

    if(additionalAmountsCovered) {
        if(additionalAmountsCovered.toLowerCase() == "on") {
            $("#additionalAmountsCoveredSwitchDisplay").attr("checked", "checked");
        } else {
            $("#additionalAmountsCoveredSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#additionalAmountsCoveredSwitchDisplay").attr("checked", false);
    }
}

function onCheckAdditionalAmountsCovered() {
    if($("#additionalAmountsCoveredSwitchDisplay").attr("checked") == "checked") {
        $("#additionalAmountsCoveredSwitch").val("on");
        $("#additionalAmountsCoveredTo").addClass("required");
        $("#popup_btn_additional_amounts_covered").show();
        $(".additionalAmountsCoveredToAsterisk").addClass("asterisk");
        $(".additionalAmountsCoveredToAsterisk").removeClass("clear_font");
    } else {
        $("#additionalAmountsCoveredSwitch").val("off");
        $("#popup_btn_additional_amounts_covered").hide();
        $("#additionalAmountsCoveredTo").val("");
        $("#additionalAmountsCoveredTo").removeClass("required");
        $(".additionalAmountsCoveredToAsterisk").removeClass("asterisk");
        $(".additionalAmountsCoveredToAsterisk").addClass("clear_font");
    }
}

function setAvailableWith() {
    var availableWith = $("#availableWithSwitch").val();

    if(availableWith) {
        if(availableWith.toLowerCase() == "on") {
            $("#availableWithSwitchDisplay").attr("checked", "checked");
        } else {
            $("#availableWithSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#availableWithSwitchDisplay").attr("checked", false);
    }
}

function onCheckAvailableWith() {
    $('#availableWithFlagMt').val("");
    if($("#availableWithSwitchDisplay").attr("checked") == "checked") {
    	var confirmationInstructionsFlagSwitch = $('#confirmationInstructionsFlagSwitch').val(),
    		confirmationInstructionsFlagTo = $('#confirmationInstructionsFlagTo').val(), option = "A";
        $("#availableWithSwitch").val("on");
        if (confirmationInstructionsFlagSwitch == 'on' && confirmationInstructionsFlagTo == '') {
        	confirmationInstructionsFlagSwitch = 'off';
        }
        
        if ((confirmationInstructionsFlagSwitch == 'on' && (confirmationInstructionsFlagTo == 'YES' || confirmationInstructionsFlagTo == 'MAY ADD'))
        		|| (confirmationInstructionsFlagSwitch == 'off' && $('#confirmationInstructionsFlagFrom').val() == 'Y')) {
            $("#availableWithTo").select2("enable");
            $('#availableWithFlagTo[value="A"]').attr('checked', 'checked');
            $("#popup_btn_bank_address").hide();
            $("#availableWithTo").addClass('required');
            $("#nameAndAddressTo").removeClass('required');
        } else {
        	option = "D";
        	$('#availableWithFlagTo[value="D"]').attr('checked', 'checked');
        	$("#popup_btn_bank_address").show();
            $("#availableWithTo").removeClass('required');
            $("#nameAndAddressTo").addClass('required');
        }

        $(".availableWithToAsterisk").addClass("asterisk");
        $(".availableWithToAsterisk").removeClass("clear_font");
    	$('#availableWithFlagMt').val(option);
    } else {
        $("#availableWithSwitch").val("off");
        $("#availableWithTo").removeClass('required');
        $("#nameAndAddressTo").removeClass('required');
        $("#availableWithTo").select2("disable");
        $("#availableWithTo").select2("data", {id: ""});
        $("input[type=radio][name=availableWithFlagTo]").attr("checked", false);
        $(".availableWithToAsterisk").removeClass("asterisk");
        $(".availableWithToAsterisk").addClass("clear_font");
        $("#availableWithTo").removeClass("required");
        $("#nameAndAddressTo").removeClass("required");
        onClickAvailableWithFlagTo();
    }
}

function onClickAvailableWithFlagTo() {
    var availableWithFlagTo = $("input[type=radio][name=availableWithFlagTo]:checked").val();
    $("#popup_btn_bank_address").hide();

    if(availableWithFlagTo == "A") {
    	$("#identifierCodeTo").removeAttr("readonly");
    	$("#identifierCodeTo").removeAttr("disabled");
        $("#popup_btn_bank_address").hide();
        $("#nameAndAddressTo").val("");
    } else if(availableWithFlagTo == "D") {
        $("#popup_btn_bank_address").show();
        $("#identifierCodeTo").attr("readonly", "readonly");
        $("#identifierCodeTo").attr("disabled", "disabled");
        $("#identifierCodeTo").val("");
    } else {
        $("#identifierCodeTo").attr("readonly", "readonly");
        $("#identifierCodeTo").attr("disabled", "disabled");
        $("#identifierCodeTo").val("");
        $("#nameAndAddressTo").val("");
        $("#popup_btn_bank_address").hide();
    }
}

function setAvailableBy() {
    var availableBy = $("#availableBySwitch").val();

    if(availableBy) {
        if(availableBy.toLowerCase() == "on") {
            $("#availableBySwitchDisplay").attr("checked", "checked");
        } else {
            $("#availableBySwitchDisplay").attr("checked", false);
        }
    }else {
        $("#availableBySwitchDisplay").attr("checked", false);
    }
}

function onCheckAvailableBy() {
    if($("#availableBySwitchDisplay").attr("checked") == "checked") {
        $("#availableBySwitch").val("on");
        $("#availableByTo").removeAttr("disabled");
        $(".availableByToAsterisk").addClass("asterisk").removeClass("clear_font");
        $("#availableByTo").addClass("required");
    } else {
        $("#availableBySwitch").val("off");
        $("#availableByTo").attr("disabled", "disabled");
        $("#availableByTo").val("");
        $(".availableByToAsterisk").addClass("clear_font").removeClass("asterisk");
        $("#availableByTo").removeClass("required");
    }
}

function setPartialShipment() {
    var partialShipment = $("#partialShipmentSwitch").val();

    if(partialShipment) {
        if(partialShipment.toLowerCase() == "on") {
            $("#partialShipmentSwitchDisplay").attr("checked", "checked");
        } else {
            $("#partialShipmentSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#partialShipmentSwitchDisplay").attr("checked", false);
    }
}

function onCheckPartialShipment() {
    if($("#partialShipmentSwitchDisplay").attr("checked") == "checked") {
        $("#partialShipmentSwitch").val("on");
        $("#partialShipmentTo").removeAttr("disabled");
        $(".partialShipmentToAsterisk").addClass("asterisk");
        $(".partialShipmentToAsterisk").removeClass("clear_font");
    } else {
        $("#partialShipmentSwitch").val("off");
        $("#partialShipmentTo").attr("disabled", "disabled");
        $("#partialShipmentTo").val("");
        $(".partialShipmentToAsterisk").removeClass("asterisk");
        $(".partialShipmentToAsterisk").addClass("clear_font");
    }
}

function setCommodityCode() {
	var commodityCode = $("#commodityCodeSwitch").val();
	
	if(commodityCode) {
		if(commodityCode.toLowerCase() == "on") {
			$("#commodityCodeSwitchDisplay").attr("checked", "checked");
		} else {
			$("#commodityCodeSwitchDisplay").attr("checked", false);
		}
	}else {
		$("#commodityCodeSwitchDisplay").attr("checked", false);
	}
}

function onCheckCommodityCode() {
	if($("#commodityCodeSwitchDisplay").attr("checked") == "checked") {
		$("#commodityCodeSwitch").val("on");
		$("#commodityTo").removeAttr("readonly").select2("enable");
		$("#commodityTo").removeAttr("disabled"); 
		$(".commodityCodeToAsterisk").addClass("asterisk");
		$(".commodityCodeToAsterisk").removeClass("clear_font");
		$("#commodityTo").addClass("required");
	} else {
		$("#commodityCodeSwitch").val("off");
		$("#commodityTo").select2('data',null);
		$("#commodityTo").attr("readonly", "readonly").select2("disable");
		$("#commodityCodeTo").val('');
		$(".commodityCodeToAsterisk").removeClass("asterisk");
		$("#commodityTo").removeClass("required");
		$(".commodityCodeToAsterisk").addClass("clear_font");
	}
}

function setTransShipment() {
    var transShipment = $("#transShipmentSwitch").val();

    if(transShipment) {
        if(transShipment.toLowerCase() == "on") {
            $("#transShipmentSwitchDisplay").attr("checked", "checked");
        } else {
            $("#transShipmentSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#transShipmentSwitchDisplay").attr("checked", false);
    }
}

function onCheckTransShipment() {
    if($("#transShipmentSwitchDisplay").attr("checked") == "checked") {
        $("#transShipmentSwitch").val("on");
        $("#transShipmentTo").removeAttr("disabled");
        $(".transShipmentToAsterisk").addClass("asterisk");
        $(".transShipmentToAsterisk").removeClass("clear_font");
    } else {
        $("#transShipmentSwitch").val("off");
        $("#transShipmentTo").attr("disabled", "disabled");
        $("#transShipmentTo").val("");
        $(".transShipmentToAsterisk").removeClass("asterisk");
        $(".transShipmentToAsterisk").addClass("clear_font");
    }
}

function setPlaceOfTaking() {
    var placeOfTaking = $("#placeOfTakingDispatchOrReceiptSwitch").val();

    if(placeOfTaking) {
        if(placeOfTaking.toLowerCase() == "on") {
            $("#placeOfTakingDispatchOrReceiptSwitchDisplay").attr("checked", "checked");
        } else {
            $("#placeOfTakingDispatchOrReceiptSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#placeOfTakingDispatchOrReceiptSwitchDisplay").attr("checked", false);
    }
}

function onCheckPlaceOfTaking() {
    $("#placeOfTakingDispatchOrReceiptTo").removeAttr("disabled");
    if($("#placeOfTakingDispatchOrReceiptSwitchDisplay").attr("checked") == "checked") {
        $("#placeOfTakingDispatchOrReceiptSwitch").val("on");
        $("#placeOfTakingDispatchOrReceiptTo").removeAttr("readonly");
        $(".placeOfTakingDispatchOrReceiptToAsterisk").addClass("asterisk");
        $(".placeOfTakingDispatchOrReceiptToAsterisk").removeClass("clear_font");
    } else {
        $("#placeOfTakingDispatchOrReceiptSwitch").val("off");
        $("#placeOfTakingDispatchOrReceiptTo").attr("readonly", "readonly");
        $("#placeOfTakingDispatchOrReceiptTo").val("");
        $(".placeOfTakingDispatchOrReceiptToAsterisk").removeClass("asterisk");
        $(".placeOfTakingDispatchOrReceiptToAsterisk").addClass("clear_font");
    }
}

function setPortOfLoading() {
    var portOfLoading = $("#portOfLoadingOrDepartureSwitch").val();

    if(portOfLoading) {
        if(portOfLoading.toLowerCase() == "on") {
            $("#portOfLoadingOrDepartureSwitchDisplay").attr("checked", "checked");
        } else {
            $("#portOfLoadingOrDepartureSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#portOfLoadingOrDepartureSwitchDisplay").attr("checked", false);
    }
}

function onCheckPortOfLoading() {
    $("#portOfLoadingOrDepartureTo").removeAttr("disabled");
    if($("#portOfLoadingOrDepartureSwitchDisplay").attr("checked") == "checked") {
        $("#portOfLoadingOrDepartureSwitch").val("on");
        $("#portOfLoadingOrDepartureTo").removeAttr("readonly");
//        $("#bspCountryCodeTo").removeAttr("disabled");
        $("#bspCountryCodeTo").select2("enable");
        $(".portOfLoadingOrDepartureTo").addClass("asterisk").removeClass("clear_font");
        $(".bspCountryCodeToAsterisk").addClass("asterisk").removeClass("clear_font");
    } else {
        $("#portOfLoadingOrDepartureSwitch").val("off");
        $("#portOfLoadingOrDepartureTo").attr("readonly", "readonly");
        $("#portOfLoadingOrDepartureTo").val("");
//        $("#bspCountryCodeTo").attr("disabled", "disabled");
//        $("#bspCountryCodeTo").val("");
        $("#bspCountryCodeTo").select2("disable");
        $("#bspCountryCodeTo").select2("data", {id: ""});
        $(".portOfLoadingOrDepartureTo").addClass("clear_font").removeClass("asterisk");
        $(".bspCountryCodeToAsterisk").addClass("clear_font").removeClass("asterisk");
    }
}

function setPortOfDischarge() {
    var portOfDischarge = $("#portOfDischargeOrDestinationSwitch").val();

    if(portOfDischarge) {
        if(portOfDischarge.toLowerCase() == "on") {
            $("#portOfDischargeOrDestinationSwitchDisplay").attr("checked", "checked");
        } else {
            $("#portOfDischargeOrDestinationSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#portOfDischargeOrDestinationSwitchDisplay").attr("checked", false);
    }
}

function onCheckPortOfDischarge() {
    $("#portOfDischargeOrDestinationTo").removeAttr("disabled");
    if($("#portOfDischargeOrDestinationSwitchDisplay").attr("checked") == "checked") {
        $("#portOfDischargeOrDestinationSwitch").val("on");
        $("#portOfDischargeOrDestinationTo").removeAttr("readonly");
        $(".portOfDischargeOrDestinationToAsterisk").addClass("asterisk");
        $(".portOfDischargeOrDestinationToAsterisk").removeClass("clear_font");
    } else {
        $("#portOfDischargeOrDestinationSwitch").val("off");
        $("#portOfDischargeOrDestinationTo").attr("readonly", "readonly");
        $("#portOfDischargeOrDestinationTo").val("");
        $(".portOfDischargeOrDestinationToAsterisk").removeClass("asterisk");
        $(".portOfDischargeOrDestinationToAsterisk").addClass("clear_font");
    }
}

function setFinalDestination() {
    var finalDestination = $("#placeOfFinalDestinationSwitch").val();

    if(finalDestination) {
        if(finalDestination.toLowerCase() == "on") {
            $("#placeOfFinalDestinationSwitchDisplay").attr("checked", "checked");
        } else {
            $("#placeOfFinalDestinationSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#placeOfFinalDestinationSwitchDisplay").attr("checked", false);
    }
}

function onCheckFinalDestination() {
    $("#placeOfFinalDestinationTo").removeAttr("disabled");
    if($("#placeOfFinalDestinationSwitchDisplay").attr("checked") == "checked") {
        $("#placeOfFinalDestinationSwitch").val("on");
        $("#placeOfFinalDestinationTo").removeAttr("readonly");
        $(".placeOfFinalDestinationToAsterisk").addClass("asterisk");
        $(".placeOfFinalDestinationToAsterisk").removeClass("clear_font");
    } else {
        $("#placeOfFinalDestinationSwitch").val("off");
        $("#placeOfFinalDestinationTo").attr("readonly", "readonly");
        $("#placeOfFinalDestinationTo").val("");
        $(".placeOfFinalDestinationToAsterisk").removeClass("asterisk");
        $(".placeOfFinalDestinationToAsterisk").addClass("clear_font");
    }
}

function setBspCountryCode() {
    var placeOfTaking = $("#bspCountryCodeSwitch").val();

    if(placeOfTaking) {
        if(placeOfTaking.toLowerCase() == "on") {
            $("#bspCountryCodeSwitchDisplay").attr("checked", "checked");
        } else {
            $("#bspCountryCodeSwitchDisplay").attr("checked", false);
        }
    }else {
        $("#bspCountryCodeSwitchDisplay").attr("checked", false);
    }
}

function onBspCountryCode() {
	if($("#bspCountryCodeSwitchDisplay").attr("checked") == "checked") {
		$("#bspCountryCodeSwitch").val("on");
		$("#bspCountryCodeTo").removeAttr("readonly");
		$("#bspCountryCodeTo").removeAttr("disabled"); 
        $("#bspCountryCodeTo").select2("enable");
		$(".bspCountryCodeToAsterisk").addClass("asterisk");
		$(".bspCountryCodeToAsterisk").removeClass("clear_font");
		$("#bspCountryCodeTo").addClass("required");
	} else {
		$("#bspCountryCodeSwitch").val("off");
        $("#bspCountryCodeTo").select2("disable");
        $("#bspCountryCodeTo").select2('data', {id:""})
		$("#bspCountryCodeTo").attr("readonly", "readonly");
		$(".bspCountryCodeToAsterisk").removeClass("asterisk");
		$("#bspCountryCodeTo").removeClass("required");
		$(".bspCountryCodeToAsterisk").addClass("clear_font");
	}
}

function initializeDataEntryIeDetails() {
    disableIEFields();

    setImporterName();
    $("#importerNameSwitchDisplay").click(onCheckImporterName);
    onCheckImporterName();

    setImporterAddress();
    $("#importerAddressSwitchDisplay").click(onCheckImporterAddress);
    onCheckImporterAddress();

    setExporterCbCode();
    $("#exporterCbCodeSwitchDisplay").click(onCheckExporterCbCode);
    onCheckExporterCbCode();

    setExporterName();
    $("#exporterNameSwitchDisplay").click(onCheckExporterName);
    onCheckExporterName();

    setExporterAddress();
    $("#exporterAddressSwitchDisplay").click(onCheckExporterAddress);
    onCheckExporterAddress();

    setPositiveToleranceLimit();
    $("#positiveToleranceLimitSwitchDisplay").click(onCheckPositveToleranceLimit);
    onCheckPositveToleranceLimit();

    setNegativeToleranceLimit();
    $("#negativeToleranceLimitSwitchDisplay").click(onCheckNegativeToleranceLimit);
    onCheckNegativeToleranceLimit();

    setMaximumCreditAmount();
    $("#maximumCreditAmountSwitchDisplay").click(onCheckMaximumCreditAmount);
    onCheckMaximumCreditAmount();

    setAdditionalAmountsCovered();
    $("#additionalAmountsCoveredSwitchDisplay").click(onCheckAdditionalAmountsCovered);
    onCheckAdditionalAmountsCovered();

    setAvailableWith();
    $("#availableWithSwitchDisplay").click(onCheckAvailableWith);
    onCheckAvailableWith();
    $("input[type=radio][name=availableWithFlagTo]").click(onClickAvailableWithFlagTo);
    onClickAvailableWithFlagTo();

    setAvailableBy();
    $("#availableBySwitchDisplay").click(onCheckAvailableBy);
    onCheckAvailableBy();

    setPartialShipment();
    $("#partialShipmentSwitchDisplay").click(onCheckPartialShipment);
    onCheckPartialShipment();
    
    setCommodityCode();
    $("#commodityCodeSwitchDisplay").click(onCheckCommodityCode);
    onCheckCommodityCode();

    setContryCode();
    $("#countryCodeSwitchDisplay").click(onCheckCountryCode);
    onCheckCountryCode();
    
    setTransShipment();
    $("#transShipmentSwitchDisplay").click(onCheckTransShipment);
    onCheckTransShipment();

    setPlaceOfTaking();
    $("#placeOfTakingDispatchOrReceiptSwitchDisplay").click(onCheckPlaceOfTaking);
    onCheckPlaceOfTaking();

    setPortOfLoading();
    $("#portOfLoadingOrDepartureSwitchDisplay").click(onCheckPortOfLoading);
    onCheckPortOfLoading();

    setPortOfDischarge();
    $("#portOfDischargeOrDestinationSwitchDisplay").click(onCheckPortOfDischarge);
    onCheckPortOfDischarge();

    setFinalDestination();
    $("#placeOfFinalDestinationSwitchDisplay").click(onCheckFinalDestination);
    onCheckFinalDestination();
    
    setBspCountryCode();
    $("#bspCountryCodeSwitchDisplay").click(onBspCountryCode);
    onBspCountryCode();
   
}

$(initializeDataEntryIeDetails);
