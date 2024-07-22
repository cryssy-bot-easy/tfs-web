$(document).ready(function(){
    var tabsToDisable=new Array();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
	}
	
	$(".orderingBankFlagMt202").change(function(){
		$(".orderingBankFlagMt202Mt752202OptionLetter").text($(this).filter(":checked").val());
	});

	$(".sendersCorrespondentFlagMt202").change(function(){
		$(".sendersCorrespondentFlagMt202Mt752202OptionLetter").text($(this).filter(":checked").val());
	});
	
	$(".receiversCorrespondentFlagMt202").change(function(){
		$(".receiversCorrespondentFlagMt202Mt752202OptionLetter").text($(this).filter(":checked").val());
	});

	$(".intermediaryFlagMt202").change(function(){
		$(".intermediaryMt202OptionLetter").text($(this).filter(":checked").val());
	});

	$(".accountWithBankFlagMt202").change(function(){
		$(".accountWithInstitutionMt202OptionLetter").text($(this).filter(":checked").val());
	});

	$(".beneficiaryBankFlagMt202").change(function(){
		$(".beneficiaryInstitutionMt202OptionLetter").text($(this).filter(":checked").val());
	});
	
	$(".orderingBankFlagMt202").change();
	$(".sendersCorrespondentFlagMt202").change();
	$(".receiversCorrespondentFlagMt202").change();
	$(".intermediaryFlagMt202").change();
	$(".accountWithBankFlagMt202").change();
	$(".beneficiaryBankFlagMt202").change();
});


function validateOutgoingMt(){
	var hasError=false;

	if('undefined' !== typeof documentNumber && documentNumber != ''){
		switch($("#orderingBankFlagMt202:checked").val()){
		case "A":
			if("" == $("#bankIdentifierCodeMt202").val()){
				hasError=true;
			}
			break;
		case "D":
			if("" == $("#bankNameAndAddressMt202").val()){
				hasError=true;
			}
			break;
		default:
			hasError=true;
		};

		switch($("#beneficiaryBankFlagMt202:checked").val()){
		case "A":
			if("" == $("#beneficiaryIdentifierCodeMt202").val()){
				hasError=true;
			}
			break;
		case "D":
			if("" == $("#beneficiaryNameAndAddressMt202").val()){
				hasError=true;
			}
			break;
		default:
			hasError=true;
		};

		$("#reimbursingBank,#negotiatingBanksReferenceNumber,#valueDateMt202,#lcCurrencyMt202,#netAmountMt202,#importerName," +
				"#beneficiaryName,#beneficiaryAddress,#detailsOfCharges,#reimbursingBank").each(function(){
					if("" == $(this).val()){
						hasError=true;
						if('undefined' !== typeof window.console){
							window.console.log("missing value: "+$(this).attr("id"));
						}
					}
		});		
	}else{
		if($.trim($("#documentNumber").val()) == "" ){
			hasError = true;
			if('undefined' !== typeof window.console){
				window.console.log("missing value: "+$(this).attr("id"));
			}
		}
	}
	if(hasError){
		triggerAlertMessage("Please fill in the required fields.");
	}
	
	return hasError;
}