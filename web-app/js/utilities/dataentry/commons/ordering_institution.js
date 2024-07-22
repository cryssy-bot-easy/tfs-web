$(orderingInit);

var orderingLength = 35;

function onChangeOrderingInstitution() {
    var orderingInstitution = $("input[type=radio][name=orderingInstitution]:checked").val();

    if(orderingInstitution == "A") {
        $('#bankIdentifierCodeMt').removeAttr("readonly");
//        $('#bankNameAndAddressMt').attr("readonly","readonly");
        $("#popup_btn_ordering_bank").hide();
        $("#bankNameAndAddressMt").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("A");
    } else if(orderingInstitution == "D") {
//        $('#bankNameAndAddressMt').removeAttr("readonly");
    	$("#popup_btn_ordering_bank").show();
        $('#bankIdentifierCodeMt').attr("readonly","readonly");
        $("#bankIdentifierCodeMt").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("D");
    } else {
        $('#bankIdentifierCodeMt').attr("readonly","readonly");
//	    $('#bankNameAndAddressMt').attr("readonly","readonly");
        $("#popup_btn_ordering_bank").hide();
        $("#bankNameAndAddressMt").val("");
        $("#bankIdentifierCodeMt").val("");
        $(".orderingInstitutionMt752202OptionLetter").text("a");
    }
}

function orderingInit(){ 
	
//	$('.orderInstitutionOptionA').click(orderingEnableInputA);
//	$('.orderInstitutionOptionD').click(orderingEnableInputD);
    $("input[type=radio][name=orderingInstitution]").click(onChangeOrderingInstitution);
    onChangeOrderingInstitution();
	
//	$('#bankIdentifierCodeMt').attr("readonly","readonly");
//	$('#bankNameAndAddressMt').attr("readonly","readonly");
	
	$("#characters_left_orderingInstitutionNameAndAddress").text(orderingLength);
};

//function orderingEnableInputA(){
//	$('#bankIdentifierCodeMt').removeAttr("readonly");
//	$('#bankNameAndAddressMt').attr("readonly","readonly");
//	$('#orderingIdentity').text("a");
//};
//
//function orderingEnableInputD(){
//	$('#bankNameAndAddressMt').removeAttr("readonly");
//	$('#bankIdentifierCodeMt').attr("readonly","readonly");
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

