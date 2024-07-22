$(document).ready(function(){
	var wrapper_div=$("#popup_doc_stamp");
	var div_bg=$("#popupBackground_doc_stamp");
	
	$(".edit_documentary_stamp").click(function(){
		mCenterPopup(wrapper_div,div_bg);
		mLoadPopup(wrapper_div,div_bg);
	});
	$(".close_documentaryStamp").click(function(){
		mDisablePopup(wrapper_div,div_bg);
	});
	$(".confirm_documentaryStamp").click(function(){
		mDisablePopup(wrapper_div,div_bg);
		openPopupX();
	});
});