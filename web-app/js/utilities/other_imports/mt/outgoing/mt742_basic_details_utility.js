$(document).ready(function(){
    var tabsToDisable=new Array();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
	}
	
	$(".issuingBankFlag").change(function(){
		$(".issuingBankOptionLetter").text($(this).filter(":checked").val());
	});

	$(".corresBankFlag").change(function(){
		$(".accountWithInstitutionOptionLetter").text($(this).filter(":checked").val());
	});
	
	$(".beneficiaryBankFlag").change(function(){
		$(".beneficiaryInstitutionOptionLetter").text($(this).filter(":checked").val());
	});

	
	
	$(".issuingBankFlag").change();
	$(".accountWithBankFlag").change();
	$(".beneficiaryBankFlag").change();
});


function validateOutgoingMt(){
	var hasError=false;

	if('undefined' !== typeof documentNumber && documentNumber != ''){
		$("#totalAmountClaimed,#amount,.documentNumber," +
				"#lcNumber,#reimbursingBank,#lcIssueDate,#currency").each(function(){
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