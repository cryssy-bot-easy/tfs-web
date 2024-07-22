$(receiverInit);

var receiverLength = 35;

function onChangeReceiversCorrespondent() {
    var receiversCorrespondentMt752 = $("input[type=radio][name=receiversCorrespondentMt752]:checked").val();

    if(receiversCorrespondentMt752 == "A") {
        $('#receiverIdentifierCodeMt752').removeAttr("readonly").select2("enable");
        $('#receiverPartyIdentifierMt752').attr("readonly","readonly");
        $('#receiverLocationMt752').attr("readonly","readonly");
//        $('#receiverNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_receiver_correspondent').hide();
        $('#receiverPartyIdentifierMt752').val("");
        $("#receiverLocationMt752").val("");
        $("#receiverNameAndAddressMt752").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("A");
    } else if(receiversCorrespondentMt752 == "B") {
        $('#receiverIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#receiverPartyIdentifierMt752').removeAttr("readonly");
        $('#receiverLocationMt752').removeAttr("readonly");
//        $('#receiverNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_receiver_correspondent').hide();
        $("#receiverIdentifierCodeMt752").val("");
        $("#receiverNameAndAddressMt752").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("B");
    } else if(receiversCorrespondentMt752 == "D") {
//        $('#receiverNameAndAddressMt752').removeAttr("readonly");
    	$('#mt752_popup_btn_receiver_correspondent').show();
        $('#receiverIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#receiverPartyIdentifierMt752').attr("readonly","readonly");
        $('#receiverLocationMt752').attr("readonly","readonly");
        $("#receiverIdentifierCodeMt752").val("");
        $('#receiverPartyIdentifierMt752').val("");
        $("#receiverLocationMt752").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("D");
    } else {
        $('#receiverIdentifierCodeMt752').attr("readonly","readonly").select2("disable");
        $('#receiverPartyIdentifierMt752').attr("readonly","readonly");
        $('#receiverLocationMt752').attr("readonly","readonly");
//        $('#receiverNameAndAddressMt752').attr("readonly","readonly");
        $('#mt752_popup_btn_receiver_correspondent').hide();
        $("#receiverIdentifierCodeMt752").val("");
        $('#receiverPartyIdentifierMt752').val("");
        $("#receiverLocationMt752").val("");
        $("#receiverNameAndAddressMt752").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("a");
    }
}

function receiverInit(){ 
	
//	$('.receiverCorrespondentOptionA').click(receiverEnableInputA);
//	$('.receiverCorrespondentOptionB').click(receiverEnableInputB);
//	$('.receiverCorrespondentOptionD').click(receiverEnableInputD);

    $("input[type=radio][name=receiversCorrespondentMt752]").click(onChangeReceiversCorrespondent);
    onChangeReceiversCorrespondent();

//	$('#receiverIdentifierCodeMt752').attr("readonly","readonly");
//	$('#receiverLocationMt752').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt752').attr("readonly","readonly");
	
	
	$("#characters_left_receiversCorrespondent").text(receiverLength);
	$(receiverSelectDropdown);
};


//function receiverEnableInputA(){
//	$('#receiverIdentifierCodeMt752').removeAttr("readonly");
//	$('#receiverLocationMt752').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt752').attr("readonly","readonly");
//	$('#receiverIdentity').text("a");
//};
//
//function receiverEnableInputB(){
//
//	$('#receiverLocationMt752').removeAttr("readonly");
//	$('#receiverIdentifierCodeMt752').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt752').attr("readonly","readonly");
//	$('#receiverIdentity').text("b");
//};
//
//function receiverEnableInputD(){
//
//	$('#receiverNameAndAddressMt752').removeAttr("readonly");
//	$('#receiverIdentifierCodeMt752').attr("readonly","readonly");
//	$('#receiverLocationMt752').attr("readonly","readonly");
//	$('#receiverIdentity').text("d");
//	$(countCharactersReceiverAddress);
//};


function receiverSelectDropdown(){

	
	//=============others/dataEntry/mt202 details===================//
	$("#receiverCorrespondent").change(function(){
		if($(this).val()=="Option A"){
			$('#identifierCodeReceiverCorrespond').removeAttr("readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option B"){
			$('#locationReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}else if($(this).val()=="Option D"){
			$('#nameAddressReceiverCorrespond').removeAttr("readonly");
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
		}else{
			$('#identifierCodeReceiverCorrespond').attr("readonly","readonly");
			$('#locationReceiverCorrespond').attr("readonly","readonly");
			$('#nameAddressReceiverCorrespond').attr("readonly","readonly");
		}
	
	});

//==============================================================//
}


function countCharactersReceiverAddress(){
	

	$("#receiverNameAndAddressMt752").keydown(onAddTextreceiverAddress);
	$("#receiverNameAndAddressMt752").keyup(onAddTextreceiverAddress);
	$("#receiverNameAndAddressMt752")
			.keypress(onAddTextreceiverAddress);

	function onAddTextreceiverAddress() {
		if ($("#receiverNameAndAddressMt752").val().length > receiverLength) {
			$("#receiverNameAndAddressMt752").val(
					$("#receiverNameAndAddressMt752")
							.val().substring(0, (receiverLength)));
		} else {
			var receiverChar = $("#receiverNameAndAddressMt752")
					.val().length;
			receiverLeft = receiverLength - receiverChar;
			if (receiverLeft >= 0) {
				$("#characters_left_receiversCorrespondent")
						.text(receiverLeft);
			} else if (receiverLeft < 0) {
				$("#characters_left_receiversCorrespondent")
						.text("0");
			}
		}
	}
}