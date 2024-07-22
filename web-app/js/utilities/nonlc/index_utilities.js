function setSettlements(){
    $("#settleFlagCheck").val($("input[name=settleFlag]:checked").val());

    if ($("input[name=settleFlag]:checked").val() == 'Y'){
        $("#productAmount").parents("tr").hide().children("input").attr("disabled", "disabled").toggleClass("required", false);
        $("input[name=cwtFlag]").parents("tr").hide().children("input").attr("disabled", "disabled").toggleClass("required", false);
        $("#settlementMode").parents("tr").hide();
        $("#settlementMode").attr("disabled", "disabled").toggleClass("required", false);
        $("table.settlement_mode").css("display","none").children("input").attr("disabled", "disabled").toggleClass("required", false);

        $("#settlementMode").removeClass("required");
        $(".settlement_mode").hide();
        $("#productAmount").val($("#outstandingAmount").val());
    } else {
        $("#productAmount").parents("tr").show().children("input").removeAttr("disabled").toggleClass("required", true);
        $("input[name=cwtFlag]").parents("tr").show().children("input").removeAttr("disabled").toggleClass("required", true);
        $("#settlementMode").parents("tr").show();
        $("#settlementMode").removeAttr("disabled").toggleClass("required", true);

        $("#settlementMode").addClass("required");
        $(".settlement_mode").show();
    }

    showSettlementMode();
}

$(document).ready(function(){
	//for dm dp settleemnt mode
	if(documentType == 'DOMESTIC'){
		if ($("#settleFlagCheck").val() == 'Y'){
			$("#productAmount").parents("tr").hide().children("input").attr("disabled", "disabled");
			$("input[name=cwtFlag]").parents("tr").hide().children("input").attr("disabled", "disabled");
			$("#settlementMode").parents("tr").hide();
			$("#settlementMode").attr("disabled", "disabled");
			$("table.settlement_mode").css("display","none").children("input").attr("disabled", "disabled");

            $("#settlementMode").removeClass("required");
            $("#productAmount").val($("#outstandingAmount").val());
		} else {
			$("#productAmount").parents("tr").show().children("input").removeAttr("disabled");
			$("input[name=cwtFlag]").parents("tr").show().children("input").removeAttr("disabled");
			$("#settlementMode").parents("tr").show();
			$("#settlementMode").removeAttr("disabled");

            $("#settlementMode").addClass("required");
            if(referenceType.toUpperCase() == "ETS") setSettlements(); //showSettlementMode();
			
		}
		$("input[name=settleFlag]").click(setSettlements);
	}
	
	//for non lc ets settlement mode
	if(serviceType.toUpperCase() == 'SETTLEMENT' || serviceType.toUpperCase() == 'CANCELLATION'){
		$("#amount").focus(function(){
			$(this).blur();
		})
		$("#outstandingAmount").focus(function(){
			$(this).blur();
		})
		if(referenceType.toUpperCase() == "DATA_ENTRY" || referenceType.toUpperCase() == "DATA ENTRY"){
			$("#productAmount").focus(function(){
				$(this).blur();
			})
		}
	}
	if(serviceType.toUpperCase() == 'SETTLEMENT'){
		$(".settlement_mode").hide();
		if($("#settlementMode").length > 0) {
			setSettlementMode();
			showSettlementMode();
			$("#cifNumber").change(setSettlementMode);
			$("#settlementMode").change(showSettlementMode);
            setSettlements();
		}
	}
	
	//for data entry's mt tabs
	//Start of MT400
	if($("form#mt400_DetailsTabForm").length > 0){
		$("#senderIdentifierCodeMt400").attr("readonly", "readonly");
		$("#senderLocationMt400").attr("readonly", "readonly");
		$("#senderNameAndAddressMt400").attr("readonly", "readonly");
		$("#popup_btn_sender_correspondentMt400").hide();
		$("#senderPartyIdentifierMt400").attr("readonly", "readonly");
		
		
		
		//Sender's Correspondent MT400 Validation #1
		$(".sendersCorrespondentMt400OptionLetter").text("a");
		if($(".sendersCorrespondentFlagMt400").length > 0){
		$(".sendersCorrespondentFlagMt400").change(function(){
			if($(this).val() == 'A'){
				$(".sendersCorrespondentMt400OptionLetter").text("A");
				$("#senderIdentifierCodeMt400").removeAttr("readonly");
				$("#senderIdentifierCodeMt400").select2("enable");
				$("#senderLocationMt400").val("");
				$("#senderLocationMt400").attr("readonly", "readonly");
				$("#senderNameAndAddressMt400").val("");
				$("#popup_btn_sender_correspondentMt400").hide();
				$("#senderPartyIdentifierMt400").val("");
				$("#senderPartyIdentifierMt400").attr("readonly", "readonly");

			} else if($(this).val() == 'B'){
				$(".sendersCorrespondentMt400OptionLetter").text("B");				
				$("#senderIdentifierCodeMt400").attr("readonly", "readonly");
				$("#senderIdentifierCodeMt400").select2('data',{id: null});
				$("#senderIdentifierCodeMt400").select2("disable");
				$("#senderLocationMt400").removeAttr("readonly");
				$("#senderNameAndAddressMt400").val("");
				$("#popup_btn_sender_correspondentMt400").hide();
				$("#senderPartyIdentifierMt400").removeAttr("readonly");

			} else if($(this).val() == 'D'){
				$(".sendersCorrespondentMt400OptionLetter").text("D");
				$("#senderIdentifierCodeMt400").attr("readonly", "readonly");
				$("#senderIdentifierCodeMt400").select2('data',{id: null});
				$("#senderIdentifierCodeMt400").select2("disable");
				$("#senderLocationMt400").val("");
				$("#senderLocationMt400").attr("readonly", "readonly");
				$("#popup_btn_sender_correspondentMt400").show();
				$("#senderPartyIdentifierMt400").val("");
				$("#senderPartyIdentifierMt400").attr("readonly", "readonly");

			} 
		});
		}

		$(".orderingBankMt400OptionLetter").text("a");
		$("#bankIdentifierCodeMt400").attr("readonly", "readonly");
		$("#bankNameAndAddressMt400").attr("readonly", "readonly");
		$("#popup_btn_ordering_bankMt400").hide();
	
		if($(".orderingBankFlagMt400").length > 0){
		$(".orderingBankFlagMt400").change(function(){
			$(".orderingBankMt400OptionLetter").text("A");
			if($(this).val() == 'A'){
				$("#bankIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				$("#bankNameAndAddressMt400").val("");
				$("#popup_btn_ordering_bankMt400").hide();
							
			} else if($(this).val() == 'D'){
				$(".orderingBankMt400OptionLetter").text("D");
				$("#bankIdentifierCodeMt400").attr("readonly", "readonly")
				$("#bankIdentifierCodeMt400").select2('data',{id: null});
				$("#bankIdentifierCodeMt400").select2("disable");
				$("#popup_btn_ordering_bankMt400").show();
					
			}
		});
		}
		
		/*$("#receiverIdentifierCode").attr("readonly", "readonly");
		$("#receiverLocation").attr("readonly", "readonly");
		$("#receiverNameAndAddress").attr("readonly", "readonly");
		
		if($(".receiversCorrespondentFlag").length > 0){
		$(".receiversCorrespondentFlag").change(function(){
			if($(this).val() == 'A'){
				$("#receiverIdentifierCode").removeAttr("readonly").select2("enable");
				$("#receiverLocation").val("");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").val("");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
							
			} else if($(this).val() == 'B'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverIdentifierCode").select2('data',{id: null});
				$("#receiverIdentifierCode").select2("disable");
				$("#receiverLocation").removeAttr("readonly");
				$("#receiverNameAndAddress").val("");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
					
			} else if($(this).val() == 'D'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverIdentifierCode").select2('data',{id: null});
				$("#receiverIdentifierCode").select2("disable");
				$("#receiverLocation").val("");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").removeAttr("readonly");
			
			} 
		});
		}*/
		

		$(".receiversCorrespondentMt400OptionLetter").text("a");
		$("#receiverIdentifierCodeMt400").attr("readonly", "readonly");
		$("#receiver400PartyIdentifierMt400").attr("readonly", "readonly");
		$("#receiverLocationMt400").attr("readonly", "readonly");
		$("#receiverNameAndAddressMt400").attr("readonly", "readonly");
		$("#popup_btn_receiver_correspondent_mt400").hide();
		$(".receiversCorrespondentFlagMt400").change(function(){
			if($(this).val() == 'A'){
				$(".receiversCorrespondentMt400OptionLetter").text("A");
				$("#receiverIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				$("#receiver400PartyIdentifierMt400").val("");
				$("#receiver400PartyIdentifierMt400").attr("readonly", "readonly");
				$("#receiverLocationMt400").val("");
				$("#receiverLocationMt400").attr("readonly", "readonly");
				$("#receiverNameAndAddressMt400").val("");
				$("#popup_btn_receiver_correspondent_mt400").hide();
							
			} else if($(this).val() == 'B'){
				$(".receiversCorrespondentMt400OptionLetter").text("B");
				$("#receiverIdentifierCodeMt400").attr("readonly", "readonly");
				$("#receiverIdentifierCodeMt400").select2('data',{id: null});
				$("#receiverIdentifierCodeMt400").select2("disable");
				$("#receiver400PartyIdentifierMt400").removeAttr("readonly");
				$("#receiverLocationMt400").removeAttr("readonly");
				$("#receiverNameAndAddressMt400").val("");
				$("#popup_btn_receiver_correspondent_mt400").hide();
					
			} else if($(this).val() == 'D'){
				$(".receiversCorrespondentMt400OptionLetter").text("D");
				$("#receiverIdentifierCodeMt400").attr("readonly", "readonly");
				$("#receiverIdentifierCodeMt400").select2('data',{id: null});
				$("#receiverIdentifierCodeMt400").select2("disable");
				$("#receiver400PartyIdentifierMt400").val("");
				$("#receiver400PartyIdentifierMt400").attr("readonly", "readonly");
				$("#receiverLocationMt400").val("");
				$("#receiverLocationMt400").attr("readonly", "readonly");
				$("#popup_btn_receiver_correspondent_mt400").show();
			
			} 
		});
		
		
		$("#intermediaryIdentifierCodeMt400").attr("readonly", "readonly");
		$("#intermediaryNameAndAddressMt400").attr("readonly", "readonly");
		$("#popup_btn_intermediaryMt400").hide();
		
		if($(".intermediaryFlagMt400").length > 0){
		$(".intermediaryFlagMt400").change(function(){
			if($(this).val() == 'A'){
				$("#intermediaryIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				$("#intermediaryNameAndAddressMt400").val("");
				$("#popup_btn_intermediaryMt400").hide();
							
			} else if($(this).val() == 'D'){
				$("#intermediaryIdentifierCodeMt400").attr("readonly", "readonly");
				$("#intermediaryIdentifierCodeMt400").select2('data',{id: null});
				$("#intermediaryIdentifierCodeMt400").select2("disable");
				$("#popup_btn_intermediaryMt400").show();
					
			} 
		});
		}

		$(".accountWithBankMt400OptionLetter").text("a");
		$("#accountIdentifierCodeMt400").attr("readonly", "readonly");
		/*$("#accountLocation").attr("readonly", "readonly");*/
		$("#accountNameAndAddressMt400").attr("readonly", "readonly");
		$("#popup_btn_account_with_bankMt400").hide();
		
		if($(".accountWithBankFlagMt400").length > 0){
		$(".accountWithBankFlagMt400").change(function(){
			if($(this).val() == 'A'){
				$(".accountWithBankMt400OptionLetter").text("A");
				$("#accountIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				/*$("#accountLocation").val("");
				$("#accountLocation").attr("readonly", "readonly");*/
				$("#accountNameAndAddressMt400").val("");
				$("#popup_btn_account_with_bankMt400").hide();
							
			/*} else if($(this).val() == 'B'){
				$("#accountIdentifierCode").attr("readonly", "readonly");
				$("#accountIdentifierCode").select2('data',{id: null});
				$("#accountIdentifierCode").select2("disable");
				$("#accountLocation").removeAttr("readonly");
				$("#accountNameAndAddress").val("");
				$("#accountNameAndAddress").attr("readonly", "readonly");*/
					
			} else if($(this).val() == 'D'){
				$(".accountWithBankMt400OptionLetter").text("D");
				$("#accountIdentifierCodeMt400").attr("readonly", "readonly");
				$("#accountIdentifierCodeMt400").select2('data',{id: null});
				$("#accountIdentifierCodeMt400").select2("disable");
				/*$("#accountLocation").val("");
				$("#accountLocation").attr("readonly", "readonly");*/
				$("#popup_btn_account_with_bankMt400").show();
			
			} 
		});
		}

		$(".beneficiaryBankMt400OptionLetter").text("a");
		$("#beneficiaryIdentifierCodeMt400").attr("readonly", "readonly");
		$("#beneficiaryNameAndAddressMt400").attr("readonly", "readonly");
		$("#beneficiaryBankLocationMt400").attr("readonly", "readonly");
		$("#popup_btn_beneficiary_bankMt400").hide();
		
		//Beneficiary Bank MT400 Validation #1
		if($(".beneficiaryBankFlagMt400").length > 0){			
		$(".beneficiaryBankFlagMt400").change(function(){
			if($(this).val() == 'A'){
				$(".beneficiaryBankMt400OptionLetter").text("A");
				$("#beneficiaryIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				$("#beneficiaryBankLocationMt400").val("");
				$("#beneficiaryBankLocationMt400").attr("readonly", "readonly");
				$("#beneficiaryNameAndAddressMt400").val("");
				$("#popup_btn_beneficiary_bankMt400").hide();
							
			} else if($(this).val() == 'B'){
				$(".beneficiaryBankMt400OptionLetter").text("B");
				$("#beneficiaryIdentifierCodeMt400").attr("readonly", "readonly");
				$("#beneficiaryIdentifierCodeMt400").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt400").select2("disable");
				$("#beneficiaryBankLocationMt400").removeAttr("readonly");
				$("#beneficiaryNameAndAddressMt400").val("");
				$("#popup_btn_beneficiary_bankMt400").hide();
			
			} else if($(this).val() == 'D'){
				$(".beneficiaryBankMt400OptionLetter").text("D");
				$("#beneficiaryIdentifierCodeMt400").attr("readonly", "readonly");
				$("#beneficiaryIdentifierCodeMt400").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt400").select2("disable");
				$("#beneficiaryBankLocationMt400").val("");
				$("#beneficiaryBankLocationMt400").attr("readonly", "readonly")
				$("#popup_btn_beneficiary_bankMt400").show();
			} 
		});
		}
		
		//Sender's Correspondent MT400 Validation #2
		if(serviceType == 'Settlement' && referenceType == 'DATA_ENTRY' && (documentClass == 'DA' || documentClass == 'DP')){
			if(sendersCorrespondentFlagMt400 == 'A'){
			$("#senderIdentifierCodeMt400").removeAttr("readonly");
			$("#senderLocationMt400").attr("readonly", "readonly");
//			$("#senderNameAndAddressMt400").attr("readonly", "readonly");
			$("#popup_btn_sender_correspondentMt400").hide();
			$("#senderPartyIdentifierMt400").val("");
			$("#senderPartyIdentifierMt400").attr("readonly", "readonly");
			
			} else if(sendersCorrespondentFlagMt400 == 'B'){
				$("#senderIdentifierCodeMt400").attr("readonly", "readonly");
				$("#senderLocationMt400").removeAttr("readonly");
//				$("#senderNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_sender_correspondentMt400").hide();
				$("#senderPartyIdentifierMt400").removeAttr("readonly");
				
			} else if(sendersCorrespondentFlagMt400 == 'D'){
				$("#senderIdentifierCodeMt400").attr("readonly", "readonly");
				$("#senderLocationMt400").attr("readonly", "readonly");
//				$("#senderNameAndAddressMt400").removeAttr("readonly");
				$("#popup_btn_sender_correspondentMt400").show();
				$("#senderPartyIdentifierMt400").val("");
				$("#senderPartyIdentifierMt400").attr("readonly", "readonly");
				
			} 
			
			if(orderingBankFlagMt400 == 'A'){
				$("#bankIdentifierCodeMt400").removeAttr("readonly");
//				$("#bankNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_ordering_bankMt400").hide();
				
			} else if(orderingBankFlagMt400 == 'D'){
				$("#bankIdentifierCodeMt400").attr("readonly", "readonly");
//				$("#bankNameAndAddressMt400").removeAttr("readonly");
				$("#popup_btn_ordering_bankMt400").show();
				
			}
			
			/*if(receiversCorrespondentFlag == 'A'){
				$("#receiverIdentifierCode").removeAttr("readonly");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
				
			} else if(receiversCorrespondentFlag == 'B'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverLocation").removeAttr("readonly");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
				
			} else if(receiversCorrespondentFlag == 'D'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").removeAttr("readonly");
				
			} */
			

			
			if(receiversCorrespondentFlagMt400 == 'A'){
				$("#receiverIdentifierCodeMt400").removeAttr("readonly");
				$("#receiver400PartyIdentifierMt400").attr("readonly", "readonly");
				$("#receiverLocationMt400").attr("readonly", "readonly");
//				$("#receiverNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_receiver_correspondent_mt400").hide();
				
			} else if(receiversCorrespondentFlagMt400 == 'B'){
				$("#receiverIdentifierCodeMt400").attr("readonly", "readonly");
				$("#receiver400PartyIdentifierMt400").removeAttr("readonly");
				$("#receiverLocationMt400").removeAttr("readonly");
//				$("#receiverNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_receiver_correspondent_mt400").hide();
				
			} else if(receiversCorrespondentFlagMt400 == 'D'){
				$("#receiverIdentifierCodeMt400").attr("readonly", "readonly");
				$("#receiver400PartyIdentifierMt400").attr("readonly", "readonly");
				$("#receiverLocationMt400").attr("readonly", "readonly");
//				$("#receiverNameAndAddressMt400").removeAttr("readonly");
				$("#popup_btn_receiver_correspondent_mt400").show();
				
			} 
			
			if(intermediaryFlagMt400 == 'A'){
				$("#intermediaryIdentifierCodeMt400").removeAttr("readonly");
//				$("#intermediaryNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_intermediaryMt400").hide();
				
			} else if(intermediaryFlagMt400 == 'D'){
				$("#intermediaryIdentifierCodeMt400").attr("readonly", "readonly");
//				$("#intermediaryNameAndAddressMt400").removeAttr("readonly");
				$("#popup_btn_intermediaryMt400").show();
				
			} 
			
			if(accountWithBankFlagMt400 == 'A'){
				$("#accountIdentifierCodeMt400").removeAttr("readonly");
				/*$("#accountLocation").attr("readonly", "readonly");*/
//				$("#accountNameAndAddressMt400").attr("readonly", "readonly");
				$("#popup_btn_account_with_bankMt400").hide();
				
			/*} else if(accountWithBankFlag == 'B'){
				$("#accountIdentifierCode").attr("readonly", "readonly");
				$("#accountLocation").removeAttr("readonly");
				$("#accountNameAndAddress").attr("readonly", "readonly");*/
				
			} else if(accountWithBankFlagMt400 == 'D'){
				$("#accountIdentifierCodeMt400").attr("readonly", "readonly");
				/*$("#accountLocation").attr("readonly", "readonly");*/
//				$("#accountNameAndAddressMt400").removeAttr("readonly");
				$("#popup_btn_account_with_bankMt400").show();
				
			} 
			
			//Beneficiary Bank MT400 Validation #2
			if(beneficiaryBankFlagMt400 == 'A'){	
				$("#beneficiaryIdentifierCodeMt400").removeAttr("readonly").select2("enable");
				$("#beneficiaryBankLocationMt400").val("");
				$("#beneficiaryBankLocationMt400").attr("readonly", "readonly");
				$("#beneficiaryNameAndAddressMt400").val("");
				$("#popup_btn_beneficiary_bankMt400").hide();
				
			} else if(beneficiaryBankFlagMt400 == 'B'){
				$("#beneficiaryIdentifierCodeMt400").attr("readonly", "readonly");
				$("#beneficiaryIdentifierCodeMt400").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt400").select2("disable");
				$("#beneficiaryBankLocationMt400").removeAttr("readonly");
				$("#beneficiaryNameAndAddressMt400").val("");
				$("#popup_btn_beneficiary_bankMt400").hide();
				
			} else if(beneficiaryBankFlagMt400 == 'D'){
				$("#beneficiaryIdentifierCodeMt400").attr("readonly", "readonly");
				$("#beneficiaryIdentifierCodeMt400").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt400").select2("disable");
				$("#beneficiaryBankLocationMt400").val("");
				$("#beneficiaryBankLocationMt400").attr("readonly", "readonly")
				$("#popup_btn_beneficiary_bankMt400").show();
			} 
		}
	} //End of Non-LC MT 400
	
	
	//Start of MT202
	if($("form#mt202_DetailsTabForm").length > 0){
		$(".sendersCorrespondentMt202OptionLetter").text($(".sendersCorrespondentFlagMt202:checked").val());
		$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
		// $("#senderLocationMt202").attr("readonly", "readonly"); -- Enable because it is selected at default (May 29, 2013)
		$("#senderNameAndAddressMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_sender_correspondent").hide();
				
		// Sender's Correspondent MT202 Validation #1
		if($(".sendersCorrespondentFlagMt202").length > 0){
		$(".sendersCorrespondentFlagMt202").change(function(){
			if($(this).val() == 'A'){
				$(".sendersCorrespondentMt202OptionLetter").text("A");
				$("#senderIdentifierCodeMt202").removeAttr("readonly");
				$("#senderIdentifierCodeMt202").select2("enable");
//				$("#senderLocationMt202").val("");
				$("#senderLocationMt202").attr("readonly", "readonly");
//				$("#senderNameAndAddressMt202").val("");
				$("#mt202_popup_btn_sender_correspondent").hide();

			} else if($(this).val() == 'B'){
				$(".sendersCorrespondentMt202OptionLetter").text("B");
				$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#senderIdentifierCodeMt202").select2('data',{id: null});
				$("#senderIdentifierCodeMt202").select2("disable");
				$("#senderLocationMt202").removeAttr("readonly");
//				$("#senderNameAndAddressMt202").val("");
				$("#mt202_popup_btn_sender_correspondent").hide();

			} else if($(this).val() == 'D'){
				$(".sendersCorrespondentMt202OptionLetter").text("D");
				$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#senderIdentifierCodeMt202").select2('data',{id: null});
				$("#senderIdentifierCodeMt202").select2("disable");
//				$("#senderLocationMt202").val("");
				$("#senderLocationMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_sender_correspondent").show();

			} 
		});
		}
		
		$(".orderingBankMt202OptionLetter").text($(".orderingBankFlagMt202:checked").val());
		$("#bankIdentifierCodeMt202").attr("readonly", "readonly");
		$("#bankNameAndAddressMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_ordering_bank").hide();
	
		if($(".orderingBankFlagMt202").length > 0){
		$(".orderingBankFlagMt202").change(function(){
			if($(this).val() == 'A'){
				$(".orderingBankMt202OptionLetter").text("A");
				$("#bankIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#bankNameAndAddressMt202").val("");
				$("#mt202_popup_btn_ordering_bank").hide();
							
			} else if($(this).val() == 'D'){
				$(".orderingBankMt202OptionLetter").text("D");
				$("#bankIdentifierCodeMt202").attr("readonly", "readonly")
//				$("#bankIdentifierCodeMt202").select2('data',{id: null});
				$("#bankIdentifierCodeMt202").select2("disable");
				$("#mt202_popup_btn_ordering_bank").show();
					
			}
		});
		}
		
		/*$("#receiverIdentifierCode").attr("readonly", "readonly");
		$("#receiverLocation").attr("readonly", "readonly");
		$("#receiverNameAndAddress").attr("readonly", "readonly");
		
		if($(".receiversCorrespondentFlag").length > 0){
		$(".receiversCorrespondentFlag").change(function(){
			if($(this).val() == 'A'){
				$("#receiverIdentifierCode").removeAttr("readonly").select2("enable");
				$("#receiverLocation").val("");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").val("");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
							
			} else if($(this).val() == 'B'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverIdentifierCode").select2('data',{id: null});
				$("#receiverIdentifierCode").select2("disable");
				$("#receiverLocation").removeAttr("readonly");
				$("#receiverNameAndAddress").val("");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
					
			} else if($(this).val() == 'D'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverIdentifierCode").select2('data',{id: null});
				$("#receiverIdentifierCode").select2("disable");
				$("#receiverLocation").val("");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").removeAttr("readonly");
			
			} 
		});
		}*/
		
		//Receiver's Correspondent MT202 Validation #1
		$(".receiversCorrespondentMt202OptionLetter").text($(".receiversCorrespondentFlagMt202:checked").val());
		$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
		$("#receiverLocationMt202").attr("readonly", "readonly");
		$("#receiverNameAndAddressMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_receiver_correspondent").hide();
		$("#receiver202PartyIdentifierMt202").attr("readonly", "readonly");

		$(".receiversCorrespondentFlagMt202").change(function(){
			if($(this).val() == 'A'){
				$(".receiversCorrespondentMt202OptionLetter").text("A");
				$("#receiverIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#receiverLocationMt202").val("");
				$("#receiverLocationMt202").attr("readonly", "readonly");
//				$("#receiverNameAndAddressMt202").val("");
				$("#mt202_popup_btn_receiver_correspondent").hide();
//				$("#receiver202PartyIdentifierMt202").val("");
				$("#receiver202PartyIdentifierMt202").attr("readonly", "readonly");
				
			} else if($(this).val() == 'B'){
				$(".receiversCorrespondentMt202OptionLetter").text("B");
				$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#receiverIdentifierCodeMt202").select2('data',{id: null});
				$("#receiverIdentifierCodeMt202").select2("disable");
				$("#receiverLocationMt202").removeAttr("readonly");
//				$("#receiverNameAndAddressMt202").val("");
				$("#mt202_popup_btn_receiver_correspondent").hide();
				$("#receiver202PartyIdentifierMt202").removeAttr("readonly");
				
			} else if($(this).val() == 'D'){
				$(".receiversCorrespondentMt202OptionLetter").text("D");
				$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#receiverIdentifierCodeMt202").select2('data',{id: null});
				$("#receiverIdentifierCodeMt202").select2("disable");
//				$("#receiverLocationMt202").val("");
				$("#receiverLocationMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_receiver_correspondent").show();
//				$("#receiver202PartyIdentifierMt202").val("");
				$("#receiver202PartyIdentifierMt202").attr("readonly", "readonly");
				
			} 
		});
		
		
		$(".intermediaryMt202OptionLetter").text($(".intermediaryFlagMt202:checked").val());
		$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
		$("#intermediaryNameAndAddressMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_intermediary").hide();
		
		if($(".intermediaryFlagMt202").length > 0){
			
			$(".intermediaryFlagMt202").change(function(){
				if($(this).val() == 'A'){
				
					$(".intermediaryMt202OptionLetter").text("A");
					$("#intermediaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//					$("#intermediaryNameAndAddressMt202").val("");
					$("#mt202_popup_btn_intermediary").hide();
							
				} else if($(this).val() == 'D'){
				
					$(".intermediaryMt202OptionLetter").text("D");
					$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
//					$("#intermediaryIdentifierCodeMt202").select2('data',{id: null});
					$("#intermediaryIdentifierCodeMt202").select2("disable");
					$("#mt202_popup_btn_intermediary").show();
					
				} 
			});
		}
		
		//Account With BankValidation #1
		$(".accountWithBankMt202OptionLetter").text($(".accountWithBankFlagMt202:checked").val());
		$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
		$("#accountNameAndAddressMt202").attr("readonly", "readonly");
		$("#mt202_popup_btn_account_with_bank").hide();
		$("#accountWithBankLocationMt202").attr("readonly", "readonly");
		
		if($(".accountWithBankFlagMt202").length > 0){
		$(".accountWithBankFlagMt202").change(function(){
			if($(this).val() == 'A'){
				$(".accountWithBankMt202OptionLetter").text("A");
				$("#accountIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#accountNameAndAddressMt202").val("");
				$("#mt202_popup_btn_account_with_bank").hide();
//				$("#accountWithBankLocationMt202").val("");
				$("#accountWithBankLocationMt202").attr("readonly", "readonly");
							
			} else if($(this).val() == 'B'){
				$(".accountWithBankMt202OptionLetter").text("B");
				$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#accountIdentifierCodeMt202").select2('data',{id: null});
				$("#accountIdentifierCodeMt202").select2("disable");
//				$("#accountNameAndAddressMt202").val("");
				$("#mt202_popup_btn_account_with_bank").hide();
				$("#accountWithBankLocationMt202").removeAttr("readonly");
					
			} else if($(this).val() == 'D'){
				$(".accountWithBankMt202OptionLetter").text("D");
				$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#accountIdentifierCodeMt202").select2('data',{id: null});
				$("#accountIdentifierCodeMt202").select2("disable");
				$("#mt202_popup_btn_account_with_bank").show();
//				$("#accountWithBankLocationMt202").val("");
				$("#accountWithBankLocationMt202").attr("readonly", "readonly");
			
			} 
		});
		}
		
		//Beneficiary Bank MT202 Validation #1
		$(".beneficiaryBankMt202OptionLetter").text($(".beneficiaryBankFlagMt202:checked").val());
		$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
		$("#beneficiaryNameAndAddressMt202").attr("readonly", "readonly");
		if(documentClass != 'DA'){
			$("#mt202_popup_btn_beneficiary_bank").hide();
		}
		$("#beneficiaryBankPartyIDASelectDMt202").attr("disabled","disabled");
		$("#beneficiaryBankPartyIDATextMt202").attr("readonly", "readonly");
		$("#beneficiaryBankPartyIDDSelectDMt202").attr("disabled","disabled");
		$("#beneficiaryBankPartyIDDTextMt202").attr("readonly", "readonly");
		
		if($(".beneficiaryBankFlagMt202").length > 0){
		$(".beneficiaryBankFlagMt202").change(function(){
			if($(this).val() == 'A'){
				$(".beneficiaryBankMt202OptionLetter").text("A");
				$("#beneficiaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#beneficiaryNameAndAddressMt202").val("")
				$("#mt202_popup_btn_beneficiary_bank").hide();
				$("#beneficiaryBankPartyIDASelectDMt202").removeAttr("disabled");
				$("#beneficiaryBankPartyIDATextMt202").removeAttr("readonly");
//				$("#beneficiaryBankPartyIDDSelectDMt202").val("");
				$("#beneficiaryBankPartyIDDSelectDMt202").attr("disabled","disabled");
//				$("#beneficiaryBankPartyIDDTextMt202").val("");
				$("#beneficiaryBankPartyIDDTextMt202").attr("readonly", "readonly");
							
			} else if($(this).val() == 'D'){
				$(".beneficiaryBankMt202OptionLetter").text("D");
				$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#beneficiaryIdentifierCodeMt202").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt202").select2("disable");
				$("#mt202_popup_btn_beneficiary_bank").show();
//				$("#beneficiaryBankPartyIDASelectDMt202").val("");
				$("#beneficiaryBankPartyIDASelectDMt202").attr("disabled","disabled");
//				$("#beneficiaryBankPartyIDATextMt202").val("");
				$("#beneficiaryBankPartyIDATextMt202").attr("readonly", "readonly");
				$("#beneficiaryBankPartyIDDSelectDMt202").removeAttr("disabled");
				$("#beneficiaryBankPartyIDDTextMt202").removeAttr("readonly");
					
			} 
		});
		}
		
		// Sender's Correspondent MT202 Validation #2
		if(serviceType == 'Settlement' && referenceType == 'DATA_ENTRY' && (documentClass == 'DA' || documentClass == 'DP')){
			if(sendersCorrespondentFlagMt202 == 'A'){
			$("#senderIdentifierCodeMt202").removeAttr("readonly");
			$("#senderLocationMt202").attr("readonly", "readonly");
//			$("#senderNameAndAddressMt202").attr("readonly", "readonly");
			$("#mt202_popup_btn_sender_correspondent").hide();
			
			} else if(sendersCorrespondentFlagMt202 == 'B'){
				$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
				$("#senderLocationMt202").removeAttr("readonly");
//				$("#senderNameAndAddressMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_sender_correspondent").hide();
				
			} else if(sendersCorrespondentFlagMt202 == 'D'){
				$("#senderIdentifierCodeMt202").attr("readonly", "readonly");
				$("#senderLocationMt202").attr("readonly", "readonly");
//				$("#senderNameAndAddressMt202").removeAttr("readonly");
				$("#mt202_popup_btn_sender_correspondent").show();
				
			} 
			
			if(orderingBankFlagMt202 == 'A'){
				$("#bankIdentifierCodeMt202").removeAttr("readonly");
//				$("#bankNameAndAddressMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_ordering_bank").hide();
				
			} else if(orderingBankFlagMt202 == 'D'){
				$("#bankIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#bankNameAndAddressMt202").removeAttr("readonly");
				$("#mt202_popup_btn_ordering_bank").show();
				
			}
			
			/*if(receiversCorrespondentFlag == 'A'){
				$("#receiverIdentifierCode").removeAttr("readonly");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
				
			} else if(receiversCorrespondentFlag == 'B'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverLocation").removeAttr("readonly");
				$("#receiverNameAndAddress").attr("readonly", "readonly");
				
			} else if(receiversCorrespondentFlag == 'D'){
				$("#receiverIdentifierCode").attr("readonly", "readonly");
				$("#receiverLocation").attr("readonly", "readonly");
				$("#receiverNameAndAddress").removeAttr("readonly");
				
			} */
			

			//Receiver's Correspondent MT202 Validation #2
			if(receiversCorrespondentFlagMt202 == 'A'){
				$("#receiverIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#receiverLocationMt202").val("");
				$("#receiverLocationMt202").attr("readonly", "readonly");
//				$("#receiverNameAndAddressMt202").val("");
				$("#mt202_popup_btn_receiver_correspondent").hide();
//				$("#receiver202PartyIdentifierMt202").val("");
				$("#receiver202PartyIdentifierMt202").attr("readonly", "readonly");
				
			} else if(receiversCorrespondentFlagMt202 == 'B'){
				$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#receiverIdentifierCodeMt202").select2('data',{id: null});
				$("#receiverIdentifierCodeMt202").select2("disable");
				$("#receiverLocationMt202").removeAttr("readonly");
//				$("#receiverNameAndAddressMt202").val("");
				$("#mt202_popup_btn_receiver_correspondent").hide();
				$("#receiver202PartyIdentifierMt202").removeAttr("readonly");
				
			} else if(receiversCorrespondentFlagMt202 == 'D'){
				$("#receiverIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#receiverIdentifierCodeMt202").select2('data',{id: null});
				$("#receiverIdentifierCodeMt202").select2("disable");
//				$("#receiverLocationMt202").val("");
				$("#receiverLocationMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_receiver_correspondent").show();
//				$("#receiver202PartyIdentifierMt202").val("");
				$("#receiver202PartyIdentifierMt202").attr("readonly", "readonly");
				
			} 
						
			if(intermediaryFlagMt202 == 'A'){
				$("#intermediaryIdentifierCodeMt202").removeAttr("readonly");
//				$("#intermediaryNameAndAddressMt202").attr("readonly", "readonly");
				$("#mt202_popup_btn_intermediary").hide();
				
			} else if(intermediaryFlagMt202 == 'D'){
				$("#intermediaryIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#intermediaryNameAndAddressMt202").removeAttr("readonly");
				$("#mt202_popup_btn_intermediary").show();
				
			} 
			
			//Account With BankValidation #2
			if(accountWithBankFlagMt202 == 'A'){
				$("#accountIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#accountNameAndAddressMt202").val("");
				$("#mt202_popup_btn_account_with_bank").hide();
//				$("#accountWithBankLocationMt202").val("");
				$("#accountWithBankLocationMt202").attr("readonly", "readonly");
				
			} else if(accountWithBankFlagMt202 == 'B'){
				$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#accountIdentifierCodeMt202").select2('data',{id: null});
				$("#accountIdentifierCodeMt202").select2("disable");
//				$("#accountNameAndAddressMt202").val("");
				$("#mt202_popup_btn_account_with_bank").hide();
				$("#accountWithBankLocationMt202").removeAttr("readonly");
				
			} else if(accountWithBankFlagMt202 == 'D'){
				$("#accountIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#accountIdentifierCodeMt202").select2('data',{id: null});
				$("#accountIdentifierCodeMt202").select2("disable");
				$("#mt202_popup_btn_account_with_bank").show();
//				$("#accountWithBankLocationMt202").val("");
				$("#accountWithBankLocationMt202").attr("readonly", "readonly");
				
			} 
			
			//Beneficiary Bank MT202 Validation #2
			if(beneficiaryBankFlagMt202 == 'A'){
				$("#beneficiaryIdentifierCodeMt202").removeAttr("readonly").select2("enable");
//				$("#beneficiaryNameAndAddressMt202").val("")
				$("#mt202_popup_btn_beneficiary_bank").hide();
				$("#beneficiaryBankPartyIDASelectDMt202").removeAttr("disabled");
				$("#beneficiaryBankPartyIDATextMt202").removeAttr("readonly");
//				$("#beneficiaryBankPartyIDDSelectDMt202").val("");
				$("#beneficiaryBankPartyIDDSelectDMt202").attr("disabled","disabled");
//				$("#beneficiaryBankPartyIDDTextMt202").val("");
				$("#beneficiaryBankPartyIDDTextMt202").attr("readonly", "readonly");
				
			} else if(beneficiaryBankFlagMt202 == 'D'){
				$("#beneficiaryIdentifierCodeMt202").attr("readonly", "readonly");
//				$("#beneficiaryIdentifierCodeMt202").select2('data',{id: null});
				$("#beneficiaryIdentifierCodeMt202").select2("disable");
				$("#mt202_popup_btn_beneficiary_bank").show();
//				$("#beneficiaryBankPartyIDASelectDMt202").val("");
				$("#beneficiaryBankPartyIDASelectDMt202").attr("disabled","disabled");
//				$("#beneficiaryBankPartyIDATextMt202").val("");
				$("#beneficiaryBankPartyIDATextMt202").attr("readonly", "readonly");
				$("#beneficiaryBankPartyIDDSelectDMt202").removeAttr("disabled");
				$("#beneficiaryBankPartyIDDTextMt202").removeAttr("readonly");
			} 
		}
	} //End of Non-LC MT 202
	
	//change event for importer cb code in nonlc nego data entry
	if((serviceType.toUpperCase() == 'NEGOTIATION' || serviceType.toUpperCase() == 'NEGOTIATION_ACKNOWLEDGEMENT' || serviceType.toUpperCase() == 'NEGOTIATION ACKNOWLEDGEMENT' || serviceType.toUpperCase() == 'SETTLEMENT')){
		$("#importerCbCode").on("change", function(e){
			$("#importerName").val($("#importerCbCode").select2('data').label);
	        $("#importerAddress").val($("#importerCbCode").select2('data').address);
	        $("#importerCifNumber").val("");
		});
		
		$("#originalPort").on("change", function(e){
			$("#originalPort_bspCode").val($("#originalPort").select2('data').hidden);
		});
	}
});

function setSettlementMode(){
	if($("#cifNumber").val()){
		var check = 0;
		$("#settlementMode").children('option').each(function(){
			if($(this).attr("value") == 'TR'){
				check++;
			}
		});
		if(check == 0){
			$('#settlementMode option[value=Pay]').before('<option>TR</option>');
		}
	} else {
		$("#settlementMode").children('option').each(function(){
			if($(this).attr("value") == 'TR'){
				$(this).remove();
			}
		});
	}
}

function showSettlementMode(){
	if($("#settlementMode").val().indexOf("TR") >= 0 && ($("#mainCifNumber").length > 0 && $("#mainCifNumber").val().length > 0 || $("#mainCifName").length > 0 && $("#mainCifName").val().length > 0)) {
		$(".settlement_mode").show();
	}else {
		$(".settlement_mode").hide();
	}
	
	//to enable/disable settleFlag radio button
//	if(userRole == "BRO") {
//		$("#settleFlag").attr("disabled", "disabled");
//	}else {
//		$("#settleFlag").removeAttr("disabled");
//	}
}