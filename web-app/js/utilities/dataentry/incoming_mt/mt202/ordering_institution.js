$(orderingInit);

var orderingLength = 35;

function onChangeOrderingInstitution() {
    var orderingInstitution = $("input[type=radio][name=orderingInstitution]:checked").val();

    if(orderingInstitution == "A") {
        $('#bankIdentifierCodeMt202').removeAttr("readonly");
//        $('#bankNameAndAddressMt').attr("readonly","readonly");
        $("#popup_btn_ordering_bank").hide();
        $("#bankNameAndAddressMt").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("A");
    } else if(orderingInstitution == "D") {
//        $('#bankNameAndAddressMt').removeAttr("readonly");
    	$("#popup_btn_ordering_bank").show();
        $('#bankIdentifierCodeMt202').attr("readonly","readonly");
        $("#bankIdentifierCodeMt202").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("D");
    } else {
        $('#bankIdentifierCodeMt202').attr("readonly","readonly");
//	    $('#bankNameAndAddressMt').attr("readonly","readonly");
        $("#popup_btn_ordering_bank").hide();
        $("#bankNameAndAddressMt").val("");
        $("#bankIdentifierCodeMt202").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("a");
    }
}

function orderingInit(){ 
	
//	$('.orderInstitutionOptionA').click(orderingEnableInputA);
//	$('.orderInstitutionOptionD').click(orderingEnableInputD);
    $("input[type=radio][name=orderingInstitution]").click(onChangeOrderingInstitution);
    onChangeOrderingInstitution();
	
//	$('#bankIdentifierCodeMt202').attr("readonly","readonly");
//	$('#bankNameAndAddressMt').attr("readonly","readonly");
	
	$("#characters_left_orderingInstitutionNameAndAddress").text(orderingLength);
};

//function orderingEnableInputA(){
//	$('#bankIdentifierCodeMt202').removeAttr("readonly");
//	$('#bankNameAndAddressMt').attr("readonly","readonly");
//	$('#orderingIdentity').text("a");
//};
//
//function orderingEnableInputD(){
//	$('#bankNameAndAddressMt').removeAttr("readonly");
//	$('#bankIdentifierCodeMt202').attr("readonly","readonly");
//	$('#orderingIdentity').text("d");
//
//	$(countCharactersorderingAddress);
//};

//============================otherImports/mt ==============================//


function countCharactersorderingAddress(){
	

	$("#bankNameAndAddressMt").keydown(onAddTextorderingAddress);
	$("#bankNameAndAddressMt").keyup(onAddTextorderingAddress);
	$("#bankNameAndAddressMt")
			.keypress(onAddTextorderingAddress);

	function onAddTextorderingAddress() {
		if ($("#bankNameAndAddressMt").val().length > orderingLength) {
			$("#bankNameAndAddressMt").val(
					$("#bankNameAndAddressMt")
							.val().substring(0, (orderingLength)));
		} else {
			var orderingChar = $("#bankNameAndAddressMt")
					.val().length;
			orderingLeft = orderingLength - orderingChar;
			if (orderingLeft >= 0) {
				$("#characters_left_orderingInstitutionNameAndAddress")
						.text(orderingLeft);
			} else if (orderingLeft < 0) {
				$("#characters_left_orderingInstitutionNameAndAddress")
						.text("0");
			}
		}
	}
}

