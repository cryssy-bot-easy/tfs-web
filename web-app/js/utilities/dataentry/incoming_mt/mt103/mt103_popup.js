function onMt103CommentSaveClick() {
    var mt103Comment = $("#mt103Comment").val();
    disablePopup("popup_mt103","mt_103_bg");

    switch($("#popup_header_mt103").text()){
    
	case "Sender to Receiver Information":
    	$("#senderToReceiverInformationTextArea").val(mt103Comment);
    	break;
	case "Ordering Bank/Institution MT103":
    	$("#bankNameAndAddress").val(mt103Comment);
    	break;
    	
	case "Sender's Correspondent MT103":
    	$("#senderNameAndAddress").val(mt103Comment);
    	break;
    	
	case "Receiver's Correspondent MT103":
    	$("#receiverNameAndAddress").val(mt103Comment);
    	break;
    	
	case "Intermediary MT103":
    	$("#intermediaryNameAndAddressMt").val(mt103Comment);
    	break;
    	
	case "Account with Bank MT103":
    	$("#accountNameAndAddress").val(mt103Comment);
    	break;    	
	case "Beneficiary Bank/Institution MT103":
    	$("#beneficiaryAddress").val(mt103Comment);
    	$("#beneficiaryAddress").change();
    	break;
	case "Remittance Information MT103":
		$("#remittanceInformationTextArea").val(mt103Comment);
		break;
	case "Regulatory Reporting MT103":
		$("#regulatoryReportingTextArea").val(mt103Comment);
		break;
	case "Instruction Code MT103":
		$("#bankOperationTextArea").val(mt103Comment);
		break;
	case "Envelope Contents MT103":
		$("#envelopeContentsTextArea").val(mt103Comment);
		break;
    }
}
$(document).ready(function(){
	var wrapper_div=$("#popup_mt103").attr("id");
	var div_bg=$("#mt_103_bg").attr("id");

	$("#close_mt103Label, #close_mt103").click(function(){
		disablePopup(wrapper_div,div_bg);
	});	
	//popup of textarea in non lc mt tabs

	$("#mt103_popup_btn_sender_receiver_information").click(function(){
    	$("#mt103Comment").val($("#senderToReceiverInformationTextArea").val());
		$("#popup_header_mt103").text("Sender to Receiver Information");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
	
	//MT103 Settle Data Entry - March 23, 2013
	$("#mt103_popup_btn_ordering_bank").click(function(){
    	$("#mt103Comment").val($("#bankNameAndAddress").val());
		$("#popup_header_mt103").text("Ordering Bank/Institution MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
	
	$("#mt103_popup_btn_sender_correspondent").click(function(){
    	$("#mt103Comment").val($("#senderNameAndAddress").val());
		$("#popup_header_mt103").text("Sender's Correspondent MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});

	$("#mt103_popup_btn_receiver_correspondent").click(function(){
    	$("#mt103Comment").val($("#receiverNameAndAddress").val());
		$("#popup_header_mt103").text("Receiver's Correspondent MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
	
	$("#mt103_popup_btn_intermediary").click(function(){
    	$("#mt103Comment").val($("#intermediaryNameAndAddressMt").val());
		$("#popup_header_mt103").text("Intermediary MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
	
	$("#mt103_popup_btn_account_with_bank").click(function(){
    	$("#mt103Comment").val($("#accountNameAndAddress").val());
		$("#popup_header_mt103").text("Account with Bank MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
	
	$("#mt103_popup_btn_beneficiary_bank").click(function(){
    	$("#mt103Comment").val($("#beneficiaryAddress").val());
		$("#popup_header_mt103").text("Beneficiary Bank/Institution MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});

	$("#mt103_popup_btn_remittanceInformation").click(function(){
		$("#mt103Comment").val($("#remittanceInformationTextArea").val());
		$("#popup_header_mt103").text("Remittance Information MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});

	$("#mt103_popup_btn_regulatoryReporting").click(function(){
		$("#mt103Comment").val($("#regulatoryReportingTextArea").val());
		$("#popup_header_mt103").text("Regulatory Reporting MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});

	$("#mt103_popup_btn_instruction_code").click(function(){
		$("#mt103Comment").val($("#bankOperationTextArea").val());
		$("#popup_header_mt103").text("Instruction Code MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});

	$("#mt103_popup_btn_envelopeContents").click(function(){
		$("#mt103Comment").val($("#envelopeContentsTextArea").val());
		$("#popup_header_mt103").text("Envelope Contents MT103");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt103Comment()
	});
		
	$("#mt103Comment").limitCharAndLines(35, 4);

	$("#mt103PopupSave").click(onMt103CommentSaveClick);
	
	function reInitializeMt103Comment() {
		$("#mt103Comment").limitCharAndLines(35, 4);
	}
});