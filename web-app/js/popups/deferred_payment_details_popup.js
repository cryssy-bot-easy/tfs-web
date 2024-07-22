function onDeferredPaymentDetailsPopupSaveClick() {
    var deferredPaymentDetails = $("#deferredPaymentDetailsComment").val();

    disablePopup("popup_defpaymentDetails","deferred_payment_details_bg");

    if($("#deferredPaymentDetailsTo").length > 0) {
        $("#deferredPaymentDetailsTo").val(deferredPaymentDetails);
    } else {
        $("#deferredPaymentDetails").val(deferredPaymentDetails);
    }
}

$(document).ready(function(){
	var wrapper_div=$("#popup_defpaymentDetails").attr("id");
	var div_bg=$("#deferred_payment_details_bg").attr("id");
	
	$("#popup_btn_deferred_payments_details").click(function(){
        $("#deferredPaymentDetailsComment").val(($("#deferredPaymentDetailsTo").length > 0) ? $("#deferredPaymentDetailsTo").val() : $("#deferredPaymentDetails").val());

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_defPaymentDetails1, #close_defPaymentDetails2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#deferredPaymentDetailsComment").limitCharAndLines(35,4);

	$("#deferredPaymentDetailsPopupSave").click(onDeferredPaymentDetailsPopupSaveClick);
});

