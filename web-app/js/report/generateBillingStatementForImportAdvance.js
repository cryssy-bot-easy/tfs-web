//@js/gsp
function generateBillingStatementForImportAdvanceReport(){

	var tmpBillingStatementForImportAdvanceUrl = billingStatementForImportAdvanceUrl;
	window.open(tmpBillingStatementForImportAdvanceUrl);

}

function init() {
	$('#viewBillingStatementForImportAdvance').click(generateBillingStatementForImportAdvanceReport);
}


$(init);