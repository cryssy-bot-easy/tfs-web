$(document).ready(function(){
	//Disable all except for document number
	if('undefined' !== typeof documentNumber && documentNumber == ''){
		//anchors
		$(".tabs_forms_table a").not("ul#tabs a,.select2-choice,#add_instruction, #docEnclosedInstructionsTabForm a").remove();

		//inputs input inputs
		$(".tabs_forms_table :input").each(function(){
			if($(this).attr("id") != "documentNumber" &&
				 $(this).attr("id") != "transactionReferenceNumber" &&
				 $(this).attr("id") != "documentNumberMt799" &&
				 $(this).attr("id") != "lcNumber"){
				if($(this).attr("type") == "text" || $(this).attr("type") == "textarea"){
						$(this).attr("readonly", "readonly");
					if($(this).hasClass("datepicker_field")) {
						$(this).datepicker("destroy");
						$(this).removeClass("datepicker_field").addClass("input_field");
					}
				}else if($(this).hasClass("select2_dropdown")){
					$(this).select2("disable");
				}else{
		            if($(this).attr("type") != "hidden") {
		                $(this).attr("disabled","disabled");
		            }
				}
			}
		});
	}else{
		$("#documentNumber").attr("readonly","readonly");
		$("#lcNumber").attr("readonly","readonly");
		$("#transactionReferenceNumber").attr("readonly","readonly");
		$("#documentNumberMt799").attr("readonly","readonly");
	}
});