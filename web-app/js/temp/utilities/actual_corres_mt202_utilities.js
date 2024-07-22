$(document).ready(function (){
	
	$("input[name=accountWithInstitutionOption]").change(function(){
		if($(this).val()=="A"){
			$('#identifierCodeAccountInstitution').removeAttr("readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAndAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="B"){
			$('#locationAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#nameAndAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="D"){
			$('#nameAndAddressAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAndAddressAccountInstitution').attr("readonly","readonly");
		}
		
	});
	
	$("input[name=sendersCorrespondentOption]").change(function(){
		if($(this).val()=="A"){
			$('#identifierCodeSenderCorrespond').removeAttr("readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAndAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="B"){
			$('#locationSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#nameAndAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="D"){
			$('#nameAndAddressSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAndAddressSenderCorrespond').attr("readonly","readonly");
		}
		
	});
	
	$("input[name=receiverCorrespondentOption]").change(function(){
		if($(this).val()=="A"){
			$('#identifierCodeReceiverCorrespond').removeAttr("readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAndAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="B"){
			$('#locationReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#nameAndAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="D"){
			$('#nameAndAddressReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAndAddressReceiverCorrespond').attr("readonly","readonly");
		}
	
	});
	
	$("input[name=intermediaryOption]").change(function(){
		if($(this).val()=="A"){
			$('#identifierCodeIntermediary').removeAttr("readonly");
			$('#nameAndAddressIntermediary').attr("readonly","readonly");
		}else if($(this).val()=="D"){
			$('#nameAndAddressIntermediary').removeAttr("readonly");
			$('#identifierCodeIntermediary').attr("readonly","readonly");
		}else{
			$('#identifierCodeIntermediary').attr("readonly","readonly");
			$('#nameAndAddressIntermediary').attr("readonly","readonly");
		}
	
	});
	
	$("input[name=benificiaryInstitutionOption]").change(function(){
		if($(this).val()=="A"){
			$('#identifierCodeBeneficiaryInstitution').removeAttr("readonly");
			$('#nameAndAddressBeneficiaryInstitution').attr("readonly","readonly");
		}else if($(this).val()=="D"){
			$('#nameAndAddressBeneficiaryInstitution').removeAttr("readonly");
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
			$('#nameAndAddressBeneficiaryInstitution').attr("readonly","readonly");
		}
	
	});
	
	
	
	//textarea counter account with institution
	$("#nameAndAddressAccountInstitution").limitCharAndLines(35,4);
	
	//textarea counter sender's correspondent
	$("#nameAndAddressSenderCorrespond").limitCharAndLines(35,4);

	//textarea counter receiver's correspondent
	$("#nameAndAddressReceiverCorrespond").limitCharAndLines(35,4);

	//textarea counter beneficiary institution
	$("#nameAndAddressBeneficiaryInstitution").limitCharAndLines(35,4);

	//textarea counter intermediary
	$("#nameAndAddressIntermediary").limitCharAndLines(35,4);
	
});