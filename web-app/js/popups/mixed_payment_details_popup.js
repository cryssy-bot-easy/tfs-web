function onMixedPaymentDetailsPopupSaveClick() {
    var mixedPaymentDetailsComment = $("#mixedPaymentDetailsComment").val();

    if($("#mixedPaymentDetailsTo").length > 0) {
        $("#mixedPaymentDetailsTo").val(mixedPaymentDetailsComment);
    } else if($("#mixedPaymentDetails").length > 0) {
    	$("#mixedPaymentDetails").val(mixedPaymentDetailsComment);
    } else {
        $("#mixedPaymentDetails").val(mixedPaymentDetailsComment);
    }

    disablePopup("popup_mixpaymentDetails","mixed_payment_details_bg");
}

$(document).ready(function(){
	var wrapper_div=$("#popup_mixpaymentDetails").attr("id");
	var div_bg=$("#mixed_payment_details_bg").attr("id");
	
	$("#popup_btn_mixed_payments_details").click(function(){
        $("#mixedPaymentDetailsComment").val(($("#mixedPaymentDetailsTo").length > 0) ? $("#mixedPaymentDetailsTo").val() : $("#mixedPaymentDetails").val());

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_mixPaymentDetails1, #close_mixPaymentDetails2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#mixedPaymentDetailsComment").limitCharAndLines(35,4);

    $("#mixedPaymentDetailsPopupSave").click(onMixedPaymentDetailsPopupSaveClick);

});