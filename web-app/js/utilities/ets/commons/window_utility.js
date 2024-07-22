$(function(){
	$(".datepicker_field").removeClass("datepicker_field").addClass("input_field");
	$("#expiryDate").attr("id", "_expiryDate")
	$("input, textarea").attr("readonly", "readonly");
	$("input[type=radio], input[type=checkbox], input[type=file], select").attr("disabled", "disabled");
	$(".search_btn, .search_btn2, .popup_btn, .popup_btn_bottom, #add_instruction, .add_btn, .etsButtons, .openSaveConfirmation").hide();
	$(".input_button, .input_button_alert, .input_button2, .input_button3, .input_button_long, .input_button_long2, .input_button_long3").hide();
	$(".input_button_negative, .input_button_negative2, .input_button_negative3, .input_button_negative_long").hide();
	$("#makerButton, #checkerButton, #approverButton, #userRole").hide();
	$("#add_instruction").parents("ul").hide();

	$(".numericCurrency, .numericQuantity, .numericWholeQuantity, .numericPercentage").focus(function(){
    	$(this).blur();
    });
	$("#close").click(function(){
  		window.close();
  	});
	$("div#body_forms div[class^=grid_wrapper]").block({message:null,overlayCSS:{cursor:"default",opacity:0.2,"z-index":2}});
});