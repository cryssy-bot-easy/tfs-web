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
		$("#documentNumberMt799,#mtNarrative,#advisingBank").each(function(){
			if("" == $(this).val()){
				hasError=true;
				if('undefined' !== typeof window.console){
					window.console.log("missing value: "+$(this).attr("id"));
				}
			}
		});
	}else{
		if($.trim($("#documentNumberMt799").val()) == "" ){
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