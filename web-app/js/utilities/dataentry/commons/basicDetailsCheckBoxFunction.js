$(document).ready(function checkThis(){

	if(document.basicDetailsTabForm.fxlcAmountRow.checked==true){
		$("#fxlcAmountTo").removeAttr("readonly","readonly");		
	}else{
		$("#fxlcAmountTo").attr("readonly","readonly");	
	}
	
	if(document.basicDetailsTabForm.expiryCountryCodeRow.checked==true){
		$("#expiryCountryCodeTo").removeAttr("disabled","true");		
	}else{
		$("#expiryCountryCodeTo").attr("disabled","true");	
	}
	
	if(document.basicDetailsTabForm.destinationBankRow.checked==true){
		$("#destinationBankTo").removeAttr("disabled","true");		
	}else{
		$("#destinationBankTo").attr("disabled","true");	
	}
	
	if(document.basicDetailsTabForm.tenorRow.checked==true){
		$("#tenorTo").removeAttr("disabled","true");		
	}else{
		$("#tenorTo").attr("disabled","true");	
	}
	
	if(document.basicDetailsTabForm.applicableRulesRow.checked==true){
		$("#applicableRulesTo").removeAttr("disabled","true");		
	}else{
		$("#applicableRulesTo").attr("disabled","true");	
	}
	
	if(document.basicDetailsTabForm.confirmationInstructionRow.checked==true){
		$("#confirmationInstructionTo1").removeAttr("disabled","true");
		$("#confirmationInstructionTo2").removeAttr("disabled","true");
		$("#confirmingBankTo").removeAttr("disabled","true");
	}else{
		$("#confirmationInstructionTo1").attr("disabled","true");	
		$("#confirmationInstructionTo2").attr("disabled","true");
		$("#confirmingBankTo").attr("disabled","true");
	}
	
	if(document.basicDetailsTabForm.fxlcExpiryDateRow.checked==true){
		$("#fxlcExpiryDateTo").removeAttr("readonly","readonly");
	}else{
		$("#fxlcExpiryDateTo").attr("readonly","readonly");	
	}
	
	if(document.basicDetailsTabForm.formDocuCreditRow.checked==true){
		$("#formDocuCreditTo").removeAttr("disabled","true");		
	}else{
		$("#formDocuCreditTo").attr("disabled","true");	
	}


});

//function onViewMt752()(
//		alert('helo');
//		location.href = view_mt_752;
//)
//
//function onViewMt202()(
//		location.href = view_mt_202;
//)