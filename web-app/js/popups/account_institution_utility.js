$(function(){
	var popup_div_account_institution = "popup_div_account_institution";
	var popup_bg_account_institution = "popup_bg_account_institution";
	
	$("#popup_btn_account_institution").click(function(){
		$("#accountWithInstitutionComment").val($("#accountNameAndAddress").val());
		$("#accountWithInstitutionComment").limitCharAndLines(35, 4);
		//centering with css
        centerPopup(popup_div_account_institution, popup_bg_account_institution);
        //load popup
        loadPopup(popup_div_account_institution, popup_bg_account_institution);
	});
	
	$(".popup_close_account_institution").click(function(){
		$("#accountWithInstitutionComment").val("");
		//disable popup
        disablePopup(popup_div_account_institution, popup_bg_account_institution);
	});
	
	$("#accountWithInstitutionPopupSave").click(function(){
		$("#accountNameAndAddress").val($("#accountWithInstitutionComment").val().toUpperCase());
		//disable popup
        disablePopup(popup_div_account_institution, popup_bg_account_institution);
	});
	
	$("#accountWithInstitutionComment").limitCharAndLines(35, 4);
})