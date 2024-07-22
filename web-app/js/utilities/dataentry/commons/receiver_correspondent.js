$(receiverInit);

var receiverLength = 35;

function onChangeReceiversCorrespondent() {
    var receiversCorrespondent = $("input[type=radio][name=receiversCorrespondent]:checked").val();

    if(receiversCorrespondent == "A") {
        $('#receiverIdentifierCodeMt').removeAttr("readonly");
        $('#receiverLocationMt').attr("readonly","readonly");
//        $('#receiverNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_receiver_correspondent').hide();
        $("#receiverLocationMt").val("");
        $("#receiverNameAndAddressMt").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("A");
    } else if(receiversCorrespondent == "B") {
        $('#receiverLocationMt').removeAttr("readonly");
        $('#receiverIdentifierCodeMt').attr("readonly","readonly");
//        $('#receiverNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_receiver_correspondent').hide();
        $("#receiverIdentifierCodeMt").val("");
        $("#receiverNameAndAddressMt").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("B");
    } else if(receiversCorrespondent == "D") {
//        $('#receiverNameAndAddressMt').removeAttr("readonly");
    	$('#popup_btn_receiver_correspondent').show();
        $('#receiverIdentifierCodeMt').attr("readonly","readonly");
        $('#receiverLocationMt').attr("readonly","readonly");
        $("#receiverIdentifierCodeMt").val("");
        $("#receiverLocationMt").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("D");
    } else {
        $('#receiverIdentifierCodeMt').attr("readonly","readonly");
        $('#receiverLocationMt').attr("readonly","readonly");
//        $('#receiverNameAndAddressMt').attr("readonly","readonly");
        $('#popup_btn_receiver_correspondent').hide();
        $("#receiverIdentifierCodeMt").val("");
        $("#receiverLocationMt").val("");
        $("#receiverNameAndAddressMt").val("");
        $(".receiversCorrespondentMt752202OptionLetter").text("a");
    }
}

function receiverInit(){ 
	
//	$('.receiverCorrespondentOptionA').click(receiverEnableInputA);
//	$('.receiverCorrespondentOptionB').click(receiverEnableInputB);
//	$('.receiverCorrespondentOptionD').click(receiverEnableInputD);

    $("input[type=radio][name=receiversCorrespondent]").click(onChangeReceiversCorrespondent);
    onChangeReceiversCorrespondent();

//	$('#receiverIdentifierCodeMt').attr("readonly","readonly");
//	$('#receiverLocationMt').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt').attr("readonly","readonly");
	
	
	$("#characters_left_receiversCorrespondent").text(receiverLength);
	$(receiverSelectDropdown);
};


//function receiverEnableInputA(){
//	$('#receiverIdentifierCodeMt').removeAttr("readonly");
//	$('#receiverLocationMt').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt').attr("readonly","readonly");
//	$('#receiverIdentity').text("a");
//};
//
//function receiverEnableInputB(){
//
//	$('#receiverLocationMt').removeAttr("readonly");
//	$('#receiverIdentifierCodeMt').attr("readonly","readonly");
//	$('#receiverNameAndAddressMt').attr("readonly","readonly");
//	$('#receiverIdentity').text("b");
//};
//
//function receiverEnableInputD(){
//
//	$('#receiverNameAndAddressMt').removeAttr("readonly");
//	$('#receiverIdentifierCodeMt').attr("readonly","readonly");
//	$('#receiverLocationMt').attr("readonly","readonly");
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
	

	$("#receiverNameAndAddressMt").keydown(onAddTextreceiverAddress);
	$("#receiverNameAndAddressMt").keyup(onAddTextreceiverAddress);
	$("#receiverNameAndAddressMt")
			.keypress(onAddTextreceiverAddress);

	function onAddTextreceiverAddress() {
		if ($("#receiverNameAndAddressMt").val().length > receiverLength) {
			$("#receiverNameAndAddressMt").val(
					$("#receiverNameAndAddressMt")
							.val().substring(0, (receiverLength)));
		} else {
			var receiverChar = $("#receiverNameAndAddressMt")
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