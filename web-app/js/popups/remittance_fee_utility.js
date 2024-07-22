$(document).ready(function() {

    $('#edit_remittance_fee').click(openRemittanceFee);
    $('.popupClose_remittance').click(closeRemittanceFee);
    $('.popupConfirm_remittance').click(closeRemittanceFee);
});

function openRemittanceFee() {
    $("#remittanceFeePopupField").val($("#REMITTANCE").val());
    centerPopup('remittanceFeePopup', 'popupBackground_remittance');
    loadPopup('remittanceFeePopup', 'popupBackground_remittance');
}

function closeRemittanceFee() {
    disablePopup('remittanceFeePopup', 'popupBackground_remittance');
}