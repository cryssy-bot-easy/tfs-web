$(document).ready(function(){
	var wrapper_div=$("#popup_confirming_fee");
	var div_bg=$("#popupBackground_confirming_fee");
	
	$(".edit_confirming_fee").click(function(){
		$("#popup_header_confirmingFee").text("Confirming Fee");
		mCenterPopup(wrapper_div,div_bg);
		mLoadPopup(wrapper_div,div_bg);
	});
	$(".close_confirmingFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
	});
	$(".confirm_confirmingFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
		openPopupX();
	});
});