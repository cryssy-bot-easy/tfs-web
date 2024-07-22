/* Modified by: Rafael Ski Poblete
 * Date Modified : 8/01/2018
 * Description : Changed "chargeNarrative" to "chargesNarrative" for variable consistency.
 * */
function onMt742CommentSaveClick() {
    var mt742Comment = $("#mt742Comment").val();
    disablePopup("popup_mt742","mt_742_bg");

    switch($("#popup_header_mt742").text()){
    
	case "Sender to Receiver Information":
    	$("#senderToReceiverInformation").val(mt742Comment);
    	break;
	case "Issuing Bank MT742":
    	$("#issuingBankAddress").val(mt742Comment);
    	break;
    	
	case "Account With Bank MT742":
    	$("#corresBankNameAndAddress").val(mt742Comment);
    	break;
    	
	case "Beneficiary MT742":
    	$("#beneficiaryNameAndAddress").val(mt742Comment);
    	break;

	case "Charges MT742":
		$("#chargeNarrative").val(mt742Comment);
		break;

    }
}
$(document).ready(function(){
	var wrapper_div=$("#popup_mt742").attr("id");
	var div_bg=$("#mt_742_bg").attr("id");

	$("#close_mt742Label, #close_mt742").click(function(){
		disablePopup(wrapper_div,div_bg);
	});	
	//popup of textarea in non lc mt tabs

	$("#mt742_popup_btn_sender_receiver_information").click(function(){
    	$("#mt742Comment").val($("#senderToReceiverInformation").val());
		$("#popup_header_mt742").text("Sender to Receiver Information");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt742Comment()
	});
	
	//MT742 Settle Data Entry - March 23, 2013
	$("#mt742_popup_btn_account_with_bank").click(function(){
    	$("#mt742Comment").val($("#corresBankNameAndAddress").val());
		$("#popup_header_mt742").text("Account With Bank MT742");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt742Comment()
	});
	
	$("#mt742_popup_btn_beneficiary_bank").click(function(){
    	$("#mt742Comment").val($("#beneficiaryNameAndAddress").val());
		$("#popup_header_mt742").text("Beneficiary MT742");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt742Comment()
	});

	$("#mt742_popup_btn_issuing_bank").click(function(){
    	$("#mt742Comment").val($("#issuingBankAddress").val());
		$("#popup_header_mt742").text("Issuing Bank MT742");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt742Comment()
	});

	$("#742_popup_btn_envelopeContents").click(function(){
		$("#mt742Comment").val($("#chargesNarrative").val());
		$("#popup_header_mt742").text("Charges MT742");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeMt742Comment()
	});
			
	$("#mt742Comment").limitCharAndLines(35, 4);

	$("#mt742PopupSave").click(onMt742CommentSaveClick);
	
	function reInitializeMt742Comment() {
		$("#mt742Comment").limitCharAndLines(35, 4);
	}
});