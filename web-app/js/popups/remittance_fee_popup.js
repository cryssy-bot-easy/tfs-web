$(document).ready(function() {
	var popup_remittance_div = $('#popup_remittance');
	var popup_remittance_bg = $('#popupBackground_remittance');

	$('.edit_remittance_fee').click(function() {
		//centering with css
		mCenterPopup(popup_remittance_div, popup_remittance_bg);
		//load popup
		mLoadPopup(popup_remittance_div, popup_remittance_bg);	
	});
	$('.popupClose_remittance').click(closeRemittanceFee);

	function closeRemittanceFee(){
		mDisablePopup(popup_remittance_div, popup_remittance_bg);	
	}
	
	
});

$(document).ready(function() {

	$('#edit_cable_fee').click(openCableFee);
	$('.popupClose_cable_fee').click(closeCableFee);
	$('.popupConfirm_cable_fee').click(openPopupX);
});

function openCableFee() {
	centerPopup($('#popup_cable_fee').attr("id"), $('#popupBackground_cable_fee').attr("id"));
	loadPopup($('#popup_cable_fee').attr("id"), $('#popupBackground_cable_fee').attr("id"));
}

function closeCableFee() {
	disablePopup($('#popup_cable_fee').attr("id"), $('#popupBackground_cable_fee').attr("id"));
}