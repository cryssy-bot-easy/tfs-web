//@js/gsp
function generateBillingStatementWithoutPaymentDetailsReport(){
			
	var tmpBillingStatementWithoutPaymentDetailsUrl = billingStatementWithoutPaymentDetailsUrl;
	window.open(tmpBillingStatementWithoutPaymentDetailsUrl);

}

function init() {
	$('#viewBillingStatementWithoutPaymentDetails').click(generateBillingStatementWithoutPaymentDetailsReport);
}


$(init);