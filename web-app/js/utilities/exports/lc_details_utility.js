$(function(){
	$("#lc_details_tab span.asterisk").hide();
	$("#lc_details_tab input[type=text], #lc_details_tab textarea").attr("readonly","readonly");
	$("#lc_details_tab .datepicker_field").removeClass("datepicker_field").addClass("input_field").datepicker("destroy");
	$("#lc_details_tab select, #lc_details_tab input[type=radio]").attr("disabled","disabled");
});