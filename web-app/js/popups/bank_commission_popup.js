$(document).ready(function() {
	var popup_bankCommision_div = $('#popup_bank_commission');
	var popup_bankCommision_bg = $('#popupBackground_bank_commission');

	$('.edit_bank_commission').click(function() {
		//centering with css
		mCenterPopup(popup_bankCommision_div, popup_bankCommision_bg);
		//load popup
		mLoadPopup(popup_bankCommision_div, popup_bankCommision_bg);
	});
	$('.popupClose_bank_commission').click(function() {
		mDisablePopup(popup_bankCommision_div, popup_bankCommision_bg);
	});
	$('.popupConfirm_bank_commission').click(function() {
		mDisablePopup(popup_bankCommision_div, popup_bankCommision_bg);
		openPopupX();
	});
});