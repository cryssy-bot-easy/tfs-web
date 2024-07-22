var popup_authorized_signatory_div = $("#authorizedSignatoryPopup");
var popup_authorized_signatory_bg = $("#popupBackground_authorized_signatory");

function openDocumentCheckListAuthorizedSignatoryPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateDocumentsCheckList');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function openBankCertificationAuthorizedSignatoryPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateCertification');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function openDiscrepancyLetterAuthorizedSignatoryPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateDiscepancyLetter');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function openLetterOfAdvisePopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateLetterOfAdvise');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function openTransmittalLetterPopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateTransmittalLetter');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function openExportNegotiationAdvicePopUp(){	
	$(".buttonPopupGenDocument").attr('id','generateExportNegotiationAdvice');
	mCenterPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
	mLoadPopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

function closeAuthorizedSignatoryPopUp() {
	mDisablePopup(popup_authorized_signatory_div, popup_authorized_signatory_bg);
}

$(document).ready(function() {	 
	
	$("#generateDocumentsCheckList").live("click",function(){		
		if($("#authorizedSign").val() == ""){
			alert("Please fill in the required field.");
		}else{			
			generateDocumentCheckListReport();		
		}
	});
	
	$("#generateCertification").live("click",function(){		
		if($("#authorizedSign").val() == ""){
			alert("Please fill in the required field.");
		}else{			
			generateCertificationReport();		
		}
	});
	
	$("#generateDiscepancyLetter").live("click",function(){		
		if($("#authorizedSign").val() == ""){
			alert("Please fill in the required field.");
		}else{			
			generateDiscrepancyLetterReport();		
		}
	});
	
	//letter of advise
	$("#generateLetterOfAdvise").live("click",function(){		
		if($("#authorizedSign").val()==""){
			alert("Please fill in all the required field.");
		}else{			
			generateLetterOfAdvise();			
		}
	});
	
	//transmittal letter
	$("#generateTransmittalLetter").live("click",function(){		
		if($("#authorizedSign").val()==""){
			alert("Please fill in all the required field.");
		}else{			
			generateTransmittalLetterReport();			
		}
	});
	
	//export negotiation advice
	$("#generateExportNegotiationAdvice").live("click",function(){		
		if($("#authorizedSign").val()==""){
			alert("Please fill in all the required field.");
		}else{			
			generateExportNegotiationAdvice();			
		}
	});
	
});

