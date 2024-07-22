$(accountInit);

var accountLength = 35;

function onChangeAccountWithInstutition() {
    var accountWithInstitution = $("input[type=radio][name=accountWithInstitution]:checked").val();

    if(accountWithInstitution == "A") {
        $('#accountIdentifierCodeMt').removeAttr("readonly");
        $('#accountWithBankLocationMt').attr("readonly","readonly");
//        $('#accountNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_account_with_bank').hide();
        $("#accountWithBankLocationMt").val("");
        $("#accountNameAndAddressMt").val("");
        $(".accountWithInstitutionMt752202OptionLetter").text("A");
    } else if(accountWithInstitution == "B") {
        $('#accountWithBankLocationMt').removeAttr("readonly");
        $('#accountIdentifierCodeMt').attr("readonly","readonly");
//        $('#accountNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_account_with_bank').hide();
        $("#accountIdentifierCodeMt").val("");
        $("#accountNameAndAddressMt").val("");
        $(".accountWithInstitutionMt752202OptionLetter").text("B");
    } else if(accountWithInstitution == "C") {
        $('#accountIdentifierCodeMt').attr("readonly","readonly");
        $('#accountWithBankLocationMt').attr("readonly","readonly");
//        $('#accountNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_account_with_bank').hide();
        $("#accountIdentifierCodeMt").val("");
        $("#accountWithBankLocationMt").val("");
        $("#accountNameAndAddressMt").val("");
        $(".accountWithInstitutionMt752202OptionLetter").text("C");
    } else if(accountWithInstitution == "D") {
//        $('#accountNameAndAddressMt').removeAttr("readonly");
    	$('#popup_btn_account_with_bank').show();
        $('#accountIdentifierCodeMt').attr("readonly","readonly");
        $('#accountWithBankLocationMt').attr("readonly","readonly");
        $("#accountIdentifierCodeMt").val("");
        $("#accountWithBankLocationMt").val("");
        $(".accountWithInstitutionMt752202OptionLetter").text("D");
    } else {
        $('#accountIdentifierCodeMt').attr("readonly","readonly");
        $('#accountWithBankLocationMt').attr("readonly","readonly");
//        $('#accountNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_account_with_bank').hide();
        $("#accountIdentifierCodeMt").val("");
        $("#accountWithBankLocationMt").val("");
        $("#accountNameAndAddressMt").val("");
        $(".accountWithInstitutionMt752202OptionLetter").text("a");
    }
}

function accountInit(){ 
	
//	$('.acctInstitutionOptionA').click(accountEnableInputA);
//	$('.acctInstitutionOptionB').click(accountEnableInputB);
//	$('.acctInstitutionOptionD').click(accountEnableInputD);
//	$('.acctInstitutionOptionC').click(accountEnableInputC);

    $("input[type=radio][name=accountWithInstitution]").click(onChangeAccountWithInstutition);
    onChangeAccountWithInstutition();
	
//	$('#accountIdentifierCodeMt').attr("readonly","readonly");
//	$('#accountWithBankLocationMt').attr("readonly","readonly");
//	$('#accountNameAndAddressMt').attr("readonly","readonly");
	
	$('#characters_left_accountWithInstitutionNameAndAddress').text(accountLength);
	$(accountInstitutionSelectDropdown);
};

//function accountEnableInputA(){
//	$('#accountIdentifierCodeMt').removeAttr("readonly");
//	$('#accountWithBankLocationMt').attr("readonly","readonly");
//	$('#accountNameAndAddressMt').attr("readonly","readonly");
//	$('#accountInstitutionIdentity').text("a");
//};
//
//function accountEnableInputB(){
//
//	$('#accountWithBankLocationMt').removeAttr("readonly");
//	$('#accountIdentifierCodeMt').attr("readonly","readonly");
//	$('#accountNameAndAddressMt').attr("readonly","readonly");
//	$('#accountInstitutionIdentity').text("b");
//};
//
//function accountEnableInputD(){
//
//	$('#accountNameAndAddressMt').removeAttr("readonly");
//	$('#accountIdentifierCodeMt').attr("readonly","readonly");
//	$('#accountWithBankLocationMt').attr("readonly","readonly");
//	$('#accountInstitutionIdentity').text("d");
//
//	$(countCharactersAccountInstitutionAddress);
//};
//
//function accountEnableInputC(){
//	$('#accountIdentifierCodeMt').attr("readonly","readonly");
//	$('#accountWithBankLocationMt').attr("readonly","readonly");
//	$('#accountNameAndAddressMt').attr("readonly","readonly");
//	$('#accountInstitutionIdentity').text("c");
//}

function accountInstitutionSelectDropdown(){
	
	//=============others/dataEntry/mt202 details===================//	
	$("#accountWithInstitution").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeAccountInstitution').removeAttr("readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressAccountInstitution').removeAttr("readonly");
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
		}else{
			$('#identifierCodeAccountInstitution').attr("readonly","readonly");
			$('#locationAccountInstitution').attr("readonly","readonly");
			$('#nameAddressAccountInstitution').attr("readonly","readonly");
		}
		
	});
	
	//==============================================================//
}

function countCharactersAccountInstitutionAddress(){
	

	$("#accountNameAndAddressMt").keydown(onAddTextaccountAddress);
	$("#accountNameAndAddressMt").keyup(onAddTextaccountAddress);
	$("#accountNameAndAddressMt")
			.keypress(onAddTextaccountAddress);

	function onAddTextaccountAddress() {
		if ($("#accountNameAndAddressMt").val().length > accountLength) {
			$("#accountNameAndAddressMt").val(
					$("#accountNameAndAddressMt")
							.val().substring(0, (accountLength)));
		} else {
			var accountChar = $("#accountNameAndAddressMt")
					.val().length;
			accountLeft = accountLength - accountChar;
			if (accountLeft >= 0) {
				$("#characters_left_accountWithInstitutionNameAndAddress")
						.text(accountLeft);
			} else if (accountLeft < 0) {
				$("#characters_left_accountWithInstitutionNameAndAddress")
						.text("0");
			}
		}
	}
}
