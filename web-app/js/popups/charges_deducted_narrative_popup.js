/*
 * Created by: Rafael Ski Poblete 
 * Date : 9/10/18
 * Description : Handles charge deducted narrative popup behaviour.
 * */
function hasWhiteSpace(s) {
		return s.indexOf(' ') >= 0;
	}
function onChargesDeductedNarrativePopupSaveClick() {
    var chargesDeductedNarrative = $("#chargesDeductedNarrativeComment").val().toUpperCase();
    if($("#chargesDeductedNarrativeTo").length > 0) {
        $("#chargesDeductedNarrativeTo").val(chargesDeductedNarrative);
    } else if($("#chargesDeductedNarrativeTextArea").length > 0) {
		$("#chargesDeductedNarrativeTextArea").val(chargesDeductedNarrative);
	} else {
        $("#chargesDeductedNarrative").val(chargesDeductedNarrative);
    }
    
    disablePopup("charges_deducted_narrative_popup", "charges_deducted_narrative_bg");
}

$(function (){
	var popup_charges_deducted_narrative_div = $('#charges_deducted_narrative_popup').attr("id");
	var popup_charges_deducted_narrative_bg = $('#charges_deducted_narrative_bg').attr("id");

	
	$('#popup_btn_charges_deducted_narrative').click(function (){
        $("#chargesDeductedNarrativeComment").val(($("#chargesDeductedNarrativeTo").length > 0 ) ? $("#chargesDeductedNarrativeTo").val() : ($("#chargesDeductedNarrativeTextArea").length > 0) ? $("#chargesDeductedNarrativeTextArea").val() : ($("#chargesDeductedNarrative").length > 0 ) ? $("#chargesDeductedNarrative").val() : ($("#chargesDeductedNarrativeMt").length > 0 ) ? $("#chargesDeductedNarrativeMt").val() : '');
		//centering with css
		centerPopup(popup_charges_deducted_narrative_div, popup_charges_deducted_narrative_bg);
		//load popup
		loadPopup(popup_charges_deducted_narrative_div, popup_charges_deducted_narrative_bg);
		$("#chargesDeductedNarrativeComment").focus();
		$("#chargesDeductedNarrativeComment").limitCharAndLines(35, 5, 'Z');
	});
	$('.charges_deducted_narrative_popup_close').click(function (){
		$("#chargesDeductedNarrativeComment").val("");
		disablePopup(popup_charges_deducted_narrative_div, popup_charges_deducted_narrative_bg);
	});
	
	$("#chargesDeductedNarrativeComment").limitCharAndLines(35, 5, 'Z');
	
    $("#chargesDeductedNarrativePopupSave").click(onChargesDeductedNarrativePopupSaveClick);
});