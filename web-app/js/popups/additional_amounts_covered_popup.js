function onAdditionalAmountsCoveredPopupSaveClick() {
    var additionalAmountCovered = $("#additionalAmountCoveredComment").val();

    if($("#additionalAmountsCoveredTo").length > 0) {
        $("#additionalAmountsCoveredTo").val(additionalAmountCovered);
    } else {
        $("#additionalAmountsCovered").val(additionalAmountCovered);
    }

    disablePopup("popup_additionalAmtCovered", "addtional_amounts_covered_bg");
}

$(document).ready(function(){
	var wrapper_div=$("#popup_additionalAmtCovered").attr("id");
	var div_bg=$("#addtional_amounts_covered_bg").attr("id");
	
	$("#popup_btn_additional_amounts_covered").click(function(){
        $("#additionalAmountCoveredComment").val(($("#additionalAmountsCoveredTo").length > 0) ? $("#additionalAmountsCoveredTo").val() : $("#additionalAmountsCovered").val());

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_additionalAmtCovered1, #close_additionalAmtCovered2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#additionalAmountCoveredComment").limitCharAndLines(35,4);

	$("#additionalAmountsCoveredPopupSave").click(onAdditionalAmountsCoveredPopupSaveClick);
	
});