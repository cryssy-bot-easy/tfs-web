$(document).ready(function (){
	$(".paymentProcessList").hide();

	$("#partialCashSettlementFlagBox").attr("disabled","true");
	
//  just for testing, actual function may vary in ets
//	$("#partialCashSettlementAmountCheckBox").attr("checked","checked");
	
	
	if(($("#partialCashSettlementFlagBox").attr("checked")=="checked")
//			&& ($("#amount").val().length > 0)){
        && ($("#outstandingBalance").val().length > 0)){
			$(".paymentProcessList").show();
		}else{
			$(".paymentProcessList").hide();
		}
	
	if($("#standbyTaggingOriginalValue").val() != $("#standbyTaggingTo").val()) {
		console.log($("#standbyTaggingOriginalValue").val());
		console.log($("#standbyTaggingTo").val());
		console.log("Standby Tagging was changed...");
		$("#standbyTaggingAdjustment").val("YES");
	} else if($("#standbyTaggingOriginalValue").val() == $("#standbyTaggingTo").val()){
		$("#standbyTaggingAdjustment").val("NO");
	}
	
	
//  disable 3 To: fields when user is TSD
	/*if("TSD" == loggedInUser){
		$("#_facilityIdTo").attr('disabled','disabled');
		$("#facilityIdTo").attr('disabled','disabled');
		$("#_cifNumberTo").attr('disabled','disabled');
		$("#cifNumberTo").attr('disabled','disabled');
		$("#_mainCifNumberTo").attr('disabled','disabled');
		$("#mainCifNumberTo").attr('disabled','disabled');
	}
	*/
	
	
	//added for standby adjustment
	$("input[name=standbyTagging]").change(function(){
		
		
//		var origVal = $("#standbyTagging").val();
//		
//		//$("#standbyTaggingAdjustmentValue").val(origVal);
//		alert(origVal);
	
		$("#standbyTaggingAdjustment").val("YES");
				
	});


});
