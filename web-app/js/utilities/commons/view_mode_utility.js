/*
	Disables/Removes inputs, links and buttons if user only wants a view of the 'entry' 
*/
$(function(){

	var viewMode={//extract variables from index page
		rEts :('undefined' !== typeof reverseEtsFlag ? reverseEtsFlag : 
			('undefined' !== typeof reversalDataEntry ? reversalDataEntry : '')),
		vMode : ('undefined' !== typeof _viewMode ? _viewMode : ''),
		hRoute: ('undefined' !== typeof hasRoute ? hasRoute : '')
	};

	//prevent reversal from overriding view mode
	if('' != viewMode.rEts && '' != viewMode.vMode){
		viewMode.rEts = '';
	}

	if("true" == viewMode.rEts || "viewMode" == viewMode.vMode || "true" == viewMode.hRoute){
		//anchors anchors anchors
		if("true" == viewMode.rEts || "true" == viewMode.hRoute){
			$("#body_forms a").not("ul#tabs a,.select2-choice,#add_instruction, #docEnclosedInstructionsTabForm a").remove();
		}else{
			$("#body_forms a#add_instruction").parents("ul.buttons").remove();
			$("#body_forms a").not("ul#tabs a,.select2-choice, #docEnclosedInstructionsTabForm a").remove();
		}

		//inputs input inputs
		$("#body_forms :input").each(function(){
			if("viewMode" != viewMode.vMode && $(this).parents().is($("#basicDetailsTabForm, #setupLcDetailsTabForm, #setupNonLcDetailsTabForm, #docEnclosedInstructionsTabForm")) && documentClass in {BP:1, BC:1}){
				//empty block pass-through
			} else {
				if($(this).attr("type") == "text" || $(this).attr("type") == "textarea") {
					$(this).attr("readonly", "readonly");
					if($(this).hasClass("datepicker_field")) {
						$(this).datepicker("destroy");
						$(this).removeClass("datepicker_field").addClass("input_field");
					}
				}else if($(this).attr("type")=="button" || $(this).attr("type")=="submit") {
					if(("true" == viewMode.rEts || "true" == viewMode.hRoute)
						&& (($(this).parents().is($("#makerButton"))) || 
							($(this).parents().is($("#checkerButton"))) ||
							($(this).parents().is($("#approverButton"))) ||
							($(this).parents().is($("#confirm_buttons"))) ||
							$(this).parents().is($("#add_instruction_buttons")))){
						//empty block pass-through
					}else if (typeof $(this).attr("onclick") !== 'undefined' && $(this).attr("onclick").indexOf("viewOutgoingMt") != -1){
						//empty block pass-through
					}else{
						$(this).remove();
					}
				}else if($(this).hasClass("select2_dropdown")){
					$(this).select2("disable");
				}else{
	                if ($(this).attr("type") != "hidden") {
	                    $(this).attr("disabled","disabled");
	                }
				}
			}
		});
		
		//instructions_and_routing_buttons
		if("true" == viewMode.rEts || "true" == viewMode.hRoute){			
			$("#makerButton *").removeAttr("disabled");
			$("#checkerButton *").removeAttr("disabled");
			$("#approverButton *").removeAttr("disabled");
		}else{
			$("#makerButton *").remove();
			$("#checkerButton *").remove();
			$("#approverButton *").remove();
		}
		
		//numeric formatters
		//$(".numericQuantity").removeClass("numericQuantity");
		//$(".numericCurrency").removeClass("numericCurrency");

		//grids grids grids
		$("div#body_forms div[class^=grid_wrapper] div[class=ui-jqgrid-bdiv] tr").block({message:null,overlayCSS:{cursor:"default",opacity:0.1,"z-index":2,width:"100%"}});
		$(".ui-pg-selbox").removeAttr("disabled");
		$(".ui-pg-input").removeAttr("readonly");
		if("true" == viewMode.rEts || "true" == viewMode.hRoute){
			$("div#grid_list_instructions_routing_remarks_div").unblock();
			if(documentClass in {BP:1, BC:1}){
				$("form#docEnclosedInstructionsTabForm div[class^=grid_wrapper]").unblock();
			}
		}
	}
});