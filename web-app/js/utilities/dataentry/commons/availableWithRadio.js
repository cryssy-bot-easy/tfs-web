$(availableRadio);

function onChangeAvailableWith() {
    var availableWith = $("input[type=radio][name=availableWithFlag]:checked").val();

    $("#availableWithFlagValue").val(availableWith);

    if(availableWith == 'A'){
        enableAvailableRadioA();
    }else if(availableWith == 'D') {
        enableAvailableRadioD();
    }
}

function availableRadio(){ 
	
//	$('.avialableWithA').click(enableAvailableRadioA);
//	$('.avialableWithB').click(enableAvailableRadioB);
    $("input[type=radio][name=availableWithFlag]").click(onChangeAvailableWith);
    //$("#availableWith").change(enableAvailableRadio);
//    enableAvailableRadio();
    onChangeAvailableWith();

//	$('#availableIdentifierCodeIETo, #identifierCode').attr("readonly","readonly");
//	$('#availableNameAndAddressIETo, #nameAndAddress').attr("readonly","readonly");
	
	
//	$(".bank_address_popup").hide();
    enableAvailableRadio();
    $("input[name=confirmationInstructionsFlag]").change(enableAvailableRadio);
};


function enableAvailableRadio(){
	switch($("input[name=confirmationInstructionsFlag]:checked").val()){
	case 'Y':
		$("input[type=radio][name=availableWithFlag]").attr("disabled" ,"disabled")
		$("#drawee").val($("#availableWith").val());
		break;
	case 'N':
		$("#drawee").val(ucpbSenderAddress);
	case 'M':
		$("input[type=radio][name=availableWithFlag]").removeAttr("disabled")
		break;
	}
	
	if("checked" == $(".availableWithB").attr("checked") && 
			"undefined" != $(".availableWithB").attr("disabled")){
		$(".availableWithB").removeAttr("disabled");
	}else if("checked" == $(".availableWithA").attr("checked") && 
			"undefined" != $(".availableWithA").attr("disabled")){
		$(".availableWithA").removeAttr("disabled");
	}
}

function enableAvailableRadioA(){
	$('#availableIdentifierCodeIETo, #identifierCode').removeAttr("readonly");
	$('#availableNameAndAddressIETo, #nameAndAddress').attr("readonly","readonly");
    $("#nameAndAddress").val("");
	$("#popup_btn_bank_address").hide();
};

function enableAvailableRadioD(){
	//$('#availableNameAndAddressIETo, #nameAndAddress').removeAttr("readonly");
    $("#identifierCode").val("");
	$('#availableIdentifierCodeIETo, #identifierCode').attr("readonly","readonly");
	if($("#availableWith").select2('data').label){
		$("#nameAndAddress").val($("#availableWith").select2('data').label);
	} else {
		$.post(autoCompleteBankUrl, {starts_with: availableWith}, function(data){
        	$("#nameAndAddress").val(data.results[0].label);
        });
	}
	$("#popup_btn_bank_address").show();
};