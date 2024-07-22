$(document).ready(function() {
	var popup_div_cif_normal = $('#popup_cif');
	var popup_bg_cif_normal = $('#popupBackground_cif');

	$('.popup_btn_cif').click(openCIFNormal);
	$('#popup_btn_cif').click(openCIFNormal);
	$('#popupClose_cif').click(closeCIFNormal);

function openCIFNormal() {
	mCenterPopup(popup_div_cif_normal, popup_bg_cif_normal);
	mLoadPopup(popup_div_cif_normal, popup_bg_cif_normal);	
}

function closeCIFNormal() {
	mDisablePopup(popup_div_cif_normal, popup_bg_cif_normal);
}
});