$(document).ready(function() {
	var popup_notarial_fee_div = $('#popup_notarial_fee');
	var popup_notarial_fee_bg = $('#popupBackground_notarial_fee');

	
	$('.edit_notarial_fee').click(function() {
		//centering with css
		mCenterPopup(popup_notarial_fee_div, popup_notarial_fee_bg);
		//load popup
		mLoadPopup(popup_notarial_fee_div, popup_notarial_fee_bg);	
	});
	$('.popupClose_notarial_fee').click(function() {
		mDisablePopup(popup_notarial_fee_div, popup_notarial_fee_bg);
	});
	$('.popupConfirm_notarial_fee').click(function() {
		mDisablePopup(popup_notarial_fee_div, popup_notarial_fee_bg);
		openPopupX();
	});
	
});