$(document).ready(function(){
	var wrapper_div=$("#requiredDocListPopup").attr("id");
	var div_bg=$("#requiredDocListPopup_bg").attr("id");
	
	$("#btnAddConditionRequiredDoc").click(function(){
		$("#requiredDocListPopupField").val("");		
		$("#popup_header_addCondition1").text("Add Comment");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#requiredDocListPopupClose, #btnRequiredDocListPopupClose").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
//	$(".confirm_condition1").click(function(){
//		disablePopup(wrapper_div,div_bg);
//		openPopupX();
//	});
	
	computeCharactersRequiredDoc();
});

//Author:Arvin
function computeCharactersRequiredDoc() {
	var l = 350;
	$("#requiredDocListPopup #remainingCharacter").text(l)
	$("#requiredDocListPopup #add_comment").keydown(onAddText);
	$("#requiredDocListPopup #add_comment").keyup(onAddText);
	$("#requiredDocListPopup #add_comment")
			.keypress(onAddText);

	function onAddText() {
		if ($("#requiredDocListPopup #add_comment").val().length > l) {
			$("#requiredDocListPopup #add_comment").val(
					$("#requiredDocListPopup #add_comment")
							.val().substring(0, (l)));
		} else {
			var m = $("#requiredDocListPopup #add_comment")
					.val().length;
			k = l - m;
			if (k >= 0) {
				$("#requiredDocListPopup #remainingCharacter")
						.text(k);
			} else if (k < 0) {
				$("#requiredDocListPopup #remainingCharacter")
						.text("0");
			}
		}
	}
}