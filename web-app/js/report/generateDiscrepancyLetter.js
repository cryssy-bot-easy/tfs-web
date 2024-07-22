//@js/gsp
function generateDiscrepancyLetterReport(){
	var tmpDiscrepancyLetterUrl = discrepancyLetterUrl;

	tmpDiscrepancyLetterUrl += "?tradeServiceId=" + $("#tradeServiceId").val();
	tmpDiscrepancyLetterUrl += "&authorizedSign=" + $("#authorizedSign").val();
	tmpDiscrepancyLetterUrl += "&authorizedSignPosition=" + $("#authorizedSignPosition").val();
	
	window.open(tmpDiscrepancyLetterUrl);

}

function init() {
	$('#viewDiscrepancyLetter').click(generateDiscrepancyLetterReport);
	$('#viewDiscrepancyLetterDataEntryDomestic').click(generateDiscrepancyLetterReport);
}

$(init);