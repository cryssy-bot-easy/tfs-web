/*
 * Created by: Rafael Ski Poblete 
 * Date : 7/26/18
 * Description : Handles charges narrative popup behaviour.
 * 
 * Date : 8/08/18
 * Description : removed white space handling.
 * */
function hasWhiteSpace(s) {
		return s.indexOf(' ') >= 0;
	}
function onChargeNarrativePopupSaveClick() {
    var chargeNarrative = $("#chargeNarrativeComment").val().toUpperCase();
    if($("#chargeNarrativeTo").length > 0) {
        $("#chargeNarrativeTo").val(chargeNarrative);
    } else if($("#chargeNarrativeTextArea").length > 0) {
		$("#chargeNarrativeTextArea").val(chargeNarrative);
	} else {
        $("#chargeNarrative").val(chargeNarrative);
    }
    
    disablePopup("charge_narrative_popup", "charge_narrative_bg");
}

$(function (){
	var popup_charge_narrative_div = $('#charge_narrative_popup').attr("id");
	var popup_charge_narrative_bg = $('#charge_narrative_bg').attr("id");

	
	$('#popup_btn_charge_narrative').click(function (){
        $("#chargeNarrativeComment").val(($("#chargeNarrativeTo").length > 0 ) ? $("#chargeNarrativeTo").val() : ($("#chargeNarrativeTextArea").length > 0) ? $("#chargeNarrativeTextArea").val() : ($("#chargeNarrative").length > 0 ) ? $("#chargeNarrative").val() : ($("#chargeNarrativeMt").length > 0 ) ? $("#chargeNarrativeMt").val() : '');
		//centering with css
		centerPopup(popup_charge_narrative_div, popup_charge_narrative_bg);
		//load popup
		loadPopup(popup_charge_narrative_div, popup_charge_narrative_bg);
		$("#chargeNarrativeComment").focus();
		$("#chargeNarrativeComment").limitCharAndLines(35, 6, 'Z');
	});
	$('.charge_narrative_close').click(function (){
		$("#chargeNarrativeComment").val("");
		disablePopup(popup_charge_narrative_div, popup_charge_narrative_bg);
	});
	
	$("#chargeNarrativeComment").limitCharAndLines(35, 6, 'Z');
	
    $("#chargeNarrativePopupSave").click(onChargeNarrativePopupSaveClick);
});