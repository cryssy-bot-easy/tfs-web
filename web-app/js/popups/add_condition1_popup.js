$(document).ready(function(){
	var wrapper_div=$("#popup_addCondition1").attr("id");
	var div_bg=$("#add_condition1_bg").attr("id");

	$(".popup_btn_add_condition1").click(function(){
        $("#statusAction").val("addInstructions");
        $("#additionalCondition").val("");
		$("#popup_header_addCondition1").text("Add Comment");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_addCondition1_1, #close_addCondition1_2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
});