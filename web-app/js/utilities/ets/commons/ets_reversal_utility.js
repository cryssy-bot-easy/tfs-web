$(document).ready(function(){
	var rEts=typeof reverseEts!=='undefined' ? reverseEts:"";

	//Disable all inputs except some if reversal
	if(rEts=='true'){
		$("#body_forms a").not("ul#tabs *").each(function(){
			if($(this).attr("id") != "add_instruction"){
				$(this).remove();
			}
		});
		$("#body_forms :input").each(function(){
			if($(this).attr("type") == "text" || $(this).attr("type")=="textarea") {
				if(!$(this).attr("readonly"))
					$(this).attr("readonly", "readonly");
				if($(this).hasClass("datepicker_field")){
					$(this).datepicker("destroy");
					$(this).removeClass("datepicker_field").addClass("input_field");
				}
			} 
			else if($(this).attr("type")=="button"||$(this).attr("type")=="submit"){
				if($(this).attr("id")!="btnAbort"&&$(this).attr("id")!="btnPrepare"&&!($(this).hasClass("openSaveConfirmation") && $(this).parents("form").attr("id") == "instructionsAndRoutingTabForm")&&!$(this).hasClass("add_instructions_close")){
					$(this).remove();
				}
			}
			else {
                if ($(this).attr("type") != "hidden") {
                    if(!$(this).attr("disabled"))
                        $(this).attr("disabled","disabled");
                }
			}
		});
		//$(".numericQuantity").removeClass("numericQuantity");
		//$(".numericCurrency").removeClass("numericCurrency");
//		
		$("#routeTo").removeAttr("disabled");
//		$("#btnAbort").removeAttr("disabled");
//		$("#btnPrepare").removeAttr("disabled");
	}	
});