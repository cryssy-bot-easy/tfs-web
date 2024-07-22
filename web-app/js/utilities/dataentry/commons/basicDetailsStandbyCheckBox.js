$(document).ready(function standbyEnabledThis(){

	var senderToReaceiverVal = $("#senderToReceiverInformationFrom").val();
	
	if(document.basicForm.expiryCountryCode.checked==true){
		$("#expiryCountryCodeTo").removeAttr("disabled","true");		
	}else{
		$("#expiryCountryCodeTo").attr("disabled","true");	
	}
	
	if(document.basicForm.formOfDocumentaryCredit.checked==true){
		$("#formOfDocumentaryCreditTo").removeAttr("disabled","true");		
	}else{
		$("#formOfDocumentaryCreditTo").attr("disabled","true");	
	}
	
	if(document.basicForm.destinationBank.checked==true){
		$("#destinationBankTo").removeAttr("disabled","true");		
	}else{
		$("#destinationBankTo").attr("disabled","true");	
	}
	
	if(document.basicForm.applicableRules.checked==true){
		$("#applicableRulesTo").removeAttr("disabled","true");		
	}else{
		$("#applicableRulesTo").attr("disabled","true");	
	}
	
	if(document.basicForm.fxlcExpiryDate.checked==true){
		$("#fxlcExpiryDateTo").removeAttr("readonly","readonly");		
	}else{
		$("#fxlcExpiryDateTo").attr("readonly","readonly");	
	}
	
	if(document.basicForm.senderToReceiver.checked==true){
		$("#senderReceiverSelectTo").removeAttr("disabled","true");
		$("#senderToReceiverInformationTo").removeAttr("readonly","readonly");	
		$("#senderToReceiverInformationTo").val(senderToReaceiverVal);
	}else{
		$("#senderReceiverSelectTo").attr("disabled","true");
		$("#senderToReceiverInformationTo").attr("readonly","readonly");	
	}
	
});

