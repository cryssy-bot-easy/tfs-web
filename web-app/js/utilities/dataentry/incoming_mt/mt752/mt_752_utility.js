function computeNetAmountForMt() {
//    var negotiationAmount = parseFloat($("#negotiationAmount").val().replace(/,/g,""));
	var negotiationAmount = 0;
    var discrepancyAmount = 0;

    if("undefined" !== typeof $("#negoAmountMt752").val() && $("#negoAmountMt752").val() != ""){
    	negotiationAmount = parseFloat($("#negoAmountMt752").val().replace(/,/g,""));
    }else{
		negotiationAmount = parseFloat($("#negotiationAmount").val().replace(/,/g,""));
    }
    
    if("undefined" !== typeof $("#discrepancyAmountMt752").val() && $("#discrepancyAmountMt752").val() != "") {
        discrepancyAmount = parseFloat($("#discrepancyAmountMt752").val().replace(/,/g,""));
    }

    var netAmount = negotiationAmount - discrepancyAmount;

    if(netAmount < 0) {
        netAmount = 0;
    }

    $("#netAmountMt752").val(formatCurrency(netAmount));
}

$(document).ready(function(){

	if('undefined' !== typeof $("#discrepancyAmountMt752").val() && 
			'undefined' !== typeof $("#negotiationAmount").val()){
		$("#discrepancyAmountMt752").change(computeNetAmountForMt);
		$("#negoAmountMt752").change(computeNetAmountForMt);
		computeNetAmountForMt();
	}

	$(".display-mt752").hide();
	
});	



