var popup_sender_receiver_div = $('#sender_receiver_popup').attr("id");
var popup_sender_receiver_bg = $('#sender_receiver_bg').attr("id");


function openPopUpSenderReceiver(){
	//centering with css
	centerPopup(popup_sender_receiver_div, popup_sender_receiver_bg);
	//load popup
	loadPopup(popup_sender_receiver_div, popup_sender_receiver_bg);	
	
	//character counter
	computeCharactersSenderToReceiver();
}

function closePopUpSenderReceiver(){
	disablePopup(popup_sender_receiver_div, popup_sender_receiver_bg);
}

function init(){

	
	$('#sender_info').click(openPopUpSenderReceiver);
	$('.sender_receiver_close').click(closePopUpSenderReceiver);
	
}

$(init);


function computeCharactersSenderToReceiver() {
	var l = 350;
	$("#sender_receiver_popup #remainingCharacter").text(l)
	$("#sender_receiver_popup #senderToReceiver").keydown(onAddText);
	$("#sender_receiver_popup #senderToReceiver").keyup(onAddText);
	$("#sender_receiver_popup #senderToReceiver")
			.keypress(onAddText);

	function onAddText() {
		if ($("#sender_receiver_popup #senderToReceiver").val().length > l) {
			$("#sender_receiver_popup #senderToReceiver").val(
					$("#sender_receiver_popup #senderToReceiver")
							.val().substring(0, (l)));
		} else {
			var m = $("#sender_receiver_popup #senderToReceiver")
					.val().length;
			k = l - m;
			if (k >= 0) {
				$("#sender_receiver_popup #remainingCharacter")
						.text(k);
			} else if (k < 0) {
				$("#sender_receiver_popup #remainingCharacter")
						.text("0");
			}
		}
	}
}