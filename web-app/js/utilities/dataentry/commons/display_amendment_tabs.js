/**
 	(revision)
	SCR/ER Number: SCR# IBD-15-1125-01
	SCR/ER Description: Added functions for Buyer Info 
	[Revised by:] Jonh Henry Santos Alabin
	[Date revised:] 1/12/2017
	Program [Revision] Details: Added functions for Buyer Info and validation upon saving if change in Buyer or Seller Info(checkbox) was checked but the new Amount was left unfilled. 
	Member Type: JAVASCRIPT
	Project: WEB
	Project Name: display_amendment_tabs.js
 
 */
$(document).ready(function(){
	
	//*********************************FOR ETS*********************************\\
	
	//*********************************END ETS*********************************\\
	
	//******************************FOR DATA_ENTRY******************************\\
	/*var byCheckBox = $("#byCheck");
	var byDropDown = $("#byTo");
	var partialDeliveryCheckBox = $("#partialDeliveryCheck");
	var partialDeliveryTextField = $("#partialDeliveryTo");
		
	byCheckBox.change(function(){
		if(byCheckBox.val() == "byCheckEnabled"){
			if(byDropDown.attr("disabled")){
				byDropDown.removeAttr("disabled");
			} else{
				byDropDown.attr("disabled", true);
			}
		} else{
			byDropDown.attr("disabled", true);
		}	
	});

	partialDeliveryCheckBox.change(function(){
		if(partialDeliveryCheckBox.val() == "partialDeliveryCheckEnabled"){
			if(partialDeliveryTextField.attr("disabled")){
				partialDeliveryTextField.removeAttr("disabled");
			} else{
				partialDeliveryTextField.attr("disabled", true);
			}
		} else{
			partialDeliveryTextField.attr("disabled", true);
		}
	});*/
	if(serviceType.toUpperCase() == 'AMENDMENT' && referenceType.toUpperCase() == 'DATA_ENTRY'){
	setByCheck();
    onByCheck();
    $("#availableBySwitchDisplay").click(onByCheck);
    
    setPartialDeliveryCheck();
    onPartialDeliveryCheck();
    $("#partialDeliverySwitchDisplay").click(onPartialDeliveryCheck);
    
    setBeneficiaryNameCheck();
    onBeneficiaryNameCheck();
    $("#beneficiaryNameSwitchDisplay").click(onBeneficiaryNameCheck);
    
    setBeneficiaryAddressCheck();
    onBeneficiaryAddressCheck();
    $("#beneficiaryAddressSwitchDisplay").click(onBeneficiaryAddressCheck);
	
	//added by henry Buyer Info
	 setApplicantNameCheck();
	 onApplicantNameCheck();
	 $("#applicantNameSwitchDisplay").click(onApplicantNameCheck);
	 
	 setApplicantAddressCheck();
	 onApplicantAddressCheck();
	 $("#applicantAddressSwitchDisplay").click(onApplicantAddressCheck);
	}
	//******************************END DATA_ENTRY******************************\\
	
	$("#settlementCurrencyCashFxlc, #settlementCurrencyCashDmlc").change(function(){
		$(".cash_currency").val($(this).val());
	});

});


	//***************************DATA ENTRY FUNCTIONS***************************\\
function setByCheck(){
	var availableBySwitch = $("#availableBySwitch").val();

    if(availableBySwitch) {
        if(availableBySwitch.toLocaleString() == "on") {
            $("#availableBySwitchDisplay").attr("checked", "checked");
        } else {
            $("#availableBySwitchDisplay").attr("checked", false);
        }
    } else {
        $("#availableBySwitchDisplay").attr("checked", false);
    }
}
function onByCheck(){
	if($("#availableBySwitchDisplay").attr("checked") == "checked") {
        $("#availableBySwitch").val("on");
        $("#availableByTo").removeAttr("disabled");
    } else {
        $("#availableBySwitch").val("off");
        $("#availableByTo").attr("disabled", "disabled");
        $("#availableByTo").val("");
    }
}

function setPartialDeliveryCheck(){
	var partialDeliverySwitch = $("#partialDeliverySwitch").val();

    if(partialDeliverySwitch) {
        if(partialDeliverySwitch.toLocaleString() == "on") {
            $("#partialDeliverySwitchDisplay").attr("checked", "checked");
        } else {
            $("#partialDeliverySwitchDisplay").attr("checked", false);
        }
    } else {
        $("#partialDeliverySwitchDisplay").attr("checked", false);
    }
}
function onPartialDeliveryCheck(){
	if($("#partialDeliverySwitchDisplay").attr("checked") == "checked") {
        $("#partialDeliverySwitch").val("on");
        $("#partialDeliveryTo").removeAttr("disabled");
    } else {
        $("#partialDeliverySwitch").val("off");
        $("#partialDeliveryTo").attr("disabled", "disabled");
        $("#partialDeliveryTo").val("");
    }
}

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
    } else {
        $("#beneficiaryNameSwitch").val("off");
        $("#beneficiaryNameTo").attr("readonly", "readonly");
        $("#beneficiaryNameTo").val("");
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
    } else {
        $("#beneficiaryAddressSwitch").val("off");
        $("#beneficiaryAddressTo").attr("readonly", "readonly");
        $("#beneficiaryAddressTo").val("");
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
//Seller info

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

//end of Buyer and Seller info Functions


