function onSenderToReceiverInformationMt103PopupSaveClick() {
    var senderToReceiverInformationMt103 = $("#senderToReceiverInformationMt103Comment").val();


    disablePopup("sender_receiver_mt103_popup", "sender_receiver_mt103_bg");

    $("#senderToReceiverInformationTextArea").val(senderToReceiverInformationMt103);
}

$(function (){
	var popup_sender_receiver_mt103_div = $('#sender_receiver_mt103_popup').attr("id");
	var popup_sender_receiver_mt103_bg = $('#sender_receiver_mt103_bg').attr("id");

	
	$('#sender_infoMt103').click(function (){
        $("#senderToReceiverInformationMt103Comment").val($("#senderToReceiverInformationTextArea").val());
		//centering with css
		centerPopup(popup_sender_receiver_mt103_div, popup_sender_receiver_mt103_bg);
		//load popup
		loadPopup(popup_sender_receiver_mt103_div, popup_sender_receiver_mt103_bg);	
		$("#senderToReceiverInformationMt103Comment").focus();
		$("#senderToReceiverInformationMt103Comment").limitCharAndLines(35,6);
	});
	$('.sender_receiver_mt103_close').click(function (){
		disablePopup(popup_sender_receiver_mt103_div, popup_sender_receiver_mt103_bg);
	});
	
	$("#senderToReceiverInformationMt103Comment").limitCharAndLines(35,6);
	
    $("#senderToReceiverInformationMt103PopupSave").click(onSenderToReceiverInformationMt103PopupSaveClick);
});
