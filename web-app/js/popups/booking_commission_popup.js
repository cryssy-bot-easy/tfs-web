$(document).ready(function() {
	var popup_booking_commission_div = $('#popup_booking_commission');
	var popup_booking_commission_bg = $('#popupBackground_booking_commission');

	
	$('.edit_booking_commission').click(function() {
		//centering with css
		mCenterPopup(popup_booking_commission_div, popup_booking_commission_bg);
		//load popup
		mLoadPopup(popup_booking_commission_div, popup_booking_commission_bg);	
	});
	$('.popupClose_booking_commission').click(function() {
		mDisablePopup(popup_booking_commission_div, popup_booking_commission_bg);
	});
	$('.popupConfirm_booking_commission').click(function() {
		mDisablePopup(popup_booking_commission_div, popup_booking_commission_bg);
		openPopupX();
	});
	
});