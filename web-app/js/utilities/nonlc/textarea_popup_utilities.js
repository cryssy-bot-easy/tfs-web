/*
 * Generic Textarea Popup
 * created by: Arvin Guiam
 * requires: textarea_utility.js
 * */

$(function() {
	var popup_textarea_div = $('#textarea_popup').attr('id');
	var popup_textarea_bg = $('#textarea_bg').attr('id');
	
	$("#popup_btn_regulatoryReporting").click(function(){
		$("#textarea_action").val($(this).siblings('textarea').attr('id'));
		$("#textarea_remainingLines").parents("span").show();
		$("#textarea_message").val($(this).siblings('textarea').val());
		$("#header_textarea_popup").text("Edit Regulatory Reporting");
		//centering with css
        centerPopup(popup_textarea_div, popup_textarea_bg);
        //load popup
        loadPopup(popup_textarea_div, popup_textarea_bg);
        $("#textarea_message").limitCharAndLines(35, 3);
	});
	$("#popup_btn_envelopeContents").click(function(){
		$("#textarea_action").val($(this).siblings('textarea').attr('id'));
		$("#textarea_remainingLines").parents("span").hide();
		$("#textarea_message").val($(this).siblings('textarea').val());
		$("#header_textarea_popup").text("Edit Envelope Contents");
		//centering with css
        centerPopup(popup_textarea_div, popup_textarea_bg);
        //load popup
        loadPopup(popup_textarea_div, popup_textarea_bg);
        $("#textarea_message").limitCharAndLines(9000);
	});
	$("#popup_btn_remittanceInformation").click(function(){
		$("#textarea_action").val($(this).siblings('textarea').attr('id'));
		$("#textarea_remainingLines").parents("span").show();
		$("#textarea_message").val($(this).siblings('textarea').val());
		$("#header_textarea_popup").text("Edit Remittance Information");
		//centering with css
        centerPopup(popup_textarea_div, popup_textarea_bg);
        //load popup
        loadPopup(popup_textarea_div, popup_textarea_bg);
        $("#textarea_message").limitCharAndLines(35, 4);
	});
	
	$(".textarea_close").click(function(){
		disablePopup(popup_textarea_div, popup_textarea_bg);
		$("#textarea_message").val('');
		$("#textarea_action").val('');
	});
	$(".textarea_save").click(function(){
		$("#"+$("#textarea_action").val()).val($("#textarea_message").val());
		$("#"+$("#textarea_action").val()).change();	//triggers event for any event listeners
		disablePopup(popup_textarea_div, popup_textarea_bg);
		$("#textarea_action").val('');
	});

});