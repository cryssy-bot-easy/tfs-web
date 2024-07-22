$(document).ready(function add2EnableThis(){
	
	var periodPresentationVal = $("#periodPresentation1From").val();
	var periodPresentation2Val = $("#periodPresentation2From").val();
	var senderToReceiverInformationVal = $("#senderToReceiverInformationFrom").val();
	$("#periodPresentation1To").attr("readonly","readonly");
	$(".reimbursingRadioTo").attr("disabled","true");
	$("#reimbursingAccntTypeTo").attr("readonly","readonly");
	$("#reimbursingCurrencyTo").attr("disabled","true");
	$("#reimbursingBankAccntNumberTo").attr("readonly","readonly")
	$("#periodPresentation2To").attr("readonly","readonly");
	$(".adviseBankTo").attr("disabled","true");
	$("#senderToReceiverTo").attr("disabled","true");
	$("#senderToReceiverInformationTo").attr("readonly","readonly");
	
	
	$("#periodPresentationRow").click(function(){
		if($("#periodPresentationRow").attr("checked") == "checked"){
			$("#periodPresentation1To").removeAttr("readonly","readonly");
			$("#periodPresentation1To").val(periodPresentationVal);
		}else{
			$("#periodPresentation1To").attr("readonly","readonly");
		}
	});
	
	$("#reimbursingBankRow").click(function(){
		if($("#reimbursingBankRow").attr("checked") == "checked"){
			$(".reimbursingRadioTo").removeAttr("disabled","true");
			$("#reimbursingAccntTypeTo").removeAttr("readonly","readonly");
			$("#reimbursingCurrencyTo").removeAttr("disabled","true");
			$("#reimbursingBankAccntNumberTo").removeAttr("readonly","readonly")
		}else{
			$(".reimbursingRadioTo").attr("disabled","true");
			$("#reimbursingAccntTypeTo").attr("readonly","readonly");
			$("#reimbursingCurrencyTo").attr("disabled","true");
			$("#reimbursingBankAccntNumberTo").attr("readonly","readonly")
		}
	});
	
	$("#periodPresentation2Row").click(function(){
		if($("#periodPresentation2Row").attr("checked") == "checked"){
			$("#periodPresentation2To").removeAttr("readonly","readonly");
			$("#periodPresentation2To").val(periodPresentation2Val);
		}else{
			$("#periodPresentation2To").attr("readonly","readonly");
		}
	});


	$("#adviseThroughBankRow").click(function(){
		if($("#adviseThroughBankRow").attr("checked") == "checked"){
			$(".adviseBankTo").removeAttr("disabled","true");
		}else{
			$(".adviseBankTo").attr("disabled","true");
		}
	});
	
	
	$("#senderToReceiverInformationRow").click(function(){
		if($("#senderToReceiverInformationRow").attr("checked") == "checked"){
			$("#senderToReceiverTo").removeAttr("disabled","true");
			$("#senderToReceiverInformationTo").removeAttr("readonly","readonly");
			$("#senderToReceiverInformationTo").val(senderToReceiverInformationVal);
		}else{
			$("#senderToReceiverTo").attr("disabled","true");
			$("#senderToReceiverInformationTo").attr("readonly","readonly");
		}
	});
	
});