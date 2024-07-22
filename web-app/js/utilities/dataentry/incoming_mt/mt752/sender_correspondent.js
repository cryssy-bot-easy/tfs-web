$(senderInit);

var senderLength = 35;

function onChangeSendersCorrespondent() {
    var sendersCorrespondentMt752 = $("input[type=radio][name=sendersCorrespondentMt752]:checked").val();

    if(sendersCorrespondentMt752 == "A") {
        $('#senderIdentifierCodeMt752').removeAttr("readonly").select2("enable");
        $('#senderPartyIdentifierMt752').attr("readonly","readonly");
        $('#senderLocationMt752').attr("readonly","readonly");
//        $('#senderNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_sender_correspondent').hide();
        $("#senderPartyIdentifierMt752").val("");
        $("#senderLocationMt752").val("");
        $("#senderNameAndAddressMt752").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("A");
    } else if(sendersCorrespondentMt752 == "B") {
        $('#senderIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#senderPartyIdentifierMt752').removeAttr("readonly");
        $('#senderLocationMt752').removeAttr("readonly");
//        $('#senderNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_sender_correspondent').hide();
        $("#senderIdentifierCodeMt752").val("");
        $("#senderNameAndAddressMt752").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("B");
    } else if(sendersCorrespondentMt752 == "D") {
//        $('#senderNameAndAddressMt752').removeAttr("readonly");
    	$('#mt752_popup_btn_sender_correspondent').show();
        $('#senderIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#senderPartyIdentifierMt752').attr("readonly","readonly");
        $('#senderLocationMt752').attr("readonly","readonly");
        $("#senderIdentifierCodeMt752").val("");
        $("#senderPartyIdentifierMt752").val("");
        $("#senderLocationMt752").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("D");
    } else {
        $('#senderIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#senderPartyIdentifierMt752').attr("readonly","readonly");
        $('#senderLocationMt752').attr("readonly","readonly");
//        $('#senderNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_sender_correspondent').hide();
        $("#senderIdentifierCodeMt752").val("");
        $("#senderPartyIdentifierMt752").val("");
        $("#senderLocationMt752").val("");
        $("#senderNameAndAddressMt752").val("");
        $(".sendersCorrespondentMt752202OptionLetter").text("a");
    }
}

function senderInit(){ 
	
//	$('.senderCorrespondentOptionA').click(senderEnableInputA);
//	$('.senderCorrespondentOptionB').click(senderEnableInputB);
//	$('.senderCorrespondentOptionD').click(senderEnableInputD);
    $("input[type=radio][name=sendersCorrespondentMt752]").click(onChangeSendersCorrespondent);
    onChangeSendersCorrespondent();
	
//	$('#senderIdentifierCodeMt752').attr("readonly","readonly");
//	$('#senderLocationMt752').attr("readonly","readonly");
//	$('#senderNameAndAddressMt752').attr("readonly","readonly");
	
	$("#characters_left_sendersCorrespondent").text(senderLength);
	
	$(senderSelectDropdown);
};

//function senderEnableInputA(){
//	$('#senderIdentifierCodeMt752').removeAttr("readonly");
//	$('#senderLocationMt752').attr("readonly","readonly");
//	$('#senderNameAndAddressMt752').attr("readonly","readonly");
//	$('#senderIdentity').text("a");
//};

//function senderEnableInputB(){
//
//	$('#senderLocationMt752').removeAttr("readonly");
//	$('#senderIdentifierCodeMt752').attr("readonly","readonly");
//	$('#senderNameAndAddressMt752').attr("readonly","readonly");
//	$('#senderIdentity').text("b");
//};

//function senderEnableInputD(){
//
//	$('#senderNameAndAddressMt752').removeAttr("readonly");
//	$('#senderIdentifierCodeMt752').attr("readonly","readonly");
//	$('#senderLocationMt752').attr("readonly","readonly");
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
	

	$("#senderNameAndAddressMt752").keydown(onAddTextsenderAddress);
	$("#senderNameAndAddressMt752").keyup(onAddTextsenderAddress);
	$("#senderNameAndAddressMt752")
			.keypress(onAddTextsenderAddress);

	function onAddTextsenderAddress() {
		if ($("#senderNameAndAddressMt752").val().length > senderLength) {
			$("#senderNameAndAddressMt752").val(
					$("#senderNameAndAddressMt752")
							.val().substring(0, (senderLength)));
		} else {
			var senderChar = $("#senderNameAndAddressMt752")
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


