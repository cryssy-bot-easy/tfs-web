var popup_letter_of_transfer_div = $("#letterOfTransferPopup");
var popup_letter_of_transfer_bg = $("#popupBackground_letter_of_transfer");

function openLetterOfTransferPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateLetterOfTransfer');
	mCenterPopup(popup_letter_of_transfer_div, popup_letter_of_transfer_bg);
	mLoadPopup(popup_letter_of_transfer_div, popup_letter_of_transfer_bg);
}

function closeLetterOfTransferPopUp() {
	mDisablePopup(popup_letter_of_transfer_div, popup_letter_of_transfer_bg);
}

$(document).ready(function() {	 
	
	$("#generateLetterOfTransfer").live("click",function(){		
		
		if($("#recevingBank").val() == "" 
			|| $("#receivingBankAddress").val() == "" 
			|| $("#recipient").val() == "" 
			|| $("#recipientPosition").val() == ""
			|| $("#documentsLists").val() == ""
			|| $("#authorizedSignatory").val() == ""){
			alert("Please fill in all the required fields.");
		}else{			
			generateTransferLetterReport();		
		}
		
	});
	
});

