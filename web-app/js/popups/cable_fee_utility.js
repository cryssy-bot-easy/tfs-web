function openCableFeePopup() {
    $("#cableFeePopupField").val($("#CABLE").val());
    loadPopup("cableFeePopup", "popupBackground_cable_fee");
    centerPopup("cableFeePopup", "popupBackground_cable_fee");
}

function closeCableFeePopup() {
    disablePopup("cableFeePopup", "popupBackground_cable_fee");
}

function initializeCableFee() {
    $("#edit_cable_fee").click(openCableFeePopup);
    $(".popupClose_cable_fee").click(closeCableFeePopup);
}

$(initializeCableFee);