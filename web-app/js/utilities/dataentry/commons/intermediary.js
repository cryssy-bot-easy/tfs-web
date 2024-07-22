$(intermediaryInit);

var intermediaryLength=35;

function onChangeIntermediary() {
    var intermediary = $("input[type=radio][name=intermediary]:checked").val();

    if(intermediary == "A") {
        $('#intermediaryIdentifierCodeMt').removeAttr("readonly");
//        $('#intermediaryNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_intermediary').hide();
        $("#intermediaryNameAndAddressMt").val("");
        $(".intermediaryMt752202OptionLetter").text("A");
    } else if(intermediary == "C") {
        $('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
//        $('#intermediaryNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_intermediary').hide();
        $("#intermediaryIdentifierCodeMt").val("");
        $("#intermediaryNameAndAddressMt").val("");
        $(".intermediaryMt752202OptionLetter").text("C");
    } else if(intermediary == "D") {
//        $('#intermediaryNameAndAddressMt').removeAttr("readonly");
    	$('#popup_btn_intermediary').show();
        $('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
        $("#intermediaryIdentifierCodeMt").val("");
        $(".intermediaryMt752202OptionLetter").text("D");
    } else {
        $('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
//        $('#intermediaryNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_intermediary').hide();
        $("#intermediaryIdentifierCodeMt").val("");
        $("#intermediaryNameAndAddressMt").val("");
        $(".#intermediaryMt752202OptionLetter").text("a");
    }
}

function intermediaryInit(){ 
	
//	$('.intermediaryOptionA').click(intermediaryEnableInputA);
//	$('.intermediaryOptionC').click(intermediaryEnableInputC);
//	$('.intermediaryOptionD').click(intermediaryEnableInputD);

    $("input[type=radio][name=intermediary]").click(onChangeIntermediary);
    onChangeIntermediary();
	
//	$('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
//	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
	
	$("#characters_left_intermediaryNameAndAddress").text(intermediaryLength);
	$(intermediarySelectDropdown);
};

//function intermediaryEnableInputA(){
//	$('#intermediaryIdentifierCodeMt').removeAttr("readonly");
//	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
//	$('#intermediaryIdentity').text("a");
//};
//
//function intermediaryEnableInputD(){
//	$('#intermediaryNameAndAddressMt').removeAttr("readonly");
//	$('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
//	$('#intermediaryIdentity').text("d");
//	$(countCharactersIntermediaryAddress);
//};
//
//function intermediaryEnableInputC(){
//	$('#intermediaryIdentifierCodeMt').attr("readonly","readonly");
//	$('#intermediaryNameAndAddressMt').attr("readonly","readonly");
//	$('#intermediaryIdentity').text("c");
//}

function intermediarySelectDropdown(){
	
	//=============others/dataEntry/mt202 details===================//
	$("#intermediary").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeIntermediary').removeAttr("readonly");
			$('#nameAddressIntermediary').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressIntermediary').removeAttr("readonly");
			$('#identifierCodeIntermediary').attr("readonly","readonly");
		}else{
			$('#identifierCodeIntermediary').attr("readonly","readonly");
			$('#nameAddressIntermediary').attr("readonly","readonly");
		}
	
	});

//==============================================================//
}

function countCharactersIntermediaryAddress(){
	

	$("#intermediaryNameAndAddressMt").keydown(onAddTextintermediaryAddress);
	$("#intermediaryNameAndAddressMt").keyup(onAddTextintermediaryAddress);
	$("#intermediaryNameAndAddressMt")
			.keypress(onAddTextintermediaryAddress);

	function onAddTextintermediaryAddress() {
		if ($("#intermediaryNameAndAddressMt").val().length > intermediaryLength) {
			$("#intermediaryNameAndAddressMt").val(
					$("#intermediaryNameAndAddressMt")
							.val().substring(0, (intermediaryLength)));
		} else {
			var intermediaryChar = $("#intermediaryNameAndAddressMt")
					.val().length;
			intermediaryLeft = intermediaryLength - intermediaryChar;
			if (intermediaryLeft >= 0) {
				$("#characters_left_intermediaryNameAndAddress")
						.text(intermediaryLeft);
			} else if (intermediaryLeft < 0) {
				$("#characters_left_intermediaryNameAndAddress")
						.text("0");
			}
		}
	}
}