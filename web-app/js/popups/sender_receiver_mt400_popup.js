function onSenderToReceiverInformationMt400PopupSaveClick() {
    var senderToReceiverInformationMt400 = $("#senderToReceiverInformationMt400Comment").val();


    disablePopup("sender_receiver_mt400_popup", "sender_receiver_mt400_bg");

    $("#senderToReceiverInformationMt400").val(senderToReceiverInformationMt400);
}

$(function (){
	var popup_sender_receiver_mt400_div = $('#sender_receiver_mt400_popup').attr("id");
	var popup_sender_receiver_mt400_bg = $('#sender_receiver_mt400_bg').attr("id");

	
	$('#sender_infoMt400').click(function (){
        $("#senderToReceiverInformationMt400Comment").val(($("#senderToReceiverInformationMt400To").length > 0 ) ? $("#senderToReceiverInformationMt400To").val() : ($("#senderToReceiverInformationMt400").length > 0 ) ? $("#senderToReceiverInformationMt400").val() : '');
		//centering with css
		centerPopup(popup_sender_receiver_mt400_div, popup_sender_receiver_mt400_bg);
		//load popup
		loadPopup(popup_sender_receiver_mt400_div, popup_sender_receiver_mt400_bg);	
		$("#senderToReceiverInformationMt400Comment").focus();
		$("#senderToReceiverInformationMt400Comment").limitCharAndLines(35,6);
	});
	$('.sender_receiver_mt400_close').click(function (){
		disablePopup(popup_sender_receiver_mt400_div, popup_sender_receiver_mt400_bg);
	});
	
	$("#senderToReceiverInformationMt400Comment").limitCharAndLines(35,6);
	
    $("#senderToReceiverInformationMt400PopupSave").click(onSenderToReceiverInformationMt400PopupSaveClick);
});