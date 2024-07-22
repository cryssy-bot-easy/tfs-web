
//@js/gsp
function generateLcConfirmationAmendmentReport(){
			
	var tmpLcConfirmationAmendmentUrl = lcConfirmationAmendmentUrl;
	
    tmpLcConfirmationAmendmentUrl += "?documentNumber=" + $("#documentNumber").val();
    tmpLcConfirmationAmendmentUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
    
    // var is in _accordion_url.gsp
    tmpLcConfirmationAmendmentUrl += "&amendmentDate=" + amendmentDate;
    tmpLcConfirmationAmendmentUrl += "&applicantName=" + $("#applicantName").val();
    tmpLcConfirmationAmendmentUrl += "&expiryDate=" + $("#expiryDate").val();
    tmpLcConfirmationAmendmentUrl += "&expiryDateTo=" + $("#expiryDateTo").val();
    tmpLcConfirmationAmendmentUrl += "&currency=" + $("#currency").val();
    tmpLcConfirmationAmendmentUrl += "&availableBy=" + $("#availableBy").val();
    tmpLcConfirmationAmendmentUrl += "&availableByTo=" + $("#availableByTo").val();
    tmpLcConfirmationAmendmentUrl += "&partialDelivery=" + $("#partialDelivery").val();
    tmpLcConfirmationAmendmentUrl += "&partialDeliveryTo=" + $("#partialDeliveryTo").val();
    tmpLcConfirmationAmendmentUrl += "&amount=" + $("#amount").val();
    tmpLcConfirmationAmendmentUrl += "&amountTo=" + $("#amountTo").val();
    tmpLcConfirmationAmendmentUrl += "&beneficiaryName=" + $("#beneficiaryName").val();
    tmpLcConfirmationAmendmentUrl += "&beneficiaryNameTo=" + $("#beneficiaryNameTo").val();
    tmpLcConfirmationAmendmentUrl += "&beneficiaryAddress=" + $("#beneficiaryAddress").val();
    tmpLcConfirmationAmendmentUrl += "&beneficiaryAddressTo=" + $("#beneficiaryAddressTo").val();
    tmpLcConfirmationAmendmentUrl += "&originalTenor=" + $("#originalTenor").val();
    tmpLcConfirmationAmendmentUrl += "&tenorTo=" + $("#tenorTo").val();
    tmpLcConfirmationAmendmentUrl += "&usancePeriodTo=" + $("#usancePeriodTo").val();
    tmpLcConfirmationAmendmentUrl += "&narrative=" + $("#narrative").val();
    tmpLcConfirmationAmendmentUrl += "&authorizedSignatory1=" + $("#authorizedSignatory1").val();
    tmpLcConfirmationAmendmentUrl += "&authorizedSignatory1Position=" + $("#authorizedSignatory1Position").val();
    tmpLcConfirmationAmendmentUrl += "&authorizedSignatory2=" + $("#authorizedSignatory2").val();
    tmpLcConfirmationAmendmentUrl += "&authorizedSignatory2Position=" + $("#authorizedSignatory2Position").val();
        
	window.open(tmpLcConfirmationAmendmentUrl);

}

function init() {
	$('#viewLcConfirmationAmendment').click(generateLcConfirmationAmendmentReport);
}


$(init);