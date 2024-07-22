/*
 * Created by: Rafael Ski Poblete 
 * Date : 08/14/18
 * Description : Handles Mixed Payment Details popup behaviour.
 * */
function onMixedPaymentDetailsPopupSaveClick() {
    var mixedPaymentDetails = $("#mixedPaymentDetailsComment").val().toUpperCase();
    if($("#mixedPaymentDetailsTo").length > 0) {
        $("#mixedPaymentDetailsTo").val(mixedPaymentDetails);
    } else if($("#mixedPaymentDetailsTextArea").length > 0) {
        $("#mixedPaymentDetailsTextArea").val(mixedPaymentDetails);
    } else {
        $("#mixedPaymentDetails").val(mixedPaymentDetails);
    }
    disablePopup("mixed_payment_details_popup", "mixed_payment_details_bg");
}

$(function (){
    var popup_mixed_payment_details_div = $('#mixed_payment_details_popup').attr("id");
    var popup_mixed_payment_details_bg = $('#mixed_payment_details_bg').attr("id");

    $('#popup_btn_mixed_payment_details').click(function (){
        $("#mixedPaymentDetailsComment").val(($("#mixedPaymentDetailsTo").length > 0 ) ? $("#mixedPaymentDetailsTo").val() : ($("#mixedPaymentDetailsTextArea").length > 0) ? $("#mixedPaymentDetailsTextArea").val() : ($("#mixedPaymentDetails").length > 0 ) ? $("#mixedPaymentDetails").val() : ($("#mixedPaymentDetailsMt").length > 0 ) ? $("#mixedPaymentDetailsMt").val() : '');
        centerPopup(popup_mixed_payment_details_div, popup_mixed_payment_details_bg);
        loadPopup(popup_mixed_payment_details_div, popup_mixed_payment_details_bg);
        $("#mixedPaymentDetailsComment").focus();
        $("#mixedPaymentDetailsComment").limitCharAndLines(35, 4);
    });
    
    $('.mixed_payment_details_close').click(function (){
        $("#mixedPaymentDetailsComment").val("");
        disablePopup(popup_mixed_payment_details_div, popup_mixed_payment_details_bg);
    });
    $("#mixedPaymentDetailsPopupSave").click(onMixedPaymentDetailsPopupSaveClick);
});