$(document).ready(function ieEnableThis(){
	
	$("#importerNameTo").attr("readonly","readonly");
	$("#importerAddressTo").attr("readonly","readonly");
	$("#exporterCBCodeTo").attr("disabled","true");
	$("#exporterNameTo").attr("readonly","readonly");
	$("#exporterAddressTo").attr("readonly","readonly");
	$("#posToleranceLimitTo").attr("readonly","readonly");
	$("#negToleranceLimitTo").attr("readonly","readonly");
	$("#maxCreditAmountTo").attr("readonly","readonly");
	$("#additionalAmountsCoveredTo").attr("readonly","readonly");
	$("#availableWithTo").attr("disabled","true");		
	$(".availableWithTo").attr("disabled","true");
	$("#identifierCodeTo").attr("readonly","readonly");
	$("#nameAndAddressTo").attr("readonly","readonly");
	$("#byDropdownTo").attr("disabled","true");	
	$("#draweeTo").attr("readonly","readonly");
	$("#tenorOfDraftTo").attr("readonly","readonly");
	$("#partialShipmentTo").attr("disabled","true");
	$("#transShipmentTo").attr("disabled","true");
	$("#placeDispatchReceiptTo").attr("readonly","readonly");
	$("#portLoadingDepartureTo").attr("readonly","readonly");	
	$("#bspCodeTo").attr("disabled","true");
	$("#portDischargeDestinationTo").attr("readonly","readonly");
	$("#placeFinalDestinationTo").attr("readonly","readonly");
	$("#popup_btn_bank_address").hide();
	
	$("#importerNameRow").click(function (){
		if($("#importerNameRow").attr("checked") == "checked"){
			$("#importerNameTo").removeAttr("readonly","readonly");	
		}else{
			$("#importerNameTo").attr("readonly","readonly");
		}
	});
	
	$("#importerAddressRow").click(function (){
		if($("#importerAddressRow").attr("checked") == "checked"){
			$("#importerAddressTo").removeAttr("readonly","readonly");	
		}else{
			$("#importerAddressTo").attr("readonly","readonly");
		}
	});
	
	$("#exporterCBCodeRow").click(function (){
		if($("#exporterCBCodeRow").attr("checked") == "checked"){
			$("#exporterCBCodeTo").removeAttr("disabled","true");	
		}else{
			$("#exporterCBCodeTo").attr("disabled","true");	
		}
	});
	
	$("#exporterNameRow").click(function (){
		if($("#exporterNameRow").attr("checked") == "checked"){
			$("#exporterNameTo").removeAttr("readonly","readonly");	
		}else{
			$("#exporterNameTo").attr("readonly","readonly");
		}
	});
	
	$("#exporterAddressRow").click(function (){
		if($("#exporterAddressRow").attr("checked") == "checked"){
			$("#exporterAddressTo").removeAttr("readonly","readonly");	
		}else{
			$("#exporterAddressTo").attr("readonly","readonly");
		}
	});
	
	$("#posToleranceLimitRows").click(function (){
		if($("#posToleranceLimitRows").attr("checked") == "checked"){
			$("#posToleranceLimitTo").removeAttr("readonly","readonly");	
		}else{
			$("#posToleranceLimitTo").attr("readonly","readonly");
		}
	});

	$("#negToleranceLimitRows").click(function (){
		if($("#negToleranceLimitRows").attr("checked") == "checked"){
			$("#negToleranceLimitTo").removeAttr("readonly","readonly");	
		}else{
			$("#negToleranceLimitTo").attr("readonly","readonly");
		}
	});
	
	$("#maxCreditAmountRow").click(function (){
		if($("#maxCreditAmountRow").attr("checked") == "checked"){
			$("#maxCreditAmountTo").removeAttr("readonly","readonly");	
		}else{
			$("#maxCreditAmountTo").attr("readonly","readonly");
		}
	});
	
	$("#additionalAmountsCoveredRow").click(function (){
		if($("#additionalAmountsCoveredRow").attr("checked") == "checked"){
			$("#additionalAmountsCoveredTo").removeAttr("readonly","readonly");	
		}else{
			$("#additionalAmountsCoveredTo").attr("readonly","readonly");
		}
	});
	
	$("#availableWithRow").click(function (){
		if($("#availableWithRow").attr("checked") == "checked"){
			$("#availableWithTo").removeAttr("disabled","true");		
			$(".availableWithTo").removeAttr("disabled","true");
			//$("#availableIdentifierCodeIETo").removeAttr("readonly","readonly");
			//$("#availableNameAndAddressIETo").removeAttr("readonly","readonly");
			$(".availableWithTo").change(function(){
				if($(this).val() == 'option A'){
					$("#availableIdentifierCodeIETo").removeAttr("readonly");
					$("#availableNameAndAddressIETo").attr("readonly", "readonly");
								
				} else if($(this).val() == 'option B'){
					$("#availableIdentifierCodeIETo").attr("readonly", "readonly");
					$("#availableNameAndAddressIETo").removeAttr("readonly");
				}
			});
			
		}else{
			$("input[name=availableFlagTo]:checked").removeAttr("checked");
			$("#availableWithTo").attr("disabled","true");		
			$(".availableWithTo").attr("disabled","true");
			$("#availableIdentifierCodeIETo").attr("readonly","readonly");
			$("#availableNameAndAddressIETo").attr("readonly","readonly");
		}
	});
	
	$("#byRow").click(function (){
		if($("#byRow").attr("checked") == "checked"){
			$("#byDropdownTo").removeAttr("disabled","true");
			$("#draweeTo").removeAttr("readonly","readonly");
			$("#tenorOfDraftTo").removeAttr("readonly","readonly");	
		}else{
			$("#byDropdownTo").attr("disabled","true");	
			$("#draweeTo").attr("readonly","readonly");
			$("#tenorOfDraftTo").attr("readonly","readonly");
		}
	});
	
	$("#partialShipmentRow").click(function (){
		if($("#partialShipmentRow").attr("checked") == "checked"){
			$("#partialShipmentTo").removeAttr("disabled","true");	
		}else{
			$("#partialShipmentTo").attr("disabled","true");
		}
	});
	
	$("#transShipmentRow").click(function (){
		if($("#transShipmentRow").attr("checked") == "checked"){
			$("#transShipmentTo").removeAttr("disabled","true");	
		}else{
			$("#transShipmentTo").attr("disabled","true");
		}
	});
	
	$("#placeDispatchReceiptRow").click(function (){
		if($("#placeDispatchReceiptRow").attr("checked") == "checked"){
			$("#placeDispatchReceiptTo").removeAttr("readonly","readonly");	
		}else{
			$("#placeDispatchReceiptTo").attr("readonly","readonly");
		}
	});

	$("#portLoadingDepartureRow").click(function (){
		if($("#portLoadingDepartureRow").attr("checked") == "checked"){
			$("#portLoadingDepartureTo").removeAttr("readonly","readonly");
			$("#bspCodeTo").removeAttr("disabled","true");	
		}else{
			$("#portLoadingDepartureTo").attr("readonly","readonly");	
			$("#bspCodeTo").attr("disabled","true");
		}
	});
	
	$("#portDischargeDestinationRow").click(function (){
		if($("#portDischargeDestinationRow").attr("checked") == "checked"){
			$("#portDischargeDestinationTo").removeAttr("readonly","readonly");	
		}else{
			$("#portDischargeDestinationTo").attr("readonly","readonly");
		}
	});
	
	$("#placeFinalDestinationRow").click(function (){
		if($("#placeFinalDestinationRow").attr("checked") == "checked"){
			$("#placeFinalDestinationTo").removeAttr("readonly","readonly");	
		}else{
			$("#placeFinalDestinationTo").attr("readonly","readonly");
		}
	});
	
	
});