$(document).ready(function(){
	var wrapper_div=$("#popup_exporterCbCode").attr("id");
	var div_bg=$("#exporter_cb_code_bg").attr("id");
	
	$("#popup_btn_exporter_cb_code").click(function(){
		$("#popup_header_exporterCbCode").text("Exporter CB Code Search");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_exporterCbCode2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	$("#close_exporterCbCode1").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
});