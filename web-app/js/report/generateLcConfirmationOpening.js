//@js/gsp
function generateLcConfirmationOpeningReport(){
			
	var tmpLcConfirmationOpeningUrl = lcConfirmationOpeningUrl;
	
	tmpLcConfirmationOpeningUrl += "?documentNumber=" + $("#documentNumber").val();
	tmpLcConfirmationOpeningUrl += "&tradeServiceId=" + $("#tradeServiceId").val();
	tmpLcConfirmationOpeningUrl += "&authorizedSignatory1=" + $("#authorizedSignatory1").val();
	tmpLcConfirmationOpeningUrl += "&authorizedSignatory1Position=" + $("#authorizedSignatory1Position").val();
	tmpLcConfirmationOpeningUrl += "&authorizedSignatory2=" + $("#authorizedSignatory2").val();
	tmpLcConfirmationOpeningUrl += "&authorizedSignatory2Position=" + $("#authorizedSignatory2Position").val();
	
	window.open(tmpLcConfirmationOpeningUrl);
}
