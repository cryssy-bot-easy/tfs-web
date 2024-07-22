function validateMt202TabFxUaLoanDataEntrySettlement(){
	var errorCount=0;
	
	if('undefined' !== typeof _pageHasErrors){
		if($("input[name=orderingBankFlagMt202]:checked").length > 0) {
	    	switch($("input[name=orderingBankFlagMt202]:checked").val()){
			case "A":
				if("" == $("#bankIdentifierCodeMt202").val()){
					errorCount++;
				}
				break;
			case "D":
				if("" == $("#bankNameAndAddressMt202").val()){
					errorCount++;
				}
				break;
			default:
				errorCount++;
	    	};
		}else{
			errorCount++;
		}
		
		if($("input[name=beneficiaryBankFlagMt202]:checked").length > 0) {
	    	switch($("input[name=beneficiaryBankFlagMt202]:checked").val()){
			case "A":
				if("" == $("#beneficiaryIdentifierCodeMt202").val()){
					errorCount++;
				}
				break;
			case "D":
				if("" == $("#beneficiaryNameAndAddressMt202").val()){
					errorCount++;
				}
				break;
			default:
				errorCount++;
	    	};
		}else{
			errorCount++;
		}
		
	    if ($("#reimbursingBankMt202").val() == "" ||
	        $("#negotiatingBankMt202").val() == "" ||
	        $("#negotiatingBanksReferenceNumberMt202").val() == ""){
	    	errorCount++;
	    }
	    
	    evaluatePageError(errorCount);
	}
}


function validateFxUaLoanSettlementBasicDetails(){
	var errorCount = 0;
	
	if('undefined' !== typeof _pageHasErrors){
		$("#reimbursingBank").each(function(){
			if("" == $(this).val()){
				errorCount++;
			}
		});
		
		if($("input[name=accountType]:checked").length <= 0){
			errorCount++;
		}
		
		evaluatePageError(errorCount);
		
	}
}



function evaluatePageError(errorCount){
	if(errorCount > 0){
		$("#alertMessage").text("Please fill in all the required fields.");
		triggerAlertMessage();
		_pageHasErrors=true
	}else{
		_pageHasErrors=false;
	}
}

function validateFxUaLoanSettlement(_buttonParentId){

	switch(_buttonParentId){
	case "basicDetailsTabForm":
		validateFxUaLoanSettlementBasicDetails();
		break;
	case "detailsForMT202TabForm":
		validateMt202TabFxUaLoanDataEntrySettlement();
		break;
	}
}