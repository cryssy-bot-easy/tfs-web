function onSenderToReceiverInformationMt202PopupSaveClick() {
    var senderToReceiverInformationMt202 = $("#senderToReceiverInformationMt202Comment").val();


    disablePopup("sender_receiver_mt202_popup", "sender_receiver_mt202_bg");

    $("#senderToReceiverInformationMt202").val(senderToReceiverInformationMt202);
    $("#senderToReceiverInformationMt").val(senderToReceiverInformationMt202);
}

$(function (){
	var popup_sender_receiver_mt202_div = $('#sender_receiver_mt202_popup').attr("id");
	var popup_sender_receiver_mt202_bg = $('#sender_receiver_mt202_bg').attr("id");

	
	$('#sender_infoMt202').click(function (){
        $("#senderToReceiverInformationMt202Comment").val(($("#senderToReceiverInformationMt202To").length > 0 ) ? $("#senderToReceiverInformationMt202To").val() : ($("#senderToReceiverInformationMt202").length > 0 ) ? $("#senderToReceiverInformationMt202").val() : $("#senderToReceiverInformationMt").length > 0 ? $("#senderToReceiverInformationMt").val() : '' );
		//centering with css
		centerPopup(popup_sender_receiver_mt202_div, popup_sender_receiver_mt202_bg);
		//load popup
		loadPopup(popup_sender_receiver_mt202_div, popup_sender_receiver_mt202_bg);	
		$("#senderToReceiverInformationMt202Comment").focus();
		$("#senderToReceiverInformationMt202Comment").limitCharAndLines(35,6);
	});
	$('.sender_receiver_mt202_close').click(function (){
		disablePopup(popup_sender_receiver_mt202_div, popup_sender_receiver_mt202_bg);
	});
	
	$("#senderToReceiverInformationMt202Comment").limitCharAndLines(35,6);
	
    $("#senderToReceiverInformationMt202PopupSave").click(onSenderToReceiverInformationMt202PopupSaveClick);
});
