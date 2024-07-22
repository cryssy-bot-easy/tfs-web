/*
 * Created by: Rafael Ski Poblete 
 * Date : 08/14/18
 * Description : Handles Deferred Payment Details popup behaviour.
 * */
function onDeferredPaymentDetailsPopupSaveClick() {
    var deferredPaymentDetails = $("#deferredPaymentDetailsComment").val().toUpperCase();
    if($("#deferredPaymentDetailsTo").length > 0) {
        $("#deferredPaymentDetailsTo").val(deferredPaymentDetails);
    } else if($("#deferredPaymentDetailsTextArea").length > 0) {
        $("#deferredPaymentDetailsTextArea").val(deferredPaymentDetails);
    } else {
        $("#deferredPaymentDetails").val(deferredPaymentDetails);
    }
    disablePopup("deferred_payment_details_popup", "deferred_payment_details_bg");
}

$(function (){
    var popup_deferred_payment_details_div = $('#deferred_payment_details_popup').attr("id");
    var popup_deferred_payment_details_bg = $('#deferred_payment_details_bg').attr("id");
    
    $('#popup_btn_deferred_payment_details').click(function (){
        $("#deferredPaymentDetailsComment").val(($("#deferredPaymentDetailsTo").length > 0 ) ? $("#deferredPaymentDetailsTo").val() : ($("#deferredPaymentDetailsTextArea").length > 0) ? $("#deferredPaymentDetailsTextArea").val() : ($("#deferredPaymentDetails").length > 0 ) ? $("#deferredPaymentDetails").val() : ($("#deferredPaymentDetailsMt").length > 0 ) ? $("#deferredPaymentDetailsMt").val() : '');
        centerPopup(popup_deferred_payment_details_div, popup_deferred_payment_details_bg);
        loadPopup(popup_deferred_payment_details_div, popup_deferred_payment_details_bg);
        $("#deferredPaymentDetailsComment").focus();
        $("#deferredPaymentDetailsComment").limitCharAndLines(35, 4, 'X');
    });
    
    $('.deferred_payment_details_close').click(function (){
        $("#deferredPaymentDetailsComment").val("");
        disablePopup(popup_deferred_payment_details_div, popup_deferred_payment_details_bg);
    });
        
    $("#deferredPaymentDetailsPopupSave").click(onDeferredPaymentDetailsPopupSaveClick);
});