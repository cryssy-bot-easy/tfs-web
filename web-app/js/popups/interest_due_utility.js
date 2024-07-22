$(document).ready(function() {
	var popup_interest_due_div = $('#popup_interest_due').attr("id");
	var popup_interest_due_bg = $('#popupBackground_interest_due').attr("id");

	
	$('#edit_interest_due').click(function() {
		//centering with css
		centerPopup(popup_interest_due_div, popup_interest_due_bg);
		//load popup
		loadPopup(popup_interest_due_div, popup_interest_due_bg);	
	});
	$('.popupClose_interest_due').click(function() {
		disablePopup(popup_interest_due_div, popup_interest_due_bg);
	});
	$('.popupConfirm_interest_due').click(function() {
		disablePopup(popup_interest_due_div, popup_interest_due_bg);
		openPopupX();
	});
});