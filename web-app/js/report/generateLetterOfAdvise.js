//@js/gsp
function generateLetterOfAdvise(){
	
	var tmpLetterOfAdviseUrl = letterOfAdviseUrl;

	tmpLetterOfAdviseUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpLetterOfAdviseUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpLetterOfAdviseUrl += "&sendMt730Flag=" + $("input[name=sendMt730Flag]:checked").val();
	tmpLetterOfAdviseUrl += "&sendMt799Flag=" + $("input[name=sendMt799Flag]:checked").val();
	tmpLetterOfAdviseUrl += "&authorizedSign=" + $("#authorizedSign").val();
	tmpLetterOfAdviseUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();

	// rest of fields (for mt700) can be found at the controller
	
	window.open(tmpLetterOfAdviseUrl);
}

function init() {	
	$('#viewLetterOfAdviseDataEntry').click(generateLetterOfAdvise);
}

$(init);