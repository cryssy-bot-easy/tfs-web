$(beneficiaryInit);

var beneficiaryLength=35;

function onChangeBeneficiaryInstitution() {
    var beneficiaryInstitution = $("input[type=radio][name=beneficiarysInstitution]:checked").val();

    if(beneficiaryInstitution == "A") {
        $('#beneficiaryIdentifierCodeMt').removeAttr("readonly");
//        $('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_beneficiary_bank').hide();
        $("#beneficiaryNameAndAddressMt").val("");
        $(".beneficiaryInstitutionMt752202OptionLetter").text("A");
    } else if(beneficiaryInstitution == "D") {
//        $('#beneficiaryNameAndAddressMt').removeAttr("readonly");
    	$('#popup_btn_beneficiary_bank').show();
        $('#beneficiaryIdentifierCodeMt').attr("readonly","readonly");
        $("#beneficiaryIdentifierCodeMt").val("");
        $(".beneficiaryInstitutionMt752202OptionLetter").text("D");
    } else {
        $('#beneficiaryIdentifierCodeMt').attr("readonly","readonly");
//        $('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_beneficiary_bank').hide();
        $("#beneficiaryIdentifierCodeMt").val("");
        $("#beneficiaryNameAndAddressMt").val("");
        $(".beneficiaryInstitutionMt752202OptionLetter").text("a");
    }
}

function beneficiaryInit(){ 
	
//	$('.beneficiaryInstitutionOptionA').click(beneficiaryEnableInputA);
//	$('.beneficiaryInstitutionOptionD').click(beneficiaryEnableInputD);

    $("input[type=radio][name=beneficiarysInstitution]").click(onChangeBeneficiaryInstitution);
    onChangeBeneficiaryInstitution();
	
//	$('#beneficiaryIdentifierCodeMt').attr("readonly","readonly");
//	$('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
	
	$("#characters_left_beneficiarysInstitutionNameAndAddress").text(beneficiaryLength);
	$(beneficiarySelectDropdown);
};

//function beneficiaryEnableInputA(){
//	$('#beneficiaryIdentifierCodeMt').removeAttr("readonly");
//	$('#beneficiaryNameAndAddressMt').attr("readonly","readonly");
//	$('#beneficiaryIdentity').text("a");
//};
//
//function beneficiaryEnableInputD(){
//	$('#beneficiaryNameAndAddressMt').removeAttr("readonly");
//	$('#beneficiaryIdentifierCodeMt').attr("readonly","readonly");
//	$('#beneficiaryIdentity').text("d");
//	$(countCharactersBeneficiaryInstitutionAddress);
//};

function beneficiarySelectDropdown(){

	
	//=============others/dataEntry/mt202 details===================//
	$("#benificiaryInstitution").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeBeneficiaryInstitution').removeAttr("readonly");
			$('#nameAddressBeneficiaryInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressBeneficiaryInstitution').removeAttr("readonly");
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeBeneficiaryInstitution').attr("readonly","readonly");
			$('#nameAddressBeneficiaryInstitution').attr("readonly","readonly");
		}
	
	});

//==============================================================//
}

function countCharactersBeneficiaryInstitutionAddress(){
	

	$("#beneficiaryNameAndAddressMt").keydown(onAddTextbeneficiaryAddress);
	$("#beneficiaryNameAndAddressMt").keyup(onAddTextbeneficiaryAddress);
	$("#beneficiaryNameAndAddressMt")
			.keypress(onAddTextbeneficiaryAddress);

	function onAddTextbeneficiaryAddress() {
		if ($("#beneficiaryNameAndAddressMt").val().length > beneficiaryLength) {
			$("#beneficiaryNameAndAddressMt").val(
					$("#beneficiaryNameAndAddressMt")
							.val().substring(0, (beneficiaryLength)));
		} else {
			var beneficiaryChar = $("#beneficiaryNameAndAddressMt")
					.val().length;
			beneficiaryLeft = beneficiaryLength - beneficiaryChar;
			if (beneficiaryLeft >= 0) {
				$("#characters_left_beneficiarysInstitutionNameAndAddress")
						.text(beneficiaryLeft);
			} else if (beneficiaryLeft < 0) {
				$("#characters_left_beneficiarysInstitutionNameAndAddress")
						.text("0");
			}
		}
	}
}
