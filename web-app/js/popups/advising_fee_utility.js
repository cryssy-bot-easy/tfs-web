function openAdvisingFeePopup() {
    $("#advisingFeePopupField").val($("#CORRES-ADVISING").val());
    loadPopup("advisingFeePopup", "popupBackground_advising_fee");
    centerPopup("advisingFeePopup", "popupBackground_advising_fee");
}

function closeAdvisingFeePopup() {
    disablePopup("advisingFeePopup", "popupBackground_advising_fee");
}

function initializeAdvisingFee() {
    $("#edit_advising_fee").click(openAdvisingFeePopup);
    $(".popupClose_advising_fee").click(closeAdvisingFeePopup);
}

$(initializeAdvisingFee);