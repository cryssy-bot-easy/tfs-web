function onMt202CommentSaveClick() {
    var mt202Comment = $("#mt202Comment").val();
    disablePopup("popup_mt202","mt_202_bg");

    switch($("#popup_header_mt202").text()){
    
	case "Sender to Receiver Information":
    	$("#senderToReceiverInformationMt202").val(mt202Comment);
    	break;
	case "Ordering Bank/Institution MT202":
    	$("#bankNameAndAddressMt202").val(mt202Comment);
    	break;
    	
	case "Sender's Correspondent MT202":
    	$("#senderNameAndAddressMt202").val(mt202Comment);
    	break;
    	
	case "Receiver's Correspondent MT202":
    	$("#receiverNameAndAddressMt202").val(mt202Comment);
    	break;
    	
	case "Intermediary MT202":
    	$("#intermediaryNameAndAddressMt202").val(mt202Comment);
    	break;
    	
	case "Account with Bank MT202":
    	$("#accountNameAndAddressMt202").val(mt202Comment);
    	break;
    	
	case "Beneficiary Bank/Institution MT202":
    	$("#beneficiaryNameAndAddressMt202").val(mt202Comment);
    	$("#beneficiaryNameAndAddressMt202").change();
    	break;
    }
}
$(document).ready(function(){
	var wrapper_div=$("#popup_mt202").attr("id");
	var div_bg=$("#mt_202_bg").attr("id");

	$("#close_mt202Label, #close_mt202").click(function(){
		disablePopup(wrapper_div,div_bg);
	});	
	//popup of textarea in non lc mt tabs

	$("#mt202_popup_btn_sender_receiver_information").click(function(){
    	$("#mt202Comment").val($("#senderToReceiverInformationMt202").val());
		$("#popup_header_mt202").text("Sender to Receiver Information");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
	
	//MT202 Settle Data Entry - March 23, 2013
	$("#mt202_popup_btn_ordering_bank").click(function(){
    	$("#mt202Comment").val($("#bankNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Ordering Bank/Institution MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
	
	$("#mt202_popup_btn_sender_correspondent").click(function(){
    	$("#mt202Comment").val($("#senderNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Sender's Correspondent MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});

	$("#mt202_popup_btn_receiver_correspondent").click(function(){
    	$("#mt202Comment").val($("#receiverNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Receiver's Correspondent MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
	
	$("#mt202_popup_btn_intermediary").click(function(){
    	$("#mt202Comment").val($("#intermediaryNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Intermediary MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
	
	$("#mt202_popup_btn_account_with_bank").click(function(){
    	$("#mt202Comment").val($("#accountNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Account with Bank MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
	
	$("#mt202_popup_btn_beneficiary_bank").click(function(){
    	$("#mt202Comment").val($("#beneficiaryNameAndAddressMt202").val());
		$("#popup_header_mt202").text("Beneficiary Bank/Institution MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt202Comment()
	});
		
	$("#mt202Comment").limitCharAndLines(35, 4);

	$("#mt202PopupSave").click(onMt202CommentSaveClick);
	
	function reInitializeMt202Comment() {
		$("#mt202Comment").limitCharAndLines(35, 4);
	}
});