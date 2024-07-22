var popup_digisign = $("#popup_processing_unit_code");
var popup_bg_digisign = $("#popupBackground_digital_signatories");

function openBillingStatementPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateBillingStatementForCash');
	mCenterPopup(popup_digisign,popup_bg_digisign);
	mLoadPopup(popup_digisign,popup_bg_digisign);
}