/*
 * Created by: Rafael Ski Poblete 
 * Date : 08/14/18
 * Description : Handles Deferred Payment Details popup behaviour.
 * */
function onSpecialPaymentConditionsForBeneficiaryPopupSaveClick() {
    var specialPaymentConditionsForBeneficiary = $("#specialPaymentConditionsForBeneficiaryComment").val().toUpperCase();
    if($("#specialPaymentConditionsForBeneficiaryTo").length > 0) {
        $("#specialPaymentConditionsForBeneficiaryTo").val(specialPaymentConditionsForBeneficiary);
    } else if($("#specialPaymentConditionsForBeneficiaryTextArea").length > 0) {
        $("#specialPaymentConditionsForBeneficiaryTextArea").val(specialPaymentConditionsForBeneficiary);
    } else {
        $("#specialPaymentConditionsForBeneficiary").val(specialPaymentConditionsForBeneficiary);
    }
    disablePopup("special_payment_conditions_for_beneficiary_popup", "special_payment_conditions_for_beneficiary_bg");
}

$(function (){
    var popup_special_payment_conditions_for_beneficiary_div = $('#special_payment_conditions_for_beneficiary_popup').attr("id");
    var popup_special_payment_conditions_for_beneficiary_bg = $('#special_payment_conditions_for_beneficiary_bg').attr("id");
    
    $('#popup_btn_special_payment_conditions_for_beneficiary').click(function (){
        $("#specialPaymentConditionsForBeneficiaryComment").val(($("#specialPaymentConditionsForBeneficiaryTo").length > 0 ) ? $("#specialPaymentConditionsForBeneficiaryTo").val() : ($("#specialPaymentConditionsForBeneficiaryTextArea").length > 0) ? $("#specialPaymentConditionsForBeneficiaryTextArea").val() : ($("#specialPaymentConditionsForBeneficiary").length > 0 ) ? $("#specialPaymentConditionsForBeneficiary").val() : ($("#specialPaymentConditionsForBeneficiaryMt").length > 0 ) ? $("#specialPaymentConditionsForBeneficiaryMt").val() : '');
        centerPopup(popup_special_payment_conditions_for_beneficiary_div, popup_special_payment_conditions_for_beneficiary_bg);
        loadPopup(popup_special_payment_conditions_for_beneficiary_div, popup_special_payment_conditions_for_beneficiary_bg);
        $("#specialPaymentConditionsForBeneficiaryComment").focus();
        $("#specialPaymentConditionsForBeneficiaryComment").limitCharAndLines(65, 800, 'Z');
    });
    
    $('.special_payment_conditions_for_beneficiary_close').click(function (){
        $("#specialPaymentConditionsForBeneficiaryComment").val("");
        disablePopup(popup_special_payment_conditions_for_beneficiary_div, popup_special_payment_conditions_for_beneficiary_bg);
    });
    $("#specialPaymentConditionsForBeneficiaryPopupSave").click(onSpecialPaymentConditionsForBeneficiaryPopupSaveClick);
});