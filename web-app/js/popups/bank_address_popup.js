/**
	(revision)
	SCR/ER Number: 20161121-097
	SCR/ER Description: Failed to route because of following reason: TFS Web app allows user to input MORE THAN 50 characters on the screen. However, our database accepts only 50 characters. (Redmine# 5644)
	[Revised by:] John Patrick C. Bautista
	[Date deployed:] 1/10/2016
	Program [Revision] Details: Adjusted the max length of textfields. As for textareas, LCs and Non LCs: Importer/Buyer 4x35, Exporter/Seller 2x35.
	Member Type: JavaScript file (JS)
	Project: WEB
	Project Name: bank_address_popup.js
*/

/**
 * (revision)
 *	SCR/ER Number: 
 *	SCR/ER Description: EBP Negotiation Importer Address (Redmine# 4139)
 *	[Revised by:] Brian Harold A. Aquino
 *	[Date revised:] 02/08/2017 (tfs-web Rev# 7357)
 *	[Date deployed:] 06/16/2017
 *	Program [Revision] Details: Added a condition for EBP.
 *	Member Type: JS
 *	Project: WEB
 *	Project Name: bank_address_popup.js
 */

/**
 * (revision)
 *	SCR/ER Number: *none*
 *	SCR/ER Description: Negotiation Discrepancy Module 
 *	[Revised by:] Rafael T. Poblete
 *	[Date revised:] 07/19/2017 
 *	[Date deployed:] 
 *	Program [Revision] Details: Added a pop-up function for sender to receiver information ellipses.
 *	Member Type: JS
 *	Project: WEB
 *	Project Name: bank_address_popup.js
 */

/**
 * (revision)
 *	SCR/ER Number: 
 *	SCR/ER Description: Negotiation Discrepancy Module
 *	[Revised by:] John Patrick C. Bautista
 *	[Date revised:] July 19, 2017
 *	[Date deployed:] 
 *	Program [Revision] Details: Corrected typographical error on checkbox fields.
 *	Member Type: JavaScript file (JS)
 *	Project: WEB
 *	Project Name: bank_address_popup.js
 */

/**
	(revision)
	SCR/ER Number: 
	SCR/ER Description: Negotiation Discrepancy
	[Revised by:] John Patrick C. Bautista
	[Date deployed:] 09/15/2017
	Program [Revision] Details: Added 'DOMESTIC' in the condition for adding dash in popup of Discrepancy Tab textareas.
	Member Type: JavaScript file (JS)
	Project: WEB
	Project Name: bank_address_popup.js
*/
/**
	(revision)
	[Modified by:] Rafael Ski Poblete
	[Date deployed:] 07/26/2018
	[Description: ] Added 'Z' as parameter for sender to receiver.
*/
/**
	(revision)
	[Modified by:] Cedrick C. Nungay
	[Date deployed:] 08/02/2018
	[Description: ] Added 'Z' as parameter on reInitializeBankAddressCommentNegoDiscrepancy for negotiation discrepancy.
*/
/**
	(revision)
	[Modified by:] Cedrick C. Nungay
	[Date deployed:] 08/27/2018
	[Description: ] Added new other place of expiry, new mixed payment details and new deferred payment detail for MT707.
 */

function onBankAddressPopupSaveClick() {
    var bankAddressComment = $("#bankAddressComment").val().trim().split('\t').join('');
    var consumedLines = 65 - parseInt($("#lines").val());
    disablePopup("popup_bankAddress","bank_address_bg");

    if ($("#beneficiaryComplete").length > 0 && bankAddressComment != "") {
        $("#beneficiaryComplete").val(true);
    }

    switch($("#popup_header_bankAddress").text()){
    case "Importer Address": case "Buyer Address":
    	if(serviceType == "Amendment") {
    		$("#importerAddressTo").val(bankAddressComment);
    	} else if (serviceType.toUpperCase() === "NEGOTIATION") {
    		$("#buyerAddress").val(bankAddressComment);
    	} else {
    		$("#importerAddress").val(bankAddressComment);
    	}
    	break;
    case "Exporter Address":
    	if(serviceType == "Amendment") {
    		$("#exporterAddressTo").val(bankAddressComment);
    	}
    	else {
    		$("#exporterAddress").val(bankAddressComment);
    	}
    	break;
    case "Bank Address":
//	    $("#nameAndAddress").val(bankAddressComment);
        if($("#nameAndAddressTo").length > 0){
            $("#nameAndAddressTo").val(bankAddressComment);
        } else {
            $("#nameAndAddress").val(bankAddressComment);
        }
	    break;
    case "'Advise Through' Bank":
    	if(serviceType == "Amendment") {
    		$("#adviseThroughBankNameAndAddressTo").val(bankAddressComment);
    	}
    	else {
    		$("#adviseThroughBankNameAndAddress").val(bankAddressComment);
    	}
    	break;
    case "Beneficiary Address": case "Seller Address":
    	$("#beneficiaryAddress").val(bankAddressComment);
    	break;
    	
    //popup of textarea in non lc mt tabs
	case "Sender's Correspondent":
		$("#senderNameAndAddressMt").val(bankAddressComment);
		$("#senderNameAndAddressMt").change();
    	$("#senderNameAndAddress").val(bankAddressComment);
    	break;
    	
	case "Receiver's Correspondent":
		$("#receiverNameAndAddressMt").val(bankAddressComment);
		$("#receiverNameAndAddressMt").change();
    	$("#receiverNameAndAddress").val(bankAddressComment);
    	break;
	
	case "Ordering Bank": case "Ordering Institution":
		$("#bankNameAndAddressMt202").val(bankAddressComment);
		$("#bankNameAndAddressMt202").change();
    	$("#bankNameAndAddress").val(bankAddressComment);
    	break;
    
	case "Receiver's Correspondent (MT202)":
    	$("#receiverMt202NameAndAddress").val(bankAddressComment);
    	break;
    	
	case "Receiver's Correspondent (MT400)":
    	$("#receiverMt400NameAndAddress").val(bankAddressComment);
    	break;
   	
	case "Intermediary":
    	$("#intermediaryNameAndAddressMt").val(bankAddressComment);
    	$("#intermediaryNameAndAddressMt").change();
    	break;
	
	case "Account with Bank": case "Account with Institution":
		$("#accountNameAndAddressMt").val(bankAddressComment);
		$("#accountNameAndAddressMt").change();
    	$("#accountNameAndAddress").val(bankAddressComment);
    	break;
    	
	case "Beneficiary's Institution":
		$("#beneficiaryNameAndAddressMt").val(bankAddressComment);
		$("#beneficiaryNameAndAddressMt").change();
		break;
		
	case "Beneficiary Bank":
    	$("#beneficiaryNameAndAddress").val(bankAddressComment);
    	break;
    	
	case "Sender to Receiver Information":
	// For FX LC only
	if($("#lcNegoDiscrepancyFlag") != 'undefined' && $("#lcNegoDiscrepancyFlag").val() == "true"){
		$("#senderToReceiverInformation").val(bankAddressComment);
	} else { 
		$("#senderToReceiverInformationTextArea").val(bankAddressComment);
	}
    	break;
    	
	case "Instruction Code":
    	$("#bankOperationTextArea").val(bankAddressComment);
    	break;
    	
   	//MT400 Settle Data Entry - March 23, 2013
	case "Ordering Bank MT400":
    	$("#bankNameAndAddressMt400").val(bankAddressComment);
    	break;
    	
	case "Sender's Correspondent MT400":
    	$("#senderNameAndAddressMt400").val(bankAddressComment);
    	break;
    	
	case "Receiver's Correspondent MT400":
    	$("#receiverNameAndAddressMt400").val(bankAddressComment);
    	break;
    	
	case "Account With Bank MT400":
    	$("#accountNameAndAddressMt400").val(bankAddressComment);
    	break;
    	
	case "Beneficiary Bank MT400":
    	$("#beneficiaryNameAndAddressMt400").val(bankAddressComment);
    	break;
    	
    //MT202 Settle Data Entry - March 23, 2013
	case "Ordering Bank MT202":
    	$("#bankNameAndAddressMt202").val(bankAddressComment);
    	break;
    	
	case "Sender's Correspondent MT202":
    	$("#senderNameAndAddressMt202").val(bankAddressComment);
    	break;
    	
	case "Receiver's Correspondent MT202":
    	$("#receiverNameAndAddressMt202").val(bankAddressComment);
    	break;
    	
	case "Intermediary MT202":
    	$("#intermediaryNameAndAddressMt202").val(bankAddressComment);
    	break;
    	
	case "Account with Bank MT202":
    	$("#accountNameAndAddressMt202").val(bankAddressComment);
    	break;
    	
	case "Beneficiary Bank MT202":
    	$("#beneficiaryNameAndAddressMt202").val(bankAddressComment);
    	$("#beneficiaryNameAndAddressMt202").change();
    	break;
    	
	case "2nd Advising Bank Address":
    	$("#advisingBankAddress").val(bankAddressComment);
    	break;
    	
	case "New Exporter Address":
    	$("#newExporterAddress").val(bankAddressComment);
    	break;
    	
	case "Description of Goods not as per LC" :
		if ($("#descriptionOfGoodsNotAsPerLc").val()) {
			$("#descriptionOfGoodsNotAsPerLc").val($("#descriptionOfGoodsNotAsPerLc").val() + "\r\n " + bankAddressComment);
		} else {
			$("#descriptionOfGoodsNotAsPerLc").val(" " + bankAddressComment);
		}
		
		$("#totalLinesDescriptionOfGoods").val(consumedLines)
		$("#descriptionOfGoodsNotAsPerLc").trigger("click");
		break;
		
	case "Documents not Presented" :
		if ($("#documentsNotPresented").val()) {
			$("#documentsNotPresented").val($("#documentsNotPresented").val() + "\r\n " + bankAddressComment);
		} else {
			$("#documentsNotPresented").val(" " + bankAddressComment);
		}
		
		$("#totalLinesDocumentsNotPresent").val(consumedLines)
		$("#documentsNotPresented").trigger("click");
		break;
		
	case "Others" :
		if ($("#others").val()) {
			$("#others").val($("#others").val() + "\r\n " + bankAddressComment);
		} else {
			$("#others").val(" " + bankAddressComment);
		}
		
		$("#totalLinesOthers").val(consumedLines);
		$("#others").trigger("click");
		break;
		
	case "Disposal of Documents":
		$("#disposalOfDocumentsText").val(bankAddressComment);
		$("#disposalOfDocumentsText").change();
		break;
    	
    //comment by robin 4116. set attribute to 250 then change back to 140 after saving
	case "Sender to Receiver Information EBC Nego":
	$("#senderToReceiverInformationEbcNego").val(bankAddressComment);
	//document.getElementById("bankAddressComment").removeAttribute("maxlength");
	document.getElementById("bankAddressComment").setAttribute("maxlength", 140);
	console.log("after saving: " + document.getElementById("bankAddressComment").getAttribute("maxlength"));
	break;
	
	case "New Other Place of Expiry":
		$("#otherPlaceOfExpiryTo").val(bankAddressComment);
		break;

	case "New Mixed Payment Details":
		$("#mixedPaymentDetailsTo").val(bankAddressComment);
		break;
		
	case "New Deferred Payment Details":
		$("#deferredPaymentDetailsTo").val(bankAddressComment);
		break;
	}

//    if($("#nameAndAddressTo").length > 0){
//        $("#nameAndAddressTo").val(bankAddressComment);
//    } else {
//        $("#nameAndAddress").val(bankAddressComment);
//    }

    if ($("#sendersCorrespondent").length > 0) {
        if ($("#bankAddressComment").val() != "") {
            $("#sendersCorrespondent").val("1");
        } else {
            $("#sendersCorrespondent").val("");
        }
    }

}

$(document).ready(function(){
	var wrapper_div=$("#popup_bankAddress").attr("id");
	var div_bg=$("#bank_address_bg").attr("id");
	var totalLines = 0;
	
	function isChecked(value) {
		return value === "on" ? 1 : 0;
	}

	function getCarriageReturn(stringValue) {
		var count = 0;
		if (stringValue) {
			var text = stringValue.split("\n");
			for (var i = 0, j = text.length; i < j; i += 1) {
				count = count + 1;
			}
		}
		return count;
	}
	
	function getTotalLines() {
		var descriptionOfGoods = getCarriageReturn($("#descriptionOfGoodsNotAsPerLc").val()),
			documentsNotPresented = getCarriageReturn($("#documentsNotPresented").val()),
			others = getCarriageReturn($("#others").val()),
			fixedTotalLines = 70 - (isChecked($("#descriptionOfGoodsNotPerLcSwitch").val()) + 
				isChecked($("#documentsNotPresentedSwitch").val()) + 
				isChecked($("#othersSwitch").val()) + 
				isChecked($("#expiredLcSwitch").val()) + 
				isChecked($("#overdrawnForAmountSwitch").val()));
		
		totalLines = fixedTotalLines - (descriptionOfGoods + documentsNotPresented + others);
		
		$("#totalLinesDescriptionOfGoods").val(descriptionOfGoods);
		$("#totalLinesDocumentsNotPresent").val(documentsNotPresented);
		$("#totalLinesOthers").val(others);
	}
	
	getTotalLines();
	
	// For Nego Discrepancy
	$("#bankAddressComment").on("keypress keyup change", function () {
		var text = $("#bankAddressComment").val(),
			key = event.keyCode || event.charCode;

		if (documentClass == "LC" && serviceType == "Negotiation_Discrepancy" && 
			(documentType == "FOREIGN" || documentType == "DOMESTIC") && referenceType == "DATA_ENTRY" && 
			$("#popup_header_bankAddress").text() !== "Disposal of Documents") {
			if ((text.length === 0 && (key == 8 || key == 46)) ||
				(text.length === 1 && $("#bankAddressComment").val() === '-') ||
				(text.length === 2 && $("#bankAddressComment").val() === '--')) {
				$("#bankAddressComment").val("");
			} else if((text.length === 0 || (text.length === 1 && $("#bankAddressComment").val() !== '-')) 
					&& $("#popup_header_bankAddress").text() !== "Sender to Receiver Information"){
				$("#bankAddressComment").val(" -"); 
			}	
		}
	});
		
	$("#close_bankAddress1, #close_bankAddress2").click(function(){
		disablePopup(wrapper_div,div_bg);
	});
	
	// For Nego Discrepancy
	$("#descriptionOfGoodsNotAsPerLc").click(getTotalLines);
	$("#documentsNotPresented").click(getTotalLines);
	$("#others").click(getTotalLines);
	$("#descriptionOfGoodsNotPerLcSwitchDisplay").click(getTotalLines);
	$("#documentsNotPresentedSwitchDisplay").click(getTotalLines);
	$("#othersSwitchDisplay").click(getTotalLines);
	
	$("#popup_btn_bank_address").click(function(){
		$("#bankAddressComment").val($("#nameAndAddress").val());
		$("#popup_header_bankAddress").text("Bank Address");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment();
	});
	$("#popup_btn_bank_address_to").click(function(){
		$("#bankAddressComment").val($("#nameAndAddressTo").val());
		$("#popup_header_bankAddress").text("Bank Address");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment();
	});
	$("#popup_btn_importer_bank_address").click(function(){
		if(serviceType == "Amendment") {
			$("#bankAddressComment").val($("#importerAddressTo").val());
    	} else if (serviceType.toUpperCase() === "NEGOTIATION") {
    		$("#bankAddressComment").val($("#buyerAddress").val());
    	} else {
    		$("#bankAddressComment").val($("#importerAddress").val());
    	}
		$("#popup_header_bankAddress").text(function(){
			if (documentType == 'FOREIGN' || documentClass == 'EXPORT_ADVISING' || serviceType.toUpperCase() === "NEGOTIATION"){
				return "Importer Address"
			} else {
				return "Buyer Address"
			}
		});
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		switch( documentClass ){
			case "LC": //LC
				reInitializeBankAddressComment();
				var documentSubType1 = $('#documentSubType1').val();
				if (documentType == 'FOREIGN' && serviceType == 'Amendment' && (documentSubType1 == 'CASH' || documentSubType1 == 'REGULAR')) {
					$("#bankAddressComment").limitCharAndLines(35, 2);
				}
				break;
			case "EXPORT_ADVISING": //Export Products
				$("#bankAddressComment").limitCharAndLines(35,2);
				break;
			default: //Non-LC
				reInitializeBankAddressComment();
				break;
		}
	});
	
	$("#popup_btn_exporter_bank_address").click(function(){
		if(serviceType == "Amendment") {
			$("#bankAddressComment").val($("#exporterAddressTo").val());
    	}
    	else {
    		$("#bankAddressComment").val($("#exporterAddress").val());
    	}
		$("#popup_header_bankAddress").text("Exporter Address");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		switch( documentClass ){
		case "LC": //LC
			$("#bankAddressComment").limitCharAndLines(35,2);
			break;
		case "EXPORT_ADVISING": //Export Products
			reInitializeBankAddressComment();
			break;
		default: //Non-LC
			$("#bankAddressComment").limitCharAndLines(35,2);
			break;
	}
	});
	
	$("#popup_btn_advise_through_bank").click(function(){
		if(serviceType == "Amendment") {
			$("#bankAddressComment").val($("#adviseThroughBankNameAndAddressTo").val());
    	}
    	else {
    		$("#bankAddressComment").val($("#adviseThroughBankNameAndAddress").val());
    	}
		$("#popup_header_bankAddress").text("'Advise Through' Bank");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_beneficiary_address").click(function(){
		var beneficiaryAddress = $("#beneficiaryAddress").val();
		if ( beneficiaryAddress != "" ){
			if ( hasWhiteSpace(beneficiaryAddress) == true ){
				beneficiaryAddress = beneficiaryAddress.replace(/(\r\n|\n|\r)/gm, ' ');
			} 
			else{
				beneficiaryAddress = beneficiaryAddress.replace(/(\r\n|\n|\r)/gm, '');
			}
		}
    	$("#bankAddressComment").val(beneficiaryAddress);
		$("#popup_header_bankAddress").text(function(){
			if (documentType == 'FOREIGN'){
				return "Beneficiary Address"
			} else {
				return "Seller Address"
			}
		});
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
//		reInitializeBankAddressComment()
		$("#bankAddressComment").limitCharAndLines(35,2);
	});
	
	// Pop-up function for sender to receiver information ellipses.
	$("#popup_btn_sender_to_receiver_information").click(function(){
		var senderToReceiverInformation = $("#senderToReceiverInformation").val();
		if(senderToReceiverInformation != ""){
			if(hasWhiteSpace(senderToReceiverInformation) == true){
				senderToReceiverInformation = senderToReceiverInformation.replace(/(\r\n|\n|\r)/gm, ' ');
			} else {
				senderToReceiverInformation = senderToReceiverInformation.replace(/(\r\n|\n|\r)/gm, '');
			}
		}
    	$("#bankAddressComment").val(senderToReceiverInformation);
		$("#popup_header_bankAddress").text(function(){
			if(documentType == 'FOREIGN'){
				return "Sender to Receiver Information"
			} 
		});
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		$("#bankAddressComment").limitCharAndLines(35, 6, 'Z');
		$("#bankAddressComment").removeAttr("maxlength");
		$("#bankAddressComment").attr("maxlength", 215); 
	});
	
	// Check if a string has white space
	function hasWhiteSpace(s) {
		return s.indexOf(' ') >= 0;
	}
	
	//comment by robin 4116. set attribute to 250 then change back to 140 after saving
	$("#popup_senderToReceiverInformation").click(function(){
		console.log("sender to receiver: " + document.getElementById("senderToReceiver").value);
		console.log("initial max length: " + document.getElementById("bankAddressComment").getAttribute("maxlength"));
		if(document.getElementById("senderToReceiver").value != "REIMBREF"){
			console.log("no code selected. set maxlength to 210");
			document.getElementById("bankAddressComment").setAttribute("maxlength", 210);
		}else{
			console.log("with code REIMBREF. set maxlength to 190");
			document.getElementById("bankAddressComment").setAttribute("maxlength", 200);
		}
		$("#bankAddressComment").limitCharAndLines(33,6);	
		//document.getElementById("bankAddressComment").removeAttribute("maxlength");
		console.log("confirm maxlength: " + document.getElementById("bankAddressComment").getAttribute("maxlength"));

		var text = document.getElementById('senderToReceiverInformationEbcNego').value;
		//text = text.replace(/(\r\n|\n|\r)/gm,"");
		document.getElementById('bankAddressComment').value = text;
		$("#popup_header_bankAddress").text("Sender to Receiver Information EBC Nego");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		
	});
	
	//popup of textarea in non lc mt tabs
	$("#popup_btn_sender_correspondent").click(function(){
		if(documentClass == 'LC' && serviceType.toUpperCase() == "NEGOTIATION"){
			$("#bankAddressComment").val($("#senderNameAndAddressMt").val());
		} else {
			$("#bankAddressComment").val($("#senderNameAndAddress").val());
		}
		$("#popup_header_bankAddress").text("Sender's Correspondent");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_receiver_correspondent").click(function(){
		if(documentClass == 'LC' && serviceType.toUpperCase() == "NEGOTIATION"){
			$("#bankAddressComment").val($("#receiverNameAndAddressMt").val());
		} else {
			$("#bankAddressComment").val($("#receiverNameAndAddress").val());
		}
		$("#popup_header_bankAddress").text("Receiver's Correspondent");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_ordering_bank").click(function(){
		if(documentClass == 'LC' && serviceType.toUpperCase() == "NEGOTIATION"){
			$("#bankAddressComment").val($("#bankNameAndAddressMt202").val());
			$("#popup_header_bankAddress").text("Ordering Institution");
		} else { 
	    	$("#bankAddressComment").val($("#bankNameAndAddress").val());
	    	if(documentClass == 'DR' || documentClass == 'OA') {
	    		$("#popup_header_bankAddress").text("Ordering Institution");
	    	}
	    	else {
	    		$("#popup_header_bankAddress").text("Ordering Bank");
	    	}
		}
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_receiver_correspondent_mt202").click(function(){
    	$("#bankAddressComment").val($("#receiverMt202NameAndAddress").val());
		$("#popup_header_bankAddress").text("Receiver's Correspondent (MT202)");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_receiver_correspondent_mt400").click(function(){
    	$("#bankAddressComment").val($("#receiverMt400NameAndAddress").val());
		$("#popup_header_bankAddress").text("Receiver's Correspondent (MT400)");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_intermediary").click(function(){
    	$("#bankAddressComment").val($("#intermediaryNameAndAddressMt").val());
		$("#popup_header_bankAddress").text("Intermediary");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_account_with_bank").click(function(){
		if(documentClass == 'LC' && serviceType.toUpperCase() == "NEGOTIATION"){
			$("#bankAddressComment").val($("#accountNameAndAddressMt").val());
			$("#popup_header_bankAddress").text("Account with Institution");
		} else { 
	    	$("#bankAddressComment").val($("#accountNameAndAddress").val());
	    	if(documentClass == 'DR' || documentClass == 'OA') {
	    		$("#popup_header_bankAddress").text("Account with Institution");
	    	}
	    	else {
	    		$("#popup_header_bankAddress").text("Account with Bank");
	    	}
		}
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_beneficiary_bank").click(function(){
		if(documentClass == 'LC' && serviceType.toUpperCase() == "NEGOTIATION"){
			$("#bankAddressComment").val($("#beneficiaryNameAndAddressMt").val());
			$("#popup_header_bankAddress").text("Beneficiary's Institution");
		} else { 
	    	$("#bankAddressComment").val($("#beneficiaryNameAndAddress").val());
	    	$("#popup_header_bankAddress").text("Beneficiary Bank");
		}
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_sender_receiver_information").click(function(){
    	$("#bankAddressComment").val($("#senderToReceiverInformationTextArea").val());
		$("#popup_header_bankAddress").text("Sender to Receiver Information");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_instruction_code").click(function(){
    	$("#bankAddressComment").val($("#bankOperationTextArea").val());
		$("#popup_header_bankAddress").text("Instruction Code");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	//MT400 Settle Data Entry - March 23, 2013
	$("#popup_btn_ordering_bankMt400").click(function(){
    	$("#bankAddressComment").val($("#bankNameAndAddressMt400").val());
		$("#popup_header_bankAddress").text("Ordering Bank MT400");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_sender_correspondentMt400").click(function(){
    	$("#bankAddressComment").val($("#senderNameAndAddressMt400").val());
		$("#popup_header_bankAddress").text("Sender's Correspondent MT400");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_receiver_correspondent_mt400").click(function(){
    	$("#bankAddressComment").val($("#receiverNameAndAddressMt400").val());
		$("#popup_header_bankAddress").text("Receiver's Correspondent MT400");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_account_with_bankMt400").click(function(){
    	$("#bankAddressComment").val($("#accountNameAndAddressMt400").val());
		$("#popup_header_bankAddress").text("Account With Bank MT400");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_beneficiary_bankMt400").click(function(){
    	$("#bankAddressComment").val($("#beneficiaryNameAndAddressMt400").val());
		$("#popup_header_bankAddress").text("Beneficiary Bank MT400");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	
	//MT202 Settle Data Entry - March 23, 2013
	$("#popup_btn_ordering_bankMt202").click(function(){
    	$("#bankAddressComment").val($("#bankNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Ordering Bank MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});

	$("#popup_btn_sender_correspondentMt202").click(function(){
    	$("#bankAddressComment").val($("#senderNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Sender's Correspondent MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_receiver_correspondent_mt202").click(function(){
    	$("#bankAddressComment").val($("#receiverNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Receiver's Correspondent MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_intermediaryMt202").click(function(){
    	$("#bankAddressComment").val($("#intermediaryNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Intermediary MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_account_with_bankMt202").click(function(){
    	$("#bankAddressComment").val($("#accountNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Account with Bank MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_beneficiary_bankMt202").click(function(){
    	$("#bankAddressComment").val($("#beneficiaryNameAndAddressMt202").val());
		$("#popup_header_bankAddress").text("Beneficiary Bank MT202");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	$("#popup_btn_2nd_advising_bank_address").click(function(){
    	$("#bankAddressComment").val($("#advisingBankAddress").val());
    	$("#popup_header_bankAddress").text("2nd Advising Bank Address");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment()
	});
	
	// Brian marker
	$("#popup_btn_description_of_goods_not_as_per_lc").click(function () {
		if ($("#descriptionOfGoodsNotPerLcSwitchDisplay").attr("checked") == "checked") {
			$("#bankAddressComment").val("");
			$("#popup_header_bankAddress").text("Description of Goods not as per LC");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
			reInitializeBankAddressCommentNegoDiscrepancy();
		} else {
			triggerAlertMessage("Click the checkbox first.");
		}
	});
	
	$("#popup_btn_documents_not_presented").click(function () {
		if ($("#documentsNotPresentedSwitchDisplay").attr("checked") == "checked") {
			$("#bankAddressComment").val("");
			$("#popup_header_bankAddress").text("Documents not Presented");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
			reInitializeBankAddressCommentNegoDiscrepancy();
		} else {
			triggerAlertMessage("Click the checkbox first.");
		}
	});
	
	// For Nego Discrepancy
	$("#popup_btn_others").click(function () {
		if ($("#othersSwitchDisplay").attr("checked") == "checked") {
			$("#bankAddressComment").val("");
			$("#popup_header_bankAddress").text("Others");
			centerPopup(wrapper_div,div_bg);
			loadPopup(wrapper_div,div_bg);
			reInitializeBankAddressCommentNegoDiscrepancy();
		} else {
			triggerAlertMessage("Click the checkbox first.");
		}
	});
	
	$("#popup_btn_disposal_of_documents").click(function(){
		$("#bankAddressComment").limitCharAndLines(33, 3);
		var disposalCode = $('#disposalOfDocuments option:selected').text();
		disposalCode = disposalCode.toUpperCase();
		disposalCode = "/" + disposalCode + "/";
		var disposalTextArea = $('textarea#disposalOfDocumentsText').val();
		if( disposalTextArea != "" && disposalTextArea.startsWith("/") ){
			var disposalTextAreaSub = disposalTextArea.substring(0,10);
			disposalTextAreaSub = disposalTextAreaSub.toUpperCase();
			if( disposalTextAreaSub.indexOf(disposalCode) != -1 ){
				if ( hasWhiteSpace(disposalTextArea) == true ){
					disposalTextArea = disposalTextArea.replace(/(\r\n|\n|\r)/gm, ' ');
				} else {
					disposalTextArea = disposalTextArea.replace(/(\r\n|\n|\r)/gm, '');
				}
				$("#bankAddressComment").val(disposalTextArea); 
			} 
		} else {
			if( !disposalCode.startsWith("/SELECT") ){
				$("#bankAddressComment").val(disposalCode); 
			} else {
				triggerAlertMessage("Please select one in Disposal of Documents dropdown.");
				return false;
			}
		}
		$("#popup_header_bankAddress").text("Disposal of Documents");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		$("#bankAddressComment").limitCharAndLines(33, 3);
		$("#bankAddressComment").removeAttr("maxlength");
		$("#bankAddressComment").attr("maxlength", 102);  
	});
	
	$("#popup_btn_new_exporter_bank_address").click(function(){
    	$("#bankAddressComment").val($("#newExporterAddress").val());
		$("#popup_header_bankAddress").text("New Exporter Address");
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
		reInitializeBankAddressComment();
	});

	$("#popup_btn_other_place_of_expiry").click(function(){
    	$("#bankAddressComment").val($("#otherPlaceOfExpiryTo").val());
		$("#popup_header_bankAddress").text("New Other Place of Expiry");
		$("#bankAddressComment").limitCharAndLines(25, 1);
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	
	$("#popup_btn_mixed_payment_detailsTo").click(function(){
		$("#bankAddressComment").val($("#mixedPaymentDetailsTo").val());
		$("#popup_header_bankAddress").text("New Mixed Payment Details");
		$("#bankAddressComment").limitCharAndLines(35, 4, 'X');
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	
	$("#popup_btn_deferred_payment_detailsTo").click(function(){
		$("#bankAddressComment").val($("#deferredPaymentDetailsTo").val());
		$("#popup_header_bankAddress").text("New Deferred Payment Details");
		$("#bankAddressComment").limitCharAndLines(35, 4, 'X');
		centerPopup(wrapper_div,div_bg);
		loadPopup(wrapper_div,div_bg);
	});
	
	
	//comment by robin 4116. 
	// when EBC NEGO DATA ENTRY, the pop_up character and line limit is set to 35 by 6. Default is still 35 by 4
	//var tradeServiceId = document.getElementsByName('tradeServiceId').value;
	//var referenceType = document.getElementsByName('referenceType').value;
	//alert("docu class: " + documentClass + "\nserviceType: " + serviceType + "\ndocumentType: " + documentType + "\ntradeServiceId :" + tradeServiceId + "\nreferenceType: " + referenceType);
	if (documentClass == "BC" && serviceType == "NEGOTIATION" && documentType == "FOREIGN" && referenceType == "DATA_ENTRY") {
		$("#bankAddressComment").limitCharAndLines(35,6);
	} else if (documentClass == "LC" && serviceType == "Negotiation_Discrepancy" && (documentType == "FOREIGN" || documentType == "DOMESTIC") && referenceType == "DATA_ENTRY") {
		$("#bankAddressComment").limitCharAndLines(50, totalLines);
		$("#bankAddressComment").attr('maxlength', 3250);
	} else {
		console.log("condition not met");
		if($("#lcNegoDiscrepancyFlag") != 'undefined' && $("#lcNegoDiscrepancyFlag").val() == "true"){
			$("#bankAddressComment").limitCharAndLines(35, 6);
		} else {
			$("#bankAddressComment").limitCharAndLines(35, 4);
		}
		
	}

	//$("#bankAddressComment").limitCharAndLines(35,4);
	//commeny by robin

	$("#bankAddressPopupSave").click(onBankAddressPopupSaveClick);
	
	// Brian marker
	function reInitializeBankAddressCommentNegoDiscrepancy() {
		$("#bankAddressComment").limitCharAndLines(50, totalLines, "Z");
	}
	
	function reInitializeBankAddressCommentDisposalOfDocuments() {
		$("#bankAddressComment").limitCharAndLines(33, 3);
	}
	
	function reInitializeBankAddressComment() {
		$("#bankAddressComment").limitCharAndLines(35,4);
	}
});