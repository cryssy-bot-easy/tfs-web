$(document).ready(function() {
	var popup_advising_fee_div = $('#popup_advising_fee');
	var popup_advising_fee_bg = $('#popupBackground_advising_fee');

	
	$('.edit_advising_fee').click(function() {
		//centering with css
		mCenterPopup(popup_advising_fee_div, popup_advising_fee_bg);
		//load popup
		mLoadPopup(popup_advising_fee_div, popup_advising_fee_bg);	
	});
	$('.popupClose_advising_fee').click(function() {
		mDisablePopup(popup_advising_fee_div, popup_advising_fee_bg);
	});
	$('.popupConfirm_advising_fee').click(function() {
		mDisablePopup(popup_advising_fee_div, popup_advising_fee_bg);
		openPopupX();
	});
});