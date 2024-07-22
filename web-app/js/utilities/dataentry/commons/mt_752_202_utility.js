function computeNetAmountForMt() {
    var negotiationAmount = parseFloat($("#negotiationAmount").val().replace(/,/g,""));
    var discrepancyAmount = 0;

    if($("#discrepancyAmount").val() != "") {
        discrepancyAmount = parseFloat($("#discrepancyAmount").val().replace(/,/g,""));
    }

    var netAmount = negotiationAmount - discrepancyAmount;

    if(netAmount < 0) {
        netAmount = 0;
    }

    $("#netAmountMt").val(formatCurrency(netAmount));
}

$(document).ready(function(){

	if('undefined' !== typeof $("#discrepancyAmount").val() && 
			'undefined' !== typeof $("#negotiationAmount").val()){
		$("#discrepancyAmount").change(computeNetAmountForMt);
		computeNetAmountForMt();
	}

	$(".display-mt752").hide();
	$(".display-mt202").hide();
	
});	



