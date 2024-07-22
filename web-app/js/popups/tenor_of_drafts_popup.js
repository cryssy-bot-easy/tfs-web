function onTenorOfDraftPopupSaveClick() {
    var tenorOfDraftComment = $("#tenorOfDraftComment").val();

    if($("#tenorOfDraftNarrativeTo").length > 0) {
        $("#tenorOfDraftNarrativeTo").val(tenorOfDraftComment);
    } else {
        $("#tenorOfDraftNarrative").val(tenorOfDraftComment);
    }

    disablePopup("popup_tenorOfDraft", "tenor_bg");
}

$(document).ready(function(){
	var wrapper_div=$("#popup_tenorOfDraft").attr("id");
	var div_bg=$("#tenor_bg").attr("id");
	
	$("#popup_btn_tenor_draft").click(function(){
        $("#tenorOfDraftComment").val(($("#tenorOfDraftNarrativeTo").length > 0) ? $("#tenorOfDraftNarrativeTo").val() : $("#tenorOfDraftNarrative").val());

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_tenor1, #close_tenor2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#tenorOfDraftComment").limitCharAndLines(35,3);

	$("#tenorOfDraftPopupSave").click(onTenorOfDraftPopupSaveClick);
});

