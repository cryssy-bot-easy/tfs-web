//@js/gsp

function generateLcConfirmationStandbyOpening(){

	var date1 = new Date($("#expiryDate").val()); 
	var date2 = new Date($("#issueDate").val())  
	var diffDate = Math.abs(date1-date2); //result in millisecond
	var expiryPeriod = diffDate/1000/60/60/24;
	
	var tmpLcConfirmationStandbyOpeningUrl = lcConfirmationStandbyOpeningUrl;

	tmpLcConfirmationStandbyOpeningUrl += "?formatType=" +  $("#formatType").val();
	tmpLcConfirmationStandbyOpeningUrl += "&documentNumber=" +  $("#documentNumber").val().split('-').join('');
	tmpLcConfirmationStandbyOpeningUrl += "&tradeServiceId=" +  $("#tradeServiceId").val();
	tmpLcConfirmationStandbyOpeningUrl += "&expiryPeriod=" + expiryPeriod;
	/*
	tmpLcConfirmationStandbyOpeningUrl += "&contractLocation=" + $("#contractLocation").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&biddingDate=" + $("#biddingDate").val();
	tmpLcConfirmationStandbyOpeningUrl += "&bidInvitationNumber=" + $("#bidInvitationNumber").val();
	tmpLcConfirmationStandbyOpeningUrl += "&bidInvitationDate=" + $("#bidInvitationDate").val();
	tmpLcConfirmationStandbyOpeningUrl += "&attentionName=" + $("#attentionName").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&attentionNamePosition=" + $("#attentionNamePosition").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&bank=" + $("#bank").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&bankBranch=" + $("#bankBranch").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&bankAddress=" + $("#bankAddress").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&city=" + $("#city").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&proprietor=" + $("#proprietor").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&proprietorPosition=" + $("#proprietorPosition").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&authorizedSignatory1=" + $("#authorizedSignatory1").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&authorizedSignatoryPosition1=" + $("#authorizedSignatoryPosition1").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&authorizedSignatory2=" + $("#authorizedSignatory2").val().toUpperCase();
	tmpLcConfirmationStandbyOpeningUrl += "&authorizedSignatoryPosition2=" + $("#authorizedSignatoryPosition2").val().toUpperCase();
	*/
	window.open(tmpLcConfirmationStandbyOpeningUrl);
}

function init() {
	$('#viewLcConfirmationStandbyOpening').click(generateLcConfirmationStandbyOpening);
}

$(init);