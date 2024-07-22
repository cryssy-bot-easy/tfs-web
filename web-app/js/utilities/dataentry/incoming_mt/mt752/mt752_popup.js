function onMt752CommentSaveClick() {
    var mt752Comment = $("#mt752Comment").val();
    disablePopup("popup_mt752","mt_752_bg");

    switch($("#popup_header_mt752").text()){
    
	case "Sender to Receiver Information":
    	$("#senderToReceiverInformationMt752").val(mt752Comment);
    	break;
    	
	case "Sender's Correspondent MT752":
    	$("#senderNameAndAddressMt752").val(mt752Comment);
    	break;
    	
	case "Receiver's Correspondent MT752":
    	$("#receiverNameAndAddressMt752").val(mt752Comment);
    	break;
    }
}

$(document).ready(function(){
	var wrapper_div=$("#popup_mt752").attr("id");
	var div_bg=$("#mt_752_bg").attr("id");

	$("#close_mt752Label, #close_mt752").click(function(){
		disablePopup(wrapper_div,div_bg);
	});	
	//popup of textarea in non lc mt tabs

	$("#mt752_popup_btn_sender_receiver_information").click(function(){
    	$("#mt752Comment").val($("#senderToReceiverInformationMt752").val());
		$("#popup_header_mt752").text("Sender to Receiver Information");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt752Comment()
	});
	
	$("#mt752_popup_btn_sender_correspondent").click(function(){
    	$("#mt752Comment").val($("#senderNameAndAddressMt752").val());
		$("#popup_header_mt752").text("Sender's Correspondent MT752");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt752Comment()
	});

	$("#mt752_popup_btn_receiver_correspondent").click(function(){
    	$("#mt752Comment").val($("#receiverNameAndAddressMt752").val());
		$("#popup_header_mt752").text("Receiver's Correspondent MT752");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt752Comment()
	});
	
	$("#mt752Comment").limitCharAndLines(35, 4);

	$("#mt752PopupSave").click(onMt752CommentSaveClick);
	
	function reInitializeMt752Comment() {
		$("#mt752Comment").limitCharAndLines(35, 4);
	}
});