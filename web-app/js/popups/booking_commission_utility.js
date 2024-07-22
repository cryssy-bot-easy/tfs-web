function openBookingCommissionPopup() {
    $("#bookingCommissionPopupField").val($("#BOOKING").val());
    loadPopup("bookingCommissionPopup", "popupBackground_booking_commission");
    centerPopup("bookingCommissionPopup", "popupBackground_booking_commission");
}

function closeBookingCommissionPopup() {
    disablePopup("bookingCommissionPopup", "popupBackground_booking_commission");
}

function initializeBookingCommission() {
    $("#edit_booking_commission").click(openBookingCommissionPopup);
    $(".popupClose_booking_commission").click(closeBookingCommissionPopup);
}

$(initializeBookingCommission);