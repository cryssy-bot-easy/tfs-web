$(document).ready(function(){
	var wrapper_div=$("#popup_reqDocuments1").attr("id");
	var div_bg=$("#required_documents_bg1").attr("id");
	
	$("#popup_btn_preview_req_doc1").click(function(){
		$("#popup_header_reqDocuments1").text("Required Documents");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_reqDocuments1_1, #close_reqDocuments1_2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
});