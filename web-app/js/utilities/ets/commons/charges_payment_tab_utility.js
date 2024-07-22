// NOTE: this is moved to mode of payment charges popup to prevent function null error
// mode_of_payment_charges_popup.js

/**
 *Functions for Add Settlement Charges button
 *
 */
$(document).ready(function(){

	$("#popup_btn_mode_of_payment_charges").removeAttr("disabled");
	
//	if($("#amountOfPaymentCharges").val().length!=0){
//		$("#popup_btn_mode_of_payment_charges").removeAttr("disabled");
//	}else $("#popup_btn_mode_of_payment_charges").attr("disabled","");
	
//	$("#amountOfPaymentCharges").keyup(function(){
//		if($(this).val().length!=0){
//			$("#").removeAttr("disabled");
//		}else $("#popup_btn_mode_of_payment_charges").attr("disabled","");
//	});
	
	$("#amountOfPaymentCharges").bind("copy cut paste",function(e){
		e.preventDefault();
//		alert("Cut,Copy and Paste is disabled.");
        $("#alertMessage").text("Cut, Copy and Paste is disabled.");
        triggerAlert();
	});
});
