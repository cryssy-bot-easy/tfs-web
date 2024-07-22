$(function(){
	if($("#amountOfPaymentProceedBeneficiary").val().length!=0){
		$("#popup_btn_mode_of_payment_proceeds").removeAttr("disabled");
	}else $("#popup_btn_mode_of_payment_proceeds").attr("disabled","");
	
	
	$("#amountOfPaymentProceedBeneficiary").change(function(){
		if($(this).val().replace(/,/g,"") * 100 > $("#proceedsAmount").val().replace(/,/g,"") * 100){
			$("#alertMessage").text("Payment Amount cannot exceed Proceeds Amount.");
	        triggerAlert();
	        $(this).val("");
	        $("#popup_btn_mode_of_payment_proceeds").attr("disabled","");
		}
	});
	$("#amountOfPaymentProceedBeneficiary").keyup(function(){
		if($(this).val().length!=0){
			$("#popup_btn_mode_of_payment_proceeds").removeAttr("disabled");
		}else {$("#popup_btn_mode_of_payment_proceeds").attr("disabled","");
		}
	});
	
	$("#amountOfPaymentProceedBeneficiary").bind("copy cut paste",function(e){
		e.preventDefault();
//		alert("Cut,Copy and Paste is disabled.");
        $("#alertMessage").text("Cut, Copy and Paste is disabled.");
        triggerAlert();
	});
	
});