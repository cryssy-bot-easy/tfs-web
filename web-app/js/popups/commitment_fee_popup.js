$(document).ready(function(){
	var wrapper_div=$("#popup_commitment_fee");
	var div_bg=$("#popupBackground_commitment_fee");
	
	$(".edit_commitment_fee").click(function(){
		mCenterPopup(wrapper_div,div_bg);
		mLoadPopup(wrapper_div,div_bg);
	});
	$(".close_commitmentFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
	});
	$(".confirm_commitmentFee").click(function(){
		mDisablePopup(wrapper_div,div_bg);
		openPopupX();
	});
});