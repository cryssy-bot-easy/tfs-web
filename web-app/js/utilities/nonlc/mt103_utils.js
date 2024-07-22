$(document).ready(function(){
	initMt103Check();
	
	if (documentClass.toUpperCase() == 'DR' || documentClass.toUpperCase() == 'OA' ){

	$(".orderingInstitutionMt103OptionLetter").text("a");
	$("#popup_btn_ordering_bank").hide();
	$("#orderInstIdentifierCode").attr("readonly", "readonly");
	$("#orderInstIdentifierCode").select2('data',{id: null});
	$("#orderInstIdentifierCode").select2("disable");
	$(".orderingBankFlag").change(function(){
		if($(this).val() == 'A'){
			$(".orderingInstitutionMt103OptionLetter").text("A");
			$("#orderInstIdentifierCode").removeAttr("readonly").select2("enable");
			$("#bankNameAndAddress").val("");
			$("#popup_btn_ordering_bank").hide();
										
		} else if($(this).val() == 'D'){
			$(".orderingInstitutionMt103OptionLetter").text("D");
			$("#orderInstIdentifierCode").attr("readonly", "readonly");
			$("#orderInstIdentifierCode").select2('data',{id: null});
			$("#orderInstIdentifierCode").select2("disable");
			$("#popup_btn_ordering_bank").show();
		
		} 
	});		

	$(".sendersCorrespondentMt103OptionLetter").text("a");		
	$("#popup_btn_sender_correspondent").hide();
	$("#senderIdentifierCode").attr("readonly", "readonly");
	$("#sendersLocation").attr("readonly", "readonly");
	$("#senderLocation").attr("readonly", "readonly");
	$("#senderIdentifierCode").select2('data', null);
	$("#senderIdentifierCode").select2("disable");
	$(".sendersCorrespondentFlag").change(function(){
        $("#sendersCorrespondent").val("");

		if($(this).val() == 'A'){
			$(".sendersCorrespondentMt103OptionLetter").text("A");	
			$("#senderIdentifierCode").removeAttr("readonly").select2("enable");
			$("#sendersLocation").val("");
			$("#sendersLocation").attr("readonly", "readonly");
			$("#senderNameAndAddress").val("");
			$("#popup_btn_sender_correspondent").hide();
						
		} else if($(this).val() == 'B'){
			$(".sendersCorrespondentMt103OptionLetter").text("B");	
			$("#senderIdentifierCode").attr("readonly", "readonly");
			$("#senderIdentifierCode").select2('data', null);
			$("#senderIdentifierCode").select2("disable");
			$("#sendersLocation").removeAttr("readonly");			
			$("#senderNameAndAddress").val("");
			$("#popup_btn_sender_correspondent").hide();
				
		} else if($(this).val() == 'D'){
			$(".sendersCorrespondentMt103OptionLetter").text("D");	
			$("#senderIdentifierCode").attr("readonly", "readonly");
			$("#senderIdentifierCode").select2('data', null);
			$("#senderIdentifierCode").select2("disable");
			$("#sendersLocation").val("");
			$("#sendersLocation").attr("readonly", "readonly");
			$("#popup_btn_sender_correspondent").show();
		
		} 
	});

	$(".receiversCorrespondentMt103OptionLetter").text("a");	
	$("#popup_btn_receiver_correspondent").hide();
	$("#receiverCorrIdentifierCode").attr("readonly", "readonly");
	$("#receiverLocation").attr("readonly", "readonly");
	$("#receiverCorrIdentifierCode").select2('data', null);
	$("#receiverCorrIdentifierCode").select2("disable");
	$(".receiversCorrespondentFlag").change(function(){
		if($(this).val() == 'A'){
			$(".receiversCorrespondentMt103OptionLetter").text("A");
			$("#receiverCorrIdentifierCode").removeAttr("readonly").select2("enable");
			$("#receiverLocation").val("");
			$("#receiverLocation").attr("readonly", "readonly");
			$("#receiverNameAndAddress").val("");
			$("#popup_btn_receiver_correspondent").hide();
						
		} else if($(this).val() == 'B'){
			$(".receiversCorrespondentMt103OptionLetter").text("B");
			$("#receiverCorrIdentifierCode").attr("readonly", "readonly");
			$("#receiverCorrIdentifierCode").select2('data', null);
			$("#receiverCorrIdentifierCode").select2("disable");
			$("#receiverLocation").removeAttr("readonly");
			$("#receiverNameAndAddress").val("");
			$("#popup_btn_receiver_correspondent").hide();
				
		} else if($(this).val() == 'D'){
			$(".receiversCorrespondentMt103OptionLetter").text("D");
			$("#receiverCorrIdentifierCode").attr("readonly", "readonly");
			$("#receiverCorrIdentifierCode").select2('data', null);
			$("#receiverCorrIdentifierCode").select2("disable");
			$("#receiverLocation").val("");
			$("#receiverLocation").attr("readonly", "readonly");
			$("#popup_btn_receiver_correspondent").show();
		
		} 
	});

	$(".intermediaryMt103OptionLetter").text("a");	
	$("#popup_btn_intermediary").hide();
	$("#intermedIdentifierCode").attr("readonly", "readonly");
	$("#intermedIdentifierCode").select2('data', null);
	$("#intermedIdentifierCode").select2("disable");
	$(".intermediaryFlag").change(function(){
		if($(this).val() == 'A'){
			$(".intermediaryMt103OptionLetter").text("A");
			$("#intermedIdentifierCode").removeAttr("readonly").select2("enable");
			$("#intermediaryNameAndAddressMt").val("");
			$("#popup_btn_intermediary").hide();
						
				
		} else if($(this).val() == 'D'){
			$(".intermediaryMt103OptionLetter").text("D");
			$("#intermedIdentifierCode").attr("readonly", "readonly");
			$("#intermedIdentifierCode").select2('data', null);
			$("#intermedIdentifierCode").select2("disable");
			$("#popup_btn_intermediary").show();
		
		} 
	});

	$(".accountWithInstitutionMt103OptionLetter").text("a");	
	$("#popup_btn_account_with_bank").hide();
	$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
	$("#acctWithInstPartyIdentifierC").attr("disabled", "true");
	$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
	$("#accountLocation").attr("readonly", "readonly");
	$("#acctWithInstIdentifierCode").select2('data', null);
	$("#acctWithInstIdentifierCode").select2("disable");
	$(".accountWithBankFlag").change(function(){
		if($(this).val() == 'A'){
			$(".accountWithInstitutionMt103OptionLetter").text("A");	
			$("#acctWithInstIdentifierCode").removeAttr("readonly").select2("enable");
			$("#accountLocation").val("");
			$("#accountLocation").attr("readonly", "readonly");
			$("#accountNameAndAddress").val("");
			$("#popup_btn_account_with_bank").hide();
			$("#acctWithInstPartyIdentifierC").attr("disabled", "disabled");
			$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
			$("#acctWithInstPartyIdentifierC").val("");
			$("#acctWithInstPartyIdentifier2").val("");
						
		} else if($(this).val() == 'B'){
			$(".accountWithInstitutionMt103OptionLetter").text("B");	
			$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
			$("#acctWithInstIdentifierCode").select2('data', null);
			$("#acctWithInstIdentifierCode").select2("disable");
			$("#accountLocation").removeAttr("readonly");
			$("#accountNameAndAddress").val("");
			$("#popup_btn_account_with_bank").hide();
			$("#acctWithInstPartyIdentifierC").attr("disabled", "disabled");
			$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
			$("#acctWithInstPartyIdentifierC").val("");
			$("#acctWithInstPartyIdentifier2").val("");
				
		} else if($(this).val() == 'D'){
			$(".accountWithInstitutionMt103OptionLetter").text("D");	
			$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
			$("#acctWithInstIdentifierCode").select2('data', null);
			$("#acctWithInstIdentifierCode").select2("disable");
			$("#accountLocation").val("");
			$("#accountLocation").attr("readonly", "readonly");
			$("#popup_btn_account_with_bank").show();
			$("#acctWithInstPartyIdentifierC").attr("disabled", "disabled");
			$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
			$("#acctWithInstPartyIdentifierC").val("");
			$("#acctWithInstPartyIdentifier2").val("");
		
		} else if($(this).val() == 'C'){		
			$(".accountWithInstitutionMt103OptionLetter").text("C");		
			$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
			$("#acctWithInstIdentifierCode").select2('data', null);
			$("#acctWithInstIdentifierCode").select2("allowClear", false);
			$("#acctWithInstIdentifierCode").select2("disable");
			$("#accountLocation").val("");
			$("#accountLocation").attr("readonly", "readonly");
			$("#popup_btn_account_with_bank").hide();
			$("#acctWithInstPartyIdentifierC").removeAttr("disabled");
			$("#acctWithInstPartyIdentifier2").removeAttr("readonly");
			$("#acctWithInstPartyIdentifier2").val("");
			
	} 
	});
	
	$("#bankOperationCode").change(function(){
		$("#instructionCode").val('');
		$("#bankOperationTextArea").val("");
		$("#bankOperationTextArea").attr("readonly", "readonly")
		switch($(this).val()){
		case 'SPRI':
			$("#instructionCode").removeAttr("disabled");
			$("#instructionCode").children('option').each(function(){
				if($(this).attr('value') != 'SDVA' && $(this).attr('value') != 'INTC' && $(this).attr('value') != '') {
					$(this).remove();
				}
			});
			break;
		case 'SPAY': case 'SSTD':
			$("#instructionCode").attr("disabled", "disabled");
			break;
		default:
			$("#instructionCode").removeAttr("disabled");
			if($("#instructionCode").children('option').length == 3){
				$("#instructionCode").append('<option value="REPA">REPA</option>');
				$("#instructionCode").append('<option value="CORT">CORT</option>');
			};
			break;
		}
	});
	
	$("#instructionCode").change(function(){
		if("" != $(this).val()){
			$("#popup_btn_instruction_code").show();
		} else {
			$("#bankOperationTextArea").val("");
			$("#popup_btn_instruction_code").hide();
		}
	});
	
	initializeMt103DROA();
	}

	if("" != $("#reimbursingBank").val() && (!$(".sendersCorrespondentFlagA").is(":checked")
			&& !$(".sendersCorrespondentFlagD").is(":checked")) && 
			("" == $("#sendersLocation").val() && "" == $("#senderLocation").val())){
		$("#sendersLocation").val($("#reimbursingBank").val());
		$("#senderLocation").val($("#reimbursingBankName").val());
		$(".sendersCorrespondentFlagB").attr("checked","true");
	}
});

function disableEnvelopeContents() {
	if ($("#remittanceInformation").val().length > 0 || $("#remittanceInformationTextArea").val().length > 0 ){
		$("#envelopeContents").attr("disabled", "disabled");
		$("#popup_btn_envelopeContents").hide();
	} else {
		$("#envelopeContents").removeAttr("disabled");
		$("#popup_btn_envelopeContents").show();
	}
}

function initializeMt103DROA() {
	if ($(".orderingBankFlag:checked").val() == 'A') {
		$("#orderInstIdentifierCode").removeAttr("readonly").select2("enable");
		$("#bankNameAndAddress").val("");
		$("#popup_btn_ordering_bank").hide();

	} else if ($(".orderingBankFlag:checked").val() == 'D') {
		$("#orderInstIdentifierCode").attr("readonly", "readonly");
		$("#orderInstIdentifierCode").select2('data', {
			id : ''
		});
		$("#orderInstIdentifierCode").select2("disable");
		$("#popup_btn_ordering_bank").show();

	}

	if ($(".sendersCorrespondentFlag:checked").val() == 'A') {
		$("#senderIdentifierCode").removeAttr("readonly").select2("enable");
		$("#senderLocation").val("");
		$("#senderLocation").attr("readonly", "readonly");
		$("#sendersLocation").val("");
		$("#sendersLocation").attr("readonly", "readonly");
		$("#senderNameAndAddress").val("");
		$("#popup_btn_sender_correspondent").hide();

	} else if ($(".sendersCorrespondentFlag:checked").val() == 'B') {
		$("#senderIdentifierCode").attr("readonly", "readonly");
		$("#senderIdentifierCode").select2('data', {
			id : ''
		});
		$("#senderIdentifierCode").select2("disable");
		$("#senderLocation").removeAttr("readonly");
		$("#sendersLocation").removeAttr("readonly");
		$("#senderNameAndAddress").val("");
		$("#popup_btn_sender_correspondent").hide();

	} else if ($(".sendersCorrespondentFlag:checked").val() == 'D') {
		$("#senderIdentifierCode").attr("readonly", "readonly");
		$("#senderIdentifierCode").select2('data', {
			id : ''
		});
		$("#senderIdentifierCode").select2("disable");
		$("#senderLocation").val("");
		$("#senderLocation").attr("readonly", "readonly");
		$("#sendersLocation").val("");
		$("#sendersLocation").attr("readonly", "readonly");
		$("#popup_btn_sender_correspondent").show();

	}
	
	if ($(".receiversCorrespondentFlag:checked").val() == 'A') {
		$("#receiverCorrIdentifierCode").removeAttr("readonly").select2(
				"enable");
		$("#receiverLocation").val("");
		$("#receiverLocation").attr("readonly", "readonly");
		$("#receiverNameAndAddress").val("");
		$("#popup_btn_receiver_correspondent").hide();

	} else if ($(".receiversCorrespondentFlag:checked").val() == 'B') {
		$("#receiverCorrIdentifierCode").attr("readonly", "readonly");
		$("#receiverCorrIdentifierCode").select2('data', {
			id : ''
		});
		$("#receiverCorrIdentifierCode").select2("disable");
		$("#receiverLocation").removeAttr("readonly");
		$("#receiverNameAndAddress").val("");
		$("#popup_btn_receiver_correspondent").hide();

	} else if ($(".receiversCorrespondentFlag:checked").val() == 'D') {
		$("#receiverCorrIdentifierCode").attr("readonly", "readonly");
		$("#receiverCorrIdentifierCode").select2('data', {
			id : ''
		});
		$("#receiverCorrIdentifierCode").select2("disable");
		$("#receiverLocation").val("");
		$("#receiverLocation").attr("readonly", "readonly");
		$("#popup_btn_receiver_correspondent").show();

	}

	if ($(".intermediaryFlag:checked").val() == 'A') {
		$("#intermedIdentifierCode").removeAttr("readonly").select2("enable");
		$("#intermediaryNameAndAddressMt").val("");
		$("#popup_btn_intermediary").hide();

	} else if ($(".intermediaryFlag:checked").val() == 'D') {
		$("#intermedIdentifierCode").attr("readonly", "readonly");
		$("#intermedIdentifierCode").select2('data', {
			id : ''
		});
		$("#intermedIdentifierCode").select2("disable");
		$("#popup_btn_intermediary").show();

	}

	if ($(".accountWithBankFlag:checked").val() == 'A') {
		$("#acctWithInstIdentifierCode").removeAttr("readonly").select2(
				"enable");
		$("#accountLocation").val("");
		$("#accountLocation").attr("readonly", "readonly");
		$("#accountNameAndAddress").val("");
		$("#popup_btn_account_with_bank").hide();
		$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
		$("#acctWithInstPartyIdentifier2").val("");

	} else if ($(".accountWithBankFlag:checked").val() == 'B') {
		$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
		$("#acctWithInstIdentifierCode").select2('data', {
			id : ''
		});
		$("#acctWithInstIdentifierCode").select2("disable");
		$("#accountLocation").removeAttr("readonly");
		$("#accountNameAndAddress").val("");
		$("#popup_btn_account_with_bank").hide();
		$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
		$("#acctWithInstPartyIdentifier2").val("");

	} else if ($(".accountWithBankFlag:checked").val() == 'D') {
		$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
		$("#acctWithInstIdentifierCode").select2('data', {
			id : ''
		});
		$("#acctWithInstIdentifierCode").select2("disable");
		$("#accountLocation").val("");
		$("#accountLocation").attr("readonly", "readonly");
		$("#popup_btn_account_with_bank").show();
		$("#acctWithInstPartyIdentifier2").attr("readonly", "readonly");
		$("#acctWithInstPartyIdentifier2").val("");

	} else if ($(".accountWithBankFlag:checked").val() == 'C') {
		
				
		$("#acctWithInstIdentifierCode").attr("readonly", "readonly");
		$("#acctWithInstIdentifierCode").select2('data', {
			id : ''
		});

		$("#acctWithInstPartyIdentifierC").removeAttr("disabled");
		$("#acctWithInstIdentifierCode").select2("disable");
		$("#accountLocation").val("");
		$("#accountLocation").attr("readonly", "readonly");
		$("#popup_btn_account_with_bank").hide();
		$("#acctWithInstPartyIdentifier2").removeAttr("readonly");
	}

	switch ($("#bankOperationCode").val()) {
	case 'SPRI':
		$("#instructionCode").removeAttr("disabled");
		$("#instructionCode").children('option').each(
				function() {
					if ($(this).attr('value') != 'SDVA'
							&& $(this).attr('value') != 'INTC'
							&& $(this).attr('value') != '') {
						$(this).remove();
					}
				});
		break;
	case 'SPAY':
	case 'SSTD':
		$("#instructionCode").attr("disabled", "disabled");
		break;
	default:
		$("#instructionCode").removeAttr("disabled");
		if ($("#instructionCode").children('option').length == 3) {
			$("#instructionCode").append('<option value="REPA">REPA</option>');
			$("#instructionCode").append('<option value="CORT">CORT</option>');
		}
		;
		break;
	}

	if ("" != $("#instructionCode").val()) {
		$("#popup_btn_instruction_code").show();
	} else {
		$("#bankOperationTextArea").val("");
		$("#popup_btn_instruction_code").hide();
	}
}

function initMt103Check(){
	$("#bankOperationTextArea").attr("readonly", "readonly")
	switch($("#bankOperationCode").val()){
	case 'SPRI':
		$("#instructionCode").removeAttr("disabled");
		$("#instructionCode").children('option').each(function(){
			if($(this).attr('value') != 'SDVA' && $(this).attr('value') != 'INTC' && $(this).attr('value') != '') {
				$(this).remove();
			}
		});
		break;
	case 'SPAY': case 'SSTD':
		$("#instructionCode").attr("disabled", "disabled");
		break;
	default:
		$("#instructionCode").removeAttr("disabled");
		if($("#instructionCode").children('option').length == 3){
			$("#instructionCode").append('<option value="REPA">REPA</option>');
			$("#instructionCode").append('<option value="CORT">CORT</option>');
		};
		break;
	}
	if($("#instructionCode").val() == 'REPA'){
		$("#bankOperationTextArea").removeAttr("readonly");
	} else {
		$("#bankOperationTextArea").val("");
		$("#bankOperationTextArea").attr("readonly", "readonly")
	}
}
