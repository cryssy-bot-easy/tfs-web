function openOtherLocalBankChargesPopup() {
    $("#otherLocalBankChargesPopupField").val($("#OTHER-EXPORT").val());
    loadPopup("otherLocalBankChargesPopup", "popupBackground_other_local_bank_charges");
    centerPopup("otherLocalBankChargesPopup", "popupBackground_other_local_bank_charges");
}

function closeOtherLocalBankChargesPopup() {
    disablePopup("otherLocalBankChargesPopup", "popupBackground_other_local_bank_charges");
}

function initializeExportsAdvisingFee() {
    $("#edit_other_local_bank_charges").click(openOtherLocalBankChargesPopup);
    $(".popupClose_other_local_bank_charges").click(closeOtherLocalBankChargesPopup);
}

$(initializeExportsAdvisingFee);