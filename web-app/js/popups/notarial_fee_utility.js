$(document).ready(function() {
	var popup_notarial_fee_div = $('#notarialFeePopup').attr("id");
	var popup_notarial_fee_bg = $('#popupBackground_notarial_fee').attr("id");

	
	$('#edit_notarial_fee').click(function() {
		//centering with css
		centerPopup(popup_notarial_fee_div, popup_notarial_fee_bg);
		//load popup
		loadPopup(popup_notarial_fee_div, popup_notarial_fee_bg);	
	});
	$('.popupClose_notarial_fee').click(function() {
		disablePopup(popup_notarial_fee_div, popup_notarial_fee_bg);
	});
	$('.popupConfirm_notarial_fee').click(function() {
		disablePopup(popup_notarial_fee_div, popup_notarial_fee_bg);
		openPopupX();
	});
	
});