function onotherChargesPopupSaveClick() {
    var otherChargesComment = $("#otherChargesComment").val();

    if($("#otherChargesTo").length > 0) {
        $("#otherChargesTo").val(otherChargesComment);
    } else if($("#otherCharges").length > 0) {
    	$("#otherCharges").val(otherChargesComment);
    } else {
        $("#otherCharges").val(otherChargesComment);
    }

    disablePopup("popup_otherCharges","other_charges_bg");
}

$(document).ready(function(){
	var wrapper_div=$("#popup_otherCharges").attr("id");
	var div_bg=$("#other_charges_bg").attr("id");
	
	$("#popup_btn_other_charges").click(function(){
        $("#otherChargesComment").val(($("#otherChargesTo").length > 0) ? $("#otherChargesTo").val() : $("#otherCharges").val());

        centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	$("#close_otherCharges1, #close_otherCharges2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#otherChargesComment").limitCharAndLines(35,6, 'Z');

    $("#otherChargesPopupSave").click(onotherChargesPopupSaveClick);

});