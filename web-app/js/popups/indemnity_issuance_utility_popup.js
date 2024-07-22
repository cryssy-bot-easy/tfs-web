$(document).ready(function(){
	var wrapper_div=$("#popup_indemnity_type").attr("id");
	var div_bg=$("#popup_indemnity_type_bg").attr("id");

	$("#indemnityType").change(function(){
		if($(this).val()=="BANK_GUARANTEE"){
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);			
		}
	});
	$(".popup_indemnity_type_close").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
});