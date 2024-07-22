function onPeriodForPresentation2PopupSaveClick() {
    var periodForPresentation = $("#periodForPresentation2Comment").val();

    disablePopup("popup_period_for_presentation2","bg_period_for_presentation2");

    if($("#periodForPresentationTo").length > 0) {
        $("#periodForPresentationTo").val(periodForPresentation);
    } else {
        $("#periodForPresentation").val(periodForPresentation);
    }

}

$(document).ready(function(){
	var wrapper_div=$("#popup_period_for_presentation2").attr("id");
	var div_bg=$("#bg_period_for_presentation2").attr("id");
	
	$("#btn_period_of_presention2").click(function(){
        $("#periodForPresentation2Comment").val(function(){
        	if($("#periodForPresentationTo").length > 0) {
                return $("#periodForPresentationTo").val();
            } else if($("#periodForPresentation").length > 0){
                return $("#periodForPresentation").val();
            } else {
            	return "";
            }
        });

		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		$("#periodForPresentation2Comment").limitCharAndLines(35,4);
	});
	$("#link_close_period2, #btn_close_period2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	$("#periodForPresentation2Comment").limitCharAndLines(35,4);
	
    $("#periodForPresentation2PopupSave").click(onPeriodForPresentation2PopupSaveClick);
});