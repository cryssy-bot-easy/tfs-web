//@js/gsp
function generateCertificationReport(){

	var tmpCertificationUrl = certificationUrl;
	
	tmpCertificationUrl += "?documentNumber=" + $("#documentNumber").val();
	
	var referenceNumber = "";
	if($("#lcNumber").val()!="" && $("#lcNumber").val() != undefined) {
		referenceNumber = $("#lcNumber").val();
	} else {
		referenceNumber = $("#documentNumber").val();
	}
	tmpCertificationUrl += "&lcNumber=" + referenceNumber;
	
	tmpCertificationUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpCertificationUrl += "&negotiationCurrency=" + $("#negotiationCurrency").val();
	tmpCertificationUrl += "&negotiationAmount=" + $("#negotiationAmount").val();
	tmpCertificationUrl += "&productAmount=" + $("#productAmount").val();
	tmpCertificationUrl += "&authorizedSign=" +$("#authorizedSign").val();
	tmpCertificationUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();
		
	window.open(tmpCertificationUrl);

}

function init() {
	$('#viewCertification').click(generateCertificationReport);
}


$(init);