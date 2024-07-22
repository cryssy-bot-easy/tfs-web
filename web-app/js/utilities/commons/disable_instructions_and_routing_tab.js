$(function(){
	$("#instructionsAndRoutingTabForm a").each(function(){
		$(this).remove();
	});
	$("#instructionsAndRoutingTabForm :input").each(function(){
		if($(this).attr("type") == "text" || $(this).attr("type")=="textarea") {
			if(!$(this).attr("readonly"))
				$(this).attr("readonly", "readonly");
			if($(this).hasClass("datepicker_field")){
				$(this).datepicker("destroy");
				$(this).removeClass("datepicker_field").addClass("input_field");
			}
		} 
		else if($(this).attr("type")=="button"||$(this).attr("type")=="submit"){
			$(this).remove();
		}
		else {
            if ($(this).attr("type") != "hidden") {
            	$(this).parents("table").remove();
//                if(!$(this).attr("disabled"))
//                    $(this).attr("disabled","disabled");
            }
		}
	});
	$("div#add_instructions_popup").remove();
});