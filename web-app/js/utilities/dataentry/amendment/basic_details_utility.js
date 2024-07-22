$(document).ready(function (){

	//for standby only
	
	if(documentSubType1 == "STANDBY"){
		
			var senderToReaceiverVal = $("#senderToReceiverInformationFrom").val();
			
			$("#lcAmountTo").attr("readonly","readonly");
			$("#expiryCountryCodeTo").attr("disabled","true");
			$("#formDocuCreditTo").attr("disabled","true");
			$("#destinationBankTo").attr("disabled","true");
			$("#applicableRulesTo").attr("disabled","true");
	//		$("#lcExpiryDateTo").attr("readonly","readonly");
			$("#senderReceiverSelectTo").attr("disabled","true");
			$("#senderToReceiverInformationTo").attr("readonly","readonly");
			
			
			
			$("#expiryCountryCodeRow").click(function(){
				if($("#expiryCountryCodeRow").attr("checked") == "checked"){
					$("#expiryCountryCodeTo").removeAttr("disabled","true");
				}else{
					$("#expiryCountryCodeTo").attr("disabled","true");
				}
				
			});
			
			$("#formDocuCreditRow").click(function(){
				if($("#formDocuCreditRow").attr("checked") == "checked"){
					$("#formDocuCreditTo").removeAttr("disabled","true");
				}else{
					$("#formDocuCreditTo").attr("disabled","true");
				}
				
			});
			
			$("#destinationBankRow").click(function(){
				if($("#destinationBankRow").attr("checked") == "checked"){
					$("#destinationBankTo").removeAttr("disabled","true");
				}else{
					$("#destinationBankTo").attr("disabled","true");
				}
				
			});
			
			$("#applicableRulesRow").click(function(){
				if($("#applicableRulesRow").attr("checked") == "checked"){
					$("#applicableRulesTo").removeAttr("disabled","true");
				}else{
					$("#applicableRulesTo").attr("disabled","true");
				}
				
			});
			
			
			$("#senderToReceiverRow").click(function(){
				if($("#senderToReceiverRow").attr("checked") == "checked"){
					$("#senderReceiverSelectTo").removeAttr("disabled","true");
					$("#senderToReceiverInformationTo").removeAttr("readonly","readonly");	
					$("#senderToReceiverInformationTo").val(senderToReaceiverVal);
				}else{
					$("#senderReceiverSelectTo").attr("disabled","true");
					$("#senderToReceiverInformationTo").attr("readonly","readonly");
				}
			});
			
	//for cash and regular
	}else{
		
			$("#lcAmountTo").attr("readonly","readonly");
			$("#expiryCountryCodeTo").attr("disabled","true");
			$("#destinationBankTo").attr("disabled","true");
			$("#tenorTo").attr("disabled","true");
			$("#applicableRulesTo").attr("disabled","true");
			$("#confirmationInstructionTo1").attr("disabled","true");	
			$("#confirmationInstructionTo2").attr("disabled","true");
			$("#confirmingBankTo").attr("disabled","true");
			$("#fxlcExpiryDateTo").removeAttr("readonly","readonly");
			$("#formDocuCreditTo").attr("disabled","true");
			$("#tenorNarrative").attr("readonly","readonly");
			
			$(".advising_bank_hide").hide();
		
			$("#lcAmountRow").click(function (){
				if($("#lcAmountRow").attr("checked") == "checked"){
					$("#lcAmountTo").removeAttr("readonly","readonly");	
				}else{
					$("#lcAmountTo").attr("readonly","readonly");
				}
			});
			
			$("#expiryCountryCodeRow").click(function (){
				if($("#expiryCountryCodeRow").attr("checked") == "checked"){
					$("#expiryCountryCodeTo").removeAttr("disabled","true");	
				}else{
					$("#expiryCountryCodeTo").attr("disabled","true");
				}
			});
			
			$("#destinationBankRow").click(function (){
				if($("#destinationBankRow").attr("checked") == "checked"){
					$("#destinationBankTo").removeAttr("disabled","true");	
				}else{
					$("#destinationBankTo").attr("disabled","true");
				}
			});
		
			$("#tenorRow").click(function (){
				if($("#tenorRow").attr("checked") == "checked"){
					$("#tenorTo").removeAttr("disabled","true");
					$("#tenorNarrative").removeAttr("readonly","readonly");
				}else{
					$("#tenorTo").attr("disabled","true");
					$("#tenorNarrative").attr("readonly","readonly");
				}
			});
			
			$("#applicableRulesRow").click(function (){
				if($("#applicableRulesRow").attr("checked") == "checked"){
					$("#applicableRulesTo").removeAttr("disabled","true");	
				}else{
					$("#applicableRulesTo").attr("disabled","true");
				}
			});
		
			
			$("#confirmationInstructionRow").click(function (){
				if($("#confirmationInstructionRow").attr("checked") == "checked"){
					$("#confirmationInstructionTo1").removeAttr("disabled","true");
					$("#confirmationInstructionTo2").removeAttr("disabled","true");
					$("#confirmingBankTo").removeAttr("disabled","true");	
				}else{
					$("#confirmationInstructionTo1").attr("disabled","true");	
					$("#confirmationInstructionTo2").attr("disabled","true");
					$("#confirmingBankTo").attr("disabled","true");
				}
			});
			
			$("#fxlcExpiryDateRow").click(function (){
				if($("#fxlcExpiryDateRow").attr("checked") == "checked"){
					$("#fxlcExpiryDateTo").removeAttr("readonly","readonly");	
				}else{
					$("#fxlcExpiryDateTo").removeAttr("readonly","readonly");
				}
			});
			
			$("#formDocuCreditRow").click(function (){
				if($("#formDocuCreditRow").attr("checked") == "checked"){
					$("#formDocuCreditTo").removeAttr("disabled","true");	
				}else{
					$("#formDocuCreditTo").attr("disabled","true");
				}
			});
	
		
			//for tenor
			var tenorToValue = $("#tenorTo");
			
				$("#tenorTo").change(function (){
					if(tenorToValue.val().toLowerCase() == "sight"){
						$("#tenorNarrative").hide();
					}else{
						$("#tenorNarrative").show();
					}
				});
			
			
			//confirmation instruction
			$("#confirmationInstructionFrom").change(function (){
				
				if($("#confirmationInstructionFrom").val().toLowerCase() == "yes"){
					$("#confirmationInstructionTo2").hide();
					$("#confirmationInstructionTo1").show();
				}else{
					$("#confirmationInstructionTo2").show();
					$("#confirmationInstructionTo1").hide();
				}
			});
		
			
			//if may add will be selected
			var confirmationInstructionValue1 = $("#confirmationInstructionTo1");
			var confirmationInstructionValue2 = $("#confirmationInstructionTo2");
			
			$("#confirmationInstructionTo1").change(function(){
				if(confirmationInstructionValue1.val().toLowerCase() == "may add"){
					$(".advising_bank_hide").show();
				}else{
					$(".advising_bank_hide").hide();
				}
			});
			
			$("#confirmationInstructionTo2").change(function(){
				if(confirmationInstructionValue2.val().toLowerCase() == "may add"){
					$(".advising_bank_hide").show();
				}else{
					$(".advising_bank_hide").hide();
				}
				
			});
		
			//for loading the page
			var confirmationValue = $("#confirmationInstructionHidden");
			
			if(confirmationValue.val().toLowerCase() == "yes"){
				$("#confirmationInstructionTo2").show();
				$("#confirmationInstructionTo1").hide();
			}else{
				$("#confirmationInstructionTo2").hide();
				$("#confirmationInstructionTo1").show();
			}
		
	}// for cash and regular end
	
	
	//for applicable rule
	var applicableValue = $("#applicableRulesTo");
	
	$(".other_rule_hide").hide();
	
	$("#applicableRulesTo").change(function (){
		if(applicableValue.val().toLowerCase() == "others"){
			$(".other_rule_hide").show();
		}else{
			$(".other_rule_hide").hide();
		}
	});
	
	
});