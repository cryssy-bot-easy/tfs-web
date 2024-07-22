$(document).ready(function() {
	var popup_cancellation_fee_div = $('#popup_cancellation_fee');
	var popup_cancellation_fee_bg = $('#popupBackground_cancellation_fee');

	
	$('.edit_cancellation_fee').click(function() {
		//centering with css
		mCenterPopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
		//load popup
		mLoadPopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);	
	});
	$('.popupClose_cancellation_fee').click(function() {
		mDisablePopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
	});
	$('.popupConfirm_cancellation_fee').click(function() {
		mDisablePopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
		openPopupX();
	});
	
});