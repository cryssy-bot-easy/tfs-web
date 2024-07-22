/* Modified by: Rafael Ski Poblete
 * Date Modified: 9/11/18
 * Description: Added condition to check if field netAmountDateMt752 is mandatory.
 * */
function onBasicDetailsSaveClick() {
	var errors = validateErrrors();
	onSaveClick(errors);
}

function onMT103SaveClick() {
	var errors = validateMT103();
	onSaveClick(errors);
}

function onMT752MT202SaveClick(messageType) {
	var errors = validateMT752MT202(messageType);
	onSaveClick(errors);
}

function onChargesTabSaveClick() {
	var errors = validateCharges();
	onSaveClick(errors);
}

function onCashLcPaymentTabSaveClick() {
	var errors = validateCashLcPaymentTab();
	onSaveClick(errors);
}

function onSaveClick(errors) {
	if (!errors) {// checks if all fields are valid
	// action = "save";
		_pageHasErrors = false;
		// openAlert();
		// confirmAlert();
	} else {
		_pageHasErrors = true;
	}
}

function onDefaultClick() {
	// action = "save";
	// openAlert();
	_pageHasErrors = false;
}

function validateErrrors() {
	drpdownNegoType = $('.negotiationType');
	drpdownNegoType2 = $('#negotiationType');
	drpdownNegobank = $('#negotiatingBank');
	drpdownreimbursebank = $('#reimbursingBank');

    if ($("#referenceType").length > 0 && $("#referenceType").val() == "DATA_ENTRY") {
        if ($("#cifAddress").val() == "" || (typeof $("#negotiationAmount").val() !== "undefined" && $("#negotiationAmount").val() == "")
            || (typeof $(".negotiationValueDate").val() !== "undefined" && $(".negotiationValueDate").val() == "")
            || (typeof $("#valueDate").val() !== "undefined" && $("#valueDate").val() == "")
            || (typeof $("#negotiatingBanksReferenceNumber").val() !== "undefined" && $("#negotiatingBanksReferenceNumber").val() == "")
            || (typeof $(drpdownNegoType).val() !== "undefined" && $(drpdownNegoType).val() == "")
            || (typeof $(drpdownNegoType2).val() !== "undefined" && $(drpdownNegoType2).val() == "")
            || (typeof $(drpdownNegobank).val() !== "undefined" && $(drpdownNegobank).val() == "")
            || (typeof $(drpdownreimbursebank).val() !== "undefined" && $(drpdownreimbursebank).val() == "")) {
            // alert('Please fill-up the required fields.');
            $("#alertMessage").text("Please fill up out required fields.");
            triggerAlert();
            return true;
        } else {
            return false;
        }
    } else {
        return false;
    }
}

function validateMT103() {
	if ($("#receivingBank").val() == "" || $("#bankOperationCode").val() == ""
			|| $("#accountWithInstitution").val() == ""
			|| $("#beneficiaryCustomerName").val() == ""
			|| $("#beneficiaryCustomerAddress").val() == ""
			|| $("#detailsOfCharges").val() == ""
			|| $("#senderToReceiverInformation").val() == "") {
		// alert("Please fill-up required fields");
		$("#alertMessage").text("Please fill in all the required fields.");
		triggerAlert();
		return true;
	} else {
		return false;
	}
}

function validateMT752MT202(messageType) {
	var mt752 = true;
	var mt202 = true;

	if (messageType == "752") {

		if ($("#reimbursingBankMt752").val() == ""
				|| $("#negotiatingBankMt752").val() == ""
				|| $("#negotiatingBanksReferenceNumberMt752").val() == ""
				|| $("#furtherIdentificationMt752").val() == ""
				|| $("#valueDateMt752").val() == "") {
			mt752 = false;
		}
//		if(document.getElementByClassName('optionA').checked)
		if(($('.optionA').get(0).checked) && (!$("#netAmountDateMt752").val())){
			mt752 = false;
		}

	} else if (messageType == "202") {

		if ($("input[name=orderingBankFlagMt202]:checked").length > 0) {
			switch ($("input[name=orderingBankFlagMt202]:checked").val()) {
			case "A":
				if ("" == $("#bankIdentifierCodeMt202").val()) {
					mt202 = false;
				}
				break;
			case "D":
				if ("" == $("#bankNameAndAddressMt202").val()) {
					mt202 = false;
				}
				break;
			default:
				mt202 = false;
			}
			;
		} else {
			mt202 = false;
		}

		// if($("input[name=intermediaryFlagMt202]:checked").length > 0) {
		// switch($("input[name=intermediaryFlagMt202]:checked").val()){
		// case "A":
		// if("" == $("#intermediaryIdentifierCodeMt202").val()){
		// mt202 = false;
		// }
		// break;
		// case "D":
		// if("" == $("#intermediaryNameAndAddressMt202").val()){
		// mt202 = false;
		// }
		// break;
		// default:
		// mt202 = false;
		// };
		// }

		// if($("input[name=accountWithBankFlagMt202]:checked").length > 0) {
		// switch($("input[name=accountWithBankFlagMt202]:checked").val()){
		// case "A":
		// if("" == $("#accountIdentifierCodeMt202").val()){
		// mt202 = false;
		// }
		// break;
		// case "B":
		// if("" == $("#accountWithBankLocationMt202").val()){
		// mt202 = false;
		// }
		// break;
		// case "D":
		// if("" == $("#accountNameAndAddressMt202").val()){
		// mt202 = false;
		// }
		// break;
		// default:
		// mt202 = false;
		// };
		// }

		if ($("input[name=beneficiaryBankFlagMt202]:checked").length > 0) {
			switch ($("input[name=beneficiaryBankFlagMt202]:checked").val()) {
			case "A":
				if ("" == $("#beneficiaryIdentifierCodeMt202").val()) {
					mt202 = false;
				}
				break;
			case "D":
				if ("" == $("#beneficiaryNameAndAddressMt202").val()) {
					mt202 = false;
				}
				break;
			default:
				mt202 = false;
			}
			;
		} else {
			mt202 = false;
		}

		if ($("#reimbursingBankMt202").val() == ""
				|| $("#negotiatingBankMt202").val() == ""
				|| $("#negotiatingBanksReferenceNumberMt202").val() == "") {

			mt202 = false;
		}
	}

	if (mt752 == false || mt202 == false) {
		$("#alertMessage").text("Please fill in all the required fields.");
		triggerAlert();
		return true;
	}
}

function validateCharges() {
	var error_msg = ""
	if ($("#settlementCurrency").val() == "") {
		error_msg += "Settlement currency is empty."
	}

	if (error_msg.length > 0) {
		$("#alertMessage").text("Please fill in all the required fields.");
		triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateCashLcPaymentTab() {
	var error_msg = ""

	if (error_msg.length > 0) {
		$("#alertMessage").text("Please fill in all the required fields.");
		triggerAlert();
		return true
	} else {
		return false;
	}
}

function validateNegotiation(buttonParentId) {
	switch (buttonParentId) {
	case "basicDetailsTabForm":
		onBasicDetailsSaveClick();
		break;
	case "mt103TabForm":
		onMT103SaveClick();
		break;
	case "mt752TabForm":
		onMT752MT202SaveClick("752");
		break;
	case "mt202TabForm":
		onMT752MT202SaveClick("202");
		break;
	case "chargesTabForm":
		onChargesTabSaveClick();
		break;
	case "cashLcPaymentTabForm":
		onCashLcPaymentTabSaveClick();
		break;
	default:
		onDefaultClick();
		break;
	}
}

$(document).ready(function() {
	// $('#textareaSample').limit('100','#charsLeft');

    
});
