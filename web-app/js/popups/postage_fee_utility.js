$(document).ready(function() {

    $('#edit_postage_fee').click(openPostageFee);
    $('.popupClose_postage').click(closePostageFee);
    $('.popupConfirm_postage').click(closePostageFee);
});

function openPostageFee() {
    $("#postageFeePopupField").val($("#POSTAGE").val());
    centerPopup('postageFeePopup', 'popupBackground_postage');
    loadPopup('postageFeePopup', 'popupBackground_postage');
}

function closePostageFee() {
    disablePopup('postageFeePopup', 'popupBackground_postage');
}