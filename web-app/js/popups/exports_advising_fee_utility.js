function openExportsAdvisingFeePopup() {
    $("#exportsAdvisingFeePopupField").val($("#ADVISING-EXPORT").val());
    loadPopup("exportsAdvisingFeePopup", "popupBackground_exports_advising_fee");
    centerPopup("exportsAdvisingFeePopup", "popupBackground_exports_advising_fee");
}

function closeExportsAdvisingFeePopup() {
    disablePopup("exportsAdvisingFeePopup", "popupBackground_exports_advising_fee");
}

function initializeExportsAdvisingFee() {
    $("#edit_exports_advising_fee").click(openExportsAdvisingFeePopup);
    $(".popupClose_exports_advising_fee").click(closeExportsAdvisingFeePopup);
}

$(initializeExportsAdvisingFee);