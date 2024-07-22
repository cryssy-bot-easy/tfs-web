$(document).ready(function() {
	var popup_cancellation_fee_div = $('#cancellationFeePopup').attr("id");
	var popup_cancellation_fee_bg = $('#popupBackground_cancellation_fee').attr("id");
	
	
	$('#edit_cancellation_fee').click(function() {
		//centering with css
		centerPopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
		//load popup
		loadPopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);	
	});
	$('.popupClose_cancellation_fee').click(function() {
		disablePopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
	});
	
	$('.popupConfirm_cancellation_fee_save').click(function() {
		disablePopup(popup_cancellation_fee_div, popup_cancellation_fee_bg);
		openPopupX();
		
	});
	
});