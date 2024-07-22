/*
 * Created by: Rafael Ski Poblete 
 * Date : 9/10/18
 * Description : Handles narrative popup behaviour.
 * */
function onNarrativePopupSaveClick() {
    var narrative = $("#narrativeComment").val().toUpperCase();
    if($("#narrativeTo").length > 0) {
        $("#narrativeTo").val(narrative);
    } else if($("#narrativeTextArea").length > 0) {
		$("#narrativeTextArea").val(narrative);
	} else {
        $("#narrative").val(narrative);
    }
    
    disablePopup("narrative_popup", "narrative_bg");
}

$(function (){
	var popup_narrative_div = $('#narrative_popup').attr("id");
	var popup_narrative_bg = $('#narrative_bg').attr("id");

	
	$('#popup_btn_narrative').click(function (){
        $("#narrativeComment").val(($("#narrativeTo").length > 0 ) ? $("#narrativeTo").val() : ($("#narrativeTextArea").length > 0) ? $("#narrativeTextArea").val() : ($("#narrative").length > 0 ) ? $("#narrative").val() : ($("#narrativeMt").length > 0 ) ? $("#narrativeMt").val() : '');
		//centering with css
		centerPopup(popup_narrative_div, popup_narrative_bg);
		//load popup
		loadPopup(popup_narrative_div, popup_narrative_bg);
		$("#narrativeComment").focus();
		$("#narrativeComment").limitCharAndLines(50, 35, 'Z');
	});
	$('.narrative_close').click(function (){
		$("#narrativeComment").val("");
		disablePopup(popup_narrative_div, popup_narrative_bg);
	});
	
	$("#narrativeComment").limitCharAndLines(50, 35, 'Z');
	
    $("#narrativePopupSave").click(onNarrativePopupSaveClick);
});