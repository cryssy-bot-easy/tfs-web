$(document).ready(function(){
	var wrapper_div=$("#popup_supplies");
	var div_bg=$("#popupBackground_supplies");
	
	$(".edit_supplies_fee").click(function(){
		mCenterPopup(wrapper_div,div_bg);
		mLoadPopup(wrapper_div,div_bg);
	});
	$(".close_suppliesFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
	});
	$(".confirm_suppliesFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
		openPopupX();
	});
});