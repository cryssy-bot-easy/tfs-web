$(document).ready(function(){
	initializeModeOfPayment();
});

function initializeModeOfPayment(){
    if(formId == "#basicDetailsTabForm" && documentClass == "AP" && serviceType.toUpperCase() == "REFUND") {
        insertToApModes();
    }

    if(formId == "#basicDetailsTabForm" && documentClass == "AR" && serviceType.toUpperCase() == "SETTLE") {
        insertToApModes();
    }

	$("#chargesPaymentTab").click(onChargesPaymentTabClick);
	$("#cashLcPaymentTab").click(onCashLcPaymentTabClick);
	$("#proceedsDetailsTab, #settlementToBenificiaryTab").click(onProceedsDetailsTabClick);
    $("#paymentDetailsTab").click(setupModeOfPaymentPaymentDetailsMd);
}

function setupModeOfPaymentPaymentDetailsMd() {
    $("#modeOfPaymentCharges").empty();

    if(serviceType == "Collection") {
        var options = {
            "": "SELECT ONE...",
            CASA : "Debit from CASA",
            CHECK: "Check",
            CASH: "Cash",
            AP: "Apply AP",
            REMITTANCE: "Remittance",
            IBT_BRANCH: "IBT - Branch"
        }
    }

    $.each(options, function(val, text) {
        $('#modeOfPaymentCharges').append(
            $('<option></option>').val(val).html(text)
        );
    });
}

function onChargesPaymentTabClick(){
	$('#modeOfPaymentCharges').empty();

	if (serviceType.toLowerCase() == 'indemnity cancellation'){
        var options = {
            "" : "SELECT ONE...",
            CASA : "Debit from CASA",
            CASH : "Cash"
        }

        $.each(options, function(val, text) {
            $('#modeOfPaymentCharges').append(
                $('<option></option>').val(val).html(text)
            );
        });
//		$('#modeOfPaymentCharges').append("<option selected='selected' value='0'>SELECT ONE...</option>");
//		$('#modeOfPaymentCharges').append("<option value='Debit from Casa'>Debit from Casa</option>");
//		$('#modeOfPaymentCharges').append("<option value='Cash'>Cash</option>");
	}else{
		insertValues();
	}
}

function onProceedsDetailsTabClick(){
	$('#modeOfPaymentCharges').empty();

    var options = {
        "" : "SELECT ONE...",
        CASA : "Credit to CASA",
        MC_ISSUANCE : "Issuance to MC",
        SWIFT : "Remittance via SWIFT",
        PDDTS : "Remittance via PDDTS"
    }

//	$('#modeOfPaymentCharges').append("<option selected='selected' value='0'>SELECT ONE...</option>");
//	$('#modeOfPaymentCharges').append("<option value='Credit to Casa'>Credit to CASA</option>");
//	$('#modeOfPaymentCharges').append("<option value='Issuance to MC'>Issuance to MC</option>");
//	$('#modeOfPaymentCharges').append("<option value='Remittance via SWIFT'>Remittance via SWIFT</option>");
//	$('#modeOfPaymentCharges').append("<option value='Remittance via PDDTS'>Remittance via PDDTS</option>");

    $.each(options, function(val, text) {
        $('#modeOfPaymentCharges').append(
            $('<option></option>').val(val).html(text)
        );
    });
}

function onCashLcPaymentTabClick(){
    var options;

	$('#modeOfPaymentCharges').empty();

    insertValues();

    if (serviceType.toLowerCase() == 'negotiation'){
//		$('#modeOfPaymentCharges').append("<option value='Apply MD'>Apply MD</option>");
//		if (documentSubType1.toLowerCase() == 'cash'){
//			// do nothing
//		}else if(documentSubType1.toLowerCase() == 'regular' && documentSubType2.toLowerCase() == 'sight'){
        if(documentSubType1.toLowerCase() == "regular" && documentSubType2.toLowerCase() == "sight") {
			if (documentType.toLowerCase() == 'foreign'){
                options = {
                    IB_LOAN : "IB Loan",
                    TR_LOAN : "TR Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='IB Loan'>IB Loan</option>");
//				$('#modeOfPaymentCharges').append("<option value='TR Loan'>TR Loan</option>");
			}else{
                options = {
                    DBP_LOAN : "DBP Loan",
                    DTR_LOAN : "DTR Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='DBP Loan'>DBP Loan</option>");
//				$('#modeOfPaymentCharges').append("<option value='DTR Loan'>DTR Loan</option>");
			}
		}else if((documentSubType1.toLowerCase() == 'regular' && documentSubType2.toLowerCase() == 'usance')){
			if (documentType.toLowerCase() == 'foreign'){
                options = {
                    TR_LOAN : "TR Loan",
                    UA_LOAN : "UA Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='TR Loan'>TR Loan</option>");
//				$('#modeOfPaymentCharges').append("<option value='UA Loan'>UA Loan</option>");
			}else{
                options = {
                    DTR_LOAN : "DTR Loan",
                    DUA_LOAN : "DUA Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='DTR Loan'>DTR Loan</option>");
//				$('#modeOfPaymentCharges').append("<option value='DUA Loan'>DUA Loan</option>");
			}
		}else {
			if (documentType.toLowerCase() == 'foreign'){
                options = {
                    TR_LOAN : "TR Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='TR Loan'>TR Loan</option>");
			}else{
                options = {
                    DTR_LOAN : "DTR Loan",
                    MD : "Apply MD"
                }
//				$('#modeOfPaymentCharges').append("<option value='DTR Loan'>DTR Loan</option>");
			}
		}
	}else if(serviceType.toLowerCase() == 'ua loan settlement' || serviceType.toLowerCase() == 'ua_loan_settlement'){
		if(documentType.toLowerCase() == 'foreign'){
            $('#modeOfPaymentCharges').empty();

            options = {
                "": "SELECT ONE...",
                TR_LOAN : "TR Loan"
            }

//			$('#modeOfPaymentCharges').append("<option value='TR Loan'>TR Loan</option>")
		}else{
            options = {
                "": "SELECT ONE...",
                DTR_LOAN : "DTR Loan"
            }
//			$('#modeOfPaymentCharges').append("<option value='DTR Loan'>DTR Loan</option>")
		}
	}

    if(options) {
        $.each(options, function(val, text) {
            $('#modeOfPaymentCharges').append(
                $('<option></option>').val(val).html(text)
            );
        });
    }
}

function insertToApModes() {
    var options = {
        CASA : "Debit from CASA",
        MC_ISSUANCE : "Issuance to MC"
    }

    if(options) {
        $.each(options, function(val, text) {
            $('#modeOfPaymentCharges').append(
                $('<option></option>').val(val).html(text)
            );
        });
    }
}

function insertValues(){
    var options = {
        "" : "SELECT ONE...",
        CASA : "Debit from CASA",
        CHECK : "Check",
        CASH : "Cash",
        AP: "Apply AP",
        AR : "Set-up AR",
        REMITTANCE : "Remittance"
    };

    $.each(options, function(val, text) {
        $('#modeOfPaymentCharges').append(
            $('<option></option>').val(val).html(text)
        );
    });

//	$('#modeOfPaymentCharges').append("<option selected='selected' value='0'>SELECT ONE...</option>");
//	$('#modeOfPaymentCharges').append("<option value='Debit from CASA'>Debit from CASA</option>");
//	$('#modeOfPaymentCharges').append("<option value='Check'>Check</option>");
//	$('#modeOfPaymentCharges').append("<option value='Cash'>Cash</option>");
//	$('#modeOfPaymentCharges').append("<option value='Apply AP'>Apply AP</option>");
//	$('#modeOfPaymentCharges').append("<option value='Set-up AR'>Set-up AR</option>");
//	$('#modeOfPaymentCharges').append("<option value='Remittance'>Remittance</option>");
}
