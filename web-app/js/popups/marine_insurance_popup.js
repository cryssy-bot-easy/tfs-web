$(document).ready(function() {
	var popup_marine_insurance_div = $('#popup_marine_insurance');
	var popup_marine_insurance_bg = $('#popupBackground_marine_insurance');

	$('.edit_marine_insurance').click(function() {
		//centering with css
		mCenterPopup(popup_marine_insurance_div, popup_marine_insurance_bg);
		//load popup
		mLoadPopup(popup_marine_insurance_div, popup_marine_insurance_bg);	
	});
	$('.popupClose_marine_insurance').click(function() {
		mDisablePopup(popup_marine_insurance_div, popup_marine_insurance_bg);
	});
	$('.popupConfirm_marine_insurance').click(function() {
		mDisablePopup(popup_marine_insurance_div, popup_marine_insurance_bg);
		openPopupX();
	});
});