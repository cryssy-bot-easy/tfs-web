$(document).ready(function(){
	var popup_cilex_div = $('#popup_cilex_fee');
	var popup_cilex_bg = $('#popupBackground_cilex');

	$('.edit_CILEX').click(function() {
		//centering with css
		mCenterPopup(popup_cilex_div, popup_cilex_bg);
		//load popup
		mLoadPopup(popup_cilex_div, popup_cilex_bg);	
	});
	$('.popupClose_cilex_fee').click(function() {
		mDisablePopup(popup_cilex_div, popup_cilex_bg);
	});
	$('.popupConfirm_cilex_fee').click(function() {
		mDisablePopup(popup_cilex_div, popup_cilex_bg);
		openPopupX();
	});

	
});