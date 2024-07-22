$(document).ready(function() {
	var popup_cable_div = $('#popup_cable_fee');
	var popup_cable_bg = $('#popupBackground_cable_fee');

	$('.edit_cable_fee').click(function() {
		//centering with css
		mCenterPopup(popup_cable_div, popup_cable_bg);
		//load popup
		mLoadPopup(popup_cable_div, popup_cable_bg);
	});
	$('.popupClose_cable_fee').click(function() {
		mDisablePopup(popup_cable_div, popup_cable_bg);
	});
	$('.popupConfirm_cable_fee').click(function() {
		mDisablePopup(popup_cable_div, popup_cable_bg);
		openPopupX();
	});
});

