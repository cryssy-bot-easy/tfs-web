/**
 * (revision)
SCR/ER Number: 
SCR/ER Description: Redmine Issue #4168 - EBP Negotiation e-ts, the field Main CIF Number should have a ellipsis.
[Revised by:] John Patrick C. Bautista
[Date deployed:] 06/16/2017
Program [Revision] Details: Added new calls for class and id for Main CIF in EBP Nego eTS.
							Added separate methods to be called for Main CIF in EBP Nego eTS only but with same body as other methods.
Member Type: JavaScript file (JS)
Project: WEB
Project Name: cif_main_search_popup.js
 */

var popup_div_cif_main = $('#popup_cif_main');
var popup_bg_cif_main = $('#popupBackground_cif_main');
$(document).ready(function() {

	$('.popup_btn_cif_main').click(openCIFMain);
	$('#popupClose_cif_main').click(closeCIFMain);
	
	// Redmine 4168 - Call method for EBP Nego eTS only
	$('.popup_btn_cif_main_new').click(openMainCIFNew);
	$('#popupClose_cif_main_new').click(closeMainCIFNew);
});

function openCIFMain() {
    onCifResetClick();
	mCenterPopup(popup_div_cif_main, popup_bg_cif_main);
	mLoadPopup(popup_div_cif_main, popup_bg_cif_main);	
}

function closeCIFMain() {
	mDisablePopup(popup_div_cif_main, popup_bg_cif_main);
}

// Redmine 4168 - Call common div but customized method for EBP Nego eTS
function openMainCIFNew() {
	mCenterPopup(popup_div_cif_main, popup_bg_cif_main);
	mLoadPopup(popup_div_cif_main, popup_bg_cif_main);	
}

function closeMainCIFNew() {
	mDisablePopup(popup_div_cif_main, popup_bg_cif_main);
}
