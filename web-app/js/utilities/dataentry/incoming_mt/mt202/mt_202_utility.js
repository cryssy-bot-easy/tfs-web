function onChangeOrderingInstitution() {
	var orderingBankFlagMt202 = $("input[type=radio][name=orderingBankFlagMt202]:checked").val();
	
	if(orderingBankFlagMt202 == "A") {
		$("#bankIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#mt202_popup_btn_ordering_bank").hide();
		$(".orderingBankFlagMt202Mt752202OptionLetter").text("A");
	} else {
		$("#bankIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#mt202_popup_btn_ordering_bank").show();
		$(".orderingBankFlagMt202Mt752202OptionLetter").text("D");
	}
}

function onChangeSendersCorrespondent() {
	var sendersCorrespondentFlagMt202 = $("input[type=radio][name=sendersCorrespondentFlagMt202]:checked").val();
	
	if(sendersCorrespondentFlagMt202 == "A") {
		$("#senderIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#senderLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_ordering_bank").hide();
		$(".sendersCorrespondentFlagMt202Mt752202OptionLetter").text("A");
	} else if(sendersCorrespondentFlagMt202 == "B") {
		$("#senderIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#senderLocationMt202").removeAttr("readonly");
		$("#mt202_popup_btn_sender_correspondent").hide();
		$(".sendersCorrespondentFlagMt202Mt752202OptionLetter").text("B");
	} else {
		$("#senderIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#senderLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_sender_correspondent").show();
		$(".sendersCorrespondentFlagMt202Mt752202OptionLetter").text("D");
	}
}

function onChangeReceiversCorrespondent() {
	var receiversCorrespondentFlagMt202 = $("input[type=radio][name=receiversCorrespondentFlagMt202]:checked").val();
	
	if(receiversCorrespondentFlagMt202 == "A") {
		$("#receiverIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#receiverLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_receiver_correspondent").hide();
		$(".receiversCorrespondentFlagMt202Mt752202OptionLetter").text("A");
	} else if(receiversCorrespondentFlagMt202 == "B") {
		$("#receiverIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#receiverLocationMt202").removeAttr("readonly");
		$("#mt202_popup_btn_receiver_correspondent").hide();
		$(".receiversCorrespondentFlagMt202Mt752202OptionLetter").text("B");
	} else {
		$("#receiverIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#receiverLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_receiver_correspondent").show();
		$(".receiversCorrespondentFlagMt202Mt752202OptionLetter").text("D");
	}
}

function onChangeIntermidiary() {
	var intermediaryFlagMt202 = $("input[type=radio][name=intermediaryFlagMt202]:checked").val();
	
	if(intermediaryFlagMt202 == "A") {
		$("#intermediaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#mt202_popup_btn_intermediary").hide();
		$(".intermediaryMt202OptionLetter").text("A");
	} else {
		$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#mt202_popup_btn_intermediary").show();
		$(".intermediaryMt202OptionLetter").text("D");
	}
}

function onChangeAccountWithInstitution() {
	var accountWithBankFlagMt202 = $("input[type=radio][name=accountWithBankFlagMt202]:checked").val();
	
	if(accountWithBankFlagMt202 == "A") {
		$("#accountIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#accountWithBankLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_account_with_bank").hide();
		$(".accountWithInstitutionMt202OptionLetter").text("A");
	} else if(accountWithBankFlagMt202 == "B") {
		$("#accountIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#accountWithBankLocationMt202").removeAttr("readonly");
		$("#mt202_popup_btn_account_with_bank").hide();
		$(".accountWithInstitutionMt202OptionLetter").text("B");
	} else {
		$("#accountIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#accountWithBankLocationMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_account_with_bank").show();
		$(".accountWithInstitutionMt202OptionLetter").text("D");
	}
}

function onChangeBeneficiaryBank() {
	var beneficiaryBankFlagMt202 = $("input[type=radio][name=beneficiaryBankFlagMt202]:checked").val();
	if(beneficiaryBankFlagMt202 == "A") {
		$("#beneficiaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
		$("#mt202_popup_btn_beneficiary_bank").hide();
		$(".beneficiaryInstitutionMt202OptionLetter").text("A");
	} else {
		$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
		$("#mt202_popup_btn_beneficiary_bank").show();
		$(".beneficiaryInstitutionMt202OptionLetter").text("D");
	}
}

$(document).ready(function(){
	$(".display-mt202").hide();
	
//	$("#bankIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
	onChangeOrderingInstitution();
	$("#mt202_popup_btn_ordering_bank").hide();
	$("input[type=radio][name=orderingBankFlagMt202]").change(onChangeOrderingInstitution);
	
//	$("#senderIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
//	$("#senderLocationMt202").attr("readonly", "readonly");
	onChangeSendersCorrespondent();
	$("#mt202_popup_btn_sender_correspondent").hide();
	$("input[type=radio][name=sendersCorrespondentFlagMt202]").change(onChangeSendersCorrespondent);
	
	$("#receiverIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
	$("#receiverLocationMt202").attr("readonly", "readonly");
	$("#mt202_popup_btn_receiver_correspondent").hide();
	$("input[type=radio][name=receiversCorrespondentFlagMt202]").change(onChangeReceiversCorrespondent);
	
	$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
	$("#mt202_popup_btn_intermediary").hide();
	$("input[type=radio][name=intermediaryFlagMt202]").change(onChangeIntermidiary);
	
	$("#accountIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
	$("#accountWithBankLocationMt202").attr("readonly", "readonly");
	$("#mt202_popup_btn_account_with_bank").hide();
	$("input[type=radio][name=accountWithBankFlagMt202]").change(onChangeAccountWithInstitution);
	
//	$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly").select2("disable");
	onChangeBeneficiaryBank();
	$("#mt202_popup_btn_beneficiary_bank").hide();
	$("input[type=radio][name=beneficiaryBankFlagMt202]").change(onChangeBeneficiaryBank);
	
    $("#bankIdentifierCodeMt202, #bankNameAndAddressMt202").each(function(){
        $(this).change(function() {
        	if($("input[name=orderingBankFlagMt202]:checked").length > 0) {
        		
        	}
        });
    });

    $("#senderIdentifierCodeMt202, #senderLocationMt202, #senderNameAndAddressMt202").each(function(){
        $(this).change(function() {
            if ($("#senderIdentifierCodeMt202").val() != "" ||
                    $("#senderLocationMt202").val() != "" ||
                    $("#senderNameAndAddressMt202").val() != "") {
                $("#senderCorrespondentComplete").val("true");
            } else {
                $("#senderCorrespondentComplete").val("");
            }
        });
    });

    $("#receiverIdentifierCodeMt202, #receiverLocationMt202, #receiverNameAndAddressMt202").each(function(){
        $(this).change(function() {
            if ($("#receiverIdentifierCodeMt202").val() != "" ||
                    $("#receiverLocationMt202").val() != "" ||
                    $("#receiverNameAndAddressMt202").val() != "") {
                $("#receiversCorrespondentFlagMt202Complete").val("true");
            } else {
                $("#receiversCorrespondentFlagMt202Complete").val("");
            }
        });
    });

    $("#intermediaryIdentifierCodeMt202, #intermediaryNameAndAddressMt202").each(function(){
        $(this).change(function() {
            if ($("#intermediaryIdentifierCodeMt202").val() != "" ||
                    $("#intermediaryNameAndAddressMt202").val() != "") {
                $("#intermediaryComplete").val("true");
            } else {
                $("#intermediaryComplete").val("");
            }
        });
    });

    $("#accountIdentifierCodeMt202, #accountWithBankLocationMt202, #accountNameAndAddressMt202").each(function(){
        $(this).change(function() {
            if ($("#accountIdentifierCodeMt202").val() != "" ||
                    $("#accountWithBankLocationMt202").val() != "" ||
                    $("#accountNameAndAddressMt202").val() != "") {
                $("#accountWithInstitutionComplete").val("true");
            } else {
                $("#accountWithInstitutionComplete").val("");
            }
        });
    });

    $("#beneficiaryIdentifierCodeMt202, #beneficiaryNameAndAddressMt202").each(function(){
        $(this).change(function() {
            if ($("#beneficiaryIdentifierCodeMt202").val() != "" ||
                $("#beneficiaryNameAndAddressMt202").val() != "") {
            $("#beneficiaryInstitutionComplete").val("true");
        } else {
            $("#beneficiaryInstitutionComplete").val("");
        }
    	});
    });

    // save buttons
    $("#saveConfirmMt202").click(function() {
    	var mt202HasErrors=false;
    	
    	if($("input[name=orderingBankFlagMt202]:checked").length > 0) {
	    	switch($("input[name=orderingBankFlagMt202]:checked").val()){
			case "A":
				if("" == $("#bankIdentifierCodeMt202").val()){
					mt202HasErrors = true;
				}
				break;
			case "D":
				if("" == $("#bankNameAndAddressMt202").val()){
					mt202HasErrors = true;
				}
				break;
			default:
				mt202HasErrors = true;
	    	};
    	}else{
    		mt202HasErrors = true;
    	}
    	
       	if($("input[name=beneficiaryBankFlagMt202]:checked").length > 0) {
	    	switch($("input[name=beneficiaryBankFlagMt202]:checked").val()){
			case "A":
				if("" == $("#beneficiaryIdentifierCodeMt202").val()){
					mt202HasErrors = true;
				}
				break;
			case "D":
				if("" == $("#beneficiaryNameAndAddressMt202").val()){
					mt202HasErrors = true;
				}
				break;
			default:
				mt202HasErrors = true;
	    	};
    	}else{
    		mt202HasErrors = true;
    	}
    	
    	
    	
        if(validateExportTab("#mt202TabForm") > 0 || mt202HasErrors){
            $("#alertMessage").text("Please fill in all the required fields.");
            triggerAlert();
        } else {
            $(".saveAction").show();
            $(".cancelAction").hide();
            $("#mt202TabForm").submit();
        }
    });

    $("#cancelConfirmMt202").click(function() {
        $(".saveAction").hide();
        $(".cancelAction").show();
        mCenterPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
        mLoadPopup($("#basicDetailsDiv"), $("#basicDetailsBg"));
    });
	
});	



