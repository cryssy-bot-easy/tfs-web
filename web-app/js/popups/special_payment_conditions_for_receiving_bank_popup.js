/*
 * Created by: Rafael Ski Poblete 
 * Date : 08/14/18
 * Description : Handles Deferred Payment Details popup behaviour.
 * */
function onSpecialPaymentConditionsForReceivingBankPopupSaveClick() {
    var specialPaymentConditionsForReceivingBank = $("#specialPaymentConditionsForReceivingBankComment").val().toUpperCase();
    if($("#specialPaymentConditionsForReceivingBankTo").length > 0) {
        $("#specialPaymentConditionsForReceivingBankTo").val(specialPaymentConditionsForReceivingBank);
    } else if($("#specialPaymentConditionsForReceivingBankTextArea").length > 0) {
        $("#specialPaymentConditionsForReceivingBankTextArea").val(specialPaymentConditionsForReceivingBank);
    } else {
        $("#specialPaymentConditionsForReceivingBank").val(specialPaymentConditionsForReceivingBank);
    }
    disablePopup("special_payment_conditions_for_receiving_bank_popup", "special_payment_conditions_for_receiving_bank_bg");
}

$(function (){
    var popup_special_payment_conditions_for_receiving_bank_div = $('#special_payment_conditions_for_receiving_bank_popup').attr("id");
    var popup_special_payment_conditions_for_receiving_bank_bg = $('#special_payment_conditions_for_receiving_bank_bg').attr("id");
    
    $('#popup_btn_special_payment_conditions_for_receiving_bank').click(function (){
        $("#specialPaymentConditionsForReceivingBankComment").val(($("#specialPaymentConditionsForReceivingBankTo").length > 0 ) ? $("#specialPaymentConditionsForReceivingBankTo").val() : ($("#specialPaymentConditionsForReceivingBankTextArea").length > 0) ? $("#specialPaymentConditionsForReceivingBankTextArea").val() : ($("#specialPaymentConditionsForReceivingBank").length > 0 ) ? $("#specialPaymentConditionsForReceivingBank").val() : ($("#specialPaymentConditionsForReceivingBankMt").length > 0 ) ? $("#specialPaymentConditionsForReceivingBankMt").val() : '');
        centerPopup(popup_special_payment_conditions_for_receiving_bank_div, popup_special_payment_conditions_for_receiving_bank_bg);
        loadPopup(popup_special_payment_conditions_for_receiving_bank_div, popup_special_payment_conditions_for_receiving_bank_bg);
        $("#specialPaymentConditionsForReceivingBankComment").focus();
        $("#specialPaymentConditionsForReceivingBankComment").limitCharAndLines(65, 800, 'Z');
    });
    
    $('.special_payment_conditions_for_receiving_bank_close').click(function (){
        $("#specialPaymentConditionsForReceivingBankComment").val("");
        disablePopup(popup_special_payment_conditions_for_receiving_bank_div, popup_special_payment_conditions_for_receiving_bank_bg);
    });
    $("#specialPaymentConditionsForReceivingBankPopupSave").click(onSpecialPaymentConditionsForReceivingBankPopupSaveClick);
});