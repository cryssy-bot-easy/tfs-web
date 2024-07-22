$(senderInit);

var senderLength = 35;

function onChangeSendersCorrespondent() {
    var senderCorrespondent = $("input[type=radio][name=sendersCorrespondent]:checked").val();

    if(senderCorrespondent == "A") {
        $('#senderIdentifierCodeMt').removeAttr("readonly");
        $('#senderLocationMt').attr("readonly","readonly");
//        $('#senderNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_sender_correspondent').hide();
        $("#senderLocationMt").val("");
        $("#senderNameAndAddressMt").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("A");
    } else if(senderCorrespondent == "B") {
        $('#senderLocationMt').removeAttr("readonly");
        $('#senderIdentifierCodeMt').attr("readonly","readonly");
//        $('#senderNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_sender_correspondent').hide();
        $("#senderIdentifierCodeMt").val("");
        $("#senderNameAndAddressMt").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("B");
    } else if(senderCorrespondent == "D") {
//        $('#senderNameAndAddressMt').removeAttr("readonly");
    	$('#popup_btn_sender_correspondent').show();
        $('#senderIdentifierCodeMt').attr("readonly","readonly");
        $('#senderLocationMt').attr("readonly","readonly");
        $("#senderIdentifierCodeMt").val("");
        $("#senderLocationMt").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("D");
    } else {
        $('#senderIdentifierCodeMt').attr("readonly","readonly");
        $('#senderLocationMt').attr("readonly","readonly");
//        $('#senderNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_sender_correspondent').hide();
        $("#senderIdentifierCodeMt").val("");
        $("#senderLocationMt").val("");
        $("#senderNameAndAddressMt").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("a");
    }
}

function senderInit(){ 
	
//	$('.senderCorrespondentOptionA').click(senderEnableInputA);
//	$('.senderCorrespondentOptionB').click(senderEnableInputB);
//	$('.senderCorrespondentOptionD').click(senderEnableInputD);
    $("input[type=radio][name=sendersCorrespondent]").click(onChangeSendersCorrespondent);
    onChangeSendersCorrespondent();
	
//	$('#senderIdentifierCodeMt').attr("readonly","readonly");
//	$('#senderLocationMt').attr("readonly","readonly");
//	$('#senderNameAndAddressMt').attr("readonly","readonly");
	
	$("#characters_left_sendersCorrespondent").text(senderLength);
	
	$(senderSelectDropdown);
};

//function senderEnableInputA(){
//	$('#senderIdentifierCodeMt').removeAttr("readonly");
//	$('#senderLocationMt').attr("readonly","readonly");
//	$('#senderNameAndAddressMt').attr("readonly","readonly");
//	$('#senderIdentity').text("a");
//};

//function senderEnableInputB(){
//
//	$('#senderLocationMt').removeAttr("readonly");
//	$('#senderIdentifierCodeMt').attr("readonly","readonly");
//	$('#senderNameAndAddressMt').attr("readonly","readonly");
//	$('#senderIdentity').text("b");
//};

//function senderEnableInputD(){
//
//	$('#senderNameAndAddressMt').removeAttr("readonly");
//	$('#senderIdentifierCodeMt').attr("readonly","readonly");
//	$('#senderLocationMt').attr("readonly","readonly");
//	$('#senderIdentity').text("d");
//
//	$(countCharactersSenderAddress);
//};

function senderSelectDropdown(){
	//=============others/dataEntry/mt202 details===================//
	$("#sendersCorrespondent").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeSenderCorrespond').removeAttr("readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressSenderCorrespond').removeAttr("readonly");
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeSenderCorrespond').attr("readonly","readonly");
			$('#locationSenderCorrespond').attr("readonly","readonly");
			$('#nameAddressSenderCorrespond').attr("readonly","readonly");
		}
		
	});
	
	//==============================================================//
	
}


function countCharactersSenderAddress(){
	

	$("#senderNameAndAddressMt").keydown(onAddTextsenderAddress);
	$("#senderNameAndAddressMt").keyup(onAddTextsenderAddress);
	$("#senderNameAndAddressMt")
			.keypress(onAddTextsenderAddress);

	function onAddTextsenderAddress() {
		if ($("#senderNameAndAddressMt").val().length > senderLength) {
			$("#senderNameAndAddressMt").val(
					$("#senderNameAndAddressMt")
							.val().substring(0, (senderLength)));
		} else {
			var senderChar = $("#senderNameAndAddressMt")
					.val().length;
			senderLeft = senderLength - senderChar;
			if (senderLeft >= 0) {
				$("#characters_left_sendersCorrespondent")
						.text(senderLeft);
			} else if (senderLeft < 0) {
				$("#characters_left_sendersCorrespondent")
						.text("0");
			}
		}
	}
}


