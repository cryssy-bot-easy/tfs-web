/* Modified by: Rafael Ski Poblete
 * Date Modified: 9/11/18
 * Description: Added condition to check if field netAmountDateMt752 is mandatory.
 * */
$(document).ready(function(){
    var tabsToDisable=new Array();
    getNetAmountRadioStatus();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
		 $("#negotiatingBank").toggleClass("required", false);
		 $("#lcNumber").toggleClass("required", false);
		 $("#negotiatingBanksReferenceNumber").toggleClass("required", false);
		 $("#furtherIdentificationMt752").toggleClass("required", false);
		 $("#valueDateMt752").toggleClass("required", false);
	} else {
		 $("#negotiatingBank").toggleClass("required", true);
		 $("#lcNumber").toggleClass("required", true);
		 $("#negotiatingBanksReferenceNumber").toggleClass("required", true);
		 $("#furtherIdentificationMt752").toggleClass("required", true);
		 $("#valueDateMt752").toggleClass("required", true);
	}
	
	$(".documentSubType2").change(function(){
		getNetAmountRadioStatus();
	});
	
	$(".sendersCorrespondentMt752").change(function(){
		$(".sendersCorrespondentMt752202OptionLetter").text($(this).filter(":checked").val());
	});

	$(".receiversCorrespondentMt752").change(function(){
		$(".receiversCorrespondentMt752202OptionLetter").text($(this).filter(":checked").val());
	});
	
	$(".sendersCorrespondentMt752").change();
	$(".receiversCorrespondentMt752").change();
});

function getNetAmountRadioStatus(){
	if($('input:radio[name=documentSubType2]:checked').val() == 'USANCE'){
		document.getElementById("netLabel").style.display = 'inline';
		$(".netAmountMt752OptionLetter").text("A");
	}else{
		document.getElementById("netLabel").style.display = 'none';
		$(".netAmountMt752OptionLetter").text("B");
		
	}
}

function validateOutgoingMt(){
	var hasError=false;

	if('undefined' !== typeof documentNumber && documentNumber != ''){
		$("#negotiatingBank,#negotiatingBanksReferenceNumber,#furtherIdentificationMt752,#valueDateMt752").each(function(){
			if("" == $(this).val()){
				hasError=true;
				if('undefined' !== typeof window.console){
					window.console.log("missing value: "+$(this).attr("id"));
				}
			}
		});	
	}else{
		if($.trim($("#lcNumber").val()) == "" ){
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