$(document).ready(function (){
	
	$(".disableMe").attr("readonly","readonly");
	$(".disableThis").attr("readonly","readonly");
	$(".disableThis2").attr("disabled","disabled");
	
	$("input[name=remitCorresCharges]").click(function (){
		if ($("input[name=remitCorresCharges]:checked").val() == 'N'){

			$(".disableMe").attr("readonly","readonly");
			$(".disableThis").attr("readonly","readonly");
			$(".disableThis2").attr("disabled","disabled");
			
		}else{		
			$(".disableThis").removeAttr("readonly","readonly");
			$(".disableThis2").removeAttr("disabled","disabled");
		}
		
	});
	
	$("#intermediary").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeIntermediary').removeAttr("readonly");
			$('#nameAddressIntermediary').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressIntermediary').removeAttr("readonly");
			$('#identifierCodeIntermediary').attr("readonly","readonly");
		}else{
			$('#identifierCodeIntermediary').attr("readonly","readonly");
			$('#nameAddressIntermediary').attr("readonly","readonly");
		}
	
	});
	
	$("#benificiaryInstitution").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeBeneficiaryInstitution').removeAttr("readonly");
			$('#nameAddressBeneficiaryInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressBeneficiaryInstitution').removeAttr("readonly");
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
			$('#nameAddressBeneficiaryInstitution').attr("readonly","readonly");
		}
	
	});
	
	$("#accountWithInstitution").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeAccountInstitution').removeAttr("readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}
		
	});
	
	$("#sendersCorrespondent").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeSenderCorrespond').removeAttr("readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}
		
	});
	
	$("#receiverCorrespondent").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeReceiverCorrespond').removeAttr("readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}
	
	});

	
});