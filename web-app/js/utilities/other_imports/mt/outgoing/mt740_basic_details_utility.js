$(document).ready(function(){
    var tabsToDisable=new Array();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
	}
});

function validateOutgoingMt(){
	var hasError=false;

	if('undefined' !== typeof documentNumber && documentNumber != ''){
		$("#applicableRules, #currency, #amount, #destinationBank").each(function(){
			if("" == $(this).val()){
				hasError=true;
				if('undefined' !== typeof window.console){
					window.console.log("missing value: "+$(this).attr("id"));
				}
			}
		});

		if((!$("#availableWithFlagA").attr('checked') && !$("#availableWithFlagD").attr('checked')) ||
				($("#availableWithFlagA").attr('checked') && $("#availableWith").val() == "") ||
				($("#availableWithFlagD").attr('checked') && $("#nameAndAddress").val() == "")){
			console.log('High end');
			hasError=true;
		}
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

	$('#positiveToleranceLimit').val(stripCommas($('#positiveToleranceLimit').val()));
	$('#negativeToleranceLimit').val(stripCommas($('#negativeToleranceLimit').val()));

	return hasError;
}
