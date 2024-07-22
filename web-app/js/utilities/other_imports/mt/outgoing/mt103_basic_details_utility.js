$(document).ready(function(){
    var tabsToDisable=new Array();
	for(var ctr = 1; ctr < $("#tab_container li").length; ctr++) {
        tabsToDisable.push(ctr)
    }
	if(typeof $("#outgoingTradeServiceId").val() == 'undefined' || $("#outgoingTradeServiceId").val()==""){
		$("#tab_container").tabs({disabled:tabsToDisable});
	}
	
	jQuery.fn.setTransactionTypeCode = function() {
		
	    var elementName = '#'+this.attr("id");
	
	    $(elementName).select2({
	        minimumInputLength: 2,
	        placeholder:"SELECT ONE...",
	        ajax: { // instead of writing the function to execute the request we use Select2's convenient helper
	            url: transactionTypeCodeAutoCompleteUrl,
	            dataType: 'json',
	            data: function (term, page, type) {
	                return {
	                    //featureClass: "P",
	                    //q: term, // search term
	                    type: "FX",
	                    starts_with: term,
	                    page_limit: 10//,
	                    //apikey: "ju6z9mjyajq2djue3gbvv26t" // please do not use so this example keeps working
	                };
	            },
	            results: function (data, page) { // parse the results into the format expected by Select2.
	                //since we are using custom formatting functions we do not need to alter remote JSON data
	                var more = (page * 10) < data.total; // whether or not there are more results available
	
	                // notice we return the value of more so Select2 knows if more results can be loaded
	                return {results: data.results, more: more};
	
	            }
	        },
	        formatResult: formatResultTransactionTypeCode, // omitted for brevity, see the source of this page
	        formatSelection: formatSelectionTransactionTypeCode, // omitted for brevity, see the source of this page
	        dropdownCssClass: "bigdrop" // apply css that makes the dropdown taller
	    });
	
	    return this;
	}

	function formatResultTransactionTypeCode(result) {
		
	    var markup = '<table><tr><td>';
	    markup += '<div>' + result.label + '</div>';
	    markup += '<div class="autocomplete_id_below">' + result.id + '</div>';
	    markup += '</td></tr></table>';
	    return markup;
	}
	
	function formatSelectionTransactionTypeCode(result) {
	    return result.id;
	}
	
	switch ($("#bankOperationCode").val()) {
	case 'SPRI':
		$("#instructionCode").removeAttr("disabled");
		$("#instructionCode").children('option').each(
				function() {
					if ($(this).attr('value') != 'SDVA'
							&& $(this).attr('value') != 'INTC'
							&& $(this).attr('value') != '') {
						$(this).remove();
					}
				});
		break;
	case 'SPAY':
	case 'SSTD':
		$("#instructionCode").attr("disabled", "disabled");
		break;
	default:
		$("#instructionCode").removeAttr("disabled");
		if ($("#instructionCode").children('option').length == 3) {
			$("#instructionCode").append('<option value="REPA">REPA</option>');
			$("#instructionCode").append('<option value="CORT">CORT</option>');
		}
		;
		break;
	}
	
	if ("" != $("#instructionCode").val()) {
		$("#popup_btn_instruction_code").show();
	} else {
		$("#bankOperationTextArea").val("");
		$("#popup_btn_instruction_code").hide();
	}

	//**//
	$("#bankOperationCode").change(function(){
		$("#instructionCode").val('');
		$("#bankOperationTextArea").val("");
		$("#bankOperationTextArea").attr("readonly", "readonly")
		switch($(this).val()){
		case 'SPRI':
			$("#instructionCode").removeAttr("disabled");
			$("#instructionCode").children('option').each(function(){
				if($(this).attr('value') != 'SDVA' && $(this).attr('value') != 'INTC' && $(this).attr('value') != '') {
					$(this).remove();
				}
			});
			break;
		case 'SPAY': case 'SSTD':
			$("#instructionCode").attr("disabled", "disabled");
			break;
		default:
			$("#instructionCode").removeAttr("disabled");
			if($("#instructionCode").children('option').length == 3){
				$("#instructionCode").append('<option value="REPA">REPA</option>');
				$("#instructionCode").append('<option value="CORT">CORT</option>');
			};
			break;
		}
	});
	
	$(".orderingBankFlag").change(function(){
		$(".orderingInstitutionMt103OptionLetter").text($(this).filter(":checked").val());
	});

	$(".sendersCorrespondentFlag").change(function(){
		$(".sendersCorrespondentMt103OptionLetter").text($(this).filter(":checked").val());
	});
	
	$(".receiversCorrespondentFlag").change(function(){
		$(".receiversCorrespondentMt103OptionLetter").text($(this).filter(":checked").val());
	});

	$(".intermediaryFlag").change(function(){
		$(".intermediaryMt103OptionLetter").text($(this).filter(":checked").val());
	});

	$(".accountWithBankFlag").change(function(){
		$(".accountWithInstitutionMt103OptionLetter").text($(this).filter(":checked").val());
	});
	

	$("#instructionCode").change(function(){
		if("" != $(this).val()){
			$("#popup_btn_instruction_code").show();
		} else {
			$("#bankOperationTextArea").val("");
			$("#popup_btn_instruction_code").hide();
		}
	});
	
	
	$(".orderingBankFlag").change();
	$(".sendersCorrespondentFlag").change();
	$(".receiversCorrespondentFlag").change();
	$(".intermediaryFlag").change();
	$(".accountWithBankFlag").change();
});

function validateOutgoingMt(){
	var hasError=false;
	
	/*
	switch($("#sendersCorrespondentFlag:checked").val()){
	case "A":
		if("" == $("#senderIdentifierCode").val()){
			hasError=true;
		}
		break;
	case "B":
		if("" == $("#sendersPartyIdentifier").val()){
			hasError=true;
		}
		break;
	case "D":
		if("" == $("#senderNameAndAddress").val()){
			hasError=true;
		}
		break;
	default:
		hasError=true;
	};*/
	if('undefined' !== typeof documentNumber && documentNumber != ''){
		$("#sendersReference,#bankOperationCode,#valueDate,#currency,#swiftAmount,#importerName," +
		"#importerAddress,#beneficiaryName,#beneficiaryAddress,#detailsOfCharges,#destinationBank").each(function(){
			if("" == $(this).val()){
				hasError=true;
				if('undefined' !== typeof window.console){
					window.console.log("missing value: "+$(this).attr("id"));
				}
			}
		});		
	}else{
		if($.trim($("#documentNumber").val()) == "" ){
			hasError = true;
			if('undefined' !== typeof window.console){
				window.console.log("missing value: "+$(this).attr("id"));
			}
		}
	}
	
	if(hasError){
		triggerAlertMessage("Please fill in the required fields.");
	}
	
	return hasError;
}