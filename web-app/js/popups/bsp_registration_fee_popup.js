//$(document).ready(function() {
//	var popup_bsp_registration_fee_div = $('#popup_bsp_registration_fee');
//	var popup_bsp_registration_fee_bg = $('#popupBackground_bsp_registration_fee');
//
//
//	$('#edit_bsp_registration_fee').click(function() {
//		//centering with css
//		mCenterPopup(popup_bsp_registration_fee_div, popup_bsp_registration_fee_bg);
//		//load popup
//		mLoadPopup(popup_bsp_registration_fee_div, popup_bsp_registration_fee_bg);
//	});
//	$('.popupClose_bsp_registration_fee').click(function() {
//		mDisablePopup(popup_bsp_registration_fee_div, popup_bsp_registration_fee_bg);
//	});
//	$('.popupConfirm_bsp_registration_fee').click(function() {
//		mDisablePopup(popup_bsp_registration_fee_div, popup_bsp_registration_fee_bg);
//		openPopupX();
//	});
//
//});


function openBspRegistrationPopup() {

    $("#bspFeePopupField").val($("#BSP").val());
//    $("#bspFeePopupFieldCurrency").val($("#bspFeeCurrency").val());
    loadPopup("bspFeePopup", "popupBackground_bsp_registration_fee");
    centerPopup("bspFeePopup", "popupBackground_bsp_registration_fee");
}

function closeBspRegistrationPopup() {
    disablePopup("bspFeePopup", "popupBackground_bsp_registration_fee");
}

function initializeBspRegistrationFee() {
    $("#edit_bsp_registration_fee").click(openBspRegistrationPopup);
    $(".popupClose_bsp_registration_fee").click(closeBspRegistrationPopup);
}

$(initializeBspRegistrationFee);