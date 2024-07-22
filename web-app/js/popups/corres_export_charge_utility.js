$(document).ready(function() {

    $('#edit_corres_export_charge').click(openCorresExportCharge);
    $('.popupClose_corres_export').click(closeCorresExportCharge);
    $('.popupConfirm_corres_export').click(closeCorresExportCharge);
});

function openCorresExportCharge() {
    $("#corresExportChargePopupField").val($("#CORRES-EXPORT").val());
    centerPopup('corresExportChargePopup', 'popupBackground_corres_export');
    loadPopup('corresExportChargePopup', 'popupBackground_corres_export');
}

function closeCorresExportCharge() {
    disablePopup('corresExportChargePopup', 'popupBackground_corres_export');
}