function openSuppliesFeePopup() {
    $("#suppliesFeePopupField").val($("#SUP").val());
    loadPopup("suppliesFeePopup", "popupBackground_supplies");
    centerPopup("suppliesFeePopup", "popupBackground_supplies");
}

function closeSuppliesFeePopup() {
    disablePopup("suppliesFeePopup", "popupBackground_supplies");
}

function initializeBankCommission() {
    $("#edit_supplies_fee").click(openSuppliesFeePopup);
    $(".popupClose_suppliesFee").click(closeSuppliesFeePopup);
}

$(initializeBankCommission);