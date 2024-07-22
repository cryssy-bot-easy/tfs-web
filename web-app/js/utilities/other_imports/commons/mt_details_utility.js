$(document).ready(function(){
	
	$("#orderingBank").change(function(){
		if($("#orderingBank").val().toLowerCase() == "option a-swift code" ){
			$("#identifierCodeOrderingBank").removeAttr("readonly","readonly");
			$("#nameAndAddressOrderingBank").attr("readonly","readonly");
		}else if($("#orderingBank").val().toLowerCase() == "option d-name"){
			$("#identifierCodeOrderingBank").attr("readonly","readonly");
			$("#nameAndAddressOrderingBank").removeAttr("readonly","readonly");
		}else{
			$("#identifierCodeOrderingBank").attr("readonly","readonly");
			$("#nameAndAddressOrderingBank").attr("readonly","readonly")
		}
	});
	
	$("#sendersCorrespondent").change(function(){
		if($("#sendersCorrespondent").val().toLowerCase() == "option a-swift code"){
			
			$("#identifierCodeSenders").removeAttr("readonly","readonly");
			$("#locationSenders").attr("readonly","readonly");
			$("#nameAndAddressSenders").attr("readonly","readonly");
			
		}else if($("#sendersCorrespondent").val().toLowerCase() == "option b-location"){
			
			$("#identifierCodeSenders").attr("readonly","readonly");
			$("#locationSenders").removeAttr("readonly","readonly");
			$("#nameAndAddressSenders").attr("readonly","readonly");
			
		}else if($("#sendersCorrespondent").val().toLowerCase() == "option d-name"){
			
			$("#identifierCodeSenders").attr("readonly","readonly");
			$("#locationSenders").attr("readonly","readonly");
			$("#nameAndAddressSenders").removeAttr("readonly","readonly");
			
		}else{
			
			$("#identifierCodeSenders").attr("readonly","readonly");
			$("#locationSenders").attr("readonly","readonly");
			$("#nameAndAddressSenders").attr("readonly","readonly");
			
		}
		
	});
	
	$("#intermediary").change(function(){
		if($("#intermediary").val().toLowerCase() == "option a-swift code" ){
			$("#identifierCodeIntermediary").removeAttr("readonly","readonly");
			$("#nameAndAddressIntermediary").attr("readonly","readonly");
		}else if($("#intermediary").val().toLowerCase() == "option d-name"){
			$("#identifierCodeIntermediary").attr("readonly","readonly");
			$("#nameAndAddressIntermediary").removeAttr("readonly","readonly");
		}else{
			$("#identifierCodeIntermediary").attr("readonly","readonly");
			$("#nameAndAddressIntermediary").attr("readonly","readonly")
		}
	});
	
	$("#receiversCorrespondent").change(function(){
		if($("#receiversCorrespondent").val().toLowerCase() == "option a-swift code"){
			
			$("#identifierCodeReceivers").removeAttr("readonly","readonly");
			$("#locationReceivers").attr("readonly","readonly");
			$("#nameAndAddressReceivers").attr("readonly","readonly");
			
		}else if($("#receiversCorrespondent").val().toLowerCase() == "option b-location"){
			
			$("#identifierCodeReceivers").attr("readonly","readonly");
			$("#locationReceivers").removeAttr("readonly","readonly");
			$("#nameAndAddressReceivers").attr("readonly","readonly");
			
		}else if($("#receiversCorrespondent").val().toLowerCase() == "option d-name"){
			
			$("#identifierCodeReceivers").attr("readonly","readonly");
			$("#locationReceivers").attr("readonly","readonly");
			$("#nameAndAddressReceivers").removeAttr("readonly","readonly");
			
		}else{
			
			$("#identifierCodeReceivers").attr("readonly","readonly");
			$("#locationReceivers").attr("readonly","readonly");
			$("#nameAndAddressReceivers").attr("readonly","readonly");
			
		}
	});
	
	
	$("#accountWithBank").change(function(){
		if($("#accountWithBank").val().toLowerCase() == "option a-swift code"){
			
			$('#identifierCodeAccountWithBank').removeAttr("readonly");
			$('#locationAccountWithBank').attr("readonly","readonly");
			$('#nameAndAddressAccountWithBank').attr("readonly","readonly");
			
		}else if($("#accountWithBank").val().toLowerCase() == "option b-location"){
			
			$('#locationAccountWithBank').removeAttr("readonly");
			$('#identifierCodeAccountWithBank').attr("readonly","readonly");
			$('#nameAndAddressAccountWithBank').attr("readonly","readonly");
			
		}else if($("#accountWithBank").val().toLowerCase() == "option d-name"){
			
			$('#nameAndAddressAccountWithBank').removeAttr("readonly");
			$('#identifierCodeAccountWithBank').attr("readonly","readonly");
			$('#locationAccountWithBank').attr("readonly","readonly");
			
		}else{
			$('#nameAndAddressAccountWithBank').attr("readonly","readonly");
			$('#identifierCodeAccountWithBank').attr("readonly","readonly");
			$('#locationAccountWithBank').attr("readonly","readonly");
		}
		
	});
	
	
	$("#thirdReimbursementInstitution").change(function(){
		if($("#thirdReimbursementInstitution").val().toLowerCase() == "option a-swift code"){
			
			$('#identifierCodeAccountThird').removeAttr("readonly");
			$('#locationAccountThird').attr("readonly","readonly");
			$('#nameAndAddressThird').attr("readonly","readonly");
			
		}else if($("#thirdReimbursementInstitution").val().toLowerCase() == "option b-location"){
			
			$('#locationAccountThird').removeAttr("readonly");
			$('#identifierCodeAccountThird').attr("readonly","readonly");
			$('#nameAndAddressThird').attr("readonly","readonly");
			
		}else if($("#thirdReimbursementInstitution").val().toLowerCase() == "option d-name"){
			
			$('#nameAndAddressThird').removeAttr("readonly");
			$('#identifierCodeAccountThird').attr("readonly","readonly");
			$('#locationAccountThird').attr("readonly","readonly");
			
		}else{
			$('#nameAndAddressThird').attr("readonly","readonly");
			$('#identifierCodeAccountThird').attr("readonly","readonly");
			$('#locationAccountThird').attr("readonly","readonly");
		}
		
	});
	
	
});