$(document).ready(function(){
    var tabsToDisable=new Array();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
	}

	$('#increaseAmountInput').blur(function() {
		var isDisabled = false;
		if ($(this).val() != '') {
            $('#decreaseAmountInput').val('');
            $('#decreaseAmount').val('');
            isDisabled = true;
		}
		$('#decreaseAmountInput').attr('disabled', isDisabled);
        $('#increaseAmount').val($(this).val());
	});
	$('#decreaseAmountInput').blur(function() {
		var isDisabled = false;
		if ($(this).val() != '') {
			$('#increaseAmountInput').val('');
			$('#increaseAmount').val('');
			isDisabled = true;
		}
		$('#increaseAmountInput').attr('disabled', isDisabled);
		$('#decreaseAmount').val($(this).val());
	});
});


function validateOutgoingMt(){
	var hasError=false;

	if('undefined' !== typeof documentNumber && documentNumber != ''){
		$("#amendmentDate, #reimbursingBankIdentifierCode").each(function(){
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

	$('#positiveToleranceLimit').val(stripCommas($('#positiveToleranceLimit').val()));
	$('#negativeToleranceLimit').val(stripCommas($('#negativeToleranceLimit').val()));

	return hasError;
}
