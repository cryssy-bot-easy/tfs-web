//@js/gsp
function generateDocumentCheckListReport(){
			
	var tmpDocumentCheckListUrl = documentCheckListUrl;
	
	tmpDocumentCheckListUrl += "?tradeServiceId=" + $("#tradeServiceId").val();

	if($("#documentClass").val()=="LC" && $("#serviceType").val()=="Negotiation"){	
		tmpDocumentCheckListUrl += "&documentNumber=" + $("#lcNumber").val();
	} else {
		tmpDocumentCheckListUrl += "&documentNumber=" + $("#documentNumber").val();
	}
		
	if($("#documentClass").val()=="LC") {
		tmpDocumentCheckListUrl += "&currency=" + $("#negotiationCurrency").val();
		tmpDocumentCheckListUrl += "&amount=" + $("#negotiationAmount").val();
	} else {
		tmpDocumentCheckListUrl += "&currency=" + $("#currency").val();
		tmpDocumentCheckListUrl += "&amount=" + $("#amount").val();
	}
	
	tmpDocumentCheckListUrl += "&authorizedSign=" + $("#authorizedSign").val();
	tmpDocumentCheckListUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();

	window.open(tmpDocumentCheckListUrl);	
}

function init() {
	$('#viewDocumentCheckList').click(generateDocumentCheckListReport);
}


$(init);