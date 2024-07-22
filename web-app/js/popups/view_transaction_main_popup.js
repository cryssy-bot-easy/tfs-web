$(document).ready(function(){
	var popup_wrapper = $('#view_transaction_main_popup').attr("id");
	var popup_bg = $('#view_transaction_main_popup_bg').attr("id");

	
//	$(".viewInquiryMain").live("click",function(){
    $(".viewInquiryMain").click(function () {
		$("#view_transaction_main_popup_header").text("View Transactions");
		//centering with css
		$('#view_transaction_main_popup').height(220);
		$('#view_transaction_main_popup').width(600);
		centerPopup(popup_wrapper, popup_bg);
		//load popup
		loadPopup(popup_wrapper, popup_bg);	
	});

	$('#view_transaction_main_popup_close').click(function() {
		disablePopup(popup_wrapper, popup_bg);
	});
	$('#cancelView').click(function() {
		disablePopup(popup_wrapper, popup_bg);
	});
});